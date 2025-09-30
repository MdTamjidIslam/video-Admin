import 'package:flutter/material.dart';
import 'package:landing_page/sistam_management.dart';

void main() => runApp(const MyApp());

/// ===================== ROOT APP =====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      ),
      home: const MainTabsPage(),
    );
  }
}

/// ===================== MAIN PAGE WITH TOP TAB =====================
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
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Dashboard"),
            Tab(text: "Shopping Mall"),
            Tab(text: "Content"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DashboardPage(),          // index 0
          ShoppingMallScreen(),     // index 1
          ContentManagementScreen() // index 2
        ],
      ),
    );
  }
}

/// ===================== 0. Dashboard Page =====================


/// ===================== 1. Shopping Mall Screen =====================
class ShoppingMallScreen extends StatelessWidget {
  const ShoppingMallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Sidebar
        Container(
          width: 240,
          color: const Color(0xFF1E1E2D),
          child: const Center(
            child: Text("🏬 Shopping Mall Menu",
                style: TextStyle(color: Colors.white)),
          ),
        ),
        /// Content
        const Expanded(
          child: Center(
            child: Text("Shopping Mall Management Screen",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

/// ===================== 2. Content Management Screen =====================
class ContentManagementScreen extends StatelessWidget {
  const ContentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Sidebar
        Container(
          width: 240,
          color: const Color(0xFF1E1E2D),
          child: const Center(
            child: Text("📑 Content Menu",
                style: TextStyle(color: Colors.white)),
          ),
        ),
        /// Content
        const Expanded(
          child: Center(
            child: Text("Content Management Screen",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

/// ===================== SIDEBAR MENU WIDGET =====================
class SidebarMenu extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SidebarMenu({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: const Color(0xFF1E1E2D),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return InkWell(
            onTap: () => onItemSelected(index),
            child: Container(
              color: isSelected ? Colors.indigo : Colors.transparent,
              child: ListTile(
                leading: Icon(
                  items[index]['icon'],
                  color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  items[index]['title'],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
