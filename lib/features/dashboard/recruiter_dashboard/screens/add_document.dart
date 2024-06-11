import 'package:campus_safar/common/widgets/Divider/divider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../common/widgets/search_bar/search_bar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';
import '../../../authentication/controllers/user controller/recruiter_controller.dart';

class AddDocumentScreen extends StatefulWidget {
  const AddDocumentScreen({super.key});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecruiterController());
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            bottom: CSSizes.spaceBtwSections,
            right: CSSizes.sm,
            left: CSSizes.sm),
        child: Column(
          children: [
            Ver(CSSizes.defaultSpace),
            const CSSearchBar(
              showBackground: false,
              padding: EdgeInsets.only(right: CSSizes.sm, left: CSSizes.sm),
              text: '',
              showTrailingIcon: true,
              trailingIcon: Icons.add,
            ),
            Center(
              child: Text(
                "or",
                style: dark
                    ? CSTextTheme.darkTextTheme.bodyLarge
                    : CSTextTheme.lightTextTheme.bodyLarge,
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: controller.selected.value
                  ? () {}
                  : () {
                      controller.pickExcelFile(FileType.custom, 'xlsx');
                    },
              child: controller.selected.value
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
                                color: CSColors.firstColor)),
                      ],
                    ),
            ),
            const CSDividerBold(),
            const CSDivider(),
            const CSDividerBold(),
            const CSDividerBold(),
            controller.image != null
                ? Container(
                    width: CSDeviceUtils.getScreenWidth() / 2,
                    height: CSDeviceUtils.getScreenHeight() * 0.20,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CSColors.white,
                    ),
                    child: controller.image,
                  )
                : Container(),
            const CSDividerBold(),
            ElevatedButton(
              style: TextButton.styleFrom(
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: controller.selected.value
                  ? () {}
                  : () {
                      showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                          backgroundColor:
                              dark ? CSColors.darkThemeBg : CSColors.white,
                          builder: (context) => Container(
                                height: CSDeviceUtils.getScreenHeight() * 0.190,
                                padding: const EdgeInsets.only(
                                    right: CSSizes.md, left: CSSizes.md),
                                child: Column(
                                  children: [
                                    CSSectionHeading(
                                      title: "Upload Document",
                                      titleStyle: dark
                                          ? CSTextTheme
                                              .darkTextTheme.headlineSmall
                                          : CSTextTheme
                                              .lightTextTheme.headlineSmall,
                                      showTextButton: false,
                                      showActionWidget: true,
                                      actionWidget: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete)),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CSCircularIcon(
                                          showLabel: true,
                                          padding:
                                              const EdgeInsets.all(CSSizes.md),
                                          icon: CupertinoIcons.camera,
                                          iconSize: CSSizes.iconMd,
                                          label: "Camera",
                                          onPressed: () {
                                            controller
                                                .pickImage(ImageSource.camera);
                                          },
                                          showBorder: true,
                                        ),
                                        Hor(10),
                                        CSCircularIcon(
                                          showLabel: true,
                                          padding:
                                              const EdgeInsets.all(CSSizes.md),
                                          icon: CupertinoIcons.photo,
                                          iconSize: CSSizes.iconMd,
                                          label: "Gallery",
                                          onPressed: () {
                                            controller.pickFile(FileType.image,
                                                ['jpg', 'png', 'jpeg', 'img']);
                                          },
                                          showBorder: true,
                                        ),
                                        Hor(10),
                                        CSCircularIcon(
                                          showLabel: true,
                                          padding:
                                              const EdgeInsets.all(CSSizes.md),
                                          icon: CupertinoIcons.doc,
                                          iconSize: CSSizes.iconMd,
                                          label: "Document",
                                          onPressed: () {
                                            controller.pickFile(
                                                FileType.custom, ['pdf']);
                                          },
                                          showBorder: true,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.upload_file,
                    color: Colors.orange,
                  ),
                  Hor(10),
                  Text('Upload Document',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: CSColors.firstColor)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 140,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: dark ? CSColors.white : CSColors.firstColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            "Post",
            style: dark
                ? CSTextTheme.lightTextTheme.titleMedium
                : CSTextTheme.darkTextTheme.titleMedium,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
