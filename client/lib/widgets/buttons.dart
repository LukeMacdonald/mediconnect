import 'package:flutter/material.dart';
import '../styles/theme.dart';

class SubmitButton extends StatelessWidget {

  const SubmitButton({
    Key? key,
    required this.color,
    required this.message,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);


  final Color color;
  final String message ;
  final double width;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color,
          child: InkWell(

            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17)
                  ),
            ],
          ),
            ),
          ),



    );
  }
}

class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 54,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 0,
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}