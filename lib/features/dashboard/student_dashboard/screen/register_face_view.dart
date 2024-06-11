import 'dart:convert';
import 'dart:developer';
import 'package:campus_safar/features/authentication/controllers/user%20controller/student_controller.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/company_screen.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/form/apply_form.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../utils/face_extract_feature/camera_view.dart';
import '../../../../utils/face_extract_feature/extract_face_feature.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/models/student_model.dart';

class RegisterFaceView extends StatefulWidget {
  const RegisterFaceView({super.key});

  @override
  State<RegisterFaceView> createState() => _RegisterFaceViewState();
}

class _RegisterFaceViewState extends State<RegisterFaceView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  String? _image;
  FaceFeatures? _faceFeatures;
  bool isRegistering = false;
  bool onClicked = false;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool dark = CSHelperFunctions.isDarkMode(context);
    final stuController = Get.put(StudentController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CSColors.darkThemeBg,
        extendBodyBehindAppBar: true,
        appBar: CSAppBar(
          changeArrowColor: true,
          arrowColor: CSColors.white,
          centerTitle: true,
          showBackArrow: true,
          title: Text(
            "Register User",
            style: CSTextTheme.darkTextTheme.headlineLarge,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CameraView(
                onImage: (image) {
                  setState(() {
                    _image = base64Encode(image);
                  });
                },
                onInputImage: (inputImage) async {
                  try {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          if (_image!.isNotEmpty) {
                            Navigator.pop(context);
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: CSColors.grey,
                            ),
                          );
                        });
                    _faceFeatures =
                        await extractFaceFeatures(inputImage, _faceDetector);
                  } catch (e) {
                    Get.off(() => const CSApplyForm());
                    return showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Warning!!'),
                              titleTextStyle: dark
                                  ? CSTextTheme.darkTextTheme.titleLarge
                                  : CSTextTheme.lightTextTheme.titleLarge,
                              content: const Text(
                                  'Image may incorrect or face not detected. Please retry'),
                              contentTextStyle: dark
                                  ? CSTextTheme.darkTextTheme.bodyLarge
                                  : CSTextTheme.lightTextTheme.bodyLarge,
                              backgroundColor:
                                  dark ? CSColors.darkBg : CSColors.lightBg,
                              actionsAlignment: MainAxisAlignment.end,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Get.off(() => const RegisterFaceView());
                                    },
                                    child: Text(
                                      'Retry',
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.titleLarge
                                          : CSTextTheme
                                              .lightTextTheme.titleLarge,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'OK',
                                      style: dark
                                          ? CSTextTheme.darkTextTheme.titleLarge
                                          : CSTextTheme
                                              .lightTextTheme.titleLarge,
                                    )),
                              ],
                            ));
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          width: 140,
          height: 40,
          child: _image != null
              ? FloatingActionButton(
                  onPressed: () {
                    if (_image!.isNotEmpty) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            StudentModel student = StudentModel(
                              id: uid,
                              fullName: stuController.user.value.fullName,
                              image: _image,
                              registeredOn: DateTime.now().toIso8601String(),
                              faceFeatures: _faceFeatures,
                            );

                            FirebaseFirestore.instance
                                .collection('User Faces')
                                .doc(uid)
                                .set(student.studentFacesToJson())
                                .catchError((e) {
                              log("Registration Error: $e");
                              Loader.errorSnackBar(
                                  title: "Registration Failed! Try Again.");
                            }).whenComplete(() {
                              Navigator.pop(context);
                              Get.off(const StudCompaniesPage(initialIndex: 1));
                              Loader.successSnackBar(
                                  title: "Registration Success!");
                            });
                            return const Center(
                              child: CircularProgressIndicator(
                                color: CSColors.grey,
                              ),
                            );
                          });
                      onClicked = true;
                    }
                  },
                  backgroundColor: CSColors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: onClicked
                      ? Text(
                          "Applied",
                          style: CSTextTheme.lightTextTheme.titleLarge,
                        )
                      : Text(
                          "Submit",
                          style: CSTextTheme.lightTextTheme.titleLarge,
                        ),
                )
              : null,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
