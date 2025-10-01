// import 'package:flutter/material.dart';
// import 'package:landing_page/sistam_management.dart';
//
// void main() => runApp(const MyApp());
//
// /// ===================== ROOT APP =====================
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Admin Dashboard',
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFF7F8FA),
//       ),
//       home: const MainTabsPage(),
//     );
//   }
// }
//
// /// ===================== MAIN PAGE WITH TOP TAB =====================
// class MainTabsPage extends StatefulWidget {
//   const MainTabsPage({super.key});
//   @override
//   State<MainTabsPage> createState() => _MainTabsPageState();
// }
//
// class _MainTabsPageState extends State<MainTabsPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Admin Dashboard"),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           tabs: const [
//             Tab(text: "Dashboard"),
//             Tab(text: "Shopping Mall"),
//             Tab(text: "Content"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const [
//           DashboardPage(),          // index 0
//           ShoppingMallScreen(),     // index 1
//           ContentManagementScreen() // index 2
//         ],
//       ),
//     );
//   }
// }
//
// /// ===================== 0. Dashboard Page =====================
//
//
// /// ===================== 1. Shopping Mall Screen =====================
// class ShoppingMallScreen extends StatelessWidget {
//   const ShoppingMallScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         /// Sidebar
//         Container(
//           width: 240,
//           color: const Color(0xFF1E1E2D),
//           child: const Center(
//             child: Text("🏬 Shopping Mall Menu",
//                 style: TextStyle(color: Colors.white)),
//           ),
//         ),
//         /// Content
//         const Expanded(
//           child: Center(
//             child: Text("Shopping Mall Management Screen",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /// ===================== 2. Content Management Screen =====================
// class ContentManagementScreen extends StatelessWidget {
//   const ContentManagementScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         /// Sidebar
//         Container(
//           width: 240,
//           color: const Color(0xFF1E1E2D),
//           child: const Center(
//             child: Text("📑 Content Menu",
//                 style: TextStyle(color: Colors.white)),
//           ),
//         ),
//         /// Content
//         const Expanded(
//           child: Center(
//             child: Text("Content Management Screen",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /// ===================== SIDEBAR MENU WIDGET =====================
// class SidebarMenu extends StatelessWidget {
//   final List<Map<String, dynamic>> items;
//   final int selectedIndex;
//   final Function(int) onItemSelected;
//
//   const SidebarMenu({
//     super.key,
//     required this.items,
//     required this.selectedIndex,
//     required this.onItemSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 240,
//       color: const Color(0xFF1E1E2D),
//       child: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           bool isSelected = index == selectedIndex;
//           return InkWell(
//             onTap: () => onItemSelected(index),
//             child: Container(
//               color: isSelected ? Colors.indigo : Colors.transparent,
//               child: ListTile(
//                 leading: Icon(
//                   items[index]['icon'],
//                   color: Colors.white,
//                   size: 20,
//                 ),
//                 title: Text(
//                   items[index]['title'],
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:landing_page/sistam_management.dart';

import 'Store Management/store_management.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF7F8FA)),
      home: const MainTabsPage(),
    );
  }
}

/// ===================== MAIN PAGE =====================
class MainTabsPage extends StatefulWidget {
  const MainTabsPage({super.key});
  @override
  State<MainTabsPage> createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// 🔹 TOP HEADER (same as image)
          Container(
            height: 80,
            color: Colors.white,
            child: Row(
              children: [
                /// Left Logo + Title
                Container(
                  height: 80,
                  color: const Color(0xFF1E1E2D),
                  width: 240,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("54M ",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Text("test",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                ),

                /// Tabs (center)
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.blue,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "系统管理"), // System Management
                      Tab(text: "商城管理"), // Shopping Mall Management
                      Tab(text: "内容管理"), // Content Management
                    ],
                  ),
                ),

                /// Right side actions
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: const [
                      Icon(Icons.settings, color: Colors.grey),
                      SizedBox(width: 16),
                      Icon(Icons.fullscreen, color: Colors.grey),
                      SizedBox(width: 16),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.blue,
                        child: Text("A",
                            style:
                            TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                      SizedBox(width: 8),
                      Text("admin",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 TAB CONTENT
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                DashboardPage(),
                StoreManagement(),
                Center(child: Text("Content Management Screen")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
