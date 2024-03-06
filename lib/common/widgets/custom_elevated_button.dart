import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: width ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
        onPressed: onPressed,
        // style: ElevatedButton.styleFrom(
        //   backgroundColor: Coloors.greenDark,
        //   foregroundColor: Coloors.backgroundDark,
        //   splashFactory: NoSplash.splashFactory,
        //   elevation: 0,
        //   shadowColor: Colors.transparent,
        //   shape: const BeveledRectangleBorder(),
        // ),
        child: Text(text),
      ),
    );
  }
}
