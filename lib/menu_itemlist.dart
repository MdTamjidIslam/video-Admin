// import 'package:flutter/material.dart';
//
// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});
//
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> {
//   int selectedIndex = 0;
//
//   // Sidebar menu items
//   final List<String> menuItems = [
//     "Role Management",
//     "Menu Management",
//     "Node Management",
//     "Configuration Management",
//     "Upload Management",
//     "Quick Access",
//     "Log Management",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // 🔹 Sidebar
//           Container(
//             width: 220,
//             color: const Color(0xFF1E2A38),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 60,
//                   color: Colors.black87,
//                   alignment: Alignment.center,
//                   child: const Text(
//                     "54m_test",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: menuItems.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(
//                           menuItems[index],
//                           style: TextStyle(
//                             color: selectedIndex == index
//                                 ? Colors.white
//                                 : Colors.white70,
//                           ),
//                         ),
//                         tileColor: selectedIndex == index
//                             ? Colors.blue
//                             : Colors.transparent,
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = index;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // 🔹 Main Content
//           Expanded(
//             child: Container(
//               color: Colors.white,
//               padding: const EdgeInsets.all(16),
//               child: IndexedStack(
//                 index: selectedIndex,
//                 children: [
//                   _roleManagementPage(),
//                   _menuManagementPage(),
//                   _nodeManagementPage(),
//                   _placeholder("Configuration Management"),
//                   _placeholder("Upload Management"),
//                   _placeholder("Quick Access"),
//                   _placeholder("Log Management"),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Placeholder for pages not designed yet
//   Widget _placeholder(String title) {
//     return Center(
//       child: Text(
//         "$title Page",
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   // 🔹 Role Management Page (Previous Design)
//   Widget _roleManagementPage() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Role Management",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 16),
//
//         // Table header
//         Container(
//           color: Colors.grey.shade200,
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: const [
//               Expanded(flex: 1, child: Text("ID")),
//               Expanded(flex: 2, child: Text("Permission Name")),
//               Expanded(flex: 3, child: Text("Note Information")),
//               Expanded(flex: 2, child: Text("Status")),
//               Expanded(flex: 3, child: Text("Creation Date")),
//               Expanded(flex: 3, child: Text("Operation")),
//             ],
//           ),
//         ),
//
//         // One Row
//         Container(
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(color: Colors.grey.shade300),
//             ),
//           ),
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: [
//               const Expanded(flex: 1, child: Text("1")),
//               const Expanded(flex: 2, child: Text("Administrator")),
//               const Expanded(flex: 3, child: Text("Test Administrator")),
//               const Expanded(
//                 flex: 2,
//                 child: SwitchExample(),
//               ),
//               const Expanded(flex: 3, child: Text("2020-05-08 15:09:13")),
//               Expanded(
//                 flex: 3,
//                 child: Row(
//                   children: [
//                     _opBtn(Icons.edit, Colors.green),
//                     _opBtn(Icons.delete, Colors.red),
//                     _opBtn(Icons.more_horiz, Colors.blue),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // 🔹 Menu Management Page
//   Widget _menuManagementPage() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Menu Management",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 16),
//         const Text("👉 এখানে তুমি চাইলে Menu CRUD যোগ করতে পারো।"),
//       ],
//     );
//   }
//
//   // 🔹 Node Management Page (Tree Table Design)
//   Widget _nodeManagementPage() {
//     final List<Map<String, dynamic>> nodes = [
//       {
//         "node": "system.admin",
//         "name": "Administrator management",
//         "time": "2020-05-16 06:07:12",
//         "children": [
//           {"node": "system.admin/index", "name": "Add to the list"},
//           {"node": "system.admin/edit", "name": "Editor"},
//           {"node": "system.admin/password", "name": "Password"},
//         ]
//       },
//       {
//         "node": "system.auth",
//         "name": "Authorization",
//         "time": "2020-05-16 06:07:12",
//         "children": [
//           {"node": "system.auth/authorize", "name": "Authorize"},
//           {"node": "system.auth/saveAuthorize", "name": "Save"},
//         ]
//       }
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Node Management",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 16),
//
//         // Header
//         Container(
//           color: Colors.grey.shade200,
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: const [
//               Expanded(flex: 3, child: Text("System Node")),
//               Expanded(flex: 3, child: Text("Node Name")),
//               Expanded(flex: 2, child: Text("Update Time")),
//               Expanded(flex: 2, child: Text("Node Control")),
//             ],
//           ),
//         ),
//
//         // Rows
//         Expanded(
//           child: ListView(
//             children: nodes.map((item) {
//               return ExpansionTile(
//                 title: Row(
//                   children: [
//                     Expanded(flex: 3, child: Text(item["node"])),
//                     Expanded(flex: 3, child: Text(item["name"])),
//                     Expanded(flex: 2, child: Text(item["time"])),
//                     const Expanded(flex: 2, child: SwitchExample()),
//                   ],
//                 ),
//                 children: (item["children"] as List).map((child) {
//                   return Container(
//                     padding:
//                     const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade300),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(flex: 3, child: Text(child["node"])),
//                         Expanded(flex: 3, child: Text(child["name"])),
//                         const Expanded(flex: 2, child: Text("2020-05-16")),
//                         const Expanded(flex: 2, child: SwitchExample()),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   static Widget _opBtn(IconData icon, Color color) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: IconButton(
//         onPressed: () {},
//         icon: Icon(icon, color: color, size: 20),
//       ),
//     );
//   }
// }
//
// // 🔹 Reusable Switch Widget
// class SwitchExample extends StatefulWidget {
//   const SwitchExample({super.key});
//
//   @override
//   State<SwitchExample> createState() => _SwitchExampleState();
// }
//
// class _SwitchExampleState extends State<SwitchExample> {
//   bool isActive = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: isActive,
//       activeColor: Colors.blue,
//       onChanged: (val) {
//         setState(() {
//           isActive = val;
//         });
//       },
//     );
//   }
// }
