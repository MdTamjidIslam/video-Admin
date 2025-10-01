import 'package:flutter/material.dart';

/// ===================== LOG MANAGEMENT PAGE =====================
class LogManagementPage extends StatelessWidget {
  const LogManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Conditional Search Form
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    _buildTextField("Log Month", "2025-09"),
                    _buildTextField("Request method", "Please enter method"),
                    _buildTextField("Routing address", "Please enter address"),
                    _buildTextField("Log Title", "Please enter log title"),
                    _buildTextField("Operation Content", "Please enter content"),
                    _buildTextField("IP address", "Please enter IP"),
                    _buildTextField("User Agent", "Please enter UA"),
                    _buildTextField("Creation Date", "Please enter date"),

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
            const SizedBox(height: 20),

            /// 🔹 Data Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                MaterialStateProperty.all(Colors.grey.shade200),
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("Back-end user")),
                  DataColumn(label: Text("Request method")),
                  DataColumn(label: Text("Routing address")),
                  DataColumn(label: Text("Log Title")),
                  DataColumn(label: Text("Operation Content")),
                  DataColumn(label: Text("IP Address")),
                  DataColumn(label: Text("User Agent")),
                  DataColumn(label: Text("Creation Date")),
                ],
                rows: List.generate(10, (index) {
                  return DataRow(cells: [
                    DataCell(Text("${640 - index}")),
                    DataCell(Text(index % 2 == 0 ? "admin" : "undefined")),
                    const DataCell(Text("post")),
                    DataCell(Text("/gladmin/log$index")),
                    DataCell(Text("Title $index")),
                    DataCell(Text("Operation $index")),
                    DataCell(Text("192.168.0.${index + 1}")),
                    const DataCell(Text("Mozilla/5.0")),
                    const DataCell(Text("2025-09-25")),
                  ]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Helper TextField
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
}
