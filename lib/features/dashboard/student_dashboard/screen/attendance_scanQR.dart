import 'dart:ui';
import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:campus_safar/utils/device/device_utility.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart';

import '../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/loaders.dart';
import '../../../../../utils/theme/custom_themes/text_theme.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  late String data;

  _getLiveData() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    const String path = '/Attendance Key/data';
    databaseReference.child(path).onValue.listen((event) async {
      // Handle the event
      DataSnapshot snapshot = event.snapshot;
      data = snapshot.value.toString();
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        backgroundColor: CSColors.darkThemeBg,
        changeArrowColor: true,
        arrowColor: CSColors.white,
        showBackArrow: true,
        title: Text(
          "Attendance QR Scanner",
          style: CSTextTheme.darkTextTheme.headlineLarge,
        ),
      ),
      backgroundColor:CSColors.darkThemeBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.scan_barcode,color: CSColors.lightBg,size: CSDeviceUtils.getScreenHeight() * 0.40,),
                Ver(CSSizes.spaceBtwSections*2),
                ElevatedButton(
                    onPressed: () async {
                      var cameraStatus = await Permission.camera.status;
                      if (cameraStatus.isGranted) {
                        String? qrData = await scan();
                        if (qrData == _getLiveData()) {
                          Loader.successSnackBar(title: 'Attendance Marked');
                        }
                      } else {
                        var isGrant = await Permission.camera.request();
                        if (isGrant.isGranted) {
                          String? qrData = await scan();
                          if (qrData == _getLiveData()) {
                            Loader.successSnackBar(title: 'Attendance Marked');
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: CSColors.white,foregroundColor: CSColors.black,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),padding: EdgeInsets.symmetric(horizontal: CSDeviceUtils.getScreenWidth()*0.15)),
                    child: const Text('Scan')),
              ],
            ),
      )
    ));
  }
}
