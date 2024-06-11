import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/custom_shapes/container/flexafit_sizedbox.dart';
import '../../../../utils/constants/sizes.dart';
import 'textformfield.dart';

class RecruiterSignupForm2 extends StatefulWidget {
  const RecruiterSignupForm2({super.key, this.onPressed, this.formKey, this.locationController, this.companyController, this.designationController, this.websiteController, required this.isLoading,});

  final void Function()? onPressed;
  final TextEditingController? locationController,companyController,designationController,websiteController;
  final GlobalKey<FormState>? formKey;
  final bool isLoading;

  @override
  State<RecruiterSignupForm2> createState() => _NewSignupFormState();
}

class _NewSignupFormState extends State<RecruiterSignupForm2> {
  @override
  Widget build(BuildContext context) {
    return Flexafit(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white12,
          ),
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child:Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    Ver(10),
                    AutoSizeText(
                      "Recruiter Details",
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium,
                      ),
                    ),
                    Ver(50),
                    Textformfield(
                      controller: widget.companyController,
                      prefixIcon: const Icon(Icons.corporate_fare),
                      isCompanyField: true,
                      textInputAction: TextInputAction.next,
                      hintText: "Company Name",
                      keyboardType: TextInputType.name,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.words,
                    ),
                    Ver(20),
                    Textformfield(
                      controller: widget.locationController,
                      prefixIcon: const Icon(Icons.location_pin),
                      isLocationField: true,
                      textInputAction: TextInputAction.next,
                      hintText: "Location",
                      keyboardType: TextInputType.name,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.words,
                    ),
                    Ver(20),
                    Textformfield(
                      controller: widget.designationController,
                      prefixIcon: const Icon(Icons.manage_accounts_rounded),
                      isDesignationField: true,
                      textInputAction: TextInputAction.next,
                      hintText:"Your Designation",
                      keyboardType: TextInputType.name,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.words,
                    ),
                    Ver(20),
                    Textformfield(
                      controller: widget.websiteController,
                      prefixIcon: const Icon(Icons.web),
                      isWebsiteField: true,
                      textInputAction: TextInputAction.next,
                      hintText: "Website",
                      keyboardType: TextInputType.url,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.none,
                    ),
                    Ver(40),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              textStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                              backgroundColor: CSColors.fifthColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20))),
                          onPressed: widget.onPressed,
                          child: widget.isLoading ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Processing...",style: GoogleFonts.inter(
                                  color: CSColors.firstColor,
                                  fontSize: 16),),
                              Hor(10),
                              const SizedBox(width: 16,height: 16,child: CircularProgressIndicator(color: CSColors.firstColor)),
                            ],
                          ):AutoSizeText(
                            "SignUp",
                            style: GoogleFonts.inter(
                                color: CSColors.firstColor,
                                fontWeight: FontWeight.w600,
                                textStyle: Theme.of(context).textTheme.titleLarge
                            ),
                            maxLines: 1,
                          )),
                    ),
                    Ver(20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     AutoSizeText(
                    //       "Have an Account? ",
                    //       maxLines: 1,
                    //       style: GoogleFonts.lexend(
                    //         color: Colors.white,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () async {
                    //         UserRoleCheck.recruiter = true;
                    //         await Get.off(()=>Login());
                    //         UserRoleCheck.recruiter = false;
                    //       },
                    //       child: AutoSizeText(
                    //         "Login Here",
                    //         maxLines: 1,
                    //         style: GoogleFonts.lexend(
                    //           color: fourthcolor,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Ver(10),
              ])
          )
      ),
    ),
    );
  }
}
