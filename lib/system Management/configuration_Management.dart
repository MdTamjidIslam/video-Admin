import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ConfigManagementPage extends StatefulWidget {
  const ConfigManagementPage({super.key});

  @override
  State<ConfigManagementPage> createState() => _ConfigManagementPageState();
}

class _ConfigManagementPageState extends State<ConfigManagementPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  Uint8List? webImage;

  final String uploadUrl = "http://192.168.0.247:8080/admin/upload_image";

  // 🔹 All controllers
  final siteNameCtrl = TextEditingController();
  final siteUrlCtrl = TextEditingController();
  final indexNumberCtrl = TextEditingController();
  final registrationCtrl = TextEditingController();
  final domainCtrl = TextEditingController();
  final copyrightCtrl = TextEditingController();
  final titleCtrl = TextEditingController();

  /// 🔹 Load config.json (optional)
  Future<void> _loadConfig() async {
    try {
      final jsonString = await rootBundle.loadString('assets/config.json');
      final data = jsonDecode(jsonString);

      setState(() {
        siteNameCtrl.text = data['site_name'] ?? '';
        siteUrlCtrl.text = data['site_url'] ?? '';
        indexNumberCtrl.text = data['index_number'] ?? '';
        registrationCtrl.text = data['registration_information'] ?? '';
        domainCtrl.text = data['domain_name'] ?? '';
        copyrightCtrl.text = data['copyright_info'] ?? '';
        titleCtrl.text = data['title_name'] ?? '';
      });
    } catch (e) {
      _showSnack("⚠️ Failed to load config.json: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  /// Pick image
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

  /// Upload API
  Future<void> uploadForm() async {
    if (selectedImage == null) {
      _showSnack("⚠️ Please select an image first");
      return;
    }

    try {
      var uri = Uri.parse(uploadUrl);
      var request = http.MultipartRequest('POST', uri);

      // ✅ Add image file
      if (kIsWeb) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          webImage!,
          filename: selectedImage!.name,
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          selectedImage!.path,
          filename: selectedImage!.name,
        ));
      }

      // ✅ Add all fields
      request.fields.addAll({
        'site_name': siteNameCtrl.text,
        'site_url': siteUrlCtrl.text,
        'index_number': indexNumberCtrl.text,
        'registration_information': registrationCtrl.text,
        'domain_name': domainCtrl.text,
        'copyright_info': copyrightCtrl.text,
        'original_filename': selectedImage!.name, // ✅ both same
        'title': titleCtrl.text, // ✅ both same
      });

      // ✅ Send request
      var response = await request.send();
      var respStr = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnack("✅ Upload successful");

        setState(() {
          selectedImage = null;
          webImage = null;
          siteNameCtrl.clear();
          siteUrlCtrl.clear();
          indexNumberCtrl.clear();
          registrationCtrl.clear();
          domainCtrl.clear();
          copyrightCtrl.clear();
          titleCtrl.clear();
        });
      } else {
        _showSnack("❌ Upload failed (${response.statusCode}) → $respStr");
      }
    } catch (e) {
      _showSnack("⚠️ Error: $e");
    }
  }

  /// SnackBar
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Website Settings Upload"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Site Name"),
              _inputField(siteNameCtrl, "Enter the site name."),
              const SizedBox(height: 20),

              _sectionTitle("Site URL"),
              _inputField(siteUrlCtrl, "Enter the website URL."),
              const SizedBox(height: 20),

              _sectionTitle("version_information"),
              _inputField(indexNumberCtrl, "Enter index number."),
              const SizedBox(height: 20),

              _sectionTitle("Browser Icon"),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedImage == null
                        ? const Icon(Icons.image, color: Colors.grey)
                        : (kIsWeb
                        ? Image.memory(webImage!, fit: BoxFit.cover)
                        : Image.file(File(selectedImage!.path),
                        fit: BoxFit.cover)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                    ),
                    child: const Text("Choose"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _sectionTitle("Title"),
              _inputField(
                  titleCtrl, "Enter your registration information."),
              const SizedBox(height: 20),

              _sectionTitle("Registration Information"),
              _inputField(
                  registrationCtrl, "Enter your registration information."),
              const SizedBox(height: 20),

              _sectionTitle("Site Domain"),
              _inputField(domainCtrl, "Enter your domain name."),
              const SizedBox(height: 20),

              _sectionTitle("Copyright Information"),
              _inputField(copyrightCtrl, "Enter copyright info."),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton.icon(
                  onPressed: uploadForm,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          hint,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
      ],
    );
  }
}
