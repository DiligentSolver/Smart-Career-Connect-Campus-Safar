import 'package:campus_safar/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../common/widgets/custom_shapes/container/flexafit_sizedbox.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/loaders.dart';
import '../../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../../authentication/screens/forms/textformfield.dart';

class ShowStudentIds extends StatefulWidget {
  const ShowStudentIds({super.key});

  @override
  State<ShowStudentIds> createState() => _ShowStudentIdsState();
}

class _ShowStudentIdsState extends State<ShowStudentIds> {
  var collection = FirebaseFirestore.instance.collection('Enrollments');
  var studentName = FirebaseFirestore.instance
      .collection('Users')
      .doc('UserRoles')
      .collection('Student');
  late List<Map<String, dynamic>> _items;
  late List<Map<String, dynamic>> _studentItems;
  List<Map<String, dynamic>> _foundedItems = [];
  bool isLoaded = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _getList() async {
    List<Map<String, dynamic>> tempList = [];
    List<Map<String, dynamic>> tempList2 = [];
    var data = await collection.get();
    var stuData = await studentName.get();

    for (var val in stuData.docs) {
      tempList2.add(val.data());
    }

    for (var element in data.docs) {
      tempList.add(element.data());
    }

    setState(() {
      _items = tempList;
      _studentItems = tempList2;
      _foundedItems = _items;
      if (_items.isNotEmpty) {
        isLoaded = true;
      }
    });
  }

  void _filterItems(String searchText) {
    if (searchText.isEmpty) {
      _foundedItems = _items;
    } else {
      _foundedItems = _items.where((item) {
        var batch = item['Batch']
            .toString()
            .toLowerCase()
            .removeAllWhitespace
            .contains(searchText.toLowerCase().removeAllWhitespace);
        var enrollment = item['Enrollment Number']
            .toString()
            .toLowerCase()
            .removeAllWhitespace
            .contains(searchText.toLowerCase().removeAllWhitespace);
        var registration = item['isUsed']
            .toString()
            .removeAllWhitespace
            .contains(searchText.toLowerCase().removeAllWhitespace == 'on'
                ? 'true'
                : searchText.toLowerCase().removeAllWhitespace == 'off'
                    ? 'false'
                    : '#');
        return enrollment || batch || registration;
      }).toList();
    }

    setState(() {});
  }

  Future<void> saveEnrollmentNumber(
      String enrollmentNumber, String batch) async {
    // Query Firestore to check if the enrollment number already exists
    QuerySnapshot querySnapshot = await collection
        .where('Enrollment Number', isEqualTo: enrollmentNumber)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // Add set operation
      collection.doc(enrollmentNumber).set({
        'Enrollment Number': enrollmentNumber,
        'isUsed': false,
        'Batch': batch
        // Add any other fields you want to save for each enrollment number
      });
      _getList();
    }

    if (querySnapshot.docs.isNotEmpty) {
      //   not uploaded
      Loader.errorSnackBar(
          title: 'Sorry', message: 'Enrollment number already exist');
    } else {
      //uploaded
      Loader.successSnackBar(
          title: 'Uploaded', message: 'Enrollment number saved');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Flexafit(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CSAppBar(
        backgroundColor: dark ? CSColors.darkThemeBg : CSColors.firstColor,
          changeArrowColor: true,
          arrowColor: CSColors.white,
          showBackArrow: true,
          title: Text("Enrollment Numbers",style: CSTextTheme.darkTextTheme.headlineLarge,),
        ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                var enrollmentController = TextEditingController();
                var batchController = TextEditingController();
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: double.infinity,
                        color: CSColors.firstColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Text(
                                  'Add Enrollment No.',
                                  style: GoogleFonts.lexend(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Ver(20),
                                Textformfield(
                                  controller: enrollmentController,
                                  keyboardType: TextInputType.text,
                                  borderradius: 10,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  prefixIcon: const Icon(
                                    Icons.confirmation_number,
                                    color: Colors.white,
                                  ),
                                  isEnrollmentField: true,
                                  hintText: 'Enter Enrollment No.',
                                  textInputAction: TextInputAction.next,
                                ),
                                Ver(20),
                                Textformfield(
                                  controller: batchController,
                                  keyboardType: TextInputType.number,
                                  borderradius: 10,
                                  textCapitalization: TextCapitalization.none,
                                  prefixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                  isPassingYearField: true,
                                  hintText: 'Passing Year',
                                ),
                                Ver(20),
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                      textStyle: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      saveEnrollmentNumber(
                                          enrollmentController.text,
                                          batchController.text);
                                      Navigator.of(context).pop();
                                    } else {
                                      Loader.errorSnackBar(
                                          title: 'Sorry!',
                                          message: 'Fill the details first');
                                    }
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                Ver(30),
                                Text(
                                  '!!Warning!! Please do not navigate back while processing, it may harm saving',
                                  maxLines: 2,
                                  style: GoogleFonts.lexend(
                                    fontSize: 14,
                                    color: CSColors.redShade,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              backgroundColor: CSColors.firstColor,
              child: Column(
                children: [
                  Text(
                    '+',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 30),
                  ),
                ],
              )),
          backgroundColor: Colors.white,
          body: isLoaded
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border.fromBorderSide(BorderSide(width: 2)),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: TextFormField(
                            style: GoogleFonts.lexend(
                                fontSize: 16, color: Colors.black),
                            cursorColor: CSColors.firstColor,
                            onChanged: (valued) {
                              _filterItems(valued);
                            },
                            onFieldSubmitted: (valued) {
                              _filterItems(valued);
                            },
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              prefixIcon: Icon(
                                  Icons.confirmation_number_outlined,
                                  color: CSColors.firstColor),
                              suffixIcon:
                                  Icon(Icons.search, color: Colors.black54),
                            ),
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _foundedItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4, bottom: 4),
                            child: GestureDetector(
                              onTap: () {
                                var docId = _foundedItems[index]['Uid'];
                                var stuIndex = _studentItems.indexWhere(
                                    (map) => map.containsValue(docId));
                                showDialog(
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Colors.white,
                                        child: SizedBox(
                                          height: 350,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: TextFormField(
                                                    initialValue:
                                                        '${_foundedItems[index]['Enrollment Number']}',
                                                    style: GoogleFonts.lexend(
                                                        fontSize: 14,
                                                        color: CSColors
                                                            .secondColor),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    decoration: InputDecoration(
                                                        prefixIcon: const Icon(
                                                          FontAwesomeIcons
                                                              .userLock,
                                                          color: Colors.black54,
                                                        ),
                                                        suffixIcon: IconButton(
                                                            onPressed: () {
                                                              TextEditingController
                                                                  confirmValue =
                                                                  TextEditingController();
                                                              deleteEnroll() {
                                                                collection
                                                                    .doc(
                                                                        '${_foundedItems[index]['Enrollment Number']}')
                                                                    .delete();
                                                              }

                                                              deleteStudent() {
                                                                studentName
                                                                    .doc(
                                                                        '${_foundedItems[index]['Uid']}')
                                                                    .delete();
                                                              }

                                                              if (_foundedItems[
                                                                              index]
                                                                          [
                                                                          'isUsed'] ==
                                                                      true &&
                                                                  _foundedItems[
                                                                              index]
                                                                          [
                                                                          'Uid'] !=
                                                                      null) {
                                                                showDialog(
                                                                    barrierColor:
                                                                        Colors
                                                                            .transparent,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Dialog(
                                                                        backgroundColor:
                                                                            Colors.black87,
                                                                        child: SizedBox(
                                                                            child: Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              4.0),
                                                                          child: Textformfield(
                                                                              onFieldSubmitted: (value) {
                                                                                if (value == _foundedItems[index]['Enrollment Number']) {
                                                                                  deleteEnroll();
                                                                                  deleteStudent();
                                                                                  Loader.successSnackBar(title: 'Success', message: 'User deleted');
                                                                                  _getList();
                                                                                  Navigator.of(context).pop();
                                                                                } else {
                                                                                  Loader.errorSnackBar(title: 'Incorrect', message: 'not matched');
                                                                                }
                                                                              },
                                                                              controller: confirmValue,
                                                                              keyboardType: TextInputType.text,
                                                                              borderradius: 20,
                                                                              textCapitalization: TextCapitalization.characters,
                                                                              isEnrollmentField: true,
                                                                              prefixIcon: const Icon(
                                                                                Icons.confirmation_number,
                                                                                color: Colors.white,
                                                                              ),
                                                                              autofocus: true,
                                                                              hintText: 'Confirm Enrollment'),
                                                                        )),
                                                                      );
                                                                    });
                                                              } else if (_foundedItems[
                                                                              index]
                                                                          [
                                                                          'isUsed'] ==
                                                                      false &&
                                                                  _foundedItems[
                                                                              index]
                                                                          [
                                                                          'Uid'] !=
                                                                      null) {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Dialog(
                                                                        backgroundColor:
                                                                            Colors.black87,
                                                                        child: SizedBox(
                                                                            child: Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              4.0),
                                                                          child: Textformfield(
                                                                              onFieldSubmitted: (value) {
                                                                                if (value == _foundedItems[index]['Enrollment Number']) {
                                                                                  deleteEnroll();
                                                                                  deleteStudent();
                                                                                  Loader.successSnackBar(title: 'Success', message: 'User deleted');
                                                                                  _getList();
                                                                                  Navigator.of(context).pop();
                                                                                } else {
                                                                                  Loader.errorSnackBar(title: 'Incorrect', message: 'not matched');
                                                                                }
                                                                              },
                                                                              controller: confirmValue,
                                                                              keyboardType: TextInputType.text,
                                                                              borderradius: 20,
                                                                              textCapitalization: TextCapitalization.characters,
                                                                              isEnrollmentField: true,
                                                                              prefixIcon: const Icon(
                                                                                Icons.confirmation_number,
                                                                                color: Colors.white,
                                                                              ),
                                                                              autofocus: true,
                                                                              hintText: 'Confirm Enrollment'),
                                                                        )),
                                                                      );
                                                                    });
                                                              } else {
                                                                deleteEnroll();
                                                                _getList();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Loader.successSnackBar(
                                                                    title:
                                                                        'Success',
                                                                    message:
                                                                        'Enrollment deleted');
                                                              }
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: CSColors
                                                                  .firstColor,
                                                            )),
                                                        border:
                                                            InputBorder.none),
                                                    readOnly: true,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text('Name:',
                                                              style: GoogleFonts.lexend(
                                                                  color: CSColors
                                                                      .secondColor,
                                                                  fontSize:
                                                                      14)),
                                                          Hor(10),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 150,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  '${stuIndex != -1 ? _studentItems[stuIndex]['Name'] : null}',
                                                              style: GoogleFonts
                                                                  .lexend(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
                                                              autovalidateMode:
                                                                  AutovalidateMode
                                                                      .onUserInteraction,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              readOnly: true,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('Branch:',
                                                              style: GoogleFonts.lexend(
                                                                  color: CSColors
                                                                      .secondColor,
                                                                  fontSize:
                                                                      14)),
                                                          Hor(10),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 150,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  '${stuIndex != -1 ? _studentItems[stuIndex]['Branch'] : null}',
                                                              style: GoogleFonts
                                                                  .lexend(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
                                                              autovalidateMode:
                                                                  AutovalidateMode
                                                                      .onUserInteraction,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              readOnly: true,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('Phone:',
                                                              style: GoogleFonts.lexend(
                                                                  color: CSColors
                                                                      .secondColor,
                                                                  fontSize:
                                                                      14)),
                                                          Hor(10),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 150,
                                                            child:
                                                                TextFormField(
                                                              initialValue:
                                                                  '${stuIndex != -1 ? _studentItems[stuIndex]['Mobile Number'] : null}',
                                                              style: GoogleFonts
                                                                  .lexend(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
                                                              autovalidateMode:
                                                                  AutovalidateMode
                                                                      .onUserInteraction,
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              readOnly: true,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Ver(20),
                                                Expanded(
                                                  flex: 2,
                                                  child: SizedBox(
                                                    height: 50,
                                                    width: 150,
                                                    child: TextFormField(
                                                      initialValue:
                                                          '${stuIndex != -1 ? _studentItems[stuIndex]['Email'] : null}',
                                                      style: GoogleFonts.lexend(
                                                          fontSize: 12,
                                                          color: CSColors
                                                              .secondColor),
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      readOnly: true,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    context: context);
                              },
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: CSColors.firstColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: Text(
                                  (index + 1).toString(),
                                  style: GoogleFonts.notoSansMayanNumerals(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                title: Text(
                                    '${_foundedItems[index]['Enrollment Number']}',
                                    style: GoogleFonts.lexend(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                                subtitle: Text(
                                    (_foundedItems[index]['isUsed']) != null
                                        ? (_foundedItems[index]['isUsed'])
                                            ? 'Registered'
                                            : 'Not Registered'
                                        : 'Not Registered',
                                    style: GoogleFonts.aBeeZee(
                                      color: (_foundedItems[index]['isUsed']) !=
                                              null
                                          ? (_foundedItems[index]['isUsed'])
                                              ? Colors.green
                                              : Colors.red
                                          : Colors.red,
                                      fontSize: 14,
                                    )),
                                trailing: IconButton(
                                  onPressed: () async {
                                    if ((_foundedItems[index]['isUsed']) !=
                                        null) {
                                      final DocumentSnapshot value =
                                          await FirebaseFirestore.instance
                                              .collection('Enrollments')
                                              .doc(
                                                  '${_foundedItems[index]['Enrollment Number']}')
                                              .get();
                                      collection
                                          .doc(
                                              '${_foundedItems[index]['Enrollment Number']}')
                                          .update({
                                        'isUsed':
                                            value.get('isUsed') ? false : true
                                      });
                                      _getList();
                                    }
                                  },
                                  icon: Icon(
                                    (_foundedItems[index]['isUsed']) != null
                                        ? (_foundedItems[index]['isUsed'])
                                            ? Icons.toggle_on_sharp
                                            : Icons.toggle_off_sharp
                                        : Icons.toggle_off_sharp,
                                    color:
                                        (_foundedItems[index]['isUsed']) != null
                                            ? (_foundedItems[index]['isUsed'])
                                                ? Colors.green
                                                : Colors.red
                                            : Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              : const Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: CSColors.firstColor,
                        strokeWidth: 3,
                      )),
                ),
        ),
      )),
    );
  }
}
