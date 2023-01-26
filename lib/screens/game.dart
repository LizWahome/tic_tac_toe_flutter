import 'dart:async';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayxo = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  String resultDeclaration = '';
  bool winnerFound = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       const Text(
                          "Player O",
                          style: TextStyle(fontFamily: 'GTWalsheim', color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          oScore.toString(),
                          style: const TextStyle(fontFamily: 'GTWalsheim', color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Player X",
                          style: TextStyle(fontFamily: 'GTWalsheim', color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          xScore.toString(),
                          style: const TextStyle(fontFamily: 'GTWalsheim', color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 5, color: Colors.white70),
                            color: matchedIndexes.contains(index)
                                ? Colors.green
                                : Colors.indigo),
                        child: Center(
                          child: Text(
                            displayxo[index],
                            style: const TextStyle(
                                fontFamily: 'stereofunk', fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultDeclaration,
                      style: const TextStyle(
                          fontFamily: 'GTWalsheim', fontSize: 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTimer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displayxo[index] == '') {
          displayxo[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayxo[index] == '') {
          displayxo[index] = 'X';
          filledBoxes++;
        }

        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    if (displayxo[0] == displayxo[1] &&
        displayxo[0] == displayxo[2] &&
        displayxo[0] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[0]} Wins!";
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayxo[0]);
      });
    }

    if (displayxo[3] == displayxo[4] &&
        displayxo[3] == displayxo[5] &&
        displayxo[3] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[3]} Wins!";
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayxo[3]);
      });
    }

    if (displayxo[6] == displayxo[7] &&
        displayxo[6] == displayxo[8] &&
        displayxo[6] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[6]} Wins!";
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayxo[6]);
      });
    }

    if (displayxo[0] == displayxo[3] &&
        displayxo[0] == displayxo[6] &&
        displayxo[0] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[0]} Wins!";
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayxo[0]);
      });
    }

    if (displayxo[1] == displayxo[4] &&
        displayxo[1] == displayxo[7] &&
        displayxo[1] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[1]} Wins!";
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayxo[1]);
      });
    }

    if (displayxo[2] == displayxo[5] &&
        displayxo[2] == displayxo[8] &&
        displayxo[2] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[2]} Wins!";
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayxo[2]);
      });
    }

    if (displayxo[0] == displayxo[4] &&
        displayxo[0] == displayxo[8] &&
        displayxo[0] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[0]} Wins!";
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayxo[0]);
      });
    }

    if (displayxo[2] == displayxo[4] &&
        displayxo[2] == displayxo[6] &&
        displayxo[2] != '') {
      setState(() {
        resultDeclaration = "Player ${displayxo[2]} Wins!";
        matchedIndexes.addAll([2, 4, 6]);
        stopTimer();
        _updateScore(displayxo[2]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody won!';
        stopTimer();
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayxo[i] = '';
      }
      matchedIndexes = [];
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: Colors.blueAccent,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: Text(
                attempts == 0 ? "Start" : "Play Again",
                style: const TextStyle(color: Colors.black, fontFamily: 'GTWalsheim', fontSize: 20),
              ),
            ));
  }
}
