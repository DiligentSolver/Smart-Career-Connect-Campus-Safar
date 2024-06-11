import 'package:campus_safar/common/widgets/list_tiles/account_menu_tile.dart';
import 'package:campus_safar/common/widgets/search_bar/search_bar.dart';
import 'package:campus_safar/features/dashboard/student_dashboard/screen/widget/two_cards_row.dart';
import 'package:campus_safar/utils/constants/colors.dart';
import 'package:campus_safar/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../common/widgets/Divider/divider.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/theme/custom_themes/text_theme.dart';

class StudLearning extends StatelessWidget {
  const StudLearning({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: CSAppBar(
          title: Text(
            title,
            style: dark
                ? CSTextTheme.darkTextTheme.headlineLarge
                : CSTextTheme.lightTextTheme.headlineLarge,
          ),
        ),
        body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 310,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: CSSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const CSSearchBar(
                        text: "Search here",
                        showBackground: false,
                        padding: EdgeInsets.only(
                            right: CSSizes.sm, left: CSSizes.sm),
                      ),
                      const CSDividerBold(
                        height: CSSizes.md,
                      ),
                      CustomCardsRow(
                        boxShadow: false,
                        subText: false,
                        text1Style: dark
                            ? CSTextTheme.darkTextTheme.titleLarge
                            : CSTextTheme.lightTextTheme.titleLarge,
                        cardColor1: dark
                            ? CSColors.white.withOpacity(0.1)
                            : CSColors.white.withOpacity(0.9),
                        onTap1: () => Get.to(() => const AptitudeScreen()),
                        cardColor2: dark
                            ? CSColors.white.withOpacity(0.1)
                            : CSColors.white.withOpacity(0.9),
                        onTap2: () => Get.to(() => const ReasoningScreen()),
                        card1text1: "Aptitude",
                        card2text1: "Logical Resoning",
                        height: 80,
                      ),
                      const CSDividerBold(),
                      CustomCardsRow(
                        boxShadow: false,
                        subText: false,
                        text1Style: dark
                            ? CSTextTheme.darkTextTheme.titleLarge
                            : CSTextTheme.lightTextTheme.titleLarge,
                        cardColor1: dark
                            ? CSColors.white.withOpacity(0.1)
                            : CSColors.white.withOpacity(0.9),
                        onTap1: () => Get.to(() => const InterviewScreen()),
                        cardColor2: dark
                            ? CSColors.white.withOpacity(0.1)
                            : CSColors.white.withOpacity(0.9),
                        onTap2: () => Get.to(() => const ProgrammingScreen()),
                        card1text1: "Interview",
                        card2text1: "Programming",
                        height: 80,
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: dark ? CSColors.white : CSColors.firstColor,
                    tabs: [
                      Tab(
                        child: Text(
                          "Online Tests",
                          style: dark
                              ? CSTextTheme.darkTextTheme.bodyLarge
                              : CSTextTheme.lightTextTheme.bodyLarge,
                        ),
                      ),
                      Tab(
                          child: Text(
                        "Last Year Papers",
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      )),
                      Tab(
                        child: Text(
                          "Quizzes",
                          style: dark
                              ? CSTextTheme.darkTextTheme.bodyLarge
                              : CSTextTheme.lightTextTheme.bodyLarge,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Current Affairs",
                          style: dark
                              ? CSTextTheme.darkTextTheme.bodyLarge
                              : CSTextTheme.lightTextTheme.bodyLarge,
                        ),
                      ),
                      Tab(
                          child: Text(
                        "Mock Interviews",
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      )),
                      Tab(
                          child: Text(
                        "Engineering",
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      )),
                      Tab(
                          child: Text(
                        "Courses",
                        style: dark
                            ? CSTextTheme.darkTextTheme.bodyLarge
                            : CSTextTheme.lightTextTheme.bodyLarge,
                      )),
                    ]),
              ),
            ];
          },
          body: TabBarView(children: [
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const CSSettingsMenuTile(
                    title: "Aptitude Test",
                    icon: FontAwesomeIcons.penToSquare,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Questions: 20"), Text("30 Minutes")],
                    ),
                  );
                }),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const CSSettingsMenuTile(
                    title: "TCS Last Year Paper",
                    icon: Iconsax.note,
                  );
                }),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const CSSettingsMenuTile(
                    title: "Quiz on Java",
                    icon: FontAwesomeIcons.brain,
                  );
                }),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const CSSettingsMenuTile(
                    title: "Technical",
                    icon: CupertinoIcons.lightbulb,
                  );
                }),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const CSSettingsMenuTile(
                      icon: Icons.laptop_mac, title: "Mock Interview 1");
                }),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const CSSettingsMenuTile(
                      title: "Mechanical Engineering",
                      icon: CupertinoIcons.gear);
                }),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const CSSettingsMenuTile(
                      icon: Icons.book, title: "CS/IT Courses");
                }),
          ]),
        ),
      ),
    );
  }
}

class AptitudeScreen extends StatelessWidget {
  const AptitudeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Aptitude",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineLarge
              : CSTextTheme.lightTextTheme.headlineLarge,
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: companyNames.length,
          itemBuilder: (context, index) {
            return CSSettingsMenuTile(
                title: companyNames[index],
                icon: CupertinoIcons.link,
                trailing: IconButton(
                  onPressed: () => Get.to(
                    () => const WebView(
                      gestureNavigationEnabled: true,
                      initialUrl:
                          'https://www.indiabix.com/aptitude/questions-and-answers/',
                      javascriptMode: JavascriptMode.unrestricted,
                      allowsInlineMediaPlayback: true,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: CSSizes.iconMd,
                  ),
                ));
          }),
    ));
  }
}

class ReasoningScreen extends StatelessWidget {
  const ReasoningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Reasoning",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineLarge
              : CSTextTheme.lightTextTheme.headlineLarge,
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: companyNames.length,
          itemBuilder: (context, index) {
            return CSSettingsMenuTile(
                title: companyNames[index],
                icon: CupertinoIcons.link,
                trailing: IconButton(
                  onPressed: () => Get.to(
                    () => const WebView(
                      gestureNavigationEnabled: true,
                      initialUrl:
                          'https://www.indiabix.com/logical-reasoning/questions-and-answers/',
                      javascriptMode: JavascriptMode.unrestricted,
                      allowsInlineMediaPlayback: true,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: CSSizes.iconMd,
                  ),
                ));
          }),
    ));
  }
}

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Interview",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineLarge
              : CSTextTheme.lightTextTheme.headlineLarge,
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: companyNames.length,
          itemBuilder: (context, index) {
            return CSSettingsMenuTile(
                title: companyNames[index],
                icon: CupertinoIcons.link,
                trailing: IconButton(
                  onPressed: () => Get.to(
                    () => const WebView(
                      gestureNavigationEnabled: true,
                      initialUrl:
                          'https://www.indiabix.com/hr-interview/questions-and-answers/',
                      javascriptMode: JavascriptMode.unrestricted,
                      allowsInlineMediaPlayback: true,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: CSSizes.iconMd,
                  ),
                ));
          }),
    ));
  }
}

class ProgrammingScreen extends StatelessWidget {
  const ProgrammingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = CSHelperFunctions.isDarkMode(context);
    return SafeArea(
        child: Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Programming",
          style: dark
              ? CSTextTheme.darkTextTheme.headlineLarge
              : CSTextTheme.lightTextTheme.headlineLarge,
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: companyNames.length,
          itemBuilder: (context, index) {
            return CSSettingsMenuTile(
                title: companyNames[index],
                icon: CupertinoIcons.link,
                trailing: IconButton(
                  onPressed: () => Get.to(
                    () => const WebView(
                      gestureNavigationEnabled: true,
                      initialUrl:
                          'https://www.indiabix.com/c-programming/questions-and-answers/',
                      javascriptMode: JavascriptMode.unrestricted,
                      allowsInlineMediaPlayback: true,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: CSSizes.iconMd,
                  ),
                ));
          }),
    ));
  }
}
