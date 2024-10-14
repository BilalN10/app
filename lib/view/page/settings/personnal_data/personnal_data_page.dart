import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/model/_list/dress_type.dart';
import 'package:findyourdresse_app/model/mesurements_model/mesurements_model.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/profil_type.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:multiselect/multiselect.dart';
import '../../../../config/theme.dart';
import '../../../../model/location_model_new/location_model_new.dart';
import '../../../../utils/phone_number_utils.dart';

class PersonnalDataPage extends ConsumerStatefulWidget {
  const PersonnalDataPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonnalDataPageState();
}

final profilControllerProvider = Provider<PageController>((ref) {
  return PageController(initialPage: 0);
});

class _PersonnalDataPageState extends ConsumerState<PersonnalDataPage> {
  int index = 0;
  final TextEditingController _controllerLocationMe = TextEditingController();
  final TextEditingController _controllerLocationShop = TextEditingController();

  final FocusNode _focusNodeSearch = FocusNode();

  String? nickname;
  String? firstname;
  String? lastname;
  String? shopNickname;
  String? description;
  PhoneNumber? number;
  PhoneNumber? initialNumber;
  String? email;
  List<String> robeType = [];

  LocationModel? location;

  String? expPro;

  String? gender;

  String? instagram;

  String? height;

  String? size;

  String? hips;

  String? eyeColor;

  String? hairColor;

  String? clothingSize;

  String? footSize;

  String? bust;
  late TextEditingController phoneController;

  void initPhoneNumber() {
    UserModelFyd userData = ref.read(userChangeNotifierProvider).userData! as UserModelFyd;
    robeType = (userData.robeType ?? []).cast<String>();
    PhoneNumber? _ = seperatePhoneAndDialCode(userData.number!);
    initialNumber = PhoneNumber(isoCode: _?.isoCode ?? "FR");
    number = _;
    phoneController = TextEditingController(text: (_?.phoneNumber ?? "").replaceFirst(_?.dialCode ?? "_", "0"));
  }

  @override
  void initState() {
    super.initState();
    initPhoneNumber();
    _controllerLocationMe.text =
        (ref.read(userChangeNotifierProvider).userData as UserModelFyd).location?.formattedText ?? '';
    _controllerLocationShop.text =
        (ref.read(userChangeNotifierProvider).userData as UserModelFyd).location?.formattedText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    UserModelFyd userData = ref.watch(userChangeNotifierProvider).userData! as UserModelFyd;
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Text(
                    'title.personnal-data'.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sp(17),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Transform.translate(
                  offset: Offset(-formatWidth(15.w), 0),
                  child: CTA.back(
                    height: 50,
                    width: 50,
                    onTap: () {
                      AutoRouter.of(context).navigateBack();
                    },
                  ),
                ),
              ],
            ),
          ),
          sh(33),
          Column(
            children: [
              if ((ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type == "ProfilType.creator") ...[
                TextFormUpdated.classic(
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(22)),
                  fieldName: "field.creator-name".tr(),
                  defaultValue: userData.nickname,
                  hintText: "field.hint-creator-name".tr(),
                  onChanged: (val) {
                    nickname = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(22)),
                  fieldName: "field.manager-name".tr(),
                  hintText: "field.hint-manager-name".tr(),
                  defaultValue: userData.lastname,
                  onChanged: (val) {
                    lastname = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(22)),
                  fieldName: "field.manager-firstname".tr(),
                  hintText: "field.hint-manager-firstname".tr(),
                  defaultValue: userData.firstname,
                  onChanged: (val) {
                    firstname = val;
                  },
                ),
                sh(14),
                //todo : add phone number

                TextFormUpdated.phoneNumber(
                  fieldName: 'content.phone-field'.tr(),
                  controller: phoneController,
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  initialPhoneValue: initialNumber,
                  onInputChanged: (p0) {
                    setState(() {
                      number = p0;
                    });
                  },
                ),

                sh(14),
                TextFormUpdated.classic(
                  fieldName: "content.email-field".tr(),
                  defaultValue: userData.emailAddress,
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  hintText: "content.email-field-hint".tr(),
                  onChanged: (val) {
                    email = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(22)),
                  fieldName: "field.nickname-shop".tr(),
                  hintText: "field.hint-nickname-shop".tr(),
                  defaultValue: userData.shopNickname,
                  onChanged: (val) {
                    shopNickname = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  defaultValue: userData.instagram,
                  fieldName: "content.instagram".tr(),
                  hintText: '',
                  prefixChild: Padding(
                    padding: EdgeInsets.symmetric(vertical: formatHeight(11), horizontal: formatWidth(10)),
                    child: const Text(
                      '@',
                      style: TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    instagram = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(22)),
                  fieldName: "field.short-description".tr(),
                  hintText: "field.hint-short-description".tr(),
                  defaultValue: userData.description,
                  onChanged: (val) {
                    description = val;
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
                        contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintText:
                            (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).location!.formattedText,
                        hintStyle: const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      style: const TextStyle(
                          color: Color(0xFF02132B), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
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
                    location = val;
                    print(val);
                    setState(() {
                      _controllerLocationShop.text = val.formattedText;
                    });
                  },
                ),
                sh(14),
                Row(
                  children: [
                    Text(
                      'content.robe-type'.tr(),
                      style: TextStyle(color: const Color(0xFF02132B), fontSize: sp(12), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                sh(6),
                FormField(validator: (value) {
                  if (value == null) {
                    return 'content.error-robe-type'.tr();
                  }
                  return null;
                }, builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: ThemeData(
                          radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all(Colors.transparent)),
                          checkboxTheme: CheckboxThemeData(
                            fillColor: MaterialStateProperty.all(AppColor.linearFirst),
                            checkColor: MaterialStateProperty.all(Colors.white),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                        child: DropDownMultiSelect(
                          hint: Text("content.robe-type-hint".tr()),
                          hintStyle: TextStyle(
                              color: const Color(0xff868E99),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          selected_values_style: TextStyle(
                              color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          onChanged: (List<String> x) {
                            setState(() {
                              robeType = x;
                              state.didChange(x);
                            });
                          },
                          icon: const Icon(Iconsax.arrow_down_14),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0XFF02132B).withOpacity(0.03),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: formatHeight((17 + max(0, (robeType.length) * 3)) * 1),
                                horizontal: formatWidth(22)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: state.hasError ? Colors.red.withOpacity(0.8) : Colors.transparent,
                              width: formatHeight(0.5),
                            )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: formatHeight(0.5),
                              ),
                            ),
                          ),
                          options: Dress.type,
                          selectedValues: robeType,
                        ),
                      ),
                      if (state.hasError) ...[
                        Padding(
                          padding: EdgeInsets.only(top: formatHeight(5), left: formatWidth(22)),
                          child: Text(state.errorText!, style: AppThemeStyle.errorText),
                        )
                      ],
                    ],
                  );
                }),
                sh(14),
              ],
              if ((ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type == "ProfilType.model" ||
                  (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type ==
                      "ProfilType.particular") ...[
                TextFormUpdated.classic(
                  fieldName: "field.user-firstname".tr(),
                  hintText: "field.hint-user-firstname".tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  defaultValue: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).firstname,
                  onChanged: (val) {
                    firstname = val;
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
                ),
                sh(14),
              ],
              if ((ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type == "ProfilType.model") ...[
                TextFormUpdated.classic(
                  fieldName: "field.user-nickname".tr(),
                  hintText: "field.hint-user-nickname".tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    nickname = val;
                  },
                  defaultValue: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).nickname,
                ),
                sh(14),
                TextFormUpdated.classic(
                  fieldName: "field.short-description".tr(),
                  hintText: "field.hint-short-description".tr(),
                  defaultValue: userData.description,
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    description = val;
                  },
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
                        contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      style: const TextStyle(
                          color: Color(0xFF02132B), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
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
                    location = val;
                    setState(() {
                      _controllerLocationMe.text = val.formattedText;
                    });
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  defaultValue: userData.instagram,
                  fieldName: "content.instagram".tr(),
                  hintText: '',
                  prefixChild: Padding(
                    padding: EdgeInsets.symmetric(vertical: formatHeight(11), horizontal: formatWidth(10)),
                    child: const Text(
                      '@',
                      style: TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    setState(() {
                      instagram = val;
                    });
                  },
                ),
                sh(14),
                TextFormUpdated.textarea(
                  initialValue: userData.expPro,
                  minLine: 3,
                  maxLine: 5,
                  fieldName: "content.exp-pro".tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  hintText: "content.exp-pro-hint".tr(),
                  onChanged: (val) {
                    setState(() {
                      expPro = val;
                    });
                  },
                ),
                sh(14),
                SelectForm<String>(
                  value: userData.gender,
                  fieldName: "content.gender".tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  hintText: "content.choose".tr(),
                  onChangedSelect: (value) {
                    gender = value;
                  },
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'content.gender-error'.tr();
                    }
                    return null;
                  },
                  items: [...Dress.gender.map((e) => DropdownMenuItem(child: Text(e), value: e))],
                ),
                sh(14),
                TextFormUpdated.classic(
                  defaultValue: height,
                  textInputType: TextInputType.number,
                  fieldName: "content.height".tr(),
                  hintText: '0',
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    height = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  defaultValue: userData.mensurations?.size,
                  textInputType: TextInputType.number,
                  fieldName: "content.size".tr(),
                  hintText: '0',
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    size = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  defaultValue: userData.mensurations?.hips,
                  textInputType: TextInputType.number,
                  fieldName: "content.hips".tr(),
                  hintText: '0',
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    hips = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  defaultValue: userData.mensurations?.bust,
                  textInputType: TextInputType.number,
                  fieldName: "content.bust".tr(),
                  hintText: '0',
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    bust = val;
                  },
                ),
                sh(14),
                TextFormUpdated.classic(
                  defaultValue: userData.mensurations?.footSize,
                  textInputType: TextInputType.number,
                  fieldName: "content.footSize".tr(),
                  hintText: '0',
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  onChanged: (val) {
                    footSize = val;
                  },
                ),
                sh(14),
                SelectForm<String>(
                  value: userData.mensurations?.clothingSize,
                  fieldName: "content.clothingSize".tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  hintText: "content.choose".tr(),
                  onChangedSelect: (value) {
                    clothingSize = value;
                  },
                  items: [
                    for (var i = 32; i <= 56; i += 2) ...{
                      DropdownMenuItem(child: Text(i.toString()), value: i.toString())
                    }
                  ],
                ),
                sh(14),
                SelectForm<String>(
                  value: userData.mensurations?.hairColor,
                  fieldName: "content.hairColor".tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  hintText: "content.choose".tr(),
                  onChangedSelect: (value) {
                    hairColor = value;
                  },
                  items: [...Dress.hairColor.map((e) => DropdownMenuItem(child: Text(e), value: e))],
                ),
                sh(14),
                SelectForm<String>(
                  value: userData.mensurations?.eyeColor,
                  fieldName: "content.eyeColor".tr(),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  hintText: "content.choose".tr(),
                  onChangedSelect: (value) {
                    eyeColor = value;
                  },
                  items: [...Dress.eyeColor.map((e) => DropdownMenuItem(child: Text(e), value: e))],
                ),
                sh(34),
              ],
              CTA.primary(
                textButton: 'utils.save'.tr(),
                onTap: () async {
                  // print('-----');
                  await FirestoreUtils.updateUserDoc({
                    ...{
                      "lastname": lastname ?? userData.lastname,
                      "firstname": firstname ?? userData.firstname,
                      "nickname": nickname ?? userData.nickname,
                      "shopNickname": shopNickname ?? userData.shopNickname,
                      "description": description ?? userData.description,
                      "location": location == null
                          ? userData.location!.toJson()
                          : LocationModelNew(
                              region: location?.region,
                              address: location?.address,
                              city: location?.city,
                              postalCode: location?.postalCode,
                              countryISOCode: location?.countryISOCode,
                              mainText: location?.mainText,
                              secondaryText: location?.secondaryText,
                              formattedText: location?.formattedText,
                            ).toJson(),
                      "profilCompleted": userData.profilCompleted,
                      "profilImage": userData.profilImage,
                      "type": userData.type,
                      "createdAt": userData.createdAt,
                      "instagram": instagram ?? userData.instagram,
                      "emailAddresses": email ?? userData.emailAddress,
                      "number": number?.phoneNumber.toString() ?? userData.number,
                      "robeType": robeType.isEmpty ? userData.robeType : robeType,
                    },
                    if (userData.type == "ProfilType.model") ...{
                      "gender": gender ?? userData.gender,
                      "expPro": expPro ?? userData.expPro,
                      "mensurations": MesurementsModel(
                        height: height ?? userData.mensurations?.height,
                        size: size ?? userData.mensurations?.size,
                        hips: hips ?? userData.mensurations?.hips,
                        bust: bust ?? userData.mensurations?.bust,
                        footSize: footSize ?? userData.mensurations?.footSize,
                        clothingSize: clothingSize ?? userData.mensurations?.clothingSize,
                        hairColor: hairColor ?? userData.mensurations?.hairColor,
                        eyeColor: eyeColor ?? userData.mensurations?.eyeColor,
                      ).toJson(),
                    }
                  });

                  Utils.notifGreen(context, "title.profil.update".tr(), 'title.profil.update-description'.tr());
                  AutoRouter.of(context).navigateBack();
                },
              ),
              sh(MediaQuery.of(context).padding.bottom + 40.h),
              Text('signalement.footer'.tr(), style: AppThemeStyle.footerSignalenemnt)
            ],
          ),
        ],
      ),
    );
  }
}
