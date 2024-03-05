# Fun Button Flutter Demo

This project demonstrates the use of a customizable Flutter widget named `FunButton`. The `FunButton` widget is designed to be versatile, allowing customization of its size, colors, borders, shadows, and other properties. It also integrates audio feedback on taps through different audio players, demonstrating dependency injection for flexible audio management.

![](https://github.com/ynaiborlang/flutter_fun_button/blob/master/funbutton_demo.gif)

## Features

- **Customizable Button Dimensions**: Adjust the width, height, and border radius.
- **Gradient Backgrounds**: Apply gradient colors to the button's background.
- **Dynamic Shadows and Borders**: Configure shadow and border colors.
- **Text and Icon Support**: Display text and icons within the button.
- **Audio Feedback**: Play sound effects on button tap using a flexible audio player interface.
- **Interactive Effects**: Implement visual feedback for user interactions such as tap.

## Getting Started

To run this project, ensure you have Flutter installed on your machine. Follow the Flutter [official documentation](https://flutter.dev/docs/get-started/install) for installation guidance.

### Installation

1. Clone the repository to your local machine.
   ```
   git clone https://github.com/ynaiborlang/flutter_fun_button.git
   ```
2. Navigate to the project directory.
   ```
   cd fun_button_demo
   ```
3. Install the required dependencies.
   ```
   flutter pub get
   ```
4. Run the app on your device or emulator.
   ```
   flutter run
   ```

## Usage

The `FunButton` widget is utilized within the `MyHomePage` widget in this demo. It demonstrates changing button properties and playing different sounds on each tap. The button configurations are stored in a list of maps, showcasing how to dynamically change the button's appearance and behavior.

```dart
FunButton(
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
    // Button tap behavior
  },
)
```

## Audio Management

This demo uses a simple interface `Audio` for audio playback, with two concrete implementations: `BlueFireAudioPlayer` and `JustAudioPlayer`. This design allows for easy switching between different audio playback strategies without modifying the codebase significantly.

## Dependencies

- [google_fonts](https://pub.dev/packages/google_fonts): For custom text styling.
- [just_audio](https://pub.dev/packages/just_audio): An alternative audio player used in one of the `Audio` implementations.

## Additional Notes

Remember to dispose of the audio player resources properly by overriding the `dispose` method of your widget.

```dart
@override
void dispose() {
  super.dispose();
  audioPlayer.dispose();
}
```
