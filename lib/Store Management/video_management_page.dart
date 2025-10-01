import 'package:flutter/material.dart';

/// ===================== VIDEO MANAGEMENT PAGE =====================
class VideoManagementPage extends StatefulWidget {
  const VideoManagementPage({super.key});

  @override
  State<VideoManagementPage> createState() => _VideoManagementPageState();
}

class _VideoManagementPageState extends State<VideoManagementPage> {
  /// প্রতিটি row এর জন্য আলাদা status & recommend list
  List<bool> statusSwitches = List.generate(50, (index) => index % 2 == 0);
  List<bool> recommendSwitches =
  List.generate(50, (index) => index % 3 == 0 ? true : false);

  /// Pagination
  int currentPage = 1;
  int rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    int start = (currentPage - 1) * rowsPerPage;
    int end = (start + rowsPerPage > statusSwitches.length)
        ? statusSwitches.length
        : start + rowsPerPage;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Conditional Search Form
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 12,
                          children: [
                            _buildTextField("ID", "Please enter your ID"),
                            _buildTextField("Sort", "Sorting order"),
                            _buildTextField("Video classification", "- All"),
                            _buildTextField("Video Title", "Enter video title"),
                            _buildTextField("Status", "- All"),
                            _buildTextField("Is Recommended?", "- All"),
                            _buildTextField(
                                "Creation Date", "Please enter date"),

                            /// Search + Reset
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

                    /// 🔹 Add/Delete/Export Buttons
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
                            child: const Text("Export")),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// 🔹 Data Table (Responsive + Scroll)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minWidth: constraints.maxWidth - 32),
                        child: DataTable(
                          headingRowColor:
                          MaterialStateProperty.all(Colors.grey.shade200),
                          border: TableBorder.all(color: Colors.grey.shade300),
                          columns: const [
                            DataColumn(label: Text("ID")),
                            DataColumn(label: Text("Sort")),
                            DataColumn(label: Text("Video classification")),
                            DataColumn(label: Text("Video Title")),
                            DataColumn(label: Text("Video Image")),
                            DataColumn(label: Text("Status")),
                            DataColumn(label: Text("Recommended")),
                            DataColumn(label: Text("Creation Date")),
                            DataColumn(label: Text("Operation")),
                          ],
                          rows: List.generate(end - start, (i) {
                            int index = start + i;
                            return DataRow(cells: [
                              DataCell(Text("119${index + 1}")),
                              const DataCell(Text("0")),
                              DataCell(Text("Category $index")),
                              DataCell(Text("Video Title $index")),
                              DataCell(Container(
                                height: 40,
                                width: 60,
                                color: Colors.grey.shade300,
                                child: const Center(child: Text("Img")),
                              )),

                              /// 🔹 Status Switch (individual)
                              DataCell(Switch(
                                value: statusSwitches[index],
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  setState(() {
                                    statusSwitches[index] = val;
                                  });
                                },
                              )),

                              /// 🔹 Recommended Switch (individual)
                              DataCell(Switch(
                                value: recommendSwitches[index],
                                activeColor: Colors.red,
                                onChanged: (val) {
                                  setState(() {
                                    recommendSwitches[index] = val;
                                  });
                                },
                              )),

                              const DataCell(Text("2025-09-30")),

                              /// 🔹 Operation Buttons
                              DataCell(Row(
                                children: [
                                  _opBtn("Edit", Colors.green),
                                  const SizedBox(width: 4),
                                  _opBtn("Delete", Colors.red),
                                ],
                              )),
                            ]);
                          }),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 Pagination Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Prev / Next
                        Row(
                          children: [
                            TextButton(
                              onPressed: currentPage > 1
                                  ? () => setState(() => currentPage--)
                                  : null,
                              child: const Text("⬅ Prev"),
                            ),
                            Text("Page $currentPage"),
                            TextButton(
                              onPressed: end < statusSwitches.length
                                  ? () => setState(() => currentPage++)
                                  : null,
                              child: const Text("Next ➡"),
                            ),
                          ],
                        ),

                        /// Rows per page
                        Row(
                          children: [
                            const Text("Rows per page: "),
                            DropdownButton<int>(
                              value: rowsPerPage,
                              items: [5, 10, 20, 50]
                                  .map((e) => DropdownMenuItem(
                                  value: e, child: Text("$e")))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  rowsPerPage = val!;
                                  currentPage = 1;
                                });
                              },
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
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

  /// 🔹 Operation Button
  Widget _opBtn(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12)),
    );
  }
}
