import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';
import 'package:findyourdresse_app/provider/notification_manage_new_provider.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:findyourdresse_app/widget/notification/notification_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class OfferSlotsPage extends ConsumerStatefulWidget {
  final NotificationFydModel notification;

  const OfferSlotsPage({super.key, required this.notification});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OfferSlotsPageState();
}

class _OfferSlotsPageState extends ConsumerState<OfferSlotsPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _firstSelectedDate;
  DateTime? _secondSelectedDate;
  DateTime? _thirdSelectedDate;
  List<DateTime?> selectedValues = [];
  final formatDate = DateFormat('dd/MM/yyyy hh:mm');

  void updateFirstSelectedDate(DateTime? date) {
    setState(() {
      _firstSelectedDate = date;
    });
  }

  void updateSecondSelectedDate(DateTime? date) {
    setState(() {
      _secondSelectedDate = date;
    });
  }

  void updateThirdSelectedDate(DateTime? date) {
    setState(() {
      _thirdSelectedDate = date;
    });
  }

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
                        'content.offer-slots'.tr(),
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
              Text('content.offer-slot-title'.tr(),
                  style: TextStyle(fontSize: sp(16), fontWeight: FontWeight.w400, fontFamily: 'PlayfairDisplay')),
              sh(11),
              NotificationCard(notification: widget.notification),
              sh(60),
              Text('content.offer-slot-title2'.tr(),
                  style: TextStyle(fontSize: sp(16), fontWeight: FontWeight.w400, fontFamily: 'PlayfairDisplay')),
              sh(9),
              _selectedDateWidget('content.offer-slot-one'.tr(), updateFirstSelectedDate),
              sh(9),
              _selectedDateWidget('content.offer-slot-two'.tr(), updateSecondSelectedDate),
              sh(9),
              _selectedDateWidget('content.offer-slot-three'.tr(), updateThirdSelectedDate),
              sh(80),
              CTA.primary(
                onTap: () async {
                  log(_firstSelectedDate.toString());
                  log(_secondSelectedDate.toString());
                  log(_thirdSelectedDate.toString());

                  if (_formKey.currentState!.validate()) {
                    List<DateTime> _listDate = [_firstSelectedDate!, _secondSelectedDate!, _thirdSelectedDate!];
                    await ref.read(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).proposeSlot(
                        widget.notification
                            .copyWith(booking: widget.notification.booking!.copyWith(slotList: _listDate)));
                    Utils.notifGreen(context, 'banner.green-product-title'.tr(), 'content.green-propose'.tr());
                    AutoRouter.of(context).navigateBack();
                  }
                },
                textButton: 'content.offer-slot-button'.tr(),
                textButtonStyle: TextStyle(fontSize: sp(14), fontWeight: FontWeight.w600, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedDateWidget(
    String slotTitle,
    Function updateValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(slotTitle, style: TextStyle(fontSize: sp(12), fontWeight: FontWeight.w500)),
        sh(8),
        Container(
          alignment: Alignment.center,
          height: formatHeight(54),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            color: const Color(0xffF7F7F8),
          ),
          child: Theme(
            data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColor.linearFirst)),
            child: DateTimeField(
              style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
              onChanged: (value) {
                updateValue(value);
              },
              validator: (value) {
                if (value == null) {
                  return 'Renseigner un créneau horaire';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                hintText: 'jj/mm/aaaa à hh:mm',
                hintStyle: TextStyle(color: AppColor.subtitle, fontSize: sp(12), fontWeight: FontWeight.w500),
                enabledBorder: InputBorder.none,
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
        )
      ],
    );
  }
}
