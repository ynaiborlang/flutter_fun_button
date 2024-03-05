import 'package:flutter/material.dart';
import 'package:fun_button/utilities/audio.dart';
import 'package:fun_button/utilities/blue_fire_audio_palyer.dart';
import 'package:fun_button/utilities/just_audio_player.dart';
import 'package:fun_button/widget/fun_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fun Button Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isButtonPressed = false;
  double borderRadius = 50;
  double height = 40;
  double width = 150;
  int counter = 0;

  // using dependency injection to easily switch between the two audio players
  final Audio audioPlayer = BlueFireAudioPlayer();

  final buttons = [
    {
      "width": 180,
      "height": 50,
      "colors": const [Color(0xFFD7FFDD), Color(0xFFECEC98)],
      "borderColor": const Color(0xFF876030),
      "shadowColor": const Color(0xFF784C13),
      "text": "ÑION ÏA NGA",
      "borderRadius": 0,
      "textSize": 15,
      "textColor": const Color(0xFF7C511F),
      "icon": Icons.chevron_right_outlined,
      "iconSize": 20,
      "soundSrc": 'sounds/click2.mp3',
      "glowColor": Color.fromARGB(255, 200, 232, 84),
    },
    {
      "width": 250,
      "height": 70,
      "colors": const [Color(0xFFFFC9E9), Color(0xFFFCE0C5)],
      "borderColor": const Color(0xFF7F0048),
      "shadowColor": const Color(0xFF972F6C),
      "text": "SA SHISIEN",
      "borderRadius": 50,
      "textSize": 21,
      "textColor": const Color(0xFF97085D),
      "icon": Icons.multitrack_audio_sharp,
      "iconSize": 21,
      "soundSrc": 'sounds/click3.mp3',
      "shadowOffsetY": 12,
      "glowColor": const Color(0xFFFFC9E9),
    },
    {
      "width": 300,
      "height": 100,
      "colors": const [Color(0xFFBBEEFF), Color(0xFFD6D1FF)],
      "borderColor": const Color(0xFF4B61A5),
      "shadowColor": const Color(0xFF4B61A5),
      "text": "KHUBLEI",
      "borderRadius": 21,
      "textSize": 28,
      "textColor": const Color(0xFF314993),
      "icon": Icons.mood_rounded,
      "iconSize": 28,
      "soundSrc": 'sounds/click1.mp3',
      "shadowOffsetY": 15,
      "glowColor": const Color.fromARGB(255, 155, 227, 251),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final button = buttons[counter]; // get the current button

    return Scaffold(
      body: Center(
        child: FunButton(
          width: button['width'] as double,
          height: button['height'] as double,
          buttonColors: button['colors'] as List<Color>,
          borderColor: button['borderColor'] as Color,
          shadowColor: button['shadowColor'] as Color,
          text: button['text'] as String?,
          borderRadius: button['borderRadius'] as double,
          textSize: button['textSize'] as double,
          textColor: button['textColor'] as Color,
          icon: button['icon'] as IconData,
          iconSize: button['iconSize'] as double?,
          shadowOffsetY: button['shadowOffsetY'] as double?,
          glowColor: button['glowColor'] as Color,
          onTap: () {
            setState(() {
              audioPlayer.play(button['soundSrc'] as String); // play sound
              counter = (counter >= buttons.length - 1) ? 0 : counter + 1; // change button
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }
}
