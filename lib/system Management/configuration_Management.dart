import 'package:flutter/material.dart';

class ConfigManagementPage extends StatefulWidget {
  const ConfigManagementPage({super.key});

  @override
  State<ConfigManagementPage> createState() => _ConfigManagementPageState();
}

class _ConfigManagementPageState extends State<ConfigManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 TOP TABS
            Container(
              color: Colors.grey.shade100,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Website settings"),
                  Tab(text: "LOGO configuration"),
                  Tab(text: "Upload configuration"),
                  Tab(text: "Return link"),
                ],
              ),
            ),

            /// 🔹 TAB CONTENT
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _websiteSettings(),
                  _logoConfig(),
                  _uploadConfig(),
                  _returnLink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ==================== 1. Website Settings Screen ====================
  Widget _websiteSettings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField("Site Name", "54M_test Back-end System"),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildFormField("Browser icon", "/favicon.png")),
              const SizedBox(width: 16),
              Container(
                height: 60,
                width: 60,
                color: Colors.grey.shade200,
                child: const Center(child: Text("IMG")),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("On the land")),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Choice")),
            ],
          ),
          const SizedBox(height: 20),
          _buildFormField("Version Information", "2.7.6"),
          const SizedBox(height: 20),
          _buildFormField("Cloud transcoding URL", "Fill in yours"),
          const SizedBox(height: 20),
          _buildFormField("Registration Information", "Fill in yours"),
          const SizedBox(height: 20),
          _buildFormField("Site Title", "54m"),
          const SizedBox(height: 20),
          _buildFormField("Site domain names", "54m.com"),
          const SizedBox(height: 20),
          _buildFormField("Copyright Information",
              "Copyright© {{\$date}} (\$domain) All Rights Reserved"),
        ],
      ),
    );
  }

  /// ==================== 2. Logo Config Screen ====================
  Widget _logoConfig() {
    return const Center(
      child: Text("LOGO Configuration Page",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  /// ==================== 3. Upload Config Screen ====================
  Widget _uploadConfig() {
    return const Center(
      child: Text("Upload Configuration Page",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  /// ==================== 4. Return Link Screen ====================
  Widget _returnLink() {
    return const Center(
      child: Text("Return Link Page",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  /// 🔹 Form Field Builder
  Widget _buildFormField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            isDense: true,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
