import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:landing_page/role_magagement.dart';
import 'package:landing_page/upload_screen.dart';

import 'administrator_screem.dart';
import 'node_management_page.dart';


/// ===================== DASHBOARD PAGE =====================
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  // Sidebar titles + icons
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Administrator Management', 'icon': Icons.admin_panel_settings},
    {'title': 'Role Management', 'icon': Icons.people},
    {'title': 'Menu Management', 'icon': Icons.menu},
    {
      'title': 'Upload Management',
      'icon': Icons.upload,
      'children': [
        {'title': 'Upload File'},
        {'title': 'Upload Logs'},
        {'title': 'Upload Reports'},
        {'title': 'Upload Settings'},
      ]
    },
    {'title': 'Configuration Management', 'icon': Icons.settings},
    {'title': 'Upload Management', 'icon': Icons.upload},
    {'title': 'Quick Access', 'icon': Icons.flash_on},
    {'title': 'Log Management', 'icon': Icons.list_alt},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarMenu(
            items: menuItems,
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() => selectedIndex = index);
            },
          ),
          Expanded(child: _buildContent(selectedIndex)),
        ],
      ),
    );
  }

  /// ডানপাশের কনটেন্ট
  Widget _buildContent(int index) {
    if (index == 0) {
      // 👉 প্রথম মেনু => Administrator Dashboard
      return const AdminDashboardContent();
    }
    else if (index == 1) {
      // 👉 তৃতীয় মেনু => Upload Page
      return const RoleManagementPage();
    }
    else if (index == 2) {
      // 👉 তৃতীয় মেনু => Upload Page
      return const UploadPage();
    }
    else if (index == 3) {
      // 👉 তৃতীয় মেনু => Upload Page
      return const NodeManagementPage();
    }
    return Center(
      child: Text(
        '${menuItems[index]['title']} Screen',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// ===================== SIDEBAR MENU =====================
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
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text('54M TEST',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
