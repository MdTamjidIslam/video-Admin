import 'package:flutter/material.dart';

class AdministratorManagement extends StatefulWidget {
  const AdministratorManagement({super.key});

  @override
  State<AdministratorManagement> createState() =>
      _AdministratorManagementState();
}

class _AdministratorManagementState extends State<AdministratorManagement> {
  // list to hold switch status (default সব OFF)
  List<bool> statusList = [false, true, false, true];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// ---------- Search Box ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildInput("ID", "Enter ID"),
                  _buildInput("Sort", "Enter sort order"),
                  _buildInput("Login Account", "Enter login account"),
                  _buildInput("Phone", "Enter phone number"),
                  _buildInput("Login Count", "Enter login count"),
                  _buildInput("Notes", "Enter notes"),
                  _buildDropdown("Status", ["All", "Open", "Closed"]),
                  _buildInput("Creation Date", "Enter creation date"),
                  ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {},
                      child: const Text("Search")),
                  OutlinedButton(onPressed: () {}, child: const Text("Reset")),
                ],
              ),
            ),

            /// ---------- Action Buttons ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey.shade50,
              child: Wrap(
                spacing: 8,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue),
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text("Add"),
                  ),
                  ElevatedButton.icon(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    icon: const Icon(Icons.delete, size: 16),
                    label: const Text("Delete"),
                  ),
                  ElevatedButton.icon(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {},
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text("Export"),
                  ),
                ],
              ),
            ),

            /// ---------- Data Table ----------
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: width), // 🔥 full screen
                    child: DataTable(
                      headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade100),
                      columnSpacing: 30,
                      columns: const [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Sort")),
                        DataColumn(label: Text("Login")),
                        DataColumn(label: Text("Avatar")),
                        DataColumn(label: Text("Phone")),
                        DataColumn(label: Text("Login Count")),
                        DataColumn(label: Text("Notes")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Created At")),
                        DataColumn(label: Text("Actions")),
                      ],
                      rows: List.generate(statusList.length, (index) {
                        return DataRow(
                          cells: [
                            DataCell(Text("${index + 1}")),
                            const DataCell(Text("0")),
                            const DataCell(Text("admin")),
                            const DataCell(CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://i.pravatar.cc/100"))),
                            DataCell(Text("+88017${index}234567")),
                            DataCell(Text("${1000 + index}")),
                            const DataCell(Text("Some notes...")),
                            DataCell(Switch(
                              value: statusList[index],
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                setState(() {
                                  statusList[index] = val;
                                });
                              },
                            )),
                            // 🔥 Dynamic date দেখানো হবে
                            DataCell(Text(
                                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${(DateTime.now().day - index).toString().padLeft(2, "0")}")),
                            DataCell(Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4)),
                                  onPressed: () {},
                                  child: const Text("Edit",
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(width: 6),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4)),
                                  onPressed: () {},
                                  child: const Text("Set Password",
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(width: 6),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4)),
                                  onPressed: () {},
                                  child: const Text("Delete",
                                      style: TextStyle(fontSize: 12)),
                                ),
                              ],
                            )),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Input Field ----------
  static Widget _buildInput(String label, String hint) {
    return SizedBox(
      width: 200,
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

  /// ---------- Dropdown ----------
  static Widget _buildDropdown(String label, List<String> items) {
    return SizedBox(
      width: 200,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {},
      ),
    );
  }
}
