import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:cryptography/cryptography.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSA Hashing Project',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "DSA Hashing Project"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();
  String? outputHashedValue;

  void _calculateHash() {
    final input = _inputController.text.trim();
    if (input.isNotEmpty) {
      int getHash = _calculateASCIIHash(input);
      setState(() {
        outputHashedValue = getHash.toString();
      });
    } else {
      setState(() {
        outputHashedValue = null;
      });
    }
  }

  int _calculateASCIIHash(String input) {
    int hashedValue = 0;
    for (int i = 0; i < input.length; i++) {
      // input[i] to ascii conversion.
      int asciiValue = input.codeUnitAt(i);

      // Hashing Function = 3k + 16, where k = asciiValue.
      hashedValue += (3 * asciiValue) + 16;
    }
    return hashedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 400,
              child: TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text to hash',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateHash,
              child: const Text('Hash it'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (outputHashedValue != null)
                      const Text(
                        'Hashed value:',
                        style: TextStyle(fontSize: 18),
                      ),
                    if (outputHashedValue != null)
                      const SizedBox(height: 8),
                    if (outputHashedValue != null)
                      SizedBox(
                        width: 200,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              outputHashedValue!,
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            ],
        ),
      ),
    );
  }
}