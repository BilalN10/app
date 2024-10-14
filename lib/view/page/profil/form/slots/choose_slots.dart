import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';
import 'package:findyourdresse_app/provider/notification_manage_new_provider.dart';
import 'package:findyourdresse_app/utils/context_provider.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:findyourdresse_app/widget/notification/notification_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class ChooseSlotPage extends ConsumerStatefulWidget {
  final NotificationFydModel notification;

  const ChooseSlotPage({super.key, required this.notification});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChooseSlotPageState();
}

class _ChooseSlotPageState extends ConsumerState<ChooseSlotPage> {
  final _formKey = GlobalKey<FormState>();
  final formatDatee = DateFormat("dd/MM/yyyy 'à' hh:mm");

  DateTime? _selectedValue;
  String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                        'content.choose-slots'.tr(),
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
              Text('content.choose-slot-title'.tr(), style: TextStyle(fontSize: sp(16), fontWeight: FontWeight.w400, fontFamily: 'PlayfairDisplay')),
              sh(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.notification.booking?.productName != null) ...[
                    Text(
                      "Produit : ${widget.notification.booking?.productName}",
                      style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                    ),
                  ],
                  Text(
                    "Date souhaitée : ${formatDate.format(widget.notification.booking!.bookingDate!)}",
                    style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Taille de vêtement : ",
                        style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                          child: Wrap(
                              children: widget.notification.booking!.sizeList!
                                  .map((e) => Text(e + (widget.notification.booking!.sizeList!.indexOf(e) == widget.notification.booking!.sizeList!.length - 1 ? '.' : ', '), style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500)))
                                  .toList())),
                    ],
                  ),
                  Text(
                    "Nombre de robe recherché : ${widget.notification.booking!.robeNumberResearch}.",
                    style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Type de robe recherché :",
                    style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                  ),
                  Wrap(
                      children: widget.notification.booking!.typeList!
                          .map((e) => Text(e + (widget.notification.booking!.typeList!.indexOf(e) == widget.notification.booking!.typeList!.length - 1 ? '.' : ', '), style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500)))
                          .toList()),
                  ReadMoreText(
                    "Message : ${widget.notification.booking!.userMessage}.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'utils.seemore'.tr(),
                    trimExpandedText: 'utils.seeless'.tr(),
                    style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                    moreStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                    lessStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                  ),
                ],
              ),
              sh(48),
              Text('content.choose-slot-title2'.tr(), style: TextStyle(fontSize: sp(16), fontWeight: FontWeight.w400, fontFamily: 'PlayfairDisplay')),
              sh(5),
              Text('content.select-slot'.tr(), style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500)),
              sh(21),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: formatHeight(5),
                clipBehavior: Clip.hardEdge,
                children: widget.notification.booking!.slotList!.map((e) => _selectedDateWidget(e)).toList(),
              ),
              sh(80),
              InkWell(
                  onTap: () {
                    _showModal(context);
                  },
                  child: Center(child: Text('content.ask-slot'.tr(), style: TextStyle(color: Colors.black, fontSize: sp(14), fontWeight: FontWeight.w600)))),
              sh(27),
              CTA.primary(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref.read(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).acceptSlot(widget.notification, _selectedValue);
                    Utils.notifGreen(context, "banner.green-product-title".tr(), "banner.valide-slot".tr());
                    Navigator.pop(context);
                  }
                },
                textButton: 'content.confirm-slot'.tr(),
                textButtonStyle: TextStyle(fontSize: sp(14), fontWeight: FontWeight.w600, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedDateWidget(
    DateTime date,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedValue = date;
        });
      },
      child: FormField(
        validator: (value) {
          if (_selectedValue == null) {
            return '';
          }
          return null;
        },
        builder: (field) {
          return Container(
              alignment: Alignment.center,
              height: formatHeight(54),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: const Color(0xffF7F7F8),
                  border: _selectedValue == date
                      ? Border.all(
                          color: Colors.black,
                          width: formatWidth(2),
                        )
                      : field.hasError
                          ? Border.all(
                              color: Colors.red,
                              width: formatWidth(.5),
                            )
                          : null),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: formatWidth(22), vertical: formatHeight(17)),
                child: Row(
                  children: [
                    Text(
                      formatDatee.format(date).toString(),
                      style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  _showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: formatHeight(370)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
      context: (context),
      builder: ((_) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: formatHeight(8), horizontal: formatWidth(29)),
          child: Column(
            children: [
              sh(8),
              Container(
                height: formatHeight(4),
                width: formatWidth(47),
                decoration: BoxDecoration(color: const Color(0xffDDDFE2), borderRadius: BorderRadius.horizontal(left: Radius.circular(3.r), right: Radius.circular(3.r))),
              ),
              sh(20),
              Text('content.add-message'.tr(), style: TextStyle(fontSize: sp(17), fontWeight: FontWeight.w600)),
              sh(23),
              TextFormUpdated.textarea(
                minLine: 4,
                maxLine: 6,
                fieldName: "content.title-message".tr(),
                contentPadding: EdgeInsets.symmetric(vertical: formatHeight(17), horizontal: formatWidth(22)),
                hintText: "content.message-hint".tr(),
                onChanged: (val) {
                  message = val;
                },
              ),
              sh(35),
              CTA.primary(
                onTap: () async {
                  await ref.read(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).askForSlot(widget.notification, message);
                  Utils.notifGreen(context, "banner.green-product-title".tr(), "content.ask-for-slot".tr());
                  Navigator.pop(context);
                  AutoRouter.of(context).navigateBack();
                },
                textButton: 'content.confirm-request'.tr(),
                textButtonStyle: TextStyle(fontSize: sp(14), fontWeight: FontWeight.w600, color: Colors.white),
              )
            ],
          ),
        );
      }),
    );
  }
}
