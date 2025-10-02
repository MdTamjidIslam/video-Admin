import 'package:flutter/material.dart';

class AdminDesignPage extends StatefulWidget {
  const AdminDesignPage({super.key});

  @override
  State<AdminDesignPage> createState() => _AdminDesignPageState();
}

class _AdminDesignPageState extends State<AdminDesignPage> {
  final List<_RowItem> _items = List.generate(
    12,
        (i) => _RowItem(
      id: i + 1,
      permission: "Permission ${i + 1}",
      quickLink: "/system/auth/${i + 1}",
    ),
  );

  int currentPage = 1;
  int rowsPerPage = 8;

  @override
  Widget build(BuildContext context) {
    final total = _items.length;
    final start = (currentPage - 1) * rowsPerPage;
    final end = (start + rowsPerPage) > total ? total : (start + rowsPerPage);
    final pageItems = _items.sublist(start, end);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;

            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================== Conditional Search ==================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _filterField("ID", "Please enter your ID"),
                        _filterField("Sort", "Please enter the sorting order"),
                        _filterField("Permission Name", "Please enter the permission name"),
                        _filterField("Icon", "Please enter the icon"),
                        _filterField("Quick Links", "Please enter the quick link"),
                        _filterField("Note information", "Please provide remarks"),
                        _filterField("Status", "- All -"),
                        _filterField("Creation Date", "Please enter the creation time"),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(onPressed: () {}, child: const Text("Search")),
                            const SizedBox(width: 8),
                            OutlinedButton(onPressed: () {}, child: const Text("Reset")),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// ================== Action Buttons ==================
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          icon: const Icon(Icons.add),
                          label: const Text("+ Add")),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete")),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          icon: const Icon(Icons.download),
                          label: const Text("Group export")),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// ================== Data Table ==================
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // ছোট screen এ scroll হবে
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: screenWidth < 1000 ? 1000 : screenWidth, // Desktop এ full width, ছোট screen এ scroll
                        ),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
                          border: TableBorder.all(color: Colors.grey.shade300),
                          columns: const [
                            DataColumn(label: Text("ID")),
                            DataColumn(label: Text("Sort")),
                            DataColumn(label: Text("Permission Name")),
                            DataColumn(label: Text("Icon")),
                            DataColumn(label: Text("Quick Links")),
                            DataColumn(label: Text("Note information")),
                            DataColumn(label: Text("Status")),
                            DataColumn(label: Text("Creation Date")),
                            DataColumn(label: Text("Operation")),
                          ],
                          rows: List.generate(pageItems.length, (i) {
                            final item = pageItems[i];
                            return DataRow(cells: [
                              DataCell(Text("${item.id}")),
                              const DataCell(Text("0")),
                              DataCell(Text(item.permission)),
                              const DataCell(Text("🔧")),
                              DataCell(Text(item.quickLink)),
                              DataCell(Text("Remarks ${item.id}")),
                              DataCell(Switch(
                                value: item.status,
                                activeColor: Colors.blue,
                                onChanged: (v) => setState(() => item.status = v),
                              )),
                              DataCell(Text("2020-0${(item.id % 9) + 1}-01")),

                              /// 👉 Edit + Delete icons properly aligned
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.green),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {},
                                  ),
                                ],
                              )),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ================== Pagination ==================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: currentPage > 1
                                  ? () => setState(() => currentPage--)
                                  : null,
                              icon: const Icon(Icons.chevron_left)),
                          Text("Page $currentPage"),
                          IconButton(
                              onPressed: end < total
                                  ? () => setState(() => currentPage++)
                                  : null,
                              icon: const Icon(Icons.chevron_right)),
                          const SizedBox(width: 12),
                          Text("Showing ${start + 1} - $end of $total"),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Items per page: "),
                          DropdownButton<int>(
                            value: rowsPerPage,
                            items: [5, 8, 10, 20]
                                .map((e) => DropdownMenuItem(value: e, child: Text("$e")))
                                .toList(),
                            onChanged: (v) {
                              if (v == null) return;
                              setState(() {
                                rowsPerPage = v;
                                currentPage = 1;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Filter Fields
  Widget _filterField(String label, String hint) {
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

/// ================== Model ==================
class _RowItem {
  final int id;
  final String permission;
  final String quickLink;
  bool status;

  _RowItem({
    required this.id,
    required this.permission,
    required this.quickLink,
    this.status = true,
  });
}
