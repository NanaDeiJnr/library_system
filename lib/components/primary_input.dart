import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lmsystem_app/utils/hex_colors.dart';

class PrimaryInputField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;
  final String hint;
  final Function()? onTap;
  final EdgeInsets? contentPadding;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final Widget? prefixIcon;
  final String? prefixText;
  final bool? readOnly;
  final Widget? suffixIcon;
  const PrimaryInputField({Key? key, this.controller, this.validator, this.onTap, this.contentPadding, this.textInputType, this.textInputAction, this.onChange, required this.hint, this.maxLength, this.enabled, this.prefixIcon, this.prefixText, this.readOnly = false, this.maxLines = 1, this.minLines = 1, this.suffixIcon, this.obscureText=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: MainColors.secondaryColor,
      obscureText: obscureText,
      enabled: enabled,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly!,
      keyboardType: textInputType ?? TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: textInputAction ?? TextInputAction.next,
      style: const TextStyle(
        color: Colors.black
      ),
      decoration: InputDecoration(
        iconColor: Colors.black,
        hintText: hint,
        hintStyle: GoogleFonts.workSans(
          color: const Color.fromARGB(255, 170, 170, 170),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: MainColors.secondaryColor
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.shade400
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.shade400
          )
        ),
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints.tightFor(
          width: 48
        ),
        prefixText: prefixText,
        /*filled: true,
        fillColor: Colors.grey.shade50*/
      ),
      validator: validator,
      onTap: onTap,
      onChanged: onChange,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}