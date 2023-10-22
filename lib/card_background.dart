import 'package:flutter/material.dart';

class CardBackgroundData{
  final String title;
  final String subtittle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  const CardBackgroundData({
    required this.title,
    required this.subtittle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background,
  });
}
class CardBackground extends StatelessWidget {
  const CardBackground({required this.data, Key? key}) : super(key: key);

  final CardBackgroundData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (data.background != null) data.background!,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15, 
            vertical: 120
          ),
          child: Column(
            children: [
              Flexible(
                flex: 20,
                child: Image(image: data.image),
              ),
              const Spacer(flex: 7,),
              Text(
                data.title.toUpperCase(),
                style: TextStyle(
                  color: data.titleColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(flex: 1,),
              Text(
                data.subtittle,
                style: TextStyle(
                  color: data.subtitleColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 7,),
            ],
          ),
        ),
      ],
    );
  }
}