import 'dart:io';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade/controller/signin_controller.dart';
import 'package:trade/screens/home/home_screen.dart';
import 'package:trade/utils/color.dart';
import 'package:trade/utils/common.dart';
import 'package:trade/utils/constant.dart';
import 'package:trade/utils/images.dart';
import 'package:trade/view/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SigninController _signinController = Get.find<SigninController>();
  final countryPicker = const FlCountryCodePicker();
  final TextEditingController mobileNumberController = TextEditingController();
  CountryCode? contryCode =
      const CountryCode(name: "India", code: "IN", dialCode: "+91");

  @override
  void initState() {
    print(Platform.isAndroid);
    print(Platform.isIOS);
    super.initState();
  }

  getValidation() {
    if (mobileNumberController.text.trim().isEmpty) {
      showSnackbar(MessageType.warning, "Please enter you mobile number");
      return false;
    }

    if (mobileNumberController.text.trim().length < 10) {
      showSnackbar(MessageType.warning, "Please enter valid mobile number");
      return false;
    }

    return true;
  }

  onSignUpClick() {
    bool isValid() {
      var value = getValidation();
      return value;
    }

    if (isValid()) {
      _signinController.login(
        countryCode: contryCode?.dialCode,
        mobileNumber: mobileNumberController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: primarycolor,
              child: Column(
                children: [
                  const SizedBox(height: 101),
                  Image.asset(Images.logo, height: 200),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: getLoginView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLoginView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 21),
          Text(
            "Mobile number",
            style: Poppins.kTextStyle16Normal500,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final code = await countryPicker.showPicker(context: context);
                  if (code != null) {
                    print(code);
                    contryCode = code;
                    setState(() {});
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: (contryCode != null)
                              ? contryCode?.flagImage
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "${contryCode?.dialCode ?? "+1"}",
                          style: Poppins.kTextStyle16Normal400,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 27,
                          color: textSecondarycolor,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 98,
                      child: Divider(
                        thickness: 1.8,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: mobileNumberController,
                  maxLength: 10,
                  style: Poppins.kTextStyle16Normal400,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomElevatedButton(
            buttonChild: Text(
              "Sign Up",
              style: Poppins.kTextStyle18Normal600,
            ),
            gradiant: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(0, 200, 188, 1),
                  Color.fromRGBO(3, 152, 143, 1)
                ]),
            shadowColor: const Color.fromRGBO(61, 219, 147, 0.17),
            onTap: () {
              onSignUpClick();
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: const Divider(
                  thickness: 0.8,
                  color: textSecondarycolor,
                ),
              ),
              const SizedBox(width: 11),
              Text(
                "With",
                style: Poppins.kTextStyle15Normal400,
              ),
              const SizedBox(width: 11),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: const Divider(
                  thickness: 0.8,
                  color: textSecondarycolor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomElevatedButton(
            buttonChild: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Images.icGoogle),
                SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                Text(
                  "Google",
                  style: Poppins.kTextStyle18Normal600,
                ),
                const Spacer(),
              ],
            ),
            gradiant: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  redcolor,
                  redcolor,
                ]),
            shadowColor: const Color.fromRGBO(246, 63, 46, 0.3),
            onTap: () {
              showSnackbar(MessageType.warning, "module under devlopment");
            },
          ),
        ],
      ),
    );
  }
}
