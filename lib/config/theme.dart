import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:ui_kosmos_v4/checkbox/theme.dart';

import 'package:ui_kosmos_v4/settings_cellule/theme.dart';

abstract class AppColor {
  static Color linearFirst = const Color(0xffBBA485);
  static Color linearSecond = const Color(0xffE5D6B3);
  static Color linearThird = const Color(0xffBBA87C);
  static Color linearFour = const Color(0xffB29777);
  static Color glinearFirst = const Color(0xffaf783b);
  static Color glinearSecond = const Color(0xffeaddc9);
  static Color glinearThird = const Color(0xffd1a777);
  static Color glinearFour = const Color(0xff9f6d3b);
  static Color glinearFive = const Color(0xffead1cd);
  static Color glinearSix = const Color(0xff946334);
  static Color backGrey = const Color(0xffF7F7F8);
  static Color textButton = const Color(0xffB4A37F);
  static Color subtitle = const Color(0xff737D8A);
  static Color lightGrey = const Color(0xffF8F8F9);
  static Color cardSubtitle = const Color(0xff979EA8);
  static Color trackColor = const Color(0xffBFC3C9);
  static Color suffixIconColor = const Color(0xff9299A3);
}

abstract class AppThemeStyle {
  static TextStyle homeScreenTitle = TextStyle(
    color: Colors.black,
    fontSize: sp(34),
    fontWeight: FontWeight.bold,
    fontFamily: 'PlayfairDisplay',
  );
  static TextStyle homeScreenSubTitle = TextStyle(color: Colors.black, fontSize: sp(13), fontWeight: FontWeight.w400);
  static TextStyle errorText = TextStyle(color: Colors.red, fontSize: sp(11), fontWeight: FontWeight.w400);
  static TextStyle formProfilTitle =
      TextStyle(color: Colors.black, fontSize: sp(27), fontWeight: FontWeight.bold, fontFamily: "PlayfairDisplay");
  static TextStyle formProfilCategory = TextStyle(color: Colors.black, fontSize: sp(17), fontWeight: FontWeight.w500);
  static TextStyle formCategory = TextStyle(color: Colors.black, fontSize: sp(17), fontWeight: FontWeight.w500);

  static TextStyle homeTitle = TextStyle(
    color: Colors.white,
    fontSize: sp(34),
    fontWeight: FontWeight.bold,
    fontFamily: "PlayfairDisplay",
  );
  static TextStyle hintStyle = TextStyle(color: const Color(0xff9299A4), fontSize: sp(12), fontWeight: FontWeight.w500);
  static TextStyle textSearchStyle = TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500);

  static TextStyle homeSecondTitle = TextStyle(
    color: Colors.black,
    fontSize: sp(25),
    fontWeight: FontWeight.bold,
    fontFamily: "PlayfairDisplay",
  );
  static TextStyle homeSeeMore = TextStyle(color: AppColor.textButton, fontSize: sp(14), fontWeight: FontWeight.w500);
  static TextStyle littleCardTitle = TextStyle(color: Colors.white, fontSize: sp(12), fontWeight: FontWeight.w500);
  static TextStyle littleCardSubTitle = TextStyle(color: Colors.white, fontSize: sp(10), fontWeight: FontWeight.w400);
  static TextStyle titleCardTitle = TextStyle(color: Colors.white, fontSize: sp(14), fontWeight: FontWeight.w500);

  static TextStyle subtitle = TextStyle(color: AppColor.subtitle, fontSize: sp(11), fontWeight: FontWeight.w400);

  static TextStyle productPrice = TextStyle(color: Colors.white, fontSize: sp(11), fontWeight: FontWeight.w500);

  static TextStyle profilsubtitle = TextStyle(color: AppColor.subtitle, fontSize: sp(14), fontWeight: FontWeight.w400);
  static TextStyle profilDescription = TextStyle(color: Colors.black, fontSize: sp(11), fontWeight: FontWeight.w400);
  static TextStyle profilStats =
      TextStyle(color: Colors.white, fontSize: sp(20), fontWeight: FontWeight.w600, height: 1);
  static TextStyle profilTextStats =
      TextStyle(color: Colors.white.withOpacity(0.7), fontSize: sp(11), fontWeight: FontWeight.w500, height: 1);

  static TextStyle detailTitle = TextStyle(color: Colors.black, fontSize: sp(16), fontWeight: FontWeight.w600);
  static TextStyle detailSubtitle = TextStyle(color: AppColor.subtitle, fontSize: sp(13), fontWeight: FontWeight.w500);
  static TextStyle detailSubtitleUnderline = TextStyle(
      color: AppColor.subtitle, fontSize: sp(13), fontWeight: FontWeight.w600, decoration: TextDecoration.underline);

  static TextStyle descriptionSubtitle = TextStyle(
    color: Colors.black,
    fontSize: sp(16),
    fontWeight: FontWeight.w400,
  );
  static TextStyle notificationTitle = TextStyle(color: Colors.black, fontSize: sp(16), fontWeight: FontWeight.w600);

  static TextStyle dialogTitle = TextStyle(color: Colors.black, fontSize: sp(22), fontWeight: FontWeight.w600);
  static TextStyle dialogSubTitle =
      TextStyle(color: Colors.black.withOpacity(0.45), fontSize: sp(15), fontWeight: FontWeight.w500);
  static TextStyle dialogButtonNo = TextStyle(color: Colors.black, fontSize: sp(17), fontWeight: FontWeight.w600);
  static TextStyle dialogButtonYes = TextStyle(color: Colors.white, fontSize: sp(17), fontWeight: FontWeight.w600);

  //search
  static TextStyle resultTitle = TextStyle(color: Colors.black, fontSize: sp(23), fontWeight: FontWeight.w600);

  //product
  static TextStyle productCardTitle = TextStyle(color: Colors.black, fontSize: sp(14), fontWeight: FontWeight.w600);

  static TextStyle productCardSubtitle =
      TextStyle(color: AppColor.cardSubtitle, fontSize: sp(11), fontWeight: FontWeight.w600);
  static TextStyle productCardDescription =
      TextStyle(color: Colors.black, fontSize: sp(11.5), fontWeight: FontWeight.w400);
  static TextStyle productFooter =
      TextStyle(color: const Color(0XFF02132B), fontSize: sp(12), fontWeight: FontWeight.w600);

  static TextStyle cardSubtitle =
      TextStyle(color: Colors.white.withOpacity(0.5), fontSize: sp(11), fontWeight: FontWeight.w500);

  static TextStyle footerSignalenemnt =
      TextStyle(color: Colors.black.withOpacity(0.75), fontSize: sp(12), fontWeight: FontWeight.w500);

  static TextStyle priceProductCard = TextStyle(color: Colors.black, fontSize: sp(23), fontWeight: FontWeight.w600);

  //fitting
  static TextStyle fittingTitle = TextStyle(color: Colors.black, fontSize: sp(17), fontWeight: FontWeight.bold);
  static TextStyle fittingSubtitle = TextStyle(color: AppColor.subtitle, fontSize: sp(10), fontWeight: FontWeight.w400);
  static TextStyle fittingSecTitle = TextStyle(color: Colors.black, fontSize: sp(10), fontWeight: FontWeight.w500);
  static TextStyle fittingSecSubtitle =
      TextStyle(color: AppColor.subtitle, fontSize: sp(9), fontWeight: FontWeight.w500);
  static TextStyle fittingButton = TextStyle(color: Colors.white, fontSize: sp(10), fontWeight: FontWeight.w500);

  //notification
  static TextStyle acceptNotification = TextStyle(color: Colors.white, fontSize: sp(12), fontWeight: FontWeight.w600);
  static TextStyle declineNotification = TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500);
  static TextStyle textNotification =
      TextStyle(color: AppColor.subtitle, fontSize: sp(12), fontWeight: FontWeight.w500);
}

AppTheme initTheme(BuildContext context) {
  final appTheme = AppTheme(
    themeData: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Poppins",
      iconTheme: const IconThemeData(color: Color(0xFFA4AAB2)),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
    ),
  );

  appTheme.addTheme("skeleton_page_padding", EdgeInsets.symmetric(horizontal: formatWidth(30)));
  appTheme.addTheme("skeleton_page_padding_phone", EdgeInsets.symmetric(horizontal: formatWidth(30)));
  appTheme.addTheme("skeleton_page_padding_tablet", EdgeInsets.symmetric(horizontal: formatWidth(30)));
  appTheme.addTheme("back_button",
      const CtaThemeData(height: 50, widthInMobile: 50, backgroundColor: Colors.transparent, iconColor: Colors.black));

  appTheme.addTheme(
    "primary_button",
    CtaThemeData(
      height: formatHeight(54),
      textButtonStyle: TextStyle(color: Colors.white, fontSize: sp(15), fontWeight: FontWeight.w600),
      gradient: LinearGradient(
          begin: const Alignment(-2.0, -2.0),
          end: const Alignment(.0, .0),
          colors: [AppColor.linearFirst, AppColor.linearSecond, AppColor.linearThird, AppColor.linearFour]),
      borderRadius: 2.0,
    ),
  );
  // LinearGradient(begin: const Alignment(-1.0, -1.0), end: const Alignment(1.0, 1.0), colors: [
  //       AppColor.glinearFirst,
  //       AppColor.glinearSecond,
  //       AppColor.glinearThird,
  //       AppColor.glinearFour,
  //       AppColor.glinearFive,
  //       AppColor.glinearSix,
  //     ], stops: const [
  //       0.0,
  //       0.202,
  //       0.444,
  //       0.691,
  //       0.854,
  //       1.0,
  //     ]),

  appTheme.addTheme(
    "secondary_button",
    CtaThemeData(
      height: formatHeight(54),
      backgroundColor: Colors.white,
      textButtonStyle: TextStyle(color: Colors.black, fontSize: sp(15), fontWeight: FontWeight.w600),
      border: Border.all(
        color: Colors.black,
        width: formatWidth(0.5),
      ),
      borderRadius: 2.0,
    ),
  );

  appTheme.addTheme(
    "tiers_button",
    CtaThemeData(
      height: formatHeight(54),
      width: formatWidth(139),
      backgroundColor: Colors.red,
      textButtonStyle: AppThemeStyle.dialogButtonYes,
      border: Border.all(
        color: Colors.red,
        width: formatWidth(0.5),
      ),
      borderRadius: 7.0,
    ),
  );
  appTheme.addTheme(
    "settings_cellule",
    SettingsCelluleThemeData(
      iconBackgroundGradient: LinearGradient(
          begin: const Alignment(-2.0, -2.0),
          end: const Alignment(0.0, 0.0),
          colors: [AppColor.linearFirst, AppColor.linearSecond, AppColor.linearThird, AppColor.linearFour]),
      titleStyle: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
      subtitleStyle: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500),
    ),
  );

  appTheme.addTheme(
    "checkbox_square",
    CustomCheckBoxThemeData(
      selectedColor: const Color(0xffBBA485),
      // defaultColor: const Color(0xFF222222),
      border: Border.all(width: .5, color: Colors.white.withOpacity(.25)),
    ),
  );

  // appTheme.addTheme("tiers_button", CtaThemeData(textButtonStyle: AppStyle.white(14)));
  //
  // appTheme.addTheme(
  //   "settings",
  //   SettingsThemeData(
  //     iconColor: Colors.white,
  //     actionIconColor: Colors.white,
  //     nameStyle: AppStyle.white(20, FontWeight.bold),
  //     sectionStyle: AppStyle.white(16, FontWeight.w600),
  //     subTitleStyle: AppStyle.white(11, FontWeight.w400).copyWith(color: Colors.white.withOpacity(.65)),
  //     titleStyle: AppStyle.white(13, FontWeight.w500),
  //   ),
  // );

  appTheme.addTheme(
    "responsive_settings",
    ResponsiveSettingsThemeData(
      settingsLeftSpacing: formatWidth(0),
      setingsDefaultPageTopSpacing: formatHeight(0),
      settingsVeriticalSpacing: formatHeight(11),
    ),
  );

  // appTheme.addTheme(
  //   "settings_cellule",
  //   SettingsCelluleThemeData(
  //     backgroundColor: Colors.white.withOpacity(.04),
  //     iconBackgroundColor: AppColor.primary,
  //   ),
  // );

  appTheme.addTheme(
    "authentication_page",
    AuthenticationPageThemeData(
        titleOtpStyle: TextStyle(
          fontSize: sp(25),
          fontFamily: 'PlayfairDisplay',
          color: const Color(0xFF021C36),
          fontWeight: FontWeight.w700,
        ),
        checkCodeOtpTitleWidthConstraint: 250.w,
        modalBottomRadius: 55.r,
        titleStyle: TextStyle(
          fontSize: sp(30),
          fontFamily: 'PlayfairDisplay',
          color: const Color(0xFF021C36),
          fontWeight: FontWeight.w700,
        ),
        // cguCtaWidth: 172.w,

        popupRadius: 28.r,
        codeTitleStyle: TextStyle(
          fontSize: sp(12),
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        topTitleSpacing: 20,
        titleSpacing: 44,
        // checkCodeOtpTitleWidthConstraint: 244.w,
        // codeOtpTopSpacing: 70,
        // appBarPhonePadding: const EdgeInsets.only(left: 6),
        cliquableTextStyle: TextStyle(
          fontSize: sp(13),
          color: const Color(0xFF02132B),
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
        richTextStyle: TextStyle(
          fontSize: sp(13),
          color: const Color(0XFFA7ADB5),
          fontWeight: FontWeight.w500,
        ),
        // richTextNotHaveAccountStyle: TextStyle(
        //   fontSize: sp(14),
        //   color: const Color(0XFFA7ADB5),
        //   fontWeight: FontWeight.w500,
        // ),
        // cliquableNotHaveAccountTextStyle: TextStyle(
        //   fontSize: sp(14),
        //   color: const Color(0xFF02132B),
        //   fontWeight: FontWeight.w600,
        //   decoration: TextDecoration.underline,
        // ),
        subTitleStyle: TextStyle(
          fontSize: sp(13),
          color: const Color(0xFF02132B).withOpacity(.35),
          fontWeight: FontWeight.w500,
        )),
  );

  appTheme.addTheme(
    "input_field",
    CustomFormFieldThemeData(
      // backgroundColor: AppColor.lowPurple,
      fieldNameStyle: TextStyle(
        color: const Color(0xFF02132B),
        fontSize: sp(12),
        fontWeight: FontWeight.w500,
      ),
      fieldPostRedirectionStyle: TextStyle(
        color: const Color(0xFF02132B),
        fontSize: sp(12),
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      ),
      // fieldStyle: AppStyle.white(14, FontWeight.w500),
      // hintStyle: AppStyle.darkPurple(13, FontWeight.w500),
      // pickerIconColor: const Color(0xFF7B7483),
      suffixIconColor: AppColor.suffixIconColor,
      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(22)),
    ),
  );

  // appTheme.addTheme(
  //   "event_button",
  //   CtaThemeData(
  //     backgroundColor: const Color(0xFF422652),
  //     textButtonStyle: AppStyle.white(14),
  //     borderRadius: 18,
  //   ),
  // );

  // appTheme.addTheme(
  //   "event_button_amazon",
  //   CtaThemeData(
  //     backgroundColor: const Color(0xFF422652),
  //     textButtonStyle: AppStyle.white(14),
  //     shadows: [
  //       BoxShadow(
  //         color: const Color(0xFFF2FF52).withOpacity(.18),
  //         blurRadius: 30,
  //         offset: const Offset(0, 10),
  //       ),
  //     ],
  //     borderRadius: 18,
  //   ),
  // );

  // appTheme.addTheme("back_button", const CtaThemeData(iconColor: Colors.white));

  // appTheme.addTheme(
  //   "multi_image_picker",
  //   MultiImagePickerThemeData(
  //     imageBoxColor: AppColor.lowPurple,
  //   ),
  // );

  // appTheme.addTheme(
  //   "onboarding",
  //   OnboardingThemeData(
  //     logo: Center(child: Image.asset("assets/images/app_onboarding_logo.png", height: formatHeight(30))),
  //     subtitleTextStyle: AppStyle.white(13, FontWeight.w400),
  //     skipButtonStyle: AppStyle.white(13, FontWeight.w500),
  //   ),
  // );

  // appTheme.addTheme(
  //   "permission",
  //   PermissionThemeData(
  //     titleStyle: AppStyle.white(24),
  //     subTitleStyle: AppStyle.white(14, FontWeight.w400),
  //   ),
  // );

  return appTheme;
}
