import 'package:flutter/material.dart';
import 'package:trade/utils/constant.dart';

class CustomElevatedButton extends StatelessWidget {
  final Gradient? gradiant;
  final Color? shadowColor;
  final Widget? buttonChild;
  final VoidCallback? onTap;
  const CustomElevatedButton({
    super.key,
    this.gradiant,
    this.shadowColor,
    this.onTap,
    this.buttonChild,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: gradiant ??
                const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 200, 188, 1),
                      Color.fromRGBO(3, 152, 143, 1)
                    ]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: shadowColor ?? const Color.fromRGBO(61, 219, 147, 0.17),
                blurRadius: 5,
              )
            ]),
        child: ElevatedButton(
          onPressed: onTap ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: buttonChild ??
              Text(
                "Sign Up",
                style: Poppins.kTextStyle18Normal600,
              ),
        ),
      ),
    );
  }
}
