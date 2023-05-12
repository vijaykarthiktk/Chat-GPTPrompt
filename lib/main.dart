import 'dart:math';

import 'package:chatgptprompt/screen/mainScreen.dart';
import 'package:chatgptprompt/themes/themeData.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat-GPT Prompts',
      theme: themeDataLight,
      darkTheme: themeDataDark,
      themeMode: ThemeMode.system,
      home: const MainScreen(title: 'Chat-GPT Prompts'),
    );
  }
}

