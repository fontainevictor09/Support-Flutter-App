import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class MemoryMathGame extends StatefulWidget {
  const MemoryMathGame({super.key});

  @override
  State<MemoryMathGame> createState() => _MemoryMathGameState();
}

class _MemoryMathGameState extends State<MemoryMathGame> {
  List<int> numbers = [];
  List<bool> revealed = [];
  int score = 0;
  int level = 1;
  bool isShowingNumbers = false;
  bool isGameOver = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startLevel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startLevel() {
    setState(() {
      numbers = List.generate(level + 2, (index) => Random().nextInt(90) + 10);
      revealed = List.generate(level + 2, (index) => true);
      isShowingNumbers = true;
      isGameOver = false;
    });

    // Hide numbers after 3 seconds
    timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          revealed = List.generate(level + 2, (index) => false);
          isShowingNumbers = false;
        });
      }
    });
  }

  void checkNumber(int enteredNumber) {
    int currentIndex = revealed.where((element) => element).length;
    if (currentIndex < numbers.length &&
        enteredNumber == numbers[currentIndex]) {
      setState(() {
        revealed[currentIndex] = true;
        score += 10;
      });

      if (revealed.every((element) => element)) {
        // Level completed
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Level Complete!'),
            content: Text('Score: $score\nReady for next level?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    level++;
                  });
                  startLevel();
                },
                child: const Text('Next Level'),
              ),
            ],
          ),
        );
      }
    } else {
      // Game Over
      setState(() {
        isGameOver = true;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Game Over!'),
          content: Text('Final Score: $score\nLevel Reached: $level'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  level = 1;
                  score = 0;
                });
                startLevel();
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5E35B1),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: const Text('Memory Math'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Level $level',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color:
                        revealed[index] ? Colors.white : Colors.deepPurple[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: revealed[index]
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
                );
              },
            ),
            const SizedBox(height: 32),
            if (!isShowingNumbers && !isGameOver)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter the next number',
                    hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      checkNumber(int.parse(value));
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
