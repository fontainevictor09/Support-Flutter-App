import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SpeedMathGame extends StatefulWidget {
  const SpeedMathGame({super.key});

  @override
  State<SpeedMathGame> createState() => _SpeedMathGameState();
}

class _SpeedMathGameState extends State<SpeedMathGame> {
  int num1 = 0;
  int num2 = 0;
  String operator = '+';
  List<int> answers = [];
  int correctAnswer = 0;
  int score = 0;
  int timeLeft = 90;
  Timer? timer;
  bool isGameActive = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startGame() {
    setState(() {
      score = 0;
      timeLeft = 90;
      isGameActive = true;
    });
    generateNewProblem();
    startTimer();
  }

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          endGame();
        }
      });
    });
  }

  Future<void> endGame() async {
    timer?.cancel();
    setState(() {
      isGameActive = false;
    });

    // Save high score
    final prefs = await SharedPreferences.getInstance();
    int currentHighScore = prefs.getInt('highScore') ?? 0;
    if (score > currentHighScore) {
      await prefs.setInt('highScore', score);
    }

    // Update total games played
    int gamesPlayed = prefs.getInt('totalGamesPlayed') ?? 0;
    await prefs.setInt('totalGamesPlayed', gamesPlayed + 1);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Great Job!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your score: $score'),
            if (score > currentHighScore)
              const Text(
                '\nNew High Score!',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void generateNewProblem() {
    final random = Random();

    // Using numbers 1-5 for simple math
    num1 = random.nextInt(5) + 1;
    num2 = random.nextInt(5) + 1;

    // Only use addition and subtraction
    if (random.nextBool()) {
      operator = '+';
      correctAnswer = num1 + num2;
    } else {
      // Ensure subtraction always results in a positive number
      if (num1 < num2) {
        int temp = num1;
        num1 = num2;
        num2 = temp;
      }
      operator = '-';
      correctAnswer = num1 - num2;
    }

    // Generate answers that are close to the correct answer
    answers = [correctAnswer];
    while (answers.length < 4) {
      // Generate wrong answers that are ±1 or ±2 from the correct answer
      int wrongAnswer = correctAnswer +
          (random.nextBool() ? 1 : -1) * (random.nextInt(2) + 1);
      if (!answers.contains(wrongAnswer) && wrongAnswer >= 0) {
        answers.add(wrongAnswer);
      }
    }
    answers.shuffle();
  }

  void checkAnswer(int selectedAnswer) {
    if (!isGameActive) return;

    bool isCorrect = selectedAnswer == correctAnswer;

    setState(() {
      if (isCorrect) {
        score += 10;
      }
    });

    // Show feedback
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'Correct!' : 'Try again!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(milliseconds: 500),
      ),
    );

    // Generate new problem after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && isGameActive) {
        setState(() {
          generateNewProblem();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5E35B1),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: const Text('Simple Math'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Time: $timeLeft',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isGameActive) ...[
                const Text(
                  'Ready to Play?',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Game',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ] else ...[
                Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '$num1 $operator $num2 = ?',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.deepPurple[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: answers.map((answer) {
                    return ElevatedButton(
                      onPressed: () => checkAnswer(answer),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[400],
                        padding: const EdgeInsets.all(24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        '$answer',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
