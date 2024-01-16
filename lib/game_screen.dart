import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<FocusNode>? _focusNodes;
  late List<TextEditingController> _controllers;
  int? secretNumber;
  String? feedbackMessage;
  bool clear = true;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(4, (index) => TextEditingController());
    secretNumber = generateRandom4DigitNumber();
  }

  int generateRandom4DigitNumber() {
    Random random = Random();
    return 1000 + random.nextInt(9000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 182, 19),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              (feedbackMessage == null || clear)
                  ? const SizedBox()
                  : Text(
                      feedbackMessage.toString(),
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const SizedBox(height: 45),
              clear
                  ? const SizedBox()
                  : Column(
                      children: [
                        const Text(
                          'Generated Number was',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          secretNumber.toString(),
                          style: const TextStyle(
                            letterSpacing: 15,
                            color: Colors.orange,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 15),
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
                      enabled: clear ? true : false,
                      focusNode: _focusNodes?[index],
                      onChanged: (value) {
                        moveCursor(index);
                      },
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
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color.fromARGB(255, 226, 182, 19),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              clear
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        for (var controller in _controllers) {
                          controller.clear();
                        }
                        clear = true;
                        secretNumber = generateRandom4DigitNumber();
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.transparent,
                          border: Border.all(
                            color: const Color.fromARGB(255, 226, 182, 19),
                          ),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: Color.fromARGB(255, 226, 182, 19),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void moveCursor(int index) {
    if (index < 3 && _controllers[index].text.isNotEmpty) {
      FocusScope.of(context).requestFocus(_focusNodes?[index + 1]);
    }
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
    }
    setState(() {
      clear = false;
      feedbackMessage = 'Bulls: $bulls, Cows: $cows';
    });
  }
}
