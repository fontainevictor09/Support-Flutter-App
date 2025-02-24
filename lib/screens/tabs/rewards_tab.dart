import 'package:flutter/material.dart';
import '../../widgets/reward_card.dart';

class RewardsTab extends StatelessWidget {
  const RewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rewards',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 4),
                      Text(
                        '750 points',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  RewardCard(
                    title: 'Extra Game Time',
                    points: 100,
                    icon: Icons.gamepad,
                  ),
                  RewardCard(
                    title: 'New Theme',
                    points: 200,
                    icon: Icons.palette,
                  ),
                  RewardCard(
                    title: 'Special Badge',
                    points: 300,
                    icon: Icons.badge,
                  ),
                  RewardCard(
                    title: 'Premium Game',
                    points: 500,
                    icon: Icons.star,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
