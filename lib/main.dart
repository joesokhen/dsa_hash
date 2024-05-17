import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSA Hashing Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "DSA Hashing Project"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();
  List<String> hashArray = List.filled(10, '');
  bool isHashButtonEnabled = true;
  String hashingProcess = '';

  final ScrollController scrollController = ScrollController();

  void _calculateHash() {
    final input = _inputController.text.trim();
    if (input.isNotEmpty) {
      int hash = _calculateASCIIHash(input);
      int index = hash % 10; // Determine the index using modulo
      int newIndex = _findEmptySlot(index); // Find the nearest empty slot
      setState(() {
        hashArray[newIndex] = input; // Store the hash value at the determined index
        if (hashArray.every((element) => element != '')) {
          isHashButtonEnabled = false; // Disable hash button if array is full
          _showArrayFullMessage();
        }
      });
    }
  }

  int _calculateASCIIHash(String input) {
    int hashedValue = 0;
    String process = '';
    for (int i = 0; i < input.length; i++) {
      int asciiValue = input.codeUnitAt(i);
      process += '${input[i]}: $asciiValue\n';
      hashedValue += (3 * asciiValue) + 16;
      process += 'Hashing Step: (3 * $asciiValue) + 16 = ${(3 * asciiValue) + 16}\n\n';
    }
    process += 'Total Hash Value: $hashedValue';
    setState(() {
      hashingProcess = process;
    });
    return hashedValue;
  }

  int _findEmptySlot(int startIndex) {
    int index = startIndex;
    while (hashArray[index] != '') {
      index = (index + 1) % 10; // Move to the next index
    }
    return index;
  }

  void _clearInput() {
    _inputController.clear();
    setState(() {
      hashArray = List.filled(10, ''); // Reset the hash array
      isHashButtonEnabled = true; // Enable hash button
      hashingProcess = ''; // Clear the hashing process
    });
  }

  void _showArrayFullMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Array is full'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width / 11;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate remaining height for the hashing process container
          double inputHeight = 60; // Approximate height of input field
          double buttonHeight = 50; // Approximate height of buttons
          double paddingHeight = 16 + 16 + 20; // Total padding and margins
          double availableHeight = constraints.maxHeight -
              inputHeight -
              buttonHeight -
              paddingHeight;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hashingProcess.isNotEmpty)
                  SizedBox(
                    height: availableHeight,
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: scrollController,
                          child: Text(
                            hashingProcess,
                            style: const TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter text to hash',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: isHashButtonEnabled
                          ? _calculateHash
                          : null, // Disable hash button if array is full
                      child: const Text('Hash it'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _clearInput,
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.purple[100],
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            10,
                (index) => Container(
              width: boxWidth,
              height: boxWidth * 1.1,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  '${hashArray[index]}',
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}