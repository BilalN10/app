import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_enum/tag_enum.dart';
import 'package:findyourdresse_app/model/picture_model/picturemodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/home_picture_provider.dart';
import 'package:findyourdresse_app/provider/notification_manage_new_provider.dart';
import 'package:findyourdresse_app/provider/notifications_user.dart';
import 'package:findyourdresse_app/provider/picture_provider.dart';
import 'package:findyourdresse_app/provider/search_provider.dart';
import 'package:findyourdresse_app/services/notification_services.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:findyourdresse_app/view/page/home/widget/little_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:ui_kosmos_v4/form/theme.dart';
import '../../../utils/utils.dart';
import '../../../model/_list/dress_type.dart';
import '../../../provider/navigation.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isLoading = true;

  String? homePicture;
  final TextEditingController _controllerLocationSearch = TextEditingController();
  final TextEditingController _valueSearch = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNodeSearch = FocusNode();
  final FocusNode _focusNodeSearchDresses = FocusNode();
  bool isSelected = false;
  @override
  void initState() {
    super.initState();

    ref.read(notificationsNormalUser).initNotifications();
    NotificationServices.initialize(context: context, ref: ref);
    setupInteractedMessage();
    _focusNodeSearchDresses.addListener(() {
      setState(() {
        isSelected = _focusNodeSearchDresses.hasFocus;
      });
    });
  }

  // Ids() {
  //pour connaitre l'id de l'installation
  //   FirebaseInstallations.instance.getId().then((value) => print(value));
  // }

  @override
  Widget build(BuildContext context) {
    List<PictureModel> picture = ref.watch(pictureProvider).pictures;
    homePicture = ref.watch(homePictureProvider).gethomePicture();

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: homePicture != null
                ? BoxDecoration(
                    image: DecorationImage(image: CachedNetworkImageProvider(homePicture!), fit: BoxFit.cover),
                  )
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: formatWidth(23), vertical: formatHeight(30)),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black])),
              child: Column(
                children: [
                  sh(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // AutoRouter.of(context).navigateNamed("/dashboard/subscription");
                        },
                        child: SvgPicture.asset(
                          "assets/svg/app_logo_gold_background_white.svg",
                          height: formatHeight(50),
                        ),
                      ),
                      if (FirebaseAuth.instance.currentUser != null) ...[
                        Row(
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(color: const Color(0XFFBBA87C).withOpacity(1), shape: BoxShape.circle),
                              child: InkWell(
                                onTap: () {
                                  // AutoRouter.of(context).navigateNamed("/dashboard/profil/notification");
                                  AutoRouter.of(context).navigateNamed("/dashboard/notification/page");
                                },
                                child: ref
                                            .watch(
                                                notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid))
                                            .hasNotification ==
                                        true
                                    ? Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: formatHeight(7), horizontal: formatWidth(7)),
                                        child: SvgPicture.asset(
                                          "assets/svg/notification_inc.svg",
                                          height: formatHeight(24),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: formatHeight(7), horizontal: formatWidth(7)),
                                        child: SvgPicture.asset(
                                          "assets/svg/notification_inc_empty.svg",
                                          color: Colors.white,
                                          height: formatHeight(24),
                                        ),
                                      ),
                              ),
                            ),
                            sw(5),
                            InkWell(
                              onTap: () {
                                if ((ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type ==
                                    "ProfilType.model") {
                                  AutoRouter.of(context).navigateNamed(
                                      "/dashboard/profil/model/${FirebaseAuth.instance.currentUser!.uid}");
                                } else if ((ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type ==
                                    "ProfilType.creator") {
                                  AutoRouter.of(context).navigateNamed(
                                      "/dashboard/profil/creator/${FirebaseAuth.instance.currentUser!.uid}");
                                } else {
                                  AutoRouter.of(context).navigateNamed('/dashboard/profile/settings');
                                }
                              },
                              child: Container(
                                width: formatWidth(40),
                                height: formatHeight(40),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                child: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).profilImage ==
                                        null
                                    ? Container(
                                        width: formatWidth(40),
                                        height: formatWidth(40),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(formatWidth(103)),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Image.asset(
                                          "assets/images/img_user_profil.png",
                                          package: "skeleton_kosmos",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd)
                                            .profilImage!,
                                        fit: BoxFit.cover,
                                        placeholderFadeInDuration: const Duration(seconds: 2),
                                        placeholder: (_, __) => Shimmer(
                                            child: Container(
                                              width: formatWidth(40),
                                              height: formatHeight(40),
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.white,
                                              ),
                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [Colors.grey.shade100, Colors.grey]))),
                              ),
                            )
                          ],
                        ),
                      ] else ...[
                        Transform.translate(
                          offset: const Offset(15, 0),
                          child: CTA.secondary(
                              border: Border.all(color: Colors.transparent),
                              backgroundColor: Colors.transparent,
                              width: formatWidth(50),
                              onTap: () {
                                AutoRouter.of(context).navigateNamed("/login");
                              },
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: formatWidth(30),
                                ),
                              )),
                        ),
                      ]
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isSelected)
                          Expanded(
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: SizedBox(
                                height: formatHeight(40),
                              ),
                            ),
                          ),
                        Text(
                          'home-page.title'.tr(),
                          textAlign: TextAlign.left,
                          style: AppThemeStyle.homeTitle,
                        ),
                        sh(10),
                        // TextFormUpdated.classic(
                        //   onChanged: (p0) {
                        //     ref.read(searchProvider).setSearchText(p0);
                        //   },
                        //   controller: _valueSearch,
                        //   theme: CustomFormFieldThemeData(
                        //     selectRadius: 0,
                        //     selectRadiusDropDown: 0,
                        //     hintStyle: AppThemeStyle.hintStyle,
                        //   ),
                        //   textStyle: AppThemeStyle.textSearchStyle,
                        //   backgroundColor: Colors.white,
                        //   contentPadding: EdgeInsets.symmetric(horizontal: formatWidth(15), vertical: formatHeight(17)),
                        //   radius: 0.0,
                        //   hintText: 'home-page.search-hint'.tr(),
                        //   hintTextStyle: AppThemeStyle.hintStyle,
                        //   prefixChildBoxConstraint: BoxConstraints(maxHeight: formatHeight(40)),
                        //   prefixChild: Padding(
                        //     padding: EdgeInsets.fromLTRB(formatWidth(17), 0, formatWidth(10), 0),
                        //     child: SvgPicture.asset(
                        //       "assets/svg/search_inc.svg",
                        //       height: formatHeight(21),
                        //     ),
                        //   ),
                        // ),
                        TypeAheadField(
                          suggestionsBoxVerticalOffset: 15.h,

                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            hasScrollbar: true,
                            color: Colors.white,
                            borderRadius: BorderRadius.zero,
                            elevation: 0.5,
                            constraints: BoxConstraints(maxHeight: 170.h, minWidth: 317.w),
                          ),
                          // hideKeyboardOnDrag: true,
                          // hideSuggestionsOnKeyboardHide: false,
                          debounceDuration: const Duration(seconds: 0),
                          animationDuration: const Duration(seconds: 0),
                          animationStart: 0.9,
                          textFieldConfiguration: TextFieldConfiguration(
                            onTap: () async {
                              await Future.delayed(const Duration(milliseconds: 300));
                              _scrollController.animateTo(70.h,
                                  duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
                            },
                            focusNode: _focusNodeSearchDresses,
                            controller: _valueSearch,
                            cursorRadius: Radius.zero,
                            decoration: InputDecoration(
                              prefixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: formatWidth(15), vertical: formatHeight(18)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: 'home-page.search-hint'.tr(),
                              hintStyle:
                                  const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(formatWidth(17), 0, formatWidth(10), 0),
                                child: SvgPicture.asset(
                                  "assets/svg/search_inc.svg",
                                  height: formatHeight(21),
                                ),
                              ),
                            ),
                            style: AppThemeStyle.textSearchStyle,
                          ),
                          hideOnEmpty: true,
                          noItemsFoundBuilder: (_) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                            child: Text(
                              'aucun résultat',
                              style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          suggestionsCallback: (value) async {
                            return DressesService.getSuggestions(value);
                          },
                          itemBuilder: (context, String dresseType) {
                            return ListTile(
                              title: Text(
                                dresseType,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            );
                          },
                          onSuggestionSelected: (String val) {
                            ref.read(searchProvider).setSearchText(val);
                            _valueSearch.text = val;
                          },
                        ),
                        sh(5),
                        TypeAheadField<LocationModel>(
                          suggestionsBoxVerticalOffset: 15.h,
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.zero,
                            elevation: 0.5,
                            constraints: BoxConstraints(maxHeight: 300, minWidth: 317.w),
                          ),
                          debounceDuration: const Duration(seconds: 0),
                          animationDuration: const Duration(seconds: 0),
                          animationStart: 0.9,
                          textFieldConfiguration: TextFieldConfiguration(
                            focusNode: _focusNodeSearch,
                            controller: _controllerLocationSearch,
                            cursorRadius: Radius.zero,
                            decoration: InputDecoration(
                              prefixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: formatWidth(15), vertical: formatHeight(18)),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: 'home-page.location-hint'.tr(),
                              hintStyle:
                                  const TextStyle(color: Color(0xFF9299A4), fontSize: 13, fontWeight: FontWeight.w500),
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(formatWidth(17), 0, formatWidth(10), 0),
                                child: SvgPicture.asset(
                                  "assets/svg/location_inc.svg",
                                  height: formatHeight(21),
                                ),
                              ),
                            ),
                            style: AppThemeStyle.textSearchStyle,
                          ),
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
                            ref.read(searchProvider).setLocation = val;
                            _controllerLocationSearch.text = val.formattedText;
                          },
                        ),
                        sh(14),
                        CTA.primary(
                          textButton: "home-page.search-button".tr(),
                          onTap: () {
                            _controllerLocationSearch.text = '';
                            _valueSearch.text = '';
                            ref.watch(searchProvider).getFilterResult(
                                queryString: ref.watch(searchProvider).searchText ?? '',
                                city: ref.watch(searchProvider).location?.city);
                            // _focusNodeSearch.unfocus();
                            AutoRouter.of(context).navigateNamed("/dashboard/research/${TagEnum.product.label}");
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: formatWidth(24),
            ),
            child: Column(children: [
              sh(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home-page.second-title'.tr(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: sp(25),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay'),
                  ),
                  InkWell(
                    onTap: () {
                      AutoRouter.of(context).navigateNamed("/dashboard/picture/index");
                    },
                    child: Text(
                      'home-page.see-more'.tr(),
                      style: AppThemeStyle.homeSeeMore,
                    ),
                  ),
                ],
              ),
              sh(10),
              SizedBox(
                height: formatHeight(188),
                child: picture.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return InkWell(
                              onTap: () async {
                                AutoRouter.of(context).navigateNamed("/dashboard/picture/details/${picture[index].id}");
                              },
                              child: LittleCardWidget(
                                mediaType: picture[index].mediaType ?? FileType.image,
                                image: picture[index].mediaType == FileType.image
                                    ? picture[index].pictureUrl!
                                    : "https://image.mux.com/${picture[index].playBackId}/thumbnail.png?width=400",
                                ownerId: picture[index].ownerId!,
                              ));
                        }),
                        separatorBuilder: ((context, index) => sw(6)),
                        itemCount: picture.sublist(0, min(4, picture.length)).length,
                      )
                    : Center(child: Text('utils.empty'.tr())),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) => _handleMessage(message));
  }

  void _handleMessage(RemoteMessage message) async {
    if (message.data['type'] == "notification") {
      if (message.data['bookingId'] != null) {
        AutoRouter.of(context).navigateNamed("/dashboard/index/fitting");
        ref.read(navigationProvider.notifier).update('fitting');
      } else {
        AutoRouter.of(context).navigateNamed("/dashboard/notification/page");
      }
    } else if (message.data['type'] == "bookingResponse") {
      AutoRouter.of(context).navigateNamed("/dashboard/index/fitting");
    }
  }
}
