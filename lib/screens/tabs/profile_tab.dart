import 'package:flutter/material.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/settings_tile.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple[400],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level 5 Explorer',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Statistics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: StatCard(
                    title: 'Games Played',
                    value: '42',
                    icon: Icons.gamepad,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    title: 'Tasks Done',
                    value: '28',
                    icon: Icons.task_alt,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: StatCard(
                    title: 'Total Points',
                    value: '750',
                    icon: Icons.star,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    title: 'Streak',
                    value: '5 days',
                    icon: Icons.local_fire_department,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const SettingsTile(
              title: 'Notifications',
              icon: Icons.notifications,
              hasSwitch: true,
            ),
            const SettingsTile(
              title: 'Sound Effects',
              icon: Icons.volume_up,
              hasSwitch: true,
            ),
            const SettingsTile(
              title: 'Dyslexia Font',
              icon: Icons.text_fields,
              hasSwitch: true,
            ),
            const SettingsTile(
              title: 'High Contrast Mode',
              icon: Icons.contrast,
              hasSwitch: true,
            ),
            const SettingsTile(
              title: 'Help & Support',
              icon: Icons.help,
              hasSwitch: false,
            ),
            const SettingsTile(
              title: 'About',
              icon: Icons.info,
              hasSwitch: false,
            ),
          ],
        ),
      ),
    );
  }
}
