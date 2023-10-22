import 'package:flutter/material.dart';

class CardActor extends StatelessWidget {
  final String name;
  final String photo;
  final String character;

  const CardActor({Key? key,
      required this.name,
      required this.photo,
      required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              photo,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            character,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}