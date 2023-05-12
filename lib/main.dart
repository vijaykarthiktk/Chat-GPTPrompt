import 'package:chatgptprompt/screen/mainScreen.dart';
import 'package:chatgptprompt/themes/themeData.dart';
import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';

void main() {
  runApp(MyApp());
  SystemTheme.accentColor;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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

