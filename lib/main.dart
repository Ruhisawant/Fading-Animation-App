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
  bool _isSwitched = true;
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleSlideText() {
    setState(() {
      _isSwitched = !_isSwitched;
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
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: toggleVisibility,
                child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const Text('Hello, Flutter!', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (widget, animation) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: widget,
                ),
                child: Text(
                  _isSwitched ? "Hello!" : "Goodbye!",
                  key: ValueKey<bool>(_isSwitched),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ],
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
            FloatingActionButton(
              onPressed: toggleSlideText,
              child: const  Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}