import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<TextEditingController> _controllers;
  int? secretNumber;
  String? feedbackMessage;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each digit
    _controllers = List.generate(4, (index) => TextEditingController());
    secretNumber = generateRandom4DigitNumber();
    print(' secretNumber   -..>>>>>   ${secretNumber}');
  }

  int generateRandom4DigitNumber() {
    Random random = Random();
    return 1000 +
        random.nextInt(9000); // Generates a random number between 1000 and 9999
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 182, 19),
        title: const Text('4-Digit Input'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            feedbackMessage == null
                ? SizedBox()
                : Text(
                    feedbackMessage.toString(),
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 50),
            Text(
              secretNumber.toString(),
              style: const TextStyle(
                letterSpacing: 65,
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 150),
            const Text(
              'Enter Your 4 digits',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '0',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                checkBullsAndCows();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromARGB(255, 226, 182, 19),
                ),
                child: const Text('OK'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkBullsAndCows() {
    int bulls = 0;
    int cows = 0;

    for (int i = 0; i < 4; i++) {
      if (_controllers[i].text == secretNumber.toString()[i]) {
        bulls++;
      } else if (secretNumber.toString().contains(_controllers[i].text)) {
        cows++;
      }

      print('i   ->>>>   ${_controllers[i].text}');
    }

    setState(() {
      feedbackMessage = 'Bulls: $bulls, Cows: $cows';
    });
  }
}
