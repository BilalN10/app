import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_list/dress_type.dart';
import 'package:findyourdresse_app/model/_list/morphology_type.dart';
import 'package:findyourdresse_app/provider/search_provider.dart';
import 'package:findyourdresse_app/utils/enum.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class FilterWidget extends ConsumerStatefulWidget {
  const FilterWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends ConsumerState<FilterWidget> {
  final TextEditingController _controllerLocation = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();
  String? city;
  String? size;
  String? dressType;
  RangeValues? price;

  @override
  void initState() {
    _controllerLocation.text = ref.read(searchProvider).location?.city ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          FocusScope.of(context).unfocus();
          await _showModal(context);
        },
        child: SvgPicture.asset('assets/svg/filter_inc.svg'));
  }

  Future _showModal(context) {
    return showModalBottomSheet(
        context: context,
        clipBehavior: Clip.hardEdge,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(29)),
            height: MediaQuery.of(context).size.height * .75,
            child: SingleChildScrollView(
              child: Column(
                // shrinkWrap: true,
                // physics: const BouncingScrollPhysics(),
                // padding: EdgeInsets.zero,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: formatWidth(47), child: Divider(thickness: formatWidth(4))),
                    ],
                  ),
                  sh(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'title.filter-search'.tr(),
                        style: AppThemeStyle.dialogButtonNo,
                      ),
                    ],
                  ),
                  sh(10),
                  Row(
                    children: [
                      Text(
                        "field.city".tr(),
                        style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
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
                        controller: _controllerLocation,
                        decoration: InputDecoration(
                          prefixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                          filled: true,
                          fillColor: const Color(0XFF02132B).withOpacity(0.03),
                          contentPadding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 17.h),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "field.city-hint".tr(),
                          hintStyle:
                              const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: sp(13), fontWeight: FontWeight.w500)),
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
                      city = val.city;
                      log(city ?? 'city null');
                      _controllerLocation.text = val.formattedText;
                    },
                  ),
                  sh(13),
                  SelectForm<String>(
                    fieldName: 'content.size-search'.tr(),
                    hintText: 'field.none'.tr(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 17.h),
                    items: [
                      for (var i = 32; i <= 56; i += 2) ...{
                        DropdownMenuItem(child: Text(i.toString()), value: i.toString())
                      }
                    ],
                    validator: (val) {
                      if (val == null) {
                        return 'field.morphology-validator'.tr();
                      }
                      return null;
                    },
                    onChangedSelect: (val) {
                      size = val;
                    },
                  ),
                  sh(13),
                  SelectForm<String>(
                    fieldName: 'field.dress-type-option'.tr(),
                    hintText: 'field.none'.tr(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 17.h),
                    items: [
                      ...DressesService.type.map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
                    ],
                    validator: (val) {
                      if (val == null) {
                        return 'field.dress-type-validator'.tr();
                      }
                      return null;
                    },
                    onChangedSelect: (val) {
                      dressType = val!;
                    },
                  ),
                  sh(13),
                  CustomSlider.range(
                    onChanged: (val) {
                      price = val;
                      print(val);
                    },
                    theme: SliderThemeData(
                      trackHeight: 0.2,
                      activeTrackColor: AppColor.trackColor,
                      inactiveTrackColor: AppColor.trackColor,
                      thumbColor: Colors.black,
                    ),
                    fieldName: "field.budget".tr(),
                    min: 0,
                    max: 10000,
                  ),
                  sh(34),
                  CTA.primary(
                    onTap: () async {
                      ref.read(searchProvider).getFilterResult(
                            queryString: ref.watch(searchProvider).searchText ?? '',
                            city: city,
                            size: size,
                            dressType: dressType,
                            price: price,
                          );

                      Navigator.pop(context);
                    },
                    textButton: 'utils.apply'.tr(),
                  ),
                  sh(26),
                  InkWell(
                      child: Text(
                    'utils.reset'.tr(),
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          );
        });
  }
}
