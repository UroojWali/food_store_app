import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF324ba3),
            ),
            BoxShadow(
              color: Color(0xFF1e266b),
              spreadRadius: -5.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Text(text),
      ),
    );
  }
}
