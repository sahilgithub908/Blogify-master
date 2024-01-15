import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const RoundButton({super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.black87, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        color: Colors.indigoAccent,
        height: 50,
        minWidth: double.infinity,
        onPressed: onPress,
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
    );
  }
}
