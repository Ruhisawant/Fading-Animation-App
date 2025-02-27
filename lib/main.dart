import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  const FadingTextAnimation({super.key});

  @override
  FadingTextAnimationState createState() => FadingTextAnimationState();
}

class FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fading Text Animation'),
          actions: const[
            Icon(Icons.dark_mode, color: Colors.white, size: 30),
          ],
        ),
        body: Center(
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: const Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (_themeMode == ThemeMode.dark) {
                    _themeMode = ThemeMode.light;
                  } else {
                    _themeMode = ThemeMode.dark;
                  }
                });
              },
              child: Icon(
                _themeMode == ThemeMode.dark ? Icons.wb_sunny : Icons.dark_mode,
                color: _themeMode == ThemeMode.dark ? Colors.white : Colors.black,
              ),
            ),
            FloatingActionButton(
              onPressed: toggleVisibility,
              child: const  Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}