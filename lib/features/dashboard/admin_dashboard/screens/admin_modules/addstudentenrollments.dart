import 'dart:io';
import 'dart:math';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../common/widgets/custom_shapes/container/flexafit_sizedbox.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/loaders.dart';
import '../../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../../authentication/screens/forms/textformfield.dart';

class AddEnrollmentsScreen extends StatefulWidget {
  const AddEnrollmentsScreen({super.key});

  @override
  State<AddEnrollmentsScreen> createState() => _AddEnrollmentsScreenState();
}

class _AddEnrollmentsScreenState extends State<AddEnrollmentsScreen> {
  String? resultpath;
  bool selected = false,
      isUploaded = false,
      isOneClicker = false,
      isBreak = false;
  final RegExp enrollmentNumberRegex =
      RegExp(r'^\d{2}[A-Z]{3}[0-9][A-Z]{3}\d+$');
  late List<Map<String, dynamic>> _items;
  var collection = FirebaseFirestore.instance.collection('Enrollments');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController batchController = TextEditingController();

  List<String> _getEnrollmentNumbers(String filePath) {
    final bytes = File(filePath).readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables.keys.first;
    final table = excel.tables[sheet]!;
    List<String> enrollmentNumbers = [];
    for (var row in table.rows) {
      // Assuming the enrollment number is in the first column (adjust as needed)
      final enrollmentNumber = row[0]?.value.toString() ?? '';
      if (enrollmentNumberRegex.hasMatch(enrollmentNumber)) {
        enrollmentNumbers.add(enrollmentNumber);
      }
    }
    return enrollmentNumbers;
  }

  Future<String?> pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      resultpath = result.files.single.path;
      setState(() {
        selected = true;
      });
    } else {
      setState(() {
        selected = false;
      });
    }

    return null;
  }

  _getList() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await collection.get();

    for (var element in data.docs) {
      tempList.add(element.data());
    }
    _items = tempList;
  }

  Future<void> saveMultipleEnrollmentNumbers(
      List<String> enrollmentNumbers) async {
    if (_items.isNotEmpty) {
      // Loop through each enrollment number and add it to the batch
      for (String enrollmentNumber in enrollmentNumbers) {
        if (isBreak) {
          break;
        }
        var checking = _items
            .where((element) => element['Enrollment Number']
                .toString()
                .contains(enrollmentNumber))
            .toList();
        // Query Firestore to check if the enrollment number already exists
        // QuerySnapshot querySnapshot = await collection
        //     .where(
        //       'Batch',
        //       isEqualTo: controller.batchController.text,
        //     )
        //     .where('Enrollment Number', isEqualTo: enrollmentNumber)
        //     .get();

        if (checking.isEmpty) {
          // Add set operation
          collection.doc(enrollmentNumber).set({
            'Enrollment Number': enrollmentNumber,
            'isUsed': false,
            'Batch': batchController.text,
            // Add any other fields you want to save for each enrollment number
          });
        }
      }

      Random random = Random();

      QuerySnapshot querySnapshot = await collection
          .where('Enrollment Number',
              isEqualTo: enrollmentNumbers[enrollmentNumbers.length -
                  random.nextInt(enrollmentNumbers.length)])
          .get();

      if (querySnapshot.docs.isEmpty) {
        //   not uploaded
        setState(() {
          isUploaded = false;
        });
        Loader.errorSnackBar(
            title: 'Sorry', message: 'Enrollment numbers not saved');
      } else {
        //uploaded
        setState(() {
          isUploaded = true;
          Loader.successSnackBar(
              title: 'Uploaded', message: 'Enrollment numbers saved');
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isUploaded = false;
    isOneClicker = false;
    _getList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isBreak = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CSAppBar(
            backgroundColor: dark ? CSColors.darkThemeBg : CSColors.firstColor,
            changeArrowColor: true,
            arrowColor: CSColors.white,
            showBackArrow: true,
            title: Text(
              "Add Enrollment Numbers",
              style: CSTextTheme.darkTextTheme.headlineLarge,
            ),
          ),
          backgroundColor: CSColors.firstColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flexafit(
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Expanded(
                          flex: 5,
                          child: Icon(
                            FontAwesomeIcons.database,
                            size: 150,
                            color: CSColors.fifthColorShade,
                          )),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                            textStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: selected ? () {} : pickExcelFile,
                        child: selected
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  Hor(10),
                                  Text(
                                    'Uploaded',
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: CSColors.firstColor),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.upload_file,
                                    color: Colors.orange,
                                  ),
                                  Hor(10),
                                  Text('Upload Excel File',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: CSColors.firstColor))
                                ],
                              ),
                      ),
                      Ver(20),
                      Textformfield(
                        controller: batchController,
                        hintText: 'Passing Year',
                        prefixIcon: const Icon(Icons.calendar_month),
                        prefixIconColor: Colors.white,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        borderradius: 10,
                        textCapitalization: TextCapitalization.none,
                        isPassingYearField: true,
                      ),
                      Ver(20),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                            textStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: isUploaded
                            ? () {}
                            : () async {
                                final filePath = resultpath;
                                if (filePath != null) {
                                  if (!isOneClicker) {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isOneClicker = true;
                                      });
                                      final enrollmentNumbers =
                                          _getEnrollmentNumbers(filePath);
                                      saveMultipleEnrollmentNumbers(
                                          enrollmentNumbers);
                                      if (isUploaded) {
                                        setState(() {
                                          isOneClicker = false;
                                        });
                                      }
                                      formKey.currentState!.reset();
                                    }
                                  }
                                } else {
                                  Loader.errorSnackBar(
                                      title: 'Sorry!',
                                      message: 'Please select the file');
                                }
                              },
                        child: isUploaded
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  Hor(10),
                                  Text(
                                    'Saved',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: CSColors.firstColor),
                                  ),
                                ],
                              )
                            : isOneClicker
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Processing...",
                                        style: GoogleFonts.inter(
                                            color: CSColors.firstColor,
                                            fontSize: 16),
                                      ),
                                      Hor(10),
                                      const SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: CircularProgressIndicator(
                                            color: CSColors.firstColor,
                                            strokeWidth: 2,
                                          )),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        const Icon(Icons.save_alt_rounded,
                                            color: Colors.teal),
                                        Hor(10),
                                        Text(
                                          'Save Enrollment No.',
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: CSColors.firstColor),
                                        ),
                                      ]),
                      ),
                      Ver(20),
                      isOneClicker
                          ? Text(
                              isUploaded
                                  ? 'Save completed'
                                  : 'Saving the enrollment numbers to the server. Please wait...',
                              style: GoogleFonts.lexend(color: Colors.white),
                              textAlign: isUploaded
                                  ? TextAlign.center
                                  : TextAlign.left,
                            )
                          : const Text(''),
                      Expanded(flex: 2, child: Ver(80)),
                      Expanded(
                        flex: 2,
                        child: isUploaded
                            ? Column(
                                children: [
                                  Text(
                                    'Now you may navigate back...',
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : Text(
                                '!!Warning!! Please do not navigate back while processing, it may harm saving the enrollment numbers to database',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  color: Colors.yellow,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
