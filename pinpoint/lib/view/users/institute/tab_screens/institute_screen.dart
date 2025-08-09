import 'package:flutter/material.dart';
import 'package:pinpoint/model/building/building_dto.dart';
import 'package:pinpoint/view/common/admin_list_screen.dart';
import 'package:pinpoint/view/common/batch_list_screen.dart';
import 'package:pinpoint/view/users/institute/building_detail_screen.dart';
import 'package:pinpoint/view/users/institute/subject_list_screen.dart';
import 'package:pinpoint/view/users/institute/upload_building_screen.dart';
import 'package:pinpoint/view/users/institute/user_list_screen.dart';
import 'package:pinpoint/view/widget/stat_card.dart';

class InstituteScreen extends StatelessWidget {
  const InstituteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Institute Dashboard"),
        //   backgroundColor: colorScheme.surface,
        //   elevation: 1,
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Text
                Text(
                  "Dashboard",
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 24),

                // Quick Statistics Grid
                _buildStatsGrid(context),

                const SizedBox(height: 32),

                // Main Action Button
                _buildUploadButton(context),

                const SizedBox(height: 32),

                // Recent Activity Section
                Text(
                  "Buildings",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                _buildBuilindList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBuilindList() {
    final List<BuildingDto> _buildings = [
      BuildingDto.getMockData(id: 'building-A', name: 'Main Campus Building'),
      BuildingDto.getMockData(id: 'building-B', name: 'Engineering Block'),
    ];
    // -
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _buildings.length,
      itemBuilder: (context, index) {
        final building = _buildings[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: ListTile(
            leading: const Icon(Icons.business_outlined, size: 40),
            title: Text(building.name ?? 'Unnamed Building',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Floors: ${building.floors?.length ?? 0}'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BuildingDetailScreen(building: building),
              ));
            },
          ),
        );
      },
    );
  }

  /// Builds the grid of summary statistics.
  Widget _buildStatsGrid(BuildContext context) {
    // Dummy data - replace with data from your view model
    final stats = [
      {
        'icon': Icons.admin_panel_settings_rounded,
        'label': 'Total Admins',
        'count': '12',
        'screen': AdminListScreen(),
      },
      {
        'icon': Icons.school_rounded,
        'label': 'Total Students',
        'count': '450',
        'screen': StudentListScreen(), // You define this
      },
      {
        'icon': Icons.groups_rounded,
        'label': 'Total Batches',
        'count': '15',
        'screen': BatchListScreen(), // You define this
      },
      {
        'icon': Icons.subject_rounded,
        'label': 'Total Subjects',
        'count': '30',
        'screen': SubjectsListScreen(), // You define this
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return StatCard(
          icon: stat['icon'] as IconData,
          label: stat['label'] as String,
          count: stat['count'] as String,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => stat['screen'] as Widget),
          ),
        );
      },
    );
  }

  /// Builds the "Upload Building Plan" button.
  Widget _buildUploadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.upload_file_rounded),
        label: const Text("Upload Building Plan"),
        onPressed: () {
          
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadBuildingPlanScreen(),
              ));
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
