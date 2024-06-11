import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:campus_safar/common/widgets/appbar/app_bar.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../data/repositories/user_repository.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/loaders.dart';
import '../../../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../../../authentication/controllers/user controller/student_controller.dart';
import '../../../../../authentication/models/student_model.dart';

class CSEditSkillsForm extends StatefulWidget {
  const CSEditSkillsForm({super.key, this.hintStyle});

  final TextStyle? hintStyle;
  @override
  State<CSEditSkillsForm> createState() => _CSEditSkillsFormState();
}

class _CSEditSkillsFormState extends State<CSEditSkillsForm> {


  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final skillsField = TextEditingController();
    final controller = Get.put(StudentController());
    final userRepo = Get.put(UserRepository());
    return SafeArea(
      child: Scaffold(
        appBar: CSAppBar(
          showBackArrow: true,
          title: Text(
            "Skills",
            style: dark
                ? CSTextTheme.darkTextTheme.headlineMedium
                : CSTextTheme.lightTextTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(CSSizes.listViewSpacing),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.user.value.skills?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: CSSizes.sm),
                              decoration: BoxDecoration(
                                  color: dark
                                      ? CSColors.white.withOpacity(0.1)
                                      : CSColors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: CSSectionHeading(
                                title: controller.user.value.skills?[index],
                                titleStyle: dark
                                    ? CSTextTheme.darkTextTheme.titleLarge
                                    : CSTextTheme.lightTextTheme.titleLarge,
                                showTextButton: false,
                                showActionWidget: true,
                                actionWidget: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.user.value.skills?.removeAt(index);
                                        StudentModel editSkills = StudentModel(skills: controller.user.value.skills);
                                        userRepo.updateStuSkillsDetails(editSkills);
                                      });
                                    },
                                    icon: const Icon(Icons.delete)),
                              )),
                          const CSDividerBold()
                        ],
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Add Your Skill..",
                      hintStyle: CSHelperFunctions.isDarkMode(context)
                          ? CSTextTheme.darkTextTheme.titleMedium
                          : CSTextTheme.lightTextTheme.titleMedium,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {
                            if(skillsField.text.isNotEmpty) {
                              setState(() {
                                controller.user.value.skills?.add(skillsField.text);
                              });
                            }
                          },
                          iconSize: CSSizes.iconMd,
                          icon: const Icon(CupertinoIcons.add)),
                    ),
                    onFieldSubmitted: (skill){
                      if(skillsField.text.isNotEmpty) {
                        setState(() {
                          controller.user.value.skills?.add(skillsField.text);
                        });
                      }
                    },
                    controller: skillsField,
                  ),
                  const CSDivider(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 140,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              if(controller.user.value.skills!.isNotEmpty) {
              StudentModel editSkills = StudentModel(skills: controller.user.value.skills);
              userRepo.updateStuSkillsDetails(editSkills);
              Loader.successSnackBar(title: "Saved");
                print(controller.user.value.skills);
              setState(() {
              });
            }
              },
            backgroundColor: dark ? CSColors.white : CSColors.firstColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              "Save",
              style: dark
                  ? CSTextTheme.lightTextTheme.titleMedium
                  : CSTextTheme.darkTextTheme.titleMedium,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
