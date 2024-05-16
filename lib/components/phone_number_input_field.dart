// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmsystem_app/components/primary_input.dart';
import 'package:lmsystem_app/controllers/auth_controller.dart';

class PhoneNumberInputField extends StatefulWidget {
  final TextEditingController controller;
  const PhoneNumberInputField({super.key, required this.controller});

  @override
  _PhoneNumberInputFieldState createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  // String _selectedCountryCode = '+233'; // Default country code
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey
            ),
            borderRadius: BorderRadius.circular(12)
          ),
          child: CountryCodePicker(
            padding: EdgeInsets.zero,
            showDropDownButton: true,
            onChanged: (CountryCode countryCode) {
              authController.countryCode.value = countryCode.dialCode!;
            },
            initialSelection: 'GH', // Initial country code selection
            favorite: const ['+233', 'GH'], // Your favorite country codes
            showCountryOnly: false,
            showFlagMain: false,
            showOnlyCountryWhenClosed: false,
            dialogSize: const Size(100, 500),
            // alignLeft: false,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: PrimaryInputField(
            textInputType: TextInputType.phone,
            controller: widget.controller,
            hint: 'Phone Number',
          ),
        ),
      ],
    );
  }
}
