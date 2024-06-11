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
import '../../../../../utils/theme/custom_themes/text_theme.dart';

class ShowStudentsInfo extends StatefulWidget {
  const ShowStudentsInfo({super.key});

  @override
  State<ShowStudentsInfo> createState() => _ShowStudentsInfoState();
}

class _ShowStudentsInfoState extends State<ShowStudentsInfo> {
  var studentName = FirebaseFirestore.instance
      .collection('Users')
      .doc('UserRoles')
      .collection('Student');
  late List<Map<String, dynamic>> _studentItems;
  List<Map<String, dynamic>> _foundedItems = [];

  bool isLoaded = false;

  _getList() async {
    List<Map<String, dynamic>> tempList2 = [];
    var stuData = await studentName.get();

    for (var val in stuData.docs) {
      tempList2.add(val.data());
    }

    setState(() {
      _studentItems = tempList2;
      _foundedItems = _studentItems;
      if (_studentItems.isNotEmpty) {
        isLoaded = true;
      }
    });
  }

  void _filterItems(String searchText) {
    if(searchText.isEmpty){_foundedItems = _studentItems;}
    else {
      _foundedItems = _studentItems.where((item) {
        var name = item['Name'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);
        var email = item['Email'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);
        var enrollment = item['Enrollment Number'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);
        var batch = item['Passing Year'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);
        var branch = item['Branch'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);
        var institute = item['Institute Name'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);
        var number = item['Mobile Number'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);

        if(email){
          return email;
        }
        if(enrollment){
          return enrollment;
        }
        if(number){
          return number;
        }if(batch){
          return batch;
        }if(branch){
          return branch;
        }if(institute){
          return institute;
        }
        else{
          return name;
        }

      }).toList();
    }
    setState(() {
    });
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
              title: Text("Students Info",style: CSTextTheme.darkTextTheme.headlineLarge,),
            ),
              backgroundColor: Colors.white,
              body: isLoaded ? Column(
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
                              fontSize: 16,
                              color: Colors.black
                          ),
                          cursorColor: CSColors.firstColor,
                          onChanged: (valued){
                            _filterItems(valued);
                          },
                          onFieldSubmitted: (valued){
                            _filterItems(valued);
                          },
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(FontAwesomeIcons.userGraduate,color: CSColors.firstColor),
                            suffixIcon: Icon(Icons.search,color: Colors.black54),
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
                                        height: 500,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 75,
                                                width: 150,
                                                child: TextFormField(
                                                  initialValue:
                                                  '${stuIndex != -1 ? _studentItems[stuIndex]['Email'] : null}',
                                                  style: GoogleFonts.lexend(
                                                      fontSize: 12,
                                                      color: CSColors.firstColor),
                                                  autovalidateMode:
                                                  AutovalidateMode
                                                      .onUserInteraction,
                                                  decoration: const InputDecoration(
                                                      border: InputBorder.none),
                                                  readOnly: true,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 25),
                                                child: Column(
                                                  children: [
                                                    Ver(10),
                                                    Row(
                                                      children: [
                                                        Text('Name:',
                                                            style: GoogleFonts.lexend(
                                                                color: CSColors.secondColor,
                                                                fontSize: 14)),
                                                        Hor(10),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 150,
                                                          child: TextFormField(
                                                            initialValue:
                                                            '${stuIndex != -1 ? _studentItems[stuIndex]['Name'] : null}',
                                                            style: GoogleFonts.lexend(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                            autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none),
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Roll No. :',
                                                            style: GoogleFonts.lexend(
                                                                color: CSColors.secondColor,
                                                                fontSize: 14)),
                                                        Hor(10),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 150,
                                                          child: TextFormField(
                                                            initialValue:
                                                            '${stuIndex != -1 ? _studentItems[stuIndex]['Enrollment Number'] : null}',
                                                            style: GoogleFonts.lexend(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                            autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none),
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Phone:',
                                                            style: GoogleFonts.lexend(
                                                                color: CSColors.secondColor,
                                                                fontSize: 14)),
                                                        Hor(10),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 150,
                                                          child: TextFormField(
                                                            initialValue:
                                                            '${stuIndex != -1 ? _studentItems[stuIndex]['Mobile Number'] : null}',
                                                            style: GoogleFonts.lexend(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                            autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none),
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Course:',
                                                            style: GoogleFonts.lexend(
                                                                color: CSColors.secondColor,
                                                                fontSize: 14)),
                                                        Hor(10),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 150,
                                                          child: TextFormField(
                                                            initialValue:
                                                            '${stuIndex != -1 ? _studentItems[stuIndex]['Course'] : null}',
                                                            style: GoogleFonts.lexend(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                            autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none),
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //     '${stuIndex != -1 ? _studentItems[stuIndex]['Course'] : null}',
                                                        //     overflow: TextOverflow.ellipsis,
                                                        //     style: GoogleFonts.lexend(
                                                        //         color: Colors.black87,
                                                        //         fontSize: 14)),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Branch:',
                                                            style: GoogleFonts.lexend(
                                                                color: CSColors.secondColor,
                                                                fontSize: 14)),
                                                        Hor(10),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 100,
                                                          child: TextFormField(
                                                            initialValue:
                                                            '${stuIndex != -1 ? _studentItems[stuIndex]['Branch'] : null}',
                                                            style: GoogleFonts.lexend(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                            autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none),
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Passing Year:',
                                                            style: GoogleFonts.lexend(
                                                                color: CSColors.secondColor,
                                                                fontSize: 14)),
                                                        Hor(10),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 100,
                                                          child: TextFormField(
                                                            initialValue:
                                                            '${stuIndex != -1 ? _studentItems[stuIndex]['Passing Year'] : null}',
                                                            style: GoogleFonts.lexend(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                            autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none),
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('Institute:',
                                                            style: GoogleFonts.lexend(
                                                                color: CSColors.secondColor,
                                                                fontSize: 14)),
                                                        Hor(10),
                                                        SizedBox(
                                                          height: 50,
                                                          width: 100,
                                                          child: TextFormField(
                                                            initialValue:
                                                            '${stuIndex != -1 ? _studentItems[stuIndex]['Institute Name'] : null}',
                                                            style: GoogleFonts.lexend(
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                            autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none),
                                                            readOnly: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
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
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (index + 1).toString(),
                                    style: GoogleFonts.notoSansMayanNumerals(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Ver(5),
                                  Text('${_foundedItems[index]['Passing Year']}',
                                      style: GoogleFonts.notoSansMayanNumerals(
                                        color: CSColors.firstColor,
                                        fontSize: 8,
                                      )),
                                ],
                              ),
                              title:
                              Text('${_foundedItems[index]['Name']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lexend(
                                    color: Colors.black,
                                    fontSize: 16,
                                  )),

                              subtitle: Text('${_foundedItems[index]['Email']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                    color: _foundedItems[index]['Email'] != null ? Colors.blueAccent.shade700 : Colors.red,
                                    fontSize: 12,
                                  )),

                              trailing: const Icon(FontAwesomeIcons.circleUser,color: Colors.black54,size: 30,),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ) : const Center(
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
