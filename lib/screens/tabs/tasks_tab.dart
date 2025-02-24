import 'package:flutter/material.dart';
import '../../widgets/task_card.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Tasks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  TaskCard(
                    title: 'Complete Math Exercise',
                    points: 50,
                    timeLimit: '20 mins',
                  ),
                  TaskCard(
                    title: 'Reading Practice',
                    points: 30,
                    timeLimit: '15 mins',
                  ),
                  TaskCard(
                    title: 'Memory Game',
                    points: 40,
                    timeLimit: '10 mins',
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
