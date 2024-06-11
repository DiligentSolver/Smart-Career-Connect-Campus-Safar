import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/custom_shapes/container/flexafit_sizedbox.dart';
import '../../../../utils/constants/sizes.dart';
import 'textformfield.dart';

class StudentSignupForm extends StatefulWidget {
  const StudentSignupForm({
    super.key,
    this.onPressed,
    this.nameController,
    this.enrollmentController,
    this.emailController,
    this.numberController,
    this.passwordController,
    this.formKey, required this.isLoading,
  });

  final TextEditingController? nameController,
      enrollmentController,
      emailController,
      numberController,
      passwordController;
  final void Function()? onPressed;
  final GlobalKey<FormState>? formKey;
  static String selectedCode = '+91';
  final bool isLoading;

  @override
  State<StudentSignupForm> createState() => _StudentSignupFormState();
}

class _StudentSignupFormState extends State<StudentSignupForm> {

  @override
  Widget build(BuildContext context) {

    Size s = MediaQuery.of(context).size;

    return Flexafit(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white12,
          ),
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    Ver(10),
                    AutoSizeText(
                      "Register",
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        textStyle: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Ver(50),
                    Textformfield(
                      controller: widget.nameController,
                      prefixIcon: const Icon(Icons.person),
                      isNameField: true,
                      textInputAction: TextInputAction.next,
                      hintText: "Full Name",
                      keyboardType: TextInputType.name,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.words,
                    ),
                    Ver(20),
                    Textformfield(
                      controller: widget.enrollmentController,
                      prefixIcon: const Icon(Icons.confirmation_number_outlined),
                      isEnrollmentField: true,
                      textInputAction: TextInputAction.next,
                      hintText: "Enrollment No.",
                      keyboardType: TextInputType.text,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.characters,
                    ),
                    Ver(20),
                    Textformfield(
                      controller: widget.emailController,
                      prefixIcon: const Icon(Icons.email),
                      isEmailField: true,
                      textInputAction: TextInputAction.next,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.none,
                    ),
                    Ver(20),
                    Row(
                      children: [
                        Container(
                          height: 62.5,
                          decoration: const BoxDecoration(color: Colors.white24,borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: CountryCodePicker(
                            dialogBackgroundColor: const Color(0x0001d97c),
                            barrierColor: Colors.black54,
                            textStyle: GoogleFonts.inter(color: Colors.white),
                            onChanged: (CountryCode? countryCode) {
                                StudentSignupForm.selectedCode = countryCode?.code ?? '+91';
                            },
                            initialSelection: '+91',
                            favorite: const ['+91', 'IN'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            boxDecoration: const BoxDecoration(color: Color(0x0001d97c)),
                          ),
                        ),
                        Hor(5),
                        Expanded(
                          flex: 4,
                          child: Textformfield(
                            controller: widget.numberController,
                              textInputAction: TextInputAction.next,
                              isPhoneField: true,
                              keyboardType: TextInputType.number,
                              borderradius: 20, textCapitalization: TextCapitalization.none,),
                        ),
                      ],
                    ),
                    Ver(20),
                    Textformfield(
                       controller: widget.passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      isSignupPasswordField: true,
                      textInputAction: TextInputAction.done,
                      hintText: "Create Password",
                      keyboardType: TextInputType.visiblePassword,
                      prefixIconColor: Colors.white,
                      borderradius: 20, textCapitalization: TextCapitalization.none,
                    ),
                    Ver(40),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: TextButton.styleFrom(
                              foregroundColor: CSColors.firstColor,
                              textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge),
                              backgroundColor: CSColors.fifthColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: widget.onPressed,
                          child: const AutoSizeText(
                            "Next",
                            maxLines: 1,
                          )),
                    ),
                    // Ver(20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     AutoSizeText(
                    //       "Have an Account? ",
                    //       maxLines: 1,
                    //       style: GoogleFonts.lexend(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 14
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () async {
                    //         UserRoleCheck.student = true;
                    //         await Get.off(()=>Login());
                    //         UserRoleCheck.student = false;
                    //       },
                    //       child: AutoSizeText(
                    //         "Login Here",
                    //         maxLines: 1,
                    //         style: GoogleFonts.lexend(
                    //           color: fourthcolor,
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Ver(10),
                  ],
                ),
              ))),
    );
  }
}
