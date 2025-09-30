import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// ===================== Main Content (Dashboard) =====================
class AdminDashboardContent extends StatelessWidget {
  const AdminDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Backstage Homepage',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // === Data Statistics Cards ===
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                DashboardCard(
                    title: 'User statistics',
                    value: '1234',
                    subtitle: 'Total records in current category'),
                DashboardCard(
                    title: 'Product statistics',
                    value: '5678',
                    subtitle: 'Total number of products'),
                DashboardCard(
                    title: 'Order statistics',
                    value: '91011',
                    subtitle: 'Total number of orders'),
              ],
            ),
            const SizedBox(height: 20),

            // === Quick Access Cards ===
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                QuickAccessCard(
                    icon: Icons.admin_panel_settings, title: 'Administrator'),
                QuickAccessCard(icon: Icons.people, title: 'Role Management'),
                QuickAccessCard(icon: Icons.menu, title: 'Menu Management'),
                QuickAccessCard(icon: Icons.account_tree, title: 'Node Management'),
                QuickAccessCard(icon: Icons.settings, title: 'Configuration'),
                QuickAccessCard(icon: Icons.upload, title: 'Upload'),
              ],
            ),
            const SizedBox(height: 20),

            // === System Announcement + Version Info Row ===
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: SystemAnnouncementCard()),
                SizedBox(width: 20),
                Expanded(child: VersionInfoCard()),
              ],
            ),
            const SizedBox(height: 30),

            // === Report Chart ===
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Report Statistics',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    SizedBox(height: 250, child: _buildLineChart()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===================== Cards =====================
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.indigo)),
              const SizedBox(height: 8),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const QuickAccessCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: Colors.indigo, size: 32),
              const SizedBox(height: 10),
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===================== System Announcement Card =====================
class SystemAnnouncementCard extends StatelessWidget {
  const SystemAnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('System Announcement',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('• Modify the style of the options tab'),
            Text('• New system 404 template added'),
            Text('• New treetable plugin and menu management'),
            Text('• Fix the issue where the "Zoom" tab cannot be moved'),
          ],
        ),
      ),
    );
  }
}

/// ===================== Version Info Card =====================
class VersionInfoCard extends StatelessWidget {
  const VersionInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Version Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Framework: EasyAdmin'),
            Text('Current version: v2.0.0'),
            Text('Main Features: Zero barrier / Responsive / Minimalist'),
          ],
        ),
      ),
    );
  }
}

/// ===================== Dummy Chart =====================
Widget _buildLineChart() {
  return LineChart(LineChartData(
    gridData: FlGridData(show: true),
    titlesData: FlTitlesData(show: true),
    borderData: FlBorderData(show: true),
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 1),
          FlSpot(1, 1.5),
          FlSpot(2, 2),
          FlSpot(3, 2.5),
          FlSpot(4, 3),
        ],
        isCurved: true,
        color: Colors.indigo,
        barWidth: 3,
      ),
      LineChartBarData(
        spots: const [
          FlSpot(0, 1.2),
          FlSpot(1, 1.8),
          FlSpot(2, 2.2),
          FlSpot(3, 2.8),
          FlSpot(4, 3.2),
        ],
        isCurved: true,
        color: Colors.green,
        barWidth: 3,
      ),
    ],
  ));
}
