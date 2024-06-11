import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../controllers/email_verification.controller/recruiterEmailVerify_controller.dart';

class RecruiterVerifyEmail extends StatefulWidget {
  const RecruiterVerifyEmail({super.key});

  @override
  State<RecruiterVerifyEmail> createState() => _RecruiterVerifyEmailState();
}

class _RecruiterVerifyEmailState extends State<RecruiterVerifyEmail> {
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _displayTimer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        if (_secondsRemaining == 0) {
          _displayTimer?.cancel();
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _displayTimer?.cancel();
    _timer?.cancel();
    isLoading = false;
    super.dispose();
  }

  int _secondsRemaining = 120;
  bool isLoading = false;
  Timer? _timer, _displayTimer;
  final emailverify = Get.put(RecruiterEmailVerification());

  @override
  Widget build(BuildContext context) {
    int clickCount = 1;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              CSImages.emailVerification,
              width: 250,
              height: 250,
            ),
            Ver(60),
            AutoSizeText(
              'Please check your email for verification',
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            Ver(5),
            AutoSizeText(
              'A verification link has been sent on your mail. \n Follow the instructions given in the email & \n complete the verification',
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            Ver(30),
            ElevatedButton(
                onPressed: () {
                  if (clickCount <= 2) {
                    if (FirebaseAuth.instance.currentUser != null) {
                      emailverify.sendEmailVerification();
                      Loader.successSnackBar(
                          title: "Sent",
                          message: "remaining attempt: ${2 - clickCount}");
                    }
                  } else {
                    null;
                  }
                  clickCount++;
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.blueGrey.shade700)),
                child: Text(
                  "Resend Email Link",
                  style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
            Ver(30),
            Text(
              "You have only $_secondsRemaining seconds remaining",
              style: GoogleFonts.lexend(
                  fontWeight: FontWeight.w600, color: CSColors.firstColor),
            ),
            Ver(30),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 80,
              height: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    emailverify.recruiterCheckEmailVerificationStatus();
                    _timer = Timer(const Duration(seconds: 15), () {
                      isLoading = false;
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue.shade700)),
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Processing...",
                              style: GoogleFonts.lexend(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Hor(10),
                            const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )),
                          ],
                        )
                      : Text(
                          "Continue",
                          style: GoogleFonts.lexend(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
