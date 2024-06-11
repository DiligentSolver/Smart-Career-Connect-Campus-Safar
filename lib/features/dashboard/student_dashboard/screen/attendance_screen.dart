import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:audioplayers/audioplayers.dart';
import 'package:campus_safar/utils/helpers/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/face_extract_feature/animated_view.dart';
import '../../../../utils/face_extract_feature/camera_view.dart';
import '../../../../utils/face_extract_feature/extract_face_feature.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/models/student_model.dart';
import 'attendance_scanQR.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  FaceFeatures? _faceFeatures;
  var image1 = regula.MatchFacesImage();
  var image2 = regula.MatchFacesImage();

  String _similarity = "";
  bool _canAuthenticate = false;
  List<dynamic> users = [];
  bool userExists = false;
  StudentModel? loggingUser;
  bool isMatching = false;

  @override
  void dispose() {
    _faceDetector.close();
    _audioPlayer.dispose();
    super.dispose();
  }

  _playScanningAudio() {
    _audioPlayer
      ..setReleaseMode(ReleaseMode.loop)
      ..play(AssetSource("scan_beep.wav"));
  }

  _playFailedAudio() {
    _audioPlayer
      ..stop()
      ..setReleaseMode(ReleaseMode.release)
      ..play(AssetSource("failed.wav"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: CSColors.darkThemeBg,
      extendBodyBehindAppBar: true,
      appBar: CSAppBar(
        showBackArrow: true,
        changeArrowColor: true,
        arrowColor: CSColors.white,
        title: Text("Authenticate Face",
            style: CSTextTheme.darkTextTheme.headlineLarge),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Stack(
            children: [
              Center(
                child: CameraView(
                  onImage: (image) {
                    _setImage(image);
                  },
                  onInputImage: (inputImage) async {
                    try {
                      setState(() => isMatching = true);
                      _faceFeatures =
                          await extractFaceFeatures(inputImage, _faceDetector);
                      setState(() => isMatching = false);
                    } catch (e) {}
                  },
                ),
              ),
              if (isMatching) const Center(child: AnimatedView())
            ],
          ),
        ),
      ]),
      floatingActionButton: _canAuthenticate
          ? SizedBox(
              width: 140,
              height: 40,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() => isMatching = true);
                  _playScanningAudio();
                  _fetchUsersAndMatchFace();
                },
                backgroundColor: CSColors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "Authenticate",
                  style: CSTextTheme.lightTextTheme.titleLarge,
                ),
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }

  Future _setImage(Uint8List imageToAuthenticate) async {
    image2.bitmap = base64Encode(imageToAuthenticate);
    image2.imageType = regula.ImageType.PRINTED;

    setState(() {
      _canAuthenticate = true;
    });
  }

  double compareFaces(FaceFeatures face1, FaceFeatures face2) {
    double distEar1 = euclideanDistance(face1.rightEar!, face1.leftEar!);
    double distEar2 = euclideanDistance(face2.rightEar!, face2.leftEar!);

    double ratioEar = distEar1 / distEar2;

    double distEye1 = euclideanDistance(face1.rightEye!, face1.leftEye!);
    double distEye2 = euclideanDistance(face2.rightEye!, face2.leftEye!);

    double ratioEye = distEye1 / distEye2;

    double distCheek1 = euclideanDistance(face1.rightCheek!, face1.leftCheek!);
    double distCheek2 = euclideanDistance(face2.rightCheek!, face2.leftCheek!);

    double ratioCheek = distCheek1 / distCheek2;

    double distMouth1 = euclideanDistance(face1.rightMouth!, face1.leftMouth!);
    double distMouth2 = euclideanDistance(face2.rightMouth!, face2.leftMouth!);

    double ratioMouth = distMouth1 / distMouth2;

    double distNoseToMouth1 =
        euclideanDistance(face1.noseBase!, face1.bottomMouth!);
    double distNoseToMouth2 =
        euclideanDistance(face2.noseBase!, face2.bottomMouth!);

    double ratioNoseToMouth = distNoseToMouth1 / distNoseToMouth2;

    double ratio =
        (ratioEye + ratioEar + ratioCheek + ratioMouth + ratioNoseToMouth) / 5;
    log(ratio.toString(), name: "Ratio");

    return ratio;
  }

// A function to calculate the Euclidean distance between two points
  double euclideanDistance(Points p1, Points p2) {
    final sqr =
        math.sqrt(math.pow((p1.x! - p2.x!), 2) + math.pow((p1.y! - p2.y!), 2));
    return sqr;
  }

  _fetchUsersAndMatchFace() async {
    await FirebaseFirestore.instance
        .collection('User Faces')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .catchError((e) {
      log("Getting User Error: $e");
      setState(() => isMatching = false);
      _playFailedAudio();
      Loader.errorSnackBar(title: "Something went wrong. Please try again.");
    }).then((snap) {
      double similarity = 0;
      if (snap.data() != null ? true : false) {
        users.clear();
        StudentModel user = StudentModel.studentFacesFromJson(snap.data()!);
        try {
          similarity = compareFaces(_faceFeatures!, user.faceFeatures!);
        } catch (e) {
          _showFailureDialog(
              title: "Warning!!",
              description: "Captured image is not perfect, please try again.");
        }
        if (similarity >= 0.8 && similarity <= 1.5) {
          users.add([user, similarity]);
        }
        log(users.length.toString(), name: "Filtered Users");
        setState(() {
          //Sorts the users based on the similarity.
          //More similar face is put first.
          users.sort((a, b) => (((a.last as double) - 1).abs())
              .compareTo(((b.last as double) - 1).abs()));
        });

        _matchFaces();
      } else {
        _showFailureDialog(
          title: "Face is not registered",
          description:
              "Make sure face must be registered first before Authenticating.",
        );
      }
    });
  }

  _matchFaces() async {
    bool faceMatched = false;
    for (List user in users) {
      image1.bitmap = (user.first as StudentModel).image;
      image1.imageType = regula.ImageType.PRINTED;

      //Face comparing logic.
      var request = regula.MatchFacesRequest();
      request.images = [image1, image2];
      dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));

      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
          jsonEncode(response!.results), 0.75);

      var split =
          regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
      setState(() {
        _similarity = split!.matchedFaces.isNotEmpty
            ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)
            : "error";
        log("similarity: $_similarity");

        if (_similarity != "error" && double.parse(_similarity) > 90.00) {
          faceMatched = true;
          loggingUser = user.first;
        } else {
          faceMatched = false;
          _showFailureDialog(
            title: "Warning!!",
            description:
                "Image is incorrect or face not matched, please try again.",
          );
        }
      });
      if (faceMatched) {
        setState(() {
          isMatching = false;
        });

        if (mounted) {
          Get.off(() => const QRCodeScanner());
          _audioPlayer
            ..setReleaseMode(ReleaseMode.release)
            ..play(AssetSource("success.wav"));
        }
        break;
      }
    }
    if (!faceMatched) {
      setState(() {
        isMatching = false;
      });
    }
  }

  _showFailureDialog({required String title, required String description}) {
    _playFailedAudio();
    setState(() => isMatching = false);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            titleTextStyle: CSHelperFunctions.isDarkMode(context)
                ? CSTextTheme.darkTextTheme.titleLarge
                : CSTextTheme.lightTextTheme.titleLarge,
            content: Text(description),
            contentTextStyle: CSHelperFunctions.isDarkMode(context)
                ? CSTextTheme.darkTextTheme.bodyLarge
                : CSTextTheme.lightTextTheme.bodyLarge,
            backgroundColor: CSHelperFunctions.isDarkMode(context)
                ? CSColors.darkBg
                : CSColors.lightBg,
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: CSHelperFunctions.isDarkMode(context)
                        ? CSTextTheme.darkTextTheme.titleLarge
                        : CSTextTheme.lightTextTheme.titleLarge,
                  )),
            ],
          );
        });
  }
}
