// import 'package:flutter/material.dart';
//
// class NodeManagementPage extends StatelessWidget {
//   const NodeManagementPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Top Buttons
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                   child: const Text("Update Node"),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                   child: const Text("Save Changes"),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: const Text("Delete Node"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             /// Table Header
//             Container(
//               color: Colors.grey.shade200,
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//               child: Row(
//                 children: const [
//                   Expanded(flex: 3, child: Text("System node")),
//                   Expanded(flex: 3, child: Text("Node name")),
//                   Expanded(flex: 2, child: Text("Update time")),
//                   Expanded(flex: 2, child: Text("Node control")),
//                 ],
//               ),
//             ),
//
//             /// Table Rows
//             Expanded(
//               child: ListView(
//                 children: [
//                   _buildRow("system.admin", "Administrator management",
//                       "2020-05-16 06:07:12", true),
//                   _buildRow(" └─ system.admin/index", "Add to the list",
//                       "2020-05-16 06:07:12", true),
//                   _buildRow(" └─ system.admin/edit", "Editor",
//                       "2020-05-16 06:07:12", true),
//                   _buildRow(" └─ system.admin/password", "Editor’s Password",
//                       "2020-05-16 06:07:12", false),
//                   _buildRow(" └─ system.admin/delete", "Delete",
//                       "2020-05-16 06:07:12", false),
//                   _buildRow(" └─ system.admin/export", "Export",
//                       "2020-05-16 06:07:12", true),
//                   _buildRow("system.auth", "Authorization",
//                       "2020-05-16 06:07:12", true),
//                   _buildRow(" └─ system.auth/add", "Add",
//                       "2020-05-16 06:07:12", true),
//                   _buildRow(" └─ system.auth/delete", "Delete",
//                       "2020-05-16 06:07:12", true),
//                   _buildRow(" └─ system.auth/export", "Export",
//                       "2020-05-16 06:07:12", false),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Row Builder
//   Widget _buildRow(
//       String systemNode, String nodeName, String updateTime, bool active) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
//       ),
//       child: Row(
//         children: [
//           Expanded(flex: 3, child: Text(systemNode)),
//           Expanded(flex: 3, child: Text(nodeName)),
//           Expanded(flex: 2, child: Text(updateTime)),
//           Expanded(
//             flex: 2,
//             child: Switch(
//               value: active,
//               activeColor: Colors.blue,
//               onChanged: (_) {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';


class NodeManagementPage extends StatefulWidget {
  const NodeManagementPage({super.key});

  @override
  State<NodeManagementPage> createState() => _NodeManagementPageState();
}

class _NodeManagementPageState extends State<NodeManagementPage> {
  // Row data list (switch state সহ)
  final List<Map<String, dynamic>> rows = [
    {
      "systemNode": "system.admin",
      "nodeName": "Administrator management",
      "updateTime": "2020-05-16 06:07:12",
      "active": true
    },
    {
      "systemNode": " └─ system.admin/index",
      "nodeName": "Add to the list",
      "updateTime": "2020-05-16 06:07:12",
      "active": true
    },
    {
      "systemNode": " └─ system.admin/edit",
      "nodeName": "Editor",
      "updateTime": "2020-05-16 06:07:12",
      "active": true
    },
    {
      "systemNode": " └─ system.admin/password",
      "nodeName": "Editor’s Password",
      "updateTime": "2020-05-16 06:07:12",
      "active": false
    },
    {
      "systemNode": " └─ system.admin/delete",
      "nodeName": "Delete",
      "updateTime": "2020-05-16 06:07:12",
      "active": false
    },
    {
      "systemNode": " └─ system.admin/export",
      "nodeName": "Export",
      "updateTime": "2020-05-16 06:07:12",
      "active": true
    },
    {
      "systemNode": "system.auth",
      "nodeName": "Authorization",
      "updateTime": "2020-05-16 06:07:12",
      "active": true
    },
    {
      "systemNode": " └─ system.auth/add",
      "nodeName": "Add",
      "updateTime": "2020-05-16 06:07:12",
      "active": true
    },
    {
      "systemNode": " └─ system.auth/delete",
      "nodeName": "Delete",
      "updateTime": "2020-05-16 06:07:12",
      "active": true
    },
    {
      "systemNode": " └─ system.auth/export",
      "nodeName": "Export",
      "updateTime": "2020-05-16 06:07:12",
      "active": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Update Node"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Save Changes"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Delete Node"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Table Header
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(flex: 3, child: Text("System node")),
                  Expanded(flex: 3, child: Text("Node name")),
                  Expanded(flex: 2, child: Text("Update time")),
                  Expanded(flex: 2, child: Text("Node control")),
                ],
              ),
            ),

            /// Table Rows (Switch now works)
            Expanded(
              child: ListView.builder(
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  final row = rows[index];
                  return Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(row["systemNode"])),
                        Expanded(flex: 3, child: Text(row["nodeName"])),
                        Expanded(flex: 2, child: Text(row["updateTime"])),
                        Expanded(
                          flex: 2,
                          child: Switch(
                            value: row["active"],
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              setState(() {
                                row["active"] = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
