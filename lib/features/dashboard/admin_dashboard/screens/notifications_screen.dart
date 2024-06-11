import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/app_bar.dart';

class AdmNotifications extends StatelessWidget {
  const AdmNotifications({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CSAppBar(title: Text(title)));
  }
}
