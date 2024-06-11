import 'package:campus_safar/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textformfield extends StatefulWidget {
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted,onChanged;
  final bool? isPasswordField,
      isLoginPasswordField,
      isSignupPasswordField,
      isEmailField,
      isPhoneField,
      isCountryCode,
      isEnrollmentField,
      isPassingYearField,
      isNameField,
      isCourseField,
      isBranchField,
      isInstituteField,isRecruiterField,isAdminField,isCompanyField,isLocationField,isDesignationField,isWebsiteField;

  final Widget? suffixIcon, widget, prefixIcon;
  final String? hintText,text;
  final TextInputType? keyboardType;
  final Color? prefixIconColor, suffixIconColor;
  final FormFieldValidator<String>? validator;
  final bool readOnly, autofocus;
  final double borderradius;
  final TextInputAction? textInputAction;
  final RegExp instituePattern = RegExp(r'^[A-Za-z. &]{2,18}$');
  final RegExp websitePattern = RegExp(r'^(?:(https?|ftp):\/\/)?(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})+(?:\/[^\s$?#]*)*$');
  final RegExp locationPattern = RegExp(r'^[a-zA-Z\s.\-]{2,18}$');
  final RegExp coursePattern = RegExp(r'^[A-Z]\.\s?[A-Za-z]+(?:\s?[A-Za-z]+)*$');
  final RegExp branchPattern = RegExp(r'^[A-Z]{2,4}$');
  final RegExp enrollmentNumberRegex = RegExp(r'^\d{2}[A-Z]{3}[0-9][A-Z]{3}\d{4,5}$');
  final RegExp countryCodeRegex = RegExp(r'^\d{1,3}$');
  final RegExp phoneNumberRegex = RegExp(r'^\d{3}-?\d{3}-?\d{4}$');
  final RegExp recruiterIdRegex = RegExp(r'^REC\d{2}HR\d{3}ID$');
  final RegExp adminIdRegex = RegExp(r'^ADM\d{2}TPC\d{3}ID$');
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z][a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$');
  static bool focused = false;

  Textformfield({super.key,
    this.isCountryCode,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.text,
    required this.keyboardType,
    this.prefixIconColor,
    this.suffixIconColor,
    this.validator,
    this.readOnly = false,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.onFieldSubmitted,
    this.isPasswordField,
    this.widget,
    this.isEmailField,
    this.isPhoneField,
    this.isEnrollmentField,
    this.isPassingYearField,
    this.isNameField,
    this.isCourseField,
    this.isBranchField,
    this.isInstituteField,
    this.autofocus = false,
    required this.borderradius,
    this.textInputAction, this.isLoginPasswordField, this.isSignupPasswordField, this.isRecruiterField, this.isAdminField, this.isCompanyField, this.isLocationField, this.isDesignationField, this.isWebsiteField,required this.textCapitalization
  });

  @override
  State<Textformfield> createState() => _TextFormFieldSignupState();
}

class _TextFormFieldSignupState extends State<Textformfield> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      key: widget.key,
      controller: widget.controller,
      obscureText: widget.isPasswordField == true||widget.isLoginPasswordField == true||widget.isSignupPasswordField == true ? obsecureText : false,
      validator: widget.isCountryCode == true ? (value) {
        if (value!.isEmpty) {
          return "C.code";
        }
        if (!widget.countryCodeRegex.hasMatch(value)) {
          return "C.code";
        }
        return null;
      }: widget.isEmailField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Enter Email";
        }
        if (!widget.emailRegex.hasMatch(value)) {
          return "Enter a valid Email";
        }
        return null;
      }
          : widget.isSignupPasswordField == true
              ? (value) {
          if (value!.isEmpty) {
            return "Enter Password";
          }
          return null;
      } : widget.isLoginPasswordField == true
              ? (value) {
        if (value!.isEmpty) {
          return "Enter Password";
        }
        return null;
      } : widget.isPasswordField == true
              ? (value) {
        if (value!.isEmpty) {
          return "Enter Password";
        }
        return null;
      }
              : widget.isPhoneField == true
                  ? (value) {
                      if (value!.isEmpty) {
                        return "Enter Mobile Number";
                      }
                      if (!widget.phoneNumberRegex.hasMatch(value)) {
                        return "Enter valid Mobile Number";
                      }
                      return null;
                    }
                  : widget.isEnrollmentField == true
                      ? (value) {
                          if (value!.isEmpty) {
                            return "Enter Enrollment no.";
                          }
                          if (!widget.enrollmentNumberRegex.hasMatch(value)) {
                            return "Enter valid Enrollment no.";
                          }
                          return null;
                        }
                      : widget.isPassingYearField == true
                          ? (value) {
                              if (value!.isEmpty) {
                                return "Enter Passing Year";
                              }
                              if (value.length < 4 || value.length > 4) {
                                return "Enter in YYYY format";
                              }
                              if (int.parse(value) < 2023) {
                                return "not eligible";
                              }
                              return null;
                            }
                          : widget.isNameField == true
                              ? (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Name";
                                  }
                                  return null;
                                }
                              : widget.isCourseField == true
                                  ? (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Course";
                                      }
                                      if (!widget.coursePattern.hasMatch(value)) {
                                        return "B.Tech/M.Tech/BCA/MCA/MBA/B.Sc/B.Pharm";
                                      }
                                      return null;
                                    }
                                  : widget.isBranchField == true
                                      ? (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Branch";
                                          }
                                          if (!widget.branchPattern.hasMatch(value)) {
                                            return "CSE/IT/AI/ML/DS/CSF/ME/EC/CA";
                                          }
                                          return null;
                                        }
                                      : widget.isInstituteField == true
                                          ? (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Institute Name";
                                              }
                                              return null;
                                            }
                                          : widget.isRecruiterField == true ? (value) {
        if (value!.isEmpty) {
          return "Enter Recruiter Id";
        }
        if (!widget.recruiterIdRegex.hasMatch(value)) {
          return "Enter valid Recruiter Id";
        }
        return null;
      }:widget.isAdminField == true ? (value) {
        if (value!.isEmpty) {
          return "Enter Admin Id";
        }
        if (!widget.adminIdRegex.hasMatch(value)) {
          return "Enter valid Admin Id";
        }
        return null;
      } : widget.isCompanyField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Enter Company Name";
        }
        return null;
      }:widget.isLocationField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Enter Location";
        }
        if (!widget.locationPattern.hasMatch(value)) {
          return "Indore/Pune/Mumbai/Bangalore";
        }
        return null;
      }:widget.isDesignationField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Enter Designation";
        }
        return null;
      }:widget.isWebsiteField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Enter Website";
        }
        if (!widget.websitePattern.hasMatch(value)) {
          return "Enter Valid Url";
        }
        return null;
      }:null,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.prefixIconColor,
        suffixIcon: widget.isLoginPasswordField == true ? GestureDetector(
          onTap: () {
            setState(() {
              obsecureText = !obsecureText;
            });
          },
          child: Icon(obsecureText ? Icons.visibility_off : Icons.visibility,
                  color: obsecureText == false ? Colors.lightBlue : Colors.white)
        ):
        widget.isSignupPasswordField == true ? GestureDetector(
            onTap: () {
              setState(() {
                obsecureText = !obsecureText;
              });
            },
            child: Icon(obsecureText ? Icons.visibility_off : Icons.visibility,
                color: obsecureText == false ? Colors.lightBlue : Colors.white)
        ):null,
        suffixIconColor: widget.suffixIconColor,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.lexend(
            color: Colors.white60,
            fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: Colors.white, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: CSColors.fourthColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: CSColors.redShade, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: Colors.white, width: 1),
        ),
      ),
      cursorColor: Colors.white,
      textInputAction: widget.textInputAction,
      textAlign: TextAlign.start,
      keyboardType: widget.keyboardType,
      style: GoogleFonts.lexend(
          color: Colors.white, fontSize: 16,),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      textCapitalization: widget.textCapitalization,
    );
  }
}
