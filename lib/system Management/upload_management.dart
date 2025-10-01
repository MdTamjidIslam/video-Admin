import 'package:flutter/material.dart';

/// ===================== UPLOAD MANAGEMENT SCREEN =====================
class UploadManagementPage extends StatelessWidget {
  const UploadManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          /// ---------- Sidebar ------------------ Main Content ----------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Conditional Search Box
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        runSpacing: 12,
                        spacing: 16,
                        children: [
                          _buildTextField("ID", "Please enter your ID"),
                          _buildDropdown("Storage location", ["All", "Local"]),
                          _buildTextField("Save the address",
                              "Please enter the save address"),
                          _buildTextField("Original file name",
                              "Please enter the original file name"),
                          _buildTextField("MIME type",
                              "Please enter the MIME type"),
                          _buildTextField("File extension",
                              "Please enter the file extension"),
                          _buildTextField("Creation Date",
                              "Please enter the creation time"),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  child: const Text("Search")),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  child: const Text("Reset")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Action Buttons
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text("+ Add")),
                      const SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Text("Delete")),
                      const SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text("Figure 导出")),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Data Table
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                          Colors.grey.shade200), // header bg
                      columns: const [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Storage location")),
                        DataColumn(label: Text("Image information")),
                        DataColumn(label: Text("Save the address")),
                        DataColumn(label: Text("Original file name")),
                        DataColumn(label: Text("MIME type")),
                        DataColumn(label: Text("Extension")),
                        DataColumn(label: Text("Creation Date")),
                        DataColumn(label: Text("Operation")),
                      ],
                      rows: List.generate(10, (index) {
                        return DataRow(cells: [
                          DataCell(Text("67${index + 1}")),
                          const DataCell(Text("Local")),
                          DataCell(Container(
                              width: 60,
                              height: 40,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.image,
                                  color: Colors.white))),
                          DataCell(Text("/upload/202${index}")),
                          DataCell(Text("file_$index")),
                          const DataCell(Text("image")),
                          const DataCell(Text("png")),
                          const DataCell(Text("2025-09-30")),
                          DataCell(ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Delete"))),
                        ]);
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper TextField
  Widget _buildTextField(String label, String hint) {
    return SizedBox(
      width: 220,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  /// Helper Dropdown
  Widget _buildDropdown(String label, List<String> items) {
    return SizedBox(
      width: 220,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        value: items.first,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) {},
      ),
    );
  }
}
