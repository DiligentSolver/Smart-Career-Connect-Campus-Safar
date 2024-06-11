import 'dart:ui';
import 'package:campus_safar/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app.dart';
import '../../../utils/constants/sizes.dart';
import 'login/admin/adminlogin.dart';
import 'signup/admin/adminsignup.dart';
import 'login/recruiter/recruiterlogin.dart';
import 'signup/recruiter/recruitersignup.dart';
import 'login/student/studentlogin.dart';
import 'signup/student/studentsignup.dart';

class UserRoleCheck {
  static bool student = false;
  static bool recruiter = false;
  static bool admin = false;
}

class UserRoles extends StatefulWidget {
  const UserRoles({super.key});

  @override
  State<UserRoles> createState() => _UserRolesState();
}

class _UserRolesState extends State<UserRoles> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CSApp.isWeb
                    ? const AssetImage(CSImages.credentialWebBg)
                    : const AssetImage(CSImages.credentialBg),
                fit: BoxFit.cover)),
        width: size.width,
        height: size.height,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white38),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.userGraduate,
                                      color: Colors.blueGrey,
                                      size: 50,
                                    ),
                                    Text(
                                      "Student",
                                      style: GoogleFonts.lexend(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Hor(10),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.to(() => const StudentSignup(),
                                          transition:
                                              Transition.cupertinoDialog,
                                          duration: const Duration(
                                              milliseconds: 1500));
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "SignUp",
                                        style: GoogleFonts.inter(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      )),
                                    ),
                                  ),
                                  Ver(10),
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.to(() => const StudentLogin(),
                                          transition:
                                              Transition.cupertinoDialog,
                                          duration: const Duration(
                                              milliseconds: 1500));
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "LogIn",
                                        style: GoogleFonts.inter(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Ver(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white38,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.hireAHelper,
                                      color: Colors.green,
                                      size: 50,
                                    ),
                                    Text(
                                      "Recruiter",
                                      style: GoogleFonts.lexend(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                              Hor(10),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.to(
                                          () => const RecruiterSignup(),
                                          transition:
                                              Transition.cupertinoDialog,
                                          duration: const Duration(
                                              milliseconds: 1500));
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "SignUp",
                                        style: GoogleFonts.inter(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      )),
                                    ),
                                  ),
                                  Ver(10),
                                  GestureDetector(
                                    onTap: () async {
                                      UserRoleCheck.recruiter = true;
                                      await Get.to(() => const RecruiterLogin(),
                                          transition:
                                              Transition.cupertinoDialog,
                                          duration: const Duration(
                                              milliseconds: 1500));
                                      UserRoleCheck.recruiter = false;
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "LogIn",
                                        style: GoogleFonts.inter(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Ver(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white38,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.userSecret,
                                      color: Colors.blueAccent,
                                      size: 50,
                                    ),
                                    Text(
                                      "Admin",
                                      style: GoogleFonts.lexend(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                              Hor(10),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Get.to(() => const AdminSignup(),
                                          transition:
                                              Transition.cupertinoDialog,
                                          duration: const Duration(
                                              milliseconds: 1500));
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "SignUp",
                                        style: GoogleFonts.inter(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      )),
                                    ),
                                  ),
                                  Ver(10),
                                  GestureDetector(
                                    onTap: () async {
                                      UserRoleCheck.admin = true;
                                      await Get.to(() => const AdminLogin(),
                                          transition:
                                              Transition.cupertinoDialog,
                                          duration: const Duration(
                                              milliseconds: 1500));
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "LogIn",
                                        style: GoogleFonts.inter(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
