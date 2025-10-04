import 'package:flutter/material.dart';

/// Safe Image wrapper → dispose error প্রতিরোধ করবে
class SafeNetworkImage extends StatelessWidget {
  final String url;
  final double size;
  const SafeNetworkImage({super.key, required this.url, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: size,
      width: size,
      fit: BoxFit.cover,
      gaplessPlayback: true, // ✅ prevent disposed stream error
      errorBuilder: (context, error, stackTrace) =>
      const Icon(Icons.broken_image, size: 30),
    );
  }
}

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
      "active": true,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.admin/index",
      "nodeName": "Add to the list",
      "updateTime": "2020-05-16 06:07:12",
      "active": true,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.admin/edit",
      "nodeName": "Editor",
      "updateTime": "2020-05-16 06:07:12",
      "active": true,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.admin/password",
      "nodeName": "Editor’s Password",
      "updateTime": "2020-05-16 06:07:12",
      "active": false,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.admin/delete",
      "nodeName": "Delete",
      "updateTime": "2020-05-16 06:07:12",
      "active": false,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.admin/export",
      "nodeName": "Export",
      "updateTime": "2020-05-16 06:07:12",
      "active": true,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": "system.auth",
      "nodeName": "Authorization",
      "updateTime": "2020-05-16 06:07:12",
      "active": true,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.auth/add",
      "nodeName": "Add",
      "updateTime": "2020-05-16 06:07:12",
      "active": true,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.auth/delete",
      "nodeName": "Delete",
      "updateTime": "2020-05-16 06:07:12",
      "active": true,
      "iconUrl": "https://via.placeholder.com/40"
    },
    {
      "systemNode": " └─ system.auth/export",
      "nodeName": "Export",
      "updateTime": "2020-05-16 06:07:12",
      "active": false,
      "iconUrl": "https://via.placeholder.com/40"
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
            /// ---------- Top Buttons ----------
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

            /// ---------- Table Header ----------
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text("Icon")),
                  Expanded(flex: 3, child: Text("System node")),
                  Expanded(flex: 3, child: Text("Node name")),
                  Expanded(flex: 2, child: Text("Update time")),
                  Expanded(flex: 2, child: Text("Node control")),
                ],
              ),
            ),

            /// ---------- Table Rows ----------
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
                        /// ✅ SafeNetworkImage ব্যবহার
                        Expanded(
                          flex: 2,
                          child: SafeNetworkImage(url: row["iconUrl"]),
                        ),
                        Expanded(flex: 3, child: Text(row["systemNode"])),
                        Expanded(flex: 3, child: Text(row["nodeName"])),
                        Expanded(flex: 2, child: Text(row["updateTime"])),
                        Expanded(
                          flex: 2,
                          child: Switch(
                            value: row["active"],
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              if (!mounted) return; // ✅ prevent disposed setState
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
