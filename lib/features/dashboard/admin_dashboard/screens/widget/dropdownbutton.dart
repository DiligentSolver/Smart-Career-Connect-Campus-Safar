import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/helpers/helper_functions.dart';
import 'package:campus_safar/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class RoleSelectionButton extends StatefulWidget {
  const RoleSelectionButton({super.key, this.items,
    this.backgroundColor= CSColors.transparent, this.style, this.value, this.dropdowndarkbgColor, this.dropdownlightbgColor, this.iconEnabledColor, this.iconSize  = 24.0, this.dropdownMenuLightStyle, this.dropdownMenuDarkStyle});

  final List<String>? items;
  final Color? backgroundColor;
  final TextStyle? style;
  final TextStyle? dropdownMenuLightStyle;
  final TextStyle? dropdownMenuDarkStyle;
  final String? value;
  final Color? dropdowndarkbgColor;
  final Color? dropdownlightbgColor;
  final Color? iconEnabledColor;
  final double iconSize;

  @override
  State<RoleSelectionButton> createState() => _RoleSelectionButtonState();
}

class _RoleSelectionButtonState extends State<RoleSelectionButton> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return Container(
        decoration: BoxDecoration(color: widget.backgroundColor,borderRadius: const BorderRadiusDirectional.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: DropdownButton<String>(
            underline: const DropdownButtonHideUnderline(child:Text("")),
            isExpanded: true, // Ensures dropdown opens downwards
            iconEnabledColor: widget.iconEnabledColor,
            iconSize: widget.iconSize,
            value: _selectedRole??widget.value,
            style: widget.style,
            dropdownColor: dark? widget.dropdowndarkbgColor:widget.dropdownlightbgColor,
            onChanged: (String? newValue) {
              setState(() {
                _selectedRole = newValue;
              });
            },
            items: widget.items
                ?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style: dark? widget.dropdownMenuDarkStyle:widget.dropdownMenuLightStyle),
              );
            }).toList(),
          ),
        ),
      );
  }
}
