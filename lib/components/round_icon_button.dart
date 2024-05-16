import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Widget? icon;
  final double? size;
  final Color? backgroundColor;
  final Color? splashColor;
  final bool? hasShadow;
  final bool? isMenuButton;
  final void Function()? onTap;
  final BoxBorder? border;
  const RoundIconButton({
    Key? key, this.icon, this.size = 35.0, this.backgroundColor, this.splashColor, this.hasShadow = false, this.isMenuButton = false, this.onTap, this.border}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasShadow! ? BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 8.0,
          )
        ],
      ) : BoxDecoration(
        border: border,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle
          ),
          child: InkWell(
            onTap: () => isMenuButton! ? Scaffold.of(context).openDrawer() : onTap!(),
            customBorder: const CircleBorder(),
            splashColor: splashColor,
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}