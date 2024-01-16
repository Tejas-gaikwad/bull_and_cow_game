import 'package:flutter/material.dart';

class SelectNumberScreen extends StatelessWidget {
  const SelectNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 182, 19),
        title: const Text('Bull and Cow'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select any one card',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(15),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 60,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(3.0, 3.0),
                            spreadRadius: 1.0,
                            blurRadius: 2.0,
                          )
                        ],
                        gradient: const LinearGradient(colors: [
                          Colors.amber,
                          Colors.yellow,
                        ])),
                    child: Text('${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
