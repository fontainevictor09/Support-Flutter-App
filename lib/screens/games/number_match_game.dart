import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:math';

class NumberMatchGame extends StatefulWidget {
  const NumberMatchGame({super.key});

  @override
  State<NumberMatchGame> createState() => _NumberMatchGameState();
}

class _NumberMatchGameState extends State<NumberMatchGame> {
  List<int> numbers = [];
  List<bool> flipped = [];
  List<bool> matched = [];
  int? firstChoice;
  int? secondChoice;
  bool canFlip = true;
  int score = 0;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    numbers = [];
    // Create pairs of numbers
    for (int i = 1; i <= 8; i++) {
      numbers.add(i);
      numbers.add(i);
    }
    // Shuffle the numbers
    numbers.shuffle();
    flipped = List.generate(16, (index) => false);
    matched = List.generate(16, (index) => false);
  }

  void onCardTap(int index) {
    if (!canFlip || flipped[index] || matched[index]) return;

    setState(() {
      flipped[index] = true;

      if (firstChoice == null) {
        firstChoice = index;
      } else {
        secondChoice = index;
        canFlip = false;

        // Check if numbers match
        if (numbers[firstChoice!] == numbers[secondChoice!]) {
          matched[firstChoice!] = true;
          matched[secondChoice!] = true;
          score += 10;
          firstChoice = null;
          secondChoice = null;
          canFlip = true;
        } else {
          // If they don't match, flip them back
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              flipped[firstChoice!] = false;
              flipped[secondChoice!] = false;
              firstChoice = null;
              secondChoice = null;
              canFlip = true;
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5E35B1),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: const Text('Number Match'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 16,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onCardTap(index),
              child: Card(
                color: matched[index]
                    ? Colors.green[300]
                    : flipped[index]
                        ? Colors.white
                        : Colors.deepPurple[400],
                child: Center(
                  child: flipped[index]
                      ? Text(
                          '${numbers[index]}',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.deepPurple[700],
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[700],
        onPressed: () {
          setState(() {
            initializeGame();
            score = 0;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
