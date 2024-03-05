import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FunButton extends StatefulWidget {
  final double borderRadius;
  final double height;
  final double width;
  final List<Color> buttonColors;
  final Color borderColor;
  final Color shadowColor;
  final VoidCallback? onTap;
  final String? text;
  final double textSize;
  final Color textColor;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? shadowOffsetX;
  final double? shadowOffsetY;
  final FontWeight? textWeight;
  final double borderWidth;
  final bool isDisabled;
  final Color glowColor;
  final bool enableGlow;

  // constructor for the FunButton widget with named parameters and default values
  /// Creates a FunButton widget.
  ///
  /// [key] : An identifier for the widget.
  ///
  /// [width] : The width of the button. Default is 150.
  ///
  /// [height] : The height of the button. Default is 40.
  ///
  /// [borderRadius] : The border radius of the button. Default is 50.
  ///
  /// [buttonColors] : The list of colors for the button gradient. Default is [Colors.blue, Colors.green].
  ///
  /// [borderColor] : The color of the button border. Default is Colors.purple.
  ///
  /// [shadowColor] : The color of the button shadow. Default is Colors.black.
  ///
  /// [text] : The text to display on the button.
  ///
  /// [textSize] : The size of the button text. Default is 15.
  ///
  /// [textColor] : The color of the button text. Default is Colors.black.
  ///
  /// [icon] : The icon to display on the button.
  ///
  /// [iconColor] : The color of the button icon.
  ///
  /// [iconSize] : The size of the button icon. Default is 30.
  ///
  /// [shadowOffsetX] : The horizontal offset of the button shadow. Default is 0.
  ///
  /// [shadowOffsetY] : The vertical offset of the button shadow.
  ///
  /// [textWeight] : The font weight of the button text. Default is FontWeight.w700.
  ///
  /// [borderWidth] : The width of the button border. Default is 0.9.
  ///
  /// [isDisabled] : Whether the button is disabled. Default is false.
  ///
  /// [onTap] : The callback function when the button is tapped.
  ///
  /// [glowColor] : The color of the button glow. Default is Colors.white.
  ///
  /// [enableGlow] : Whether to enable the button glow. Default is true.
  FunButton({
    super.key,
    this.width = 150,
    this.height = 40,
    this.borderRadius = 50,
    this.buttonColors = const [
      Colors.blue, // Start color
      Colors.green, // End color
    ],
    this.borderColor = Colors.purple,
    this.shadowColor = Colors.black,
    this.text,
    this.textSize = 15,
    this.textColor = Colors.black,
    this.icon,
    this.iconColor,
    this.iconSize = 30,
    this.shadowOffsetX = 0,
    double? shadowOffsetY,
    this.textWeight = FontWeight.w700,
    this.borderWidth = 0.9,
    this.isDisabled = false,
    VoidCallback? onTap,
    this.glowColor = Colors.white,
    this.enableGlow = true,
  })  : onTap = onTap ?? (() {}), // if onTap is null, then set it to an empty function
        shadowOffsetY = shadowOffsetY ?? 11;

  @override
  State<FunButton> createState() => _FunButtonState();
}

class _FunButtonState extends State<FunButton> {
  // Flag to track if the button is pressed
  bool isButtonPressed = false;

  // Offset value for the pressed state
  late double pressedOffsetY;

  // Offset value for the not pressed state
  static const double notPressedOffsetY = 3;

  // Flag to track if the glow should be shown
  bool isShowGlow = false;

  // Opacity value for the glow
  double glowOpacity = 0;

  // Initialize the state of the widget
  @override
  void initState() {
    super.initState();
    pressedOffsetY = widget.shadowOffsetY!;
  }

  // when the button is pressed down
  void _onButtonPressedDown(_) {
    setState(() {
      isButtonPressed = true; // set the button state to pressed
      isShowGlow = false; // hide the glow
    });
  }

  // when the button is released
  void _onButtonReleased(_) {
    setState(() {
      isButtonPressed = false; // set the button state to not pressed
      isShowGlow = true; // show the glow
      glowOpacity = 1; // set the opacity to 1 to make the glow visible
    });

    /**
     * we use a delayed future to hide the glow after a short delay, otherwise it will still be visible
     * when the button is pressed again
     */
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        glowOpacity = 0; // set the opacity to 0 to hide the glow
      });
    });

    // call the onTap function
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // center align the glow and the button body
      children: [
        // show the glow only if the enableGlow property is set to true
        if (widget.enableGlow) _renderGlow(),

        // the button body and shadow, wrapped in an AnimatedScale widget to create a scale effect when the button is pressed
        AnimatedScale(
          duration: const Duration(milliseconds: 450),
          curve: Curves.elasticOut,
          scale: isButtonPressed ? 0.95 : 1,
          alignment: Alignment.center,

          /**
            * Non-positioned children of a Stack are fit to the Stack according to their own size, 
            * BUT positioned children do not contribute to the Stack's size.
            * This can lead to a situation where the Stack (and thereby the FunButton) does not occupy any space
            * 
            * By wrapping the Stack with a SizedBox, you are defining the space that the Stack should occupy.
            * This is crucial because without dimensions or constraints,
            * the Stack might not know how much space it should take, leading to layout issues. such as parts of 
            * the button being clipped during the animation
          */
          child: SizedBox(
            // account for the button width and shadow offset to prevent button from being clipped while scaling during animation
            width: widget.width + widget.shadowOffsetX!,
            // account for the button height and  shadow offset to prevent button from being clipped while scaling during animation
            height: widget.height + widget.shadowOffsetY!,
            child: Stack(
              children: [
                _renderButtonShadow(),
                _renderButtonBody(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // the glow effect widget, which will be displayed after button is clicked
  Widget _renderGlow() {
    return AnimatedScale(
      scale: isShowGlow
          ? 1.4
          : 0.7, // scale the glow when the button is clicked, and shrink and hide it when the button is released
      duration: const Duration(milliseconds: 700),
      curve: Curves.ease,
      child: AnimatedOpacity(
        opacity: glowOpacity,
        duration: const Duration(milliseconds: 650),
        //curve: Curves.easeOutCubic,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              widget.borderRadius,
            ),
            color: widget.glowColor,
          ),
        ),
      ),
    );
  }

  // the button body widget
  Widget _renderButtonBody() {
    return AnimatedPositioned(
      // move the button down when pressed or disabled
      top: isButtonPressed || widget.isDisabled ? pressedOffsetY : notPressedOffsetY,
      // move the button right when pressed or disabled
      left: isButtonPressed || widget.isDisabled ? widget.shadowOffsetX : 0,
      curve: Curves.elasticOut,
      duration: const Duration(milliseconds: 500),
      // if we use InkWell widget we need to have the Material widget as the parent
      child: Material(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: IgnorePointer(
          ignoring: widget.isDisabled, // ignore user click events if the button is disabled
          // the InkWell widget is used to create the ripple effect when the button is pressed
          child: InkWell(
            //splashColor: widget.buttonColor,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            onTapCancel: () => _onButtonReleased(""),
            onTapDown: _onButtonPressedDown,
            onTapUp: _onButtonReleased,
            // the sized box is used to define the dimensions of the button so that its not clipped by the stack
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              // this animated container will only animate changes in the border-radius,button color and border color
              child: AnimatedContainer(
                  curve: Curves.elasticOut,
                  duration: const Duration(milliseconds: 900),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, // Where the gradient begins
                      end: Alignment.bottomRight, // Where the gradient ends
                      colors: widget.buttonColors,
                    ),
                    backgroundBlendMode: BlendMode.multiply,
                    border: Border.all(
                      color: widget.borderColor,
                      width: widget.borderWidth,
                    ),
                  ),
                  child: _buttonBody()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonBody() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.text != null) // if a text is present, render it
            Text(
              widget.text!,
              style: GoogleFonts.poppins(
                fontWeight: widget.textWeight,
                fontSize: widget.textSize,
                color: widget.textColor,
              ),
            ),
          // add a space between the text and the icon if both are present
          if (widget.text != null && widget.icon != null) const SizedBox(width: 7),
          if (widget.icon != null) // if an icon is present, render it
            Icon(
              widget.icon!,
              size: widget.iconSize,
              color: widget.iconColor ?? widget.textColor,
            )
        ],
      ),
    );
  }

  // the shadow widget
  Widget _renderButtonShadow() {
    return Positioned(
      left: widget.shadowOffsetX, // move the shadow a bit to the right
      top: widget.shadowOffsetY, // move the shadow a bit down
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        // this animated container will only animate changes in the border-radius and shadow color
        child: AnimatedContainer(
          curve: Curves.elasticOut,
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.shadowColor,
          ),
        ),
      ),
    );
  }
}
