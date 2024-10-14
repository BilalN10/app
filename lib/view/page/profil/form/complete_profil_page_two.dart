import 'dart:io';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/controller/storage_controller.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/model/_list/dress_type.dart';
import 'package:findyourdresse_app/model/location_model_new/location_model_new.dart';
import 'package:findyourdresse_app/model/mesurements_model/mesurements_model.dart';
import 'package:findyourdresse_app/provider/profil_type.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:multiselect/multiselect.dart';

import 'complete_profil_page.dart';

class CompleteProfilPageTwo extends ConsumerStatefulWidget {
  final PageController pageController;

  const CompleteProfilPageTwo({super.key, required this.pageController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteProfilPageTwoState();
}

class _CompleteProfilPageTwoState extends ConsumerState<CompleteProfilPageTwo> {
  final TextEditingController _controllerLocationMe = TextEditingController();
  final TextEditingController _controllerLocationShop = TextEditingController();

  final FocusNode _focusNodeSearch = FocusNode();
  final _formKeyProfil = GlobalKey<FormState>();

  String? nickname;
  String? firstname;
  String? lastname;
  String? shopNickname;
  String? shortDescription;
  PhoneNumber? number;
  String? email;
  List<String> robeType = [];
  LocationModel? location;
  File? _profilImage;

  String? instagram;
  String? expPro;
  String? gender;
  String? height;
  String? size;
  String? hips;
  String? bust;
  String? footSize;
  String? clothingSize;
  String? hairColor;
  String? eyeColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: formatHeight(51), horizontal: formatWidth(27)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Transform.translate(
          offset: const Offset(-10, -5),
          child: CTA.back(
            onTap: () async {
              FocusScope.of(context).unfocus();
              widget.pageController.jumpToPage(0);
            },
          ),
        ),
        Form(
            key: _formKeyProfil,
            child: Column(
              children: [
                Text('complete-profil.title-2'.tr(), style: AppThemeStyle.formProfilTitle),
                sh(25),
                //CREATOR FORM
                if (ref.watch(profilTypeProvider).type == ProfilType.creator) ...[
                  TextFormUpdated.classic(
                    fieldName: "field.creator-name".tr(),
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
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "field.hint-manager-name".tr(),
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
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "field.hint-manager-firstname".tr(),
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
                  TextFormUpdated.phoneNumber(
                    fieldName: 'content.phone-field'.tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    initialPhoneValue: PhoneNumber(isoCode: 'FR'),
                    onInputChanged: (p0) {
                      setState(() {
                        number = p0;
                      });
                    },
                  ),
                  sh(14),
                  TextFormUpdated.classic(
                    fieldName: "content.email-field".tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "content.email-field-hint".tr(),
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                  sh(14),
                  TextFormUpdated.classic(
                    fieldName: "field.nickname-shop".tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "field.hint-nickname-shop".tr(),
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
                  TextFormUpdated.classic(
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
                  Row(
                    children: [
                      Text(
                        "field.address-shop".tr(),
                        style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  sh(6),
                  FormField(validator: (value) {
                    if (value == null) {
                      return 'error.location'.tr();
                    }
                    return null;
                  }, builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: state.hasError ? Colors.red.withOpacity(0.8) : Colors.transparent,
                                  width: formatHeight(0.5),
                                )),
                                hintText: "field.hint-address-shop".tr(),
                                hintStyle: const TextStyle(
                                    color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
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
                            location = val;
                            setState(() {
                              _controllerLocationShop.text = val.formattedText;
                              state.didChange(val);
                            });
                          },
                        ),
                        if (state.hasError) ...[
                          Padding(
                            padding: EdgeInsets.only(top: formatHeight(5), left: formatWidth(22)),
                            child: Text(state.errorText!, style: AppThemeStyle.errorText),
                          )
                        ]
                      ],
                    );
                  }),
                  sh(14),
                  FormField<File>(validator: (value) {
                    if (value == null) {
                      return 'error.picture'.tr();
                    }
                    return null;
                  }, builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Input.image(
                          boxDecoration: BoxDecoration(
                              color: const Color(0xffF7F7F8),
                              borderRadius: BorderRadius.circular(7.r),
                              border: Border.all(
                                width: formatHeight(0.5),
                                color: state.hasError ? Colors.red : Colors.transparent,
                              )),
                          imageMobile: _profilImage,
                          contentPadding: const EdgeInsets.fromLTRB(7, 6, 30, 6),
                          fieldName: "field.profil-picture".tr(args: [
                            ref.watch(profilTypeProvider).type == ProfilType.particular ? ' (Facultatif)' : '*'
                          ]),
                          onTap: () async {
                            PermissionStatus status = await Permission.photos.status;
                            if (status.isDenied) {
                              await Permission.photos.request();
                            } else if (status.isPermanentlyDenied) {
                              await showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("Photos permission"),
                                    content: const Text(
                                        'Please accept the photos permission in settings to select a photo.'),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () async {
                                          await openAppSettings();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Open app settings'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                            File? _image = await StorageController.selectFile();
                            if (_image != null) {
                              setState(() {
                                _profilImage = _image;
                                state.didChange(_image);
                              });
                            }
                          },
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
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
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
                  TextFormUpdated.textarea(
                    minLine: 3,
                    maxLine: 5,
                    fieldName: "field.short-description".tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "field.hint-short-description".tr(),
                    onChanged: (val) {
                      shortDescription = val;
                    },
                  ),
                  sh(14),
                ],
                if (ref.watch(profilTypeProvider).type == ProfilType.model ||
                    ref.watch(profilTypeProvider).type == ProfilType.particular) ...[
                  TextFormUpdated.classic(
                    fieldName: "field.user-firstname".tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "field.hint-user-firstname".tr(),
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
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "field.hint-user-lastname".tr(),
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
                  if (ref.watch(profilTypeProvider).type == ProfilType.particular) ...[
                    sh(14),
                    Input.image(
                      boxDecoration: BoxDecoration(
                          color: const Color(0xffF7F7F8),
                          borderRadius: BorderRadius.circular(7.r),
                          border: Border.all(
                            width: formatHeight(0.5),
                            color: Colors.transparent,
                          )),
                      imageMobile: _profilImage,
                      contentPadding: const EdgeInsets.fromLTRB(7, 6, 30, 6),
                      fieldName: "field.profil-picture".tr(args: [" (facultatif)"]),
                      onTap: () async {
                        PermissionStatus status = await Permission.photos.status;
                        if (status.isDenied) {
                          await Permission.photos.request();
                        } else if (status.isPermanentlyDenied) {
                          await showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text("Photos permission"),
                                content:
                                    const Text('Please accept the photos permission in settings to select a photo.'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () async {
                                      await openAppSettings();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Open app settings'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        File? _image = await StorageController.selectFile();
                        if (_image != null) {
                          setState(() {
                            _profilImage = _image;
                          });
                        }
                      },
                    ),
                  ],
                  sh(14),
                ],
                if (ref.watch(profilTypeProvider).type == ProfilType.model) ...[
                  TextFormUpdated.classic(
                    fieldName: "field.user-nickname".tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "field.hint-user-nickname".tr(),
                    onChanged: (val) {
                      nickname = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "field.error-user-nickname".tr();
                      }
                      return null;
                    },
                  ),
                  sh(14),
                  Row(
                    children: [
                      Text(
                        "field.user-city".tr(),
                        style: TextStyle(color: Colors.black, fontSize: sp(11), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  sh(6),
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
                          hintText: "field.hint-user-city".tr(),
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
                      location = val;

                      setState(() {
                        _controllerLocationMe.text = val.formattedText;
                      });
                    },
                  ),
                  sh(14),
                  Input.image(
                    boxDecoration: BoxDecoration(
                        color: const Color(0xffF7F7F8),
                        borderRadius: BorderRadius.circular(7.r),
                        border: Border.all(
                          width: formatHeight(0.5),
                          color: Colors.transparent,
                        )),
                    imageMobile: _profilImage,
                    contentPadding: const EdgeInsets.fromLTRB(7, 6, 30, 6),
                    fieldName: "field.profil-picture".tr(args: [" (facultatif)"]),
                    onTap: () async {
                      PermissionStatus status = await Permission.photos.status;
                      if (status.isDenied) {
                        await Permission.photos.request();
                      } else if (status.isPermanentlyDenied) {
                        await showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text("Photos permission"),
                              content: const Text('Please accept the photos permission in settings to select a photo.'),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () async {
                                    await openAppSettings();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Open app settings'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      File? _image = await StorageController.selectFile();
                      if (_image != null) {
                        setState(() {
                          _profilImage = _image;
                        });
                      }
                    },
                  ),
                  sh(14),
                  TextFormUpdated.classic(
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
                  TextFormUpdated.textarea(
                    minLine: 3,
                    maxLine: 5,
                    fieldName: "content.exp-pro".tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "content.exp-pro-hint".tr(),
                    onChanged: (val) {
                      expPro = val;
                    },
                  ),
                  sh(14),
                  SelectForm<String>(
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
                    fieldName: "content.eyeColor".tr(),
                    contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                    hintText: "content.choose".tr(),
                    onChangedSelect: (value) {
                      eyeColor = value;
                    },
                    items: [...Dress.eyeColor.map((e) => DropdownMenuItem(child: Text(e), value: e))],
                  ),
                ],

                sh(38),
                CTA.primary(
                    textButton: 'utils.finish-subscription'.tr(),
                    onTap: () async {
                      if (_formKeyProfil.currentState!.validate()) {
                        await addUser();
                      }
                    }),
                sh(14),
                Text('signalement.footer'.tr(), style: AppThemeStyle.footerSignalenemnt)
              ],
            ))
      ]),
    );
  }

  addUser() async {
    String? url;

    if (_profilImage != null) {
      url = await StorageController.uploadProfilPicture(_profilImage!);
    }

    await FirestoreUtils.updateUserDoc({
      "lastname": lastname?.toCapitalized(),
      "firstname": firstname?.toCapitalized(),
      "nickname": nickname?.toCapitalized(),
      "shopNickname": shopNickname?.toCapitalized(),
      "description": shortDescription,
      "location": location != null
          ? LocationModelNew(
              region: location?.region,
              address: location?.address,
              city: location?.city,
              postalCode: location?.postalCode,
              countryISOCode: location?.countryISOCode,
              mainText: location?.mainText,
              secondaryText: location?.secondaryText,
              formattedText: location?.formattedText,
            ).toJson()
          : null,
      "profilCompleted": true,
      "profilImage": url,
      "type": ref.read(profilTypeProvider).type.toString(),
      "createdAt": DateTime.now(),
      "number": number?.phoneNumber,
      "emailAddress": email,
      "robeType": robeType,
      "instagram": instagram,
      "expPro": expPro,
      "gender": gender,
      "mensurations": MesurementsModel(
        height: height,
        size: size,
        hips: hips,
        bust: bust,
        footSize: footSize,
        clothingSize: clothingSize,
        hairColor: hairColor,
        eyeColor: eyeColor,
      ).toJson()
    });

    Utils.notifGreen(context, "Félicitations", "Votre compte à bien été créé !");
    AutoRouter.of(context).pushAndPopUntil(GetIt.I<ApplicationDataModel>().mainRoute, predicate: (_) => false);
  }
}
