import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class PasswordGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordGeneratorScreen(),
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  String password = '';
  double length = 12;
  bool useNumbers = true;
  bool useSymbols = true;
  bool useUppercase = true;
  bool useLowercase = true;

  String generatePassword() {
    final numbers = '0123456789';
    final symbols = '!@#\$%^&*()_-+=<>?';
    final uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final lowercase = 'abcdefghijklmnopqrstuvwxyz';

    String chars = '';
    if (useNumbers) chars += numbers;
    if (useSymbols) chars += symbols;
    if (useUppercase) chars += uppercase;
    if (useLowercase) chars += lowercase;

    return List.generate(
            length.toInt(), (index) => chars[Random().nextInt(chars.length)])
        .join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              password.isNotEmpty ? password : 'Your password will appear here',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Slider(
              value: length,
              min: 4,
              max: 20,
              divisions: 16,
              label: '${length.toInt()} characters',
              onChanged: (value) {
                setState(() {
                  length = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Include Numbers'),
              value: useNumbers,
              onChanged: (value) {
                setState(() {
                  useNumbers = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Include Symbols'),
              value: useSymbols,
              onChanged: (value) {
                setState(() {
                  useSymbols = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Include Uppercase Letters'),
              value: useUppercase,
              onChanged: (value) {
                setState(() {
                  useUppercase = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Include Lowercase Letters'),
              value: useLowercase,
              onChanged: (value) {
                setState(() {
                  useLowercase = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  password = generatePassword();
                });
              },
              child: Text('Generate Password'),
            ),
            ElevatedButton(
              onPressed: () {
                if (password.isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: password));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password copied to clipboard!')));
                }
              },
              child: Text('Copy to Clipboard'),
            ),
          ],
        ),
      ),
    );
  }
}
