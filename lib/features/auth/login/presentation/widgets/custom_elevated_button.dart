import 'package:flutter/material.dart';
import 'package:mvvm/core/const/colors_const.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const new({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConst.appColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: const StadiumBorder(),
        elevation: 4,
        // ignore: deprecated_member_use
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
    );
  }
}
