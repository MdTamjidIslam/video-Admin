import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class DashboardPageScreen extends StatelessWidget {
  const DashboardPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: width > 1000
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _dataStatisticsCard(),
                    const SizedBox(height: 16),
                    _quickAccessCard(),
                    const SizedBox(height: 16),
                    _reportStatisticsCard(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _systemAnnouncementCard(),
                    const SizedBox(height: 16),
                    _versionInfoCard(),
                    const SizedBox(height: 16),
                    _authorReflectionCard(),
                  ],
                ),
              ),
            ],
          )
              : Column(
            children: [
              _dataStatisticsCard(),
              const SizedBox(height: 16),
              _quickAccessCard(),
              const SizedBox(height: 16),
              _reportStatisticsCard(),
              const SizedBox(height: 16),
              _systemAnnouncementCard(),
              const SizedBox(height: 16),
              _versionInfoCard(),
              const SizedBox(height: 16),
              _authorReflectionCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// ================== Data Statistics ==================
  Widget _dataStatisticsCard() {
    final stats = [
      ("User statistics", "1234", "Total number of records in the current category", Colors.lightBlue),
      ("Product statistics", "1234", "Total number of records in the current category", Colors.green),
      ("Browse statistics", "1234", "Total number of records in the current category", Colors.orange),
      ("Order statistics", "1234", "Total number of records in the current category", Colors.red),
    ];

    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Data statistics",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _statCard("User statistics", "1234",
                    "Total number of records in the current category", Colors.lightBlue),
                _statCard("Product statistics", "1234",
                    "Total number of records in the current category", Colors.green),
                _statCard("Browse statistics", "1234",
                    "Total number of records in the current category", Colors.orange),
                _statCard("Order statistics", "1234",
                    "Total number of records in the current category", Colors.red),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget _statCard(String title, String value, String subtitle, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6)),
            child: Icon(Icons.insert_chart, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(value,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: color)),
                Text(subtitle,
                    style: const TextStyle(fontSize: 10, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  /// ================== Quick Access ==================
  Widget _quickAccessCard() {
    final items = [
      ("Administrator", Icons.admin_panel_settings),
      ("Role Management", Icons.people),
      ("Menu Management", Icons.menu),
      ("Node management", Icons.account_tree),
      ("Configuration Management", Icons.settings),
      ("Upload Management", Icons.upload),
      ("Product Classification", Icons.category),
      ("Product Management", Icons.shopping_bag),
    ];

    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quick Access",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: items.length,
              itemBuilder: (context, i) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(items[i].$2, color: Colors.indigo, size: 28),
                      const SizedBox(height: 6),
                      Text(items[i].$1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ================== Report Statistics ==================
  Widget _reportStatisticsCard() {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Report statistics",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text("Visitor statistics",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: LineChart(LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(show: true),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                      spots: const [
                        FlSpot(0, 1.5),
                        FlSpot(1, 1.6),
                        FlSpot(2, 2.0),
                        FlSpot(3, 2.4),
                        FlSpot(4, 2.8),
                      ],
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3),
                  LineChartBarData(
                      spots: const [
                        FlSpot(0, 0.5),
                        FlSpot(1, 0.7),
                        FlSpot(2, 1.0),
                        FlSpot(3, 1.3),
                        FlSpot(4, 1.5),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3),
                  LineChartBarData(
                      spots: const [
                        FlSpot(0, 0.3),
                        FlSpot(1, 0.4),
                        FlSpot(2, 0.5),
                        FlSpot(3, 0.7),
                        FlSpot(4, 1.0),
                      ],
                      isCurved: true,
                      color: Colors.purple,
                      barWidth: 3),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  /// ================== System Announcement ==================
  Widget _systemAnnouncementCard() {
    final announcements = [
      ("Modify the style of the options tab", "2019-07-11 23:06"),
      ("New system 404 template added", "2019-07-11 12:57"),
      ("New treetable plugin and menu management", "2019-07-05 14:28"),
      ("Modify the scaling issue of the logo", "2019-07-04 11:02"),
    ];

    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("System Announcement",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: announcements
                  .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(e.$1)),
                    Text(e.$2,
                        style: const TextStyle(
                            fontSize: 11, color: Colors.black54)),
                  ],
                ),
              ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  /// ================== Version Info ==================
  Widget _versionInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Version Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text("Framework Name: EasyAdmin"),
            Text("The current version: v2.0.0"),
            Text("Main Features: Zero threshold / Responsive / Refreshing / Minimalist"),
          ],
        ),
      ),
    );
  }

  /// ================== Author Reflection ==================
  Widget _authorReflectionCard() {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Author's Reflections",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text("This template is based on layui 2.5.4 and font-awesome 4.7.0"),
            Text("Zero threshold / Responsive / Refreshing / Minimalist"),
            Text("Give a thumbs-up to Star!"),
          ],
        ),
      ),
    );
  }
}
