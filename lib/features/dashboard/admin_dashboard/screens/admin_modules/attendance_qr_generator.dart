import 'dart:async';
import 'dart:convert';
import 'package:campus_safar/common/widgets/appbar/app_bar.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/theme/custom_themes/text_theme.dart';

class AttendanceQRGenerator extends StatefulWidget {
  const AttendanceQRGenerator({super.key});

  @override
  State<AttendanceQRGenerator> createState() => _AttendanceQRGeneratorState();
}

class _AttendanceQRGeneratorState extends State<AttendanceQRGenerator> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final String path = '/Attendance Key';
  String qrData = "Apply Attendance"; // Initial QR code data
  late Timer _timer;
  final String companyName = "Example @ Inc.";

  String generateToken() {
    final key = utf8.encode(companyName);
    final data = DateTime.now().toIso8601String();
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(utf8.encode(data));
    return digest.toString();
  }

  // Function to change QR code data
  Future<void> changeQRData() async {
    setState((){
      // Generate new data for the QR code
      qrData = generateToken();
    });
    await databaseReference.child(path).update({
      'data': qrData});
  }

  @override
  void initState() {
    super.initState();
    // Create a periodic timer to update the QR code data every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // Call the function to change the QR code data in the widget
     changeQRData();
    });
  }

  @override
  Future<void> dispose() async {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        appBar: CSAppBar(
          backgroundColor: dark ? CSColors.darkThemeBg : CSColors.firstColor,
          changeArrowColor: true,
          arrowColor: CSColors.white,
          showBackArrow: true,
          title: Text("Attendance QR Generator",style: CSTextTheme.darkTextTheme.headlineLarge,),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Ver(20),
            Expanded(flex:10,child: Center(child: Container(decoration:BoxDecoration(border: Border.all(width: 5)),child: QrImageView(data: qrData,size: 300,version: 8,)))),
            Expanded(flex:4,child: Column(children: [
              Text('Campus Drive',style: GoogleFonts.aBeeZee(fontSize: 20,color: CSColors.firstColor,fontWeight: FontWeight.w600)),
              Text(DateFormat('EEEE, dd-MM-yy').format(DateTime.now()),style: GoogleFonts.lexend(fontSize: 14,color: Colors.black54),),
              Ver(10),
              Text('${companyName}',style: GoogleFonts.lexend(fontSize: 22,color: CSColors.secondColor,fontWeight: FontWeight.w600)),
              Text('Attendance QR Code',style: GoogleFonts.aBeeZee(fontSize: 16,color: Colors.black54,fontWeight: FontWeight.w600))],)),
            Expanded(flex:5,child: Image.asset('assets/images/machine.png')),
            Ver(40),
          ],
        ),
      ),
    );
  }
}
