
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:landing_page/Store%20Management/video_management_page.dart';
import 'package:landing_page/role_magagement.dart';
import 'package:landing_page/system%20Management/log_management.dart';
import 'package:landing_page/system%20Management/upload_management.dart';
import 'package:landing_page/upload_screen.dart';


/// ===================== DASHBOARD PAGE =====================
class StoreManagement extends StatefulWidget {
  const StoreManagement({super.key});
  @override
  State<StoreManagement> createState() => _StoreManagementState();
}

class _StoreManagementState extends State<StoreManagement> {
  int selectedIndex = 0;

  // Sidebar titles + icons
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Video classification', 'icon': Icons.admin_panel_settings},
    {'title': 'Video Management', 'icon': Icons.people},
    {'title': 'video sharing', 'icon': Icons.menu},
    {'title': 'Number of searches', 'icon': Icons.settings},
    {'title': 'Gathering Speectations Management', 'icon': Icons.upload},
    {'title': 'Dating Management', 'icon': Icons.flash_on},
    {'title': 'Live Steraming management', 'icon': Icons.list_alt},
    {'title': 'Pharmacy Management', 'icon': Icons.list_alt},
    {'title': 'Product Management', 'icon': Icons.list_alt},
    {'title': 'Channel Management', 'icon': Icons.list_alt},
    {'title': 'Channel Summary', 'icon': Icons.list_alt},
    {'title': 'Product Summary', 'icon': Icons.list_alt},
    {'title': 'Click on the trend line', 'icon': Icons.list_alt},
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
      // return const AdminDashboardContent();
    }
    else if (index == 1) {
      // 👉 তৃতীয় মেনু => Upload Page
      return const VideoManagementPage();
    }
    else if (index == 2) {
      // 👉 তৃতীয় মেনু => Upload Page
      return const UploadPage();
    }
    else if (index == 3) {
      // 👉 তৃতীয় মেনু => Upload Page
      // return const NodeManagementPage();
    }
    else if (index == 5) {
      // 👉 তৃতীয় মেনু => Upload Page
      return const UploadManagementPage();
    }
    else if (index == 7) {
      // 👉 তৃতীয় মেনু => Upload Page
      return const LogManagementPage();
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
          // const DrawerHeader(
          //   child: Center(
          //     child: Text('54M TEST',
          //         style: TextStyle(color: Colors.white, fontSize: 20)),
          //   ),
          // ),
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
