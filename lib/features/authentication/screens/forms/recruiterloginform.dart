import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/widgets/custom_shapes/container/flexafit_sizedbox.dart';
import '../../../../utils/constants/sizes.dart';
import 'forgotpasswordbtbar.dart';
import 'textformfield.dart';

class RecruiterLoginForm extends StatefulWidget {

  const RecruiterLoginForm({super.key,  this.onPressed, this.emailController, this.passwordController, this.formKey, this.dropDownKey, required this.isLoading});

  final void Function()? onPressed;
  final TextEditingController? emailController,passwordController;
  final GlobalKey<FormState>? formKey;
  final Key? dropDownKey;
  final bool isLoading;

  @override
  State<RecruiterLoginForm> createState() => _RecruiterLoginFormState();
}

class _RecruiterLoginFormState extends State<RecruiterLoginForm> {


  @override
  Widget build(BuildContext context) {
    return  Flexafit(
      child: Container(
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
                  "Welcome Back!",
                  maxLines: 1,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    fontWeight: FontWeight.w600,
                    textStyle:
                    Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Ver(50),
                Textformfield(
                  controller: widget.emailController,
                  prefixIcon: Icon(Icons.person),
                  isEmailField: true,
                  textInputAction: TextInputAction.next,
                  hintText: "Recruiter Email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIconColor: Colors.white,
                  borderradius: 20, textCapitalization: TextCapitalization.none,
                ),
                Ver(20),
                Textformfield(
                  controller: widget.passwordController,
                  prefixIcon: Icon(Icons.lock),
                  isLoginPasswordField: true,
                  textInputAction: TextInputAction.done,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  prefixIconColor: Colors.white,
                  borderradius: 20, textCapitalization: TextCapitalization.none,
                ),
                Ver(10),
                Row(
                  mainAxisAlignment:MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(context: context, builder: (context)=>const ForgotPwdBar());
                      },
                      child: AutoSizeText("Forgot password?",
                          maxLines: 1,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                    Hor(5)
                  ],),
                Ver(40),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: TextButton.styleFrom(
                          foregroundColor: CSColors.firstColor,
                          textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                          backgroundColor: CSColors.fifthColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      onPressed: widget.onPressed,
                      child: widget.isLoading ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Processing...",style: GoogleFonts.inter(
                            color: CSColors.firstColor,
                            fontSize: 16
                          ),),
                          Hor(10),
                          const SizedBox(height:16,width: 16,child: CircularProgressIndicator(color: CSColors.firstColor,strokeWidth: 2,)),
                        ],
                      ):AutoSizeText(
                        "LogIn",
                        style: GoogleFonts.inter(
                            color: CSColors.firstColor,
                            fontWeight: FontWeight.w600,
                            textStyle: Theme.of(context).textTheme.titleLarge
                        ),
                        maxLines: 1,
                      ),
                )
                ),
                // Ver(20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     AutoSizeText(
                //       "Don't have an Account? ",
                //       maxLines: 1,
                //       style: GoogleFonts.lexend(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w400,
                //         fontSize: 14
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         Get.off(()=> const RecruiterSignup());
                //       },
                //       child: AutoSizeText(
                //         "Register Now",
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
          ),
        ),
      ),
    );
  }
}
