import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_safar/features/authentication/screens/forms/textformfield.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/loaders.dart';

class ForgotPwdBar extends StatefulWidget {
  const ForgotPwdBar({super.key});

  @override
  State<ForgotPwdBar> createState() => _ForgotPwdBarState();
}

class _ForgotPwdBarState extends State<ForgotPwdBar> {

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    isLoading = false;
    super.dispose();
  }

  Timer? _timer;
  final resetEmailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: CSColors.firstColor,
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                "Forgot Password?",
                maxLines: 1,
                style: GoogleFonts.lexend(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                    fontWeight: FontWeight.w600),
              ),
              Ver(20),
              Textformfield(
                controller: resetEmailController,
                prefixIcon: const Icon(Icons.email),
                isEmailField: true,
                textInputAction: TextInputAction.next,
                hintText: "User Email",
                keyboardType: TextInputType.emailAddress,
                prefixIconColor: Colors.white,
                borderradius: 20, textCapitalization: TextCapitalization.none,
              ),
              Ver(20),
              GestureDetector(
                onTap: () async{
                  if(!isLoading) {
                    if (resetEmailController.text.isEmpty) {
                      Loader.warningSnackBar(
                          title: "Sorry", message: "Enter your email");
                    }
                    if (resetEmailController.text.isEmail) {
                      setState(() {
                        isLoading = true;
                      });
                      await AuthenticationRepository.instance.sendPasswordLink(
                          resetEmailController.text);
                      _timer = Timer(const Duration(seconds: 6), () {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading ? Row(mainAxisAlignment:MainAxisAlignment.center,children: [AutoSizeText(
                    "Processing...",
                    maxLines: 1,
                    style: GoogleFonts.lexend(
                      color: CSColors.firstColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),), Hor(10),const SizedBox(height:12,width: 12,child: CircularProgressIndicator(color: CSColors.firstColor,strokeWidth: 2))],) :
                      AutoSizeText(
                        "Send Password Reset Link",
                        maxLines: 1,
                        style: GoogleFonts.lexend(
                          color: CSColors.firstColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Ver(70),
              AutoSizeText(
                "A password reset link will be send on your registered email to reset your password",
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Ver(40)
            ],
          ),
        ),
      ),
    );
  }
}
