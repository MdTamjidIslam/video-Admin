import 'package:flutter/material.dart';

class RoleManagementPage extends StatefulWidget {
  const RoleManagementPage({super.key});

  @override
  State<RoleManagementPage> createState() => _RoleManagementPageState();
}

class _RoleManagementPageState extends State<RoleManagementPage> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Content Management",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Filter Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildInput("ID", "Please enter your ID"),
                  _buildInput("Sort", "Please enter sorting order"),
                  _buildInput("Permission Name", "Please enter name"),
                  _buildInput("Note Information", "Please provide remarks"),
                  _buildInput("Status", "All"),
                  _buildInput("Creation Date", "Please enter time"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Add/Delete Buttons
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24)),
                  onPressed: () {},
                  child: const Text("Add"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24)),
                  onPressed: () {},
                  child: const Text("Delete"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Table Header
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(flex: 1, child: Text("ID")),
                  Expanded(flex: 1, child: Text("Sort")),
                  Expanded(flex: 2, child: Text("Permission Name")),
                  Expanded(flex: 3, child: Text("Note Information")),
                  Expanded(flex: 2, child: Text("Status")),
                  Expanded(flex: 3, child: Text("Creation Date")),
                  Expanded(flex: 3, child: Text("Operation")),
                ],
              ),
            ),

            // 🔹 Table Row
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: [
                  const Expanded(flex: 1, child: Text("1")),
                  const Expanded(flex: 1, child: Text("1")),
                  const Expanded(flex: 2, child: Text("Administrator")),
                  const Expanded(flex: 3, child: Text("Test Administrator")),
                  Expanded(
                    flex: 2,
                    child: Switch(
                      value: isActive,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setState(() {
                          isActive = val;
                        });
                      },
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Text("2020-05-08 15:09:13"),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        _opBtn(Icons.edit, Colors.green),
                        _opBtn(Icons.delete, Colors.red),
                        _opBtn(Icons.more_horiz, Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Pagination/Footer
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: [
                  const Text("1"),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                    ),
                    onPressed: () {},
                    child: const Text("Confirm"),
                  ),
                  const SizedBox(width: 16),
                  const Text("Total: 1 item"),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: "To home page",
                    items: const [
                      DropdownMenuItem(
                          value: "To home page", child: Text("To home page")),
                      DropdownMenuItem(
                          value: "Next page", child: Text("Next page")),
                    ],
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, String hint) {
    return SizedBox(
      width: 220,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          isDense: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
      ),
    );
  }

  static Widget _opBtn(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
