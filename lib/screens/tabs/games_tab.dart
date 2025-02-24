import 'package:flutter/material.dart';
import '../../widgets/game_card.dart';

class GamesTab extends StatelessWidget {
  const GamesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Math Games',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  GameCard(
                    title: 'Number Match',
                    description: 'Match pairs of numbers',
                    icon: Icons.calculate,
                  ),
                  GameCard(
                    title: 'Speed Math',
                    description: 'Solve equations quickly',
                    icon: Icons.timer,
                  ),
                  GameCard(
                    title: 'Pattern Game',
                    description: 'Find the next number',
                    icon: Icons.pattern,
                  ),
                  GameCard(
                    title: 'Memory Math',
                    description: 'Remember and solve',
                    icon: Icons.memory,
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
