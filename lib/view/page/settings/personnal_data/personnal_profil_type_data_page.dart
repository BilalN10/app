import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/profil_type.dart';
import 'package:findyourdresse_app/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:ui_kosmos_v4/cta/theme.dart';

import '../../../../config/theme.dart';
import '../../../../model/location_model_new/location_model_new.dart';

class PersonnalProfilTypeDataPage extends ConsumerStatefulWidget {
  const PersonnalProfilTypeDataPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonnalProfilTypeDataPageState();
}

class _PersonnalProfilTypeDataPageState extends ConsumerState<PersonnalProfilTypeDataPage> {
  final TextEditingController _controllerLocationMe = TextEditingController();
  final TextEditingController _controllerLocationShop = TextEditingController();
  final _profilKey = GlobalKey<FormState>();

  final FocusNode _focusNodeSearch = FocusNode();

  String? nickname;
  String? firstname;
  String? lastname;
  String? shopNickname;
  LocationModelNew? location;
  @override
  void initState() {
    super.initState();
    _controllerLocationMe.text =
        (ref.read(userChangeNotifierProvider).userData as UserModelFyd).location?.formattedText ?? '';
    _controllerLocationShop.text =
        (ref.read(userChangeNotifierProvider).userData as UserModelFyd).location?.formattedText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    UserModelFyd userData = ref.watch(userChangeNotifierProvider).userData! as UserModelFyd;
    //  TODO
    if (userData.location != null) {
      location = LocationModelNew(
        region: userData.location!.region,
        address: userData.location!.address,
        city: userData.location!.city,
        postalCode: userData.location!.postalCode,
        countryISOCode: userData.location!.countryISOCode,
        mainText: userData.location!.mainText,
        secondaryText: userData.location!.secondaryText,
        formattedText: userData.location!.formattedText,
      );
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: formatHeight(51)),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        // shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: formatWidth(12)),
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Text(
                    'title.personnal-data-change'.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sp(17),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                CTA.back(
                  height: 50,
                  width: 50,
                  onTap: () {
                    // Navigator.pop(context);
                    AutoRouter.of(context).navigateBack();
                  },
                ),
              ],
            ),
          ),
          sh(33),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: formatWidth(27)),
            child: Form(
              key: _profilKey,
              child: Column(
                children: [
                  if (ref.watch(profilTypeProvider).type == ProfilType.creator) ...[
                    TextFormUpdated.classic(
                      fieldName: "field.creator-name".tr(),
                      defaultValue: userData.nickname,
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      hintText: "field.hint-creator-name".tr(),
                      onChanged: (val) {
                        nickname = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field.error-creator-name".tr();
                        }
                        return null;
                      },
                    ),
                    sh(14),
                    TextFormUpdated.classic(
                      fieldName: "field.manager-name".tr(),
                      hintText: "field.hint-manager-name".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      defaultValue: userData.lastname,
                      onChanged: (val) {
                        lastname = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field.error-manager-name".tr();
                        }
                        return null;
                      },
                    ),
                    sh(14),
                    TextFormUpdated.classic(
                      fieldName: "field.manager-firstname".tr(),
                      hintText: "field.hint-manager-firstname".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      defaultValue: userData.firstname,
                      onChanged: (val) {
                        firstname = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field.error-manager-firstname".tr();
                        }
                        return null;
                      },
                    ),
                    sh(14),
                    TextFormUpdated.classic(
                      fieldName: "field.nickname-shop".tr(),
                      hintText: "field.hint-nickname-shop".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      defaultValue: userData.shopNickname,
                      onChanged: (val) {
                        shopNickname = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field.error-nickname-shop".tr();
                        }
                        return null;
                      },
                    ),
                    sh(14),
                    Row(
                      children: [
                        Text(
                          "field.address-shop".tr(),
                          style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    sh(4),
                    TypeAheadField<LocationModel>(
                      suggestionsBoxVerticalOffset: 15.h,
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          color: Colors.white,
                          elevation: 0.5,
                          constraints: BoxConstraints(maxHeight: 300, minWidth: 317.w),
                          borderRadius: BorderRadius.all(Radius.circular(7.r))),
                      debounceDuration: const Duration(seconds: 0),
                      animationDuration: const Duration(seconds: 0),
                      animationStart: 0.9,
                      textFieldConfiguration: TextFieldConfiguration(
                          focusNode: _focusNodeSearch,
                          controller: _controllerLocationShop,
                          decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                            filled: true,
                            fillColor: const Color(0XFF02132B).withOpacity(0.03),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd)
                                    .location
                                    ?.formattedText ??
                                "Ex. 11 rue des fleurs 06000 Nice",
                            hintStyle:
                                const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          style: const TextStyle()),
                      hideOnEmpty: true,
                      noItemsFoundBuilder: (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                        child: Text(
                          'aucun résultat',
                          style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      suggestionsCallback: (value) async {
                        if (value.length < 3) {
                          return [];
                        }
                        final query = value.replaceAllMapped(' ', (m) => '+');
                        return (await placeAutocomplete(query, 'fr', country: null));
                      },
                      itemBuilder: (context, location) {
                        return ListTile(
                          title: Text(
                            location.mainText ?? "",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          subtitle: Text(
                            location.secondaryText ?? "",
                            style: TextStyle(fontSize: 9.sp),
                          ),
                        );
                      },
                      onSuggestionSelected: (val) {
                        location = LocationModelNew(
                          address: val.address,
                          city: val.city,
                          region: val.region,
                          formattedText: val.formattedText,
                          mainText: val.mainText,
                          secondaryText: val.secondaryText,
                          countryISOCode: val.countryISOCode,
                          postalCode: val.postalCode,
                        );
                        setState(() {
                          _controllerLocationShop.text = val.formattedText;
                        });
                      },
                    ),
                    sh(33),
                  ],
                  if (ref.watch(profilTypeProvider).type == ProfilType.model ||
                      ref.watch(profilTypeProvider).type == ProfilType.particular) ...[
                    TextFormUpdated.classic(
                      fieldName: "field.user-firstname".tr(),
                      hintText: "field.hint-user-firstname".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      defaultValue: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).firstname,
                      onChanged: (val) {
                        firstname = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field.error-user-firstname".tr();
                        }
                        return null;
                      },
                    ),
                    sh(14),
                    TextFormUpdated.classic(
                      fieldName: "field.user-lastname".tr(),
                      hintText: "field.hint-user-lastname".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      defaultValue: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).lastname,
                      onChanged: (val) {
                        lastname = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field.error-user-lastname".tr();
                        }
                        return null;
                      },
                    ),
                    sh(14),
                  ],
                  if (ref.watch(profilTypeProvider).type == ProfilType.model) ...[
                    TextFormUpdated.classic(
                      fieldName: "field.user-nickname".tr(),
                      hintText: "field.hint-user-nickname".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      onChanged: (val) {
                        nickname = val;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field.error-user-nickname".tr();
                        }
                        return null;
                      },
                      defaultValue: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).nickname,
                    ),
                    sh(14),
                    Row(
                      children: [
                        Text(
                          "field.user-city".tr(),
                          style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    sh(4),
                    TypeAheadField<LocationModel>(
                      suggestionsBoxVerticalOffset: 15.h,
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          color: Colors.white,
                          elevation: 0.5,
                          constraints: BoxConstraints(maxHeight: 300, minWidth: 317.w),
                          borderRadius: BorderRadius.all(Radius.circular(7.r))),
                      debounceDuration: const Duration(seconds: 0),
                      animationDuration: const Duration(seconds: 0),
                      animationStart: 0.9,
                      textFieldConfiguration: TextFieldConfiguration(
                          focusNode: _focusNodeSearch,
                          controller: _controllerLocationMe,
                          decoration: InputDecoration(
                            prefixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                            filled: true,
                            fillColor: const Color(0XFF02132B).withOpacity(0.03),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd)
                                    .location
                                    ?.formattedText ??
                                "Ex. 11 rue des fleurs 06000 Nice",
                            hintStyle:
                                const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          style: const TextStyle()),
                      hideOnEmpty: true,
                      noItemsFoundBuilder: (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                        child: Text(
                          'aucun résultat',
                          style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      suggestionsCallback: (value) async {
                        if (value.length < 3) {
                          return [];
                        }
                        final query = value.replaceAllMapped(' ', (m) => '+');
                        return (await placeAutocomplete(query, 'fr', country: null));
                      },
                      itemBuilder: (context, location) {
                        return ListTile(
                          title: Text(
                            location.mainText ?? "",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          subtitle: Text(
                            location.secondaryText ?? "",
                            style: TextStyle(fontSize: 9.sp),
                          ),
                        );
                      },
                      onSuggestionSelected: (val) {
                        location = LocationModelNew(
                          address: val.address,
                          city: val.city,
                          region: val.region,
                          formattedText: val.formattedText,
                          mainText: val.mainText,
                          secondaryText: val.secondaryText,
                          countryISOCode: val.countryISOCode,
                          postalCode: val.postalCode,
                        );
                        setState(() {
                          _controllerLocationMe.text = val.formattedText;
                        });
                      },
                    ),
                    sh(33),
                  ],
                  CTA.primary(
                    textButton: 'utils.save'.tr(),
                    onTap: () async {
                      if (_profilKey.currentState!.validate()) {
                        if (ref.watch(profilTypeProvider).type != ProfilType.particular &&
                            location!.formattedText == null) {
                          Utils.notifRed(context, 'Attention', 'Veuillez renseigner une adresse valide');
                        } else {
                          dialogModifyProfil(context, userData);
                        }
                      } else {
                        Utils.notifRed(context, "title.profil-update-title".tr(), 'title.profil-update-subtitle'.tr());
                      }
                      // print('-----');
                    },
                  ),
                  sh(14),
                  Text('signalement.footer'.tr(), style: AppThemeStyle.footerSignalenemnt)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  dialogModifyProfil(BuildContext context, UserModelFyd userData) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "",
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxHeight: formatHeight(MediaQuery.of(context).size.height * .6)),
              width: formatWidth(282),
              padding: EdgeInsets.symmetric(horizontal: formatWidth(20), vertical: formatHeight(18)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.of(_).pop(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(14)),
                        child: SvgPicture.asset("assets/svg/close_inc.svg", width: formatWidth(15)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: formatWidth(20)),
                    child: Column(
                      children: [
                        Text(
                          'title.careful'.tr(),
                          style: AppThemeStyle.dialogTitle,
                        ),
                        sh(11),
                        Text(
                          "title.careful-text-profil".tr(),
                          style: AppThemeStyle.dialogSubTitle,
                          textAlign: TextAlign.center,
                        ),
                        sh(32),
                        InkWell(
                          onTap: () async {
                            await FirestoreUtils.updateUserDoc({
                              "lastname": lastname ?? userData.lastname,
                              "firstname": firstname ?? userData.firstname,
                              "nickname": nickname ?? userData.nickname,
                              "shopNickname": shopNickname ?? userData.shopNickname,
                              "location":
                                  location!.formattedText == null ? userData.location!.toJson() : location!.toJson(),
                              "profilCompleted": userData.profilCompleted,
                              "profilImage": userData.profilImage,
                              "type": ref.watch(profilTypeProvider).type.toString(),
                              "createdAt": userData.createdAt,
                            });

                            Navigator.of(_).pop();
                            Utils.notifGreen(
                                context, "title.profil-update".tr(), 'title.profil-update-description'.tr());

                            AutoRouter.of(context).navigateNamed("/dashboard/index/home");
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(7)),
                            height: formatHeight(54),
                            width: formatWidth(139),
                            child: Center(
                              child: Text(
                                "utils.yes".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: sp(17), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        sh(13),
                        InkWell(
                          onTap: () => Navigator.of(_).pop(),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(14)),
                            child: Text(
                              "utils.no".tr(),
                              style: AppThemeStyle.dialogButtonNo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
