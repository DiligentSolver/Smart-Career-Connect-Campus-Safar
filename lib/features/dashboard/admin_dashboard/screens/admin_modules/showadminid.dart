import 'dart:math';
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

class ShowAdminIds extends StatefulWidget {
  const ShowAdminIds({super.key});

  @override
  State<ShowAdminIds> createState() => _ShowAdminIdsState();
}

class _ShowAdminIdsState extends State<ShowAdminIds> {
  var collection = FirebaseFirestore.instance.collection('Ad_id');
  var adName = FirebaseFirestore.instance
      .collection('Users')
      .doc('UserRoles')
      .collection('Admin');
  late List<Map<String, dynamic>> _items;
  late List<Map<String, dynamic>> _adItems;
  List<Map<String, dynamic>> _foundedItems = [];

  bool isLoaded = false;

  _getList() async {
    List<Map<String, dynamic>> tempList = [];
    List<Map<String, dynamic>> tempList2 = [];
    var data = await collection.get();
    var adData = await adName.get();

    for (var val in adData.docs) {
      tempList2.add(val.data());
    }

    for (var element in data.docs) {
      tempList.add(element.data());
    }

    setState(() {
      _items = tempList;
      _adItems = tempList2;
      _foundedItems = _items;
      if (_items.isNotEmpty) {
        isLoaded = true;
      }
    });
  }

  void _filterItems(String searchText) {
    if(searchText.isEmpty){_foundedItems = _items;}
    else{
        _foundedItems = _items.where((item) {
          var adId = item['Enrollment Number'].toString().toLowerCase().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace);
          var registration = item['isUsed'].toString().removeAllWhitespace.contains(searchText.toLowerCase().removeAllWhitespace == 'on' ? 'true' : searchText.toLowerCase().removeAllWhitespace == 'off' ? 'false' : '#');
          return adId || registration;
        }).toList();
    }
    setState(() {
    });
  }

  Future<void> saveAdminId() async {

    var adId = generateAdId();

    // Query Firestore to check if the enrollment number already exists
    QuerySnapshot querySnapshot = await collection
        .where('Admin Id', isEqualTo: adId).get();

    if (querySnapshot.docs.isEmpty) {
      // Add set operation
      collection.doc(adId).set({
        'Admin Id': adId,
        'isUsed': false,
        // Add any other fields you want to save for each enrollment number
      });
      _getList();
    }

    if (querySnapshot.docs.isNotEmpty) {
      //   not uploaded
      Loader.errorSnackBar(
          title: 'Sorry', message: 'Admin Id already exist');
    } else {
      //uploaded
      setState(() {
        Loader.successSnackBar(
            title: 'Uploaded', message: 'Admin Id saved');
      });
    }
  }

  String generateAdId() {
    // Get the current year
    int currentYear = DateTime.now().year % 100; // Extracting last two digits

    // Generate random three-digit number for the XXX placeholder
    Random random = Random();
    int threeDigitNumber = random.nextInt(1000);

    // Format the ID
    String adId = 'ADM${currentYear.toString().padLeft(2, '0')}TPC${threeDigitNumber.toString().padLeft(3, '0')}ID';

    return adId;
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
                title: Text("Admin Ids",style: CSTextTheme.darkTextTheme.headlineLarge,),
              ),
              floatingActionButton: SizedBox(
                width: 125,
                child: FloatingActionButton(onPressed: (){
                  saveAdminId();
                },backgroundColor: CSColors.firstColor,child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Generate Id',style: GoogleFonts.inter(color: Colors.white,fontSize: 16),),
                  ],
                ),),
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
                            prefixIcon: Icon(Icons.confirmation_number_outlined,color: CSColors.firstColor),
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
                              var adIndex = _adItems.indexWhere(
                                      (map) => map.containsValue(docId));
                              showDialog(
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.white,
                                      child: SizedBox(
                                        height: 300,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: TextFormField(
                                                  initialValue:
                                                  '${_foundedItems[index]['Admin Id']}',
                                                  style: GoogleFonts.lexend(
                                                      fontSize: 14,
                                                      color: CSColors.secondColor),
                                                  autovalidateMode:
                                                  AutovalidateMode
                                                      .onUserInteraction,
                                                  decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        FontAwesomeIcons.userLock,
                                                        color: Colors.black54,
                                                      ),
                                                      suffixIcon: IconButton(
                                                          onPressed: () {
                                                            deleteRecId(){
                                                              collection
                                                                  .doc(
                                                                  '${_foundedItems[index]['Admin Id']}')
                                                                  .delete();
                                                            }
                                                            deleteRecruiter(){
                                                              adName
                                                                  .doc(
                                                                  '${_foundedItems[index]['Uid']}')
                                                                  .delete();
                                                            }
                                                            if (_foundedItems[index]
                                                            ['isUsed'] == true && _foundedItems[index]
                                                            ['Uid'] !=
                                                                null) {
                                                              showDialog(barrierColor: Colors.transparent,context: context, builder: (BuildContext context){
                                                                return Dialog(
                                                                  backgroundColor: Colors.black87,
                                                                  child: SizedBox(child: Padding(
                                                                    padding: const EdgeInsets.all(4.0),
                                                                    child: Textformfield(onFieldSubmitted: (value){
                                                                      if(value == _foundedItems[index]['Admin Id']){
                                                                        deleteRecId();
                                                                        deleteRecruiter();
                                                                        Loader.successSnackBar(title: 'Success',message: 'User deleted');
                                                                        _getList();
                                                                        Navigator.of(context).pop();
                                                                      }
                                                                      else{
                                                                        Loader.errorSnackBar(title: 'Incorrect',message: 'not matched');
                                                                      }
                                                                    },keyboardType: TextInputType.text, borderradius: 20, textCapitalization: TextCapitalization.characters,isAdminField: true,prefixIcon: Icon(Icons.confirmation_number,color: Colors.white,),autofocus: true,hintText: 'Confirm Admin Id'),
                                                                  )),
                                                                );
                                                              });
                                                            }
                                                            else if(_foundedItems[index]
                                                            ['isUsed'] == false && _foundedItems[index]
                                                            ['Uid'] !=
                                                                null){
                                                              showDialog(context: context, builder: (BuildContext context){
                                                                return Dialog(
                                                                  backgroundColor: Colors.black87,
                                                                  child: SizedBox(child: Padding(
                                                                    padding: const EdgeInsets.all(4.0),
                                                                    child: Textformfield(onFieldSubmitted: (value){
                                                                      if(value == _foundedItems[index]['Admin Id']){
                                                                        deleteRecId();
                                                                        deleteRecruiter();
                                                                        Loader.successSnackBar(title: 'Success',message: 'User deleted');
                                                                        _getList();
                                                                        Navigator.of(context).pop();
                                                                      }
                                                                      else{
                                                                        Loader.errorSnackBar(title: 'Incorrect',message: 'not matched');
                                                                      }
                                                                    },keyboardType: TextInputType.text, borderradius: 20, textCapitalization: TextCapitalization.characters,isRecruiterField: true,prefixIcon: Icon(Icons.confirmation_number,color: Colors.white,),autofocus: true,hintText: 'Confirm Enrollment'),
                                                                  )),
                                                                );
                                                              });
                                                            }
                                                            else{
                                                              deleteRecId();
                                                              _getList();
                                                              Navigator.of(context).pop();
                                                              Loader.successSnackBar(title: 'Success', message: 'Admin id deleted');
                                                            }
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.black,
                                                          )),
                                                      border: InputBorder.none),
                                                  readOnly: true,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 50),
                                                  child: Column(
                                                    children: [
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
                                                              '${index != -1 ? _adItems[adIndex]['Name'] : null}',
                                                              style: GoogleFonts.lexend(
                                                                  fontSize: 14,
                                                                  color: Colors.black),
                                                              autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                              decoration: const InputDecoration(
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
                                                              '${adIndex != -1 ? _adItems[adIndex]['Mobile Number'] : null}',
                                                              style: GoogleFonts.lexend(
                                                                  fontSize: 14,
                                                                  color: Colors.black),
                                                              autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                              decoration: const InputDecoration(
                                                                  border: InputBorder.none),
                                                              readOnly: true,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 150,
                                                  child: TextFormField(
                                                    initialValue:
                                                    '${adIndex != -1 ? _adItems[adIndex]['Email'] : null}',
                                                    style: GoogleFonts.lexend(
                                                        fontSize: 12,
                                                        color: CSColors.secondColor),
                                                    autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none),
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
                              title:
                              Text('${_foundedItems[index]['Admin Id']}',
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
                                    color: (_foundedItems[index]['isUsed']) != null
                                        ? (_foundedItems[index]['isUsed'])
                                        ? Colors.green
                                        : Colors.red
                                        : Colors.red,
                                    fontSize: 14,
                                  )),
                              trailing: IconButton(
                                onPressed: () async {
                                  if ((_foundedItems[index]['isUsed']) != null) {
                                    final DocumentSnapshot value =
                                    await FirebaseFirestore.instance
                                        .collection('Rec_id')
                                        .doc(
                                        '${_foundedItems[index]['Admin Id']}')
                                        .get();
                                    collection
                                        .doc(
                                        '${_foundedItems[index]['Admin Id']}')
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
                                  color: (_foundedItems[index]['isUsed']) != null
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
