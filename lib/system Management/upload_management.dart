import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:intl/intl.dart';

class UploadManagementPage extends StatefulWidget {
  const UploadManagementPage({super.key});

  @override
  State<UploadManagementPage> createState() => _UploadManagementPageState();
}

class _UploadManagementPageState extends State<UploadManagementPage> {
  final String baseUrl = "http://192.168.0.247:8080";

  // Scroll Controllers
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  // Text Controllers
  final titleCtrl = TextEditingController();
  final indexCtrl = TextEditingController();
  String bannerType = "header";

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  Uint8List? webImage;

  List<dynamic> bannerList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  /// -------- GET API: Fetch All Banners --------
  Future<void> fetchBanners() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse("$baseUrl/banners"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Handle different JSON structures
        if (data is List) {
          bannerList = data;
        } else {
          bannerList = data["banners"] ?? data["images"] ?? [];
        }
        setState(() {});
      } else {
        _showSnack("❌ Failed to load (${response.statusCode})");
      }
    } catch (e) {
      _showSnack("⚠️ Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// -------- POST API: Upload Banner --------
  Future<void> uploadBanner() async {
    if (selectedImage == null) {
      _showSnack("⚠️ Please select an image first");
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/admin/banner/upload"),
      );

      // Attach image file
      if (kIsWeb) {
        final bytes = await selectedImage!.readAsBytes();
        final mimeType = lookupMimeType(selectedImage!.name) ?? 'image/png';
        final typeSplit = mimeType.split('/');
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: selectedImage!.name,
          contentType: MediaType(typeSplit[0], typeSplit[1]),
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          selectedImage!.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      // Attach other fields
      request.fields['title'] = titleCtrl.text;
      request.fields['banner_type'] = bannerType;
      request.fields['index_number'] = indexCtrl.text;

      var response = await request.send();
      if (response.statusCode == 200||response.statusCode == 201) {
        _showSnack("✅ Uploaded successfully");
        fetchBanners();
      } else {
        _showSnack("❌ Upload failed (${response.statusCode})");
      }
    } catch (e) {
      _showSnack("⚠️ Error: $e");
    }
  }

  /// -------- Pick Image from Gallery --------
  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() {
          selectedImage = picked;
          webImage = bytes;
        });
      } else {
        setState(() {
          selectedImage = picked;
        });
      }
    }
  }

  /// -------- Helper: Show Snackbar --------
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));
  }

  /// -------- Helper: Format Date --------
  String formatDate(String? dateStr) {
    try {
      if (dateStr == null || dateStr.isEmpty) return "—";
      final dt = DateTime.parse(dateStr);
      return DateFormat("dd-MM-yyyy").format(dt);
    } catch (_) {
      return "—";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("📢 Banner Management"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scrollbar(
          controller: _verticalController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _verticalController,
            scrollDirection: Axis.vertical,
            child: Scrollbar(
              controller: _horizontalController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: screen.width,
                    minHeight: screen.height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ---------- Upload Form ----------
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              runSpacing: 16,
                              spacing: 16,
                              children: [
                                // Title Input
                                SizedBox(
                                  width: 220,
                                  child: TextField(
                                    controller: titleCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Title",
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                ),

                                // Dropdown for Banner Type
                                SizedBox(
                                  width: 220,
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      labelText: "Banner Type",
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                    value: bannerType,
                                    items: const [
                                      DropdownMenuItem(
                                          value: "header",
                                          child: Text("Header")),
                                      DropdownMenuItem(
                                          value: "footer",
                                          child: Text("Footer")),
                                    ],
                                    onChanged: (v) {
                                      setState(() => bannerType = v!);
                                    },
                                  ),
                                ),

                                // Index Number
                                SizedBox(
                                  width: 220,
                                  child: TextField(
                                    controller: indexCtrl,
                                    decoration: const InputDecoration(
                                      labelText: "Index Number",
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                  ),
                                ),

                                // Image Picker Button
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.image),
                                  label: const Text("Select Image"),
                                  onPressed: pickImage,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                ),

                                // Image Preview
                                if (selectedImage != null)
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Colors.grey),
                                      borderRadius:
                                      BorderRadius.circular(6),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: kIsWeb
                                            ? MemoryImage(webImage!)
                                            : Image.file(
                                            File(selectedImage!
                                                .path))
                                            .image,
                                      ),
                                    ),
                                  ),

                                // Upload Button
                                ElevatedButton.icon(
                                  icon: const Icon(
                                      Icons.cloud_upload_outlined),
                                  label: const Text("Upload"),
                                  onPressed: uploadBanner,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ---------- Banner Table ----------
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: bannerList.isEmpty
                                ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Text("No data available 😴",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey)),
                              ),
                            )
                                : DataTable(
                              headingRowColor:
                              MaterialStateProperty.all(
                                  Colors.grey.shade200),
                              headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold),
                              columns: const [
                                DataColumn(label: Text("Index")),
                                DataColumn(label: Text("Title")),
                                DataColumn(label: Text("Type")),
                                DataColumn(label: Text("Image")),
                                DataColumn(
                                    label: Text("Uploaded At")),
                              ],
                              rows: bannerList.map((b) {
                                final idx =
                                    b["index_number"] ?? "—";
                                final title = b["title"] ?? "—";
                                final type =
                                    b["banner_type"] ?? "—";
                                final imgUrl = b["url"] ?? "";
                                final uploaded = formatDate(
                                    b["uploaded_at"]?.toString());
                                return DataRow(cells: [
                                  DataCell(Text(idx.toString())),
                                  DataCell(Text(title)),
                                  DataCell(Text(type)),
                                  DataCell(Container(
                                    width: 60,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(6),
                                      image: imgUrl.isNotEmpty
                                          ? DecorationImage(
                                          image: NetworkImage(
                                              imgUrl),
                                          fit: BoxFit.cover)
                                          : null,
                                      color: Colors.grey.shade300,
                                    ),
                                  )),
                                  DataCell(Text(uploaded)),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
