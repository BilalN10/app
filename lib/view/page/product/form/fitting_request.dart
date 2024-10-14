import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/model/_enum/_booking_state.dart';
import 'package:findyourdresse_app/model/_enum/_notification_state.dart';
import 'package:findyourdresse_app/model/_list/dress_type.dart';
import 'package:findyourdresse_app/model/booking_model/bookingmodel.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/model/user_info_model/user_info_model.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/notification_manage_new_provider.dart';
import 'package:findyourdresse_app/utils/context_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multiselect/multiselect.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import '../../../../config/theme.dart';
import '../../../../utils/utils.dart';

class FittingRequestPage extends ConsumerStatefulWidget {
  final String? creatorId;
  final ProductModel? product;

  const FittingRequestPage({super.key, required this.creatorId, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FittingRequestPageState();
}

class _FittingRequestPageState extends ConsumerState<FittingRequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? bookingDate;
  List<String> sizeList = [];
  List<String> typeList = [];
  String? message;
  String? robeNumberlookingFor;
  final formatDate = DateFormat("'Le' dd/MM/y 'à' HH'h'mm");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: formatHeight(51), horizontal: formatWidth(28)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          'content.request-title'.tr(),
                          style: AppThemeStyle.descriptionSubtitle.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-formatWidth(10), 0),
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
                sh(25),
                Text(
                  'content.request-title'.tr(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: sp(16),
                      fontFamily: 'PlayfairDisplay'),
                ),
                sh(19),
                Text(
                  'content.request-date'.tr(),
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: sp(12)),
                ),
                sh(6),
                Theme(
                  data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColor.linearFirst)),
                  child: DateTimeField(
                    style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                    onChanged: (value) {
                      setState(() {
                        bookingDate = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'content.request-date-error'.tr();
                      }
                      return null;
                    },
                    cursorRadius: Radius.circular(7.r),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0XFF02132B).withOpacity(0.03),
                      contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                      hintText: 'Le jj/mm/aaaa à hh:mm',
                      hintStyle: TextStyle(color: AppColor.subtitle, fontSize: sp(12), fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                        width: formatHeight(0.5),
                      )),
                    ),
                    format: formatDate,
                    onShowPicker: (BuildContext context, DateTime? currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: currentValue ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()));
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ),
                sh(14),
                Row(
                  children: [
                    Text(
                      "content.clothingSize".tr(),
                      style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                sh(6),
                FormField<List<String>>(validator: (value) {
                  if (sizeList.isEmpty) {
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
                          hint: Text("content.choose".tr()),
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          selected_values_style: const TextStyle(
                              color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          onChanged: (List<String> x) {
                            setState(() {
                              sizeList = x;
                              state.didChange(x);
                            });
                          },
                          icon: const Icon(Iconsax.arrow_down_14),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0XFF02132B).withOpacity(0.03),
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: formatHeight((17 + max(0, (sizeList.length) * 1.2)) * 1),
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
                          options: [
                            for (var i = 32; i <= 56; i += 2) ...{i.toString()},
                          ],
                          selectedValues: sizeList,
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
                SelectForm<String>(
                  fieldName: "content.request-number-input".tr(),
                  fieldNameStyle: const TextStyle(
                      color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                  contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                  hintText: "content.choose".tr(),
                  hintTextStyle: const TextStyle(color: Colors.black),
                  onChangedSelect: (value) {
                    robeNumberlookingFor = value;
                  },
                  items: [
                    for (var i = 1; i <= 5; i++) ...{DropdownMenuItem(child: Text(i.toString()), value: i.toString())}
                  ],
                  validator: (p0) {
                    if (p0 == null) {
                      return 'content.request-number-error'.tr();
                    }
                  },
                ),
                sh(14),
                Row(
                  children: [
                    Text(
                      "content.request-type-input".tr(),
                      style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                sh(6),
                FormField<List<String>>(validator: (value) {
                  if (sizeList.isEmpty) {
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
                          hint: Text("content.choose".tr()),
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          selected_values_style: const TextStyle(
                              color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          onChanged: (List<String> x) {
                            setState(() {
                              typeList = x;
                              state.didChange(x);
                            });
                          },
                          icon: const Icon(Iconsax.arrow_down_14),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                            filled: true,
                            fillColor: const Color(0XFF02132B).withOpacity(0.03),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: formatHeight((17 + max(0, (typeList.length) * 3)) * 1),
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
                          selectedValues: typeList,
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
                  fieldNameStyle: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                  fieldName: 'content.request-message'.tr(),
                  hintText: 'content.request-message-hint'.tr(),
                  onChanged: (val) {
                    message = val;
                  },
                  maxLine: 5,
                ),
                sh(37),
                CTA.primary(
                  textButton: 'content.request-confirm'.tr(),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid))
                          .createNotificationNew(
                              notification: NotificationFydModel(
                            sendAt: DateTime.now(),
                            requestAt: bookingDate,
                            receiverId: widget.creatorId,
                            senderId: FirebaseAuth.instance.currentUser!.uid,
                            booking: BookingModel(
                              productId: widget.product?.id,
                              productName: widget.product?.name,
                              state: BookingState.pending,
                              bookingDate: bookingDate,
                              sizeList: sizeList,
                              typeList: typeList,
                              userMessage: message,
                              robeNumberResearch: robeNumberlookingFor,
                            ),
                            state: NotificationState.request,
                            message: 'Aimerait réserver un essayage',
                            userInfo: UserInfoModel.fromUserFydModel(
                                ref.read(userChangeNotifierProvider).userData as UserModelFyd),
                          ));

                      if (mounted) {
                        Utils.notifGreen(
                            context, 'banner.green-booking-title'.tr(), 'banner.green-booking-subtitle'.tr());
                      }

                      AutoRouter.of(context).navigateBack();
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
