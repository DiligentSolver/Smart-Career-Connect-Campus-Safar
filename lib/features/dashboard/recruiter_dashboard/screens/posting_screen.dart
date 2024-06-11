import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/add_document.dart';
import 'package:campus_safar/features/dashboard/recruiter_dashboard/screens/add_job_details.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.initialIndex,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Companies",
              style: dark
                  ? CSTextTheme.darkTextTheme.headlineLarge
                  : CSTextTheme.lightTextTheme.headlineLarge,
            ),
            bottom: TabBar(
                isScrollable: true,
                indicatorColor: dark ? CSColors.white : CSColors.firstColor,
                tabs: [
                  Tab(
                    child: Text(
                      "Job Details",
                      style: dark
                          ? CSTextTheme.darkTextTheme.bodyLarge
                          : CSTextTheme.lightTextTheme.bodyLarge,
                    ),
                  ),
                  Tab(
                      child: Text(
                    "Document",
                    style: dark
                        ? CSTextTheme.darkTextTheme.bodyLarge
                        : CSTextTheme.lightTextTheme.bodyLarge,
                  )),
                ]),
          ),
          body: const TabBarView(
              children: [AddJobDetails(), AddDocumentScreen()]),
        ),
      ),
    );
  }
}
