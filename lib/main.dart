import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/legalDoc/legal_doc.dart';
import 'package:findyourdresse_app/legalDoc/static_doc.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/services/notification_services.dart';
import 'package:findyourdresse_app/services/revenue_cat_services.dart';
import 'package:findyourdresse_app/view/page/profil/form/complete_profil_page.dart';
import 'package:findyourdresse_app/view/page/settings/personnal_data/personnal_profil_type_page.dart';
import 'package:findyourdresse_app/view/page/settings/personnal_data/personnal_data_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:findyourdresse_app/routes/app_router.gr.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notification_kosmos/notification_kosmos.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:ui_kosmos_v4/cta/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:app_settings/app_settings.dart';
import 'package:path_provider/path_provider.dart';
import 'routes/guards/alreadyloggedguard.dart';
import 'routes/guards/onboardingguardcustom.dart';

Directory? directory;
String? profilType;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  directory = await getApplicationDocumentsDirectory();
  // await FirebaseAuth.instance.signOut();
  await PurchaseApi.initPlatformState();
  SharedPreferences myPrefs = await SharedPreferences.getInstance();
  await myPrefs.setBool("alreadyRun", false);
  timeago.setLocaleMessages('fr', timeago.FrShortMessages());

  final appModel = ApplicationDataModel<UserModelFyd>(
    userTypeProvider: UserModelFyd(),
    noConnexionRouteName: '/dashboard/index',
    logoutFunction: (BuildContext context, WidgetRef ref) async {
      printInDebug("kdfsd");
      SharedPreferences myPrefs = await SharedPreferences.getInstance();
      await myPrefs.setBool("alreadyRun", false);

      // CustomSharedPreferences.instance.setBooleanValue("alreadyRun", false);
      ref.read(userChangeNotifierProvider).clear();
      await FirebaseAuth.instance.signOut();
      AutoRouter.of(context).navigateBack();
      AutoRouter.of(context).navigateBack();
      // AutoRouter.of(context).replaceNamed("/onboarding");
    },
    deleteAccountFunction: (BuildContext context, WidgetRef ref) async {
      ref.read(userChangeNotifierProvider).clear();
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseAuth.instance.signOut();
      await FirebaseFunctions.instance.httpsCallable("deleteUser").call({
        "userId": uid,
        "uid": uid,
      });
      AutoRouter.of(context).navigateBack();
      AutoRouter.of(context).navigateBack();
    },
    noConnexionRoute: const DashboardRoute(),
    userConstructorProvider: UserModelFyd.fromJson,
    appLogo: "assets/svg/app_logo_gold.svg",
    appTitle: "Find Your Dresses",
    mainRouteName: "/dashboard",
    dashboardInitialiserWithUserData: (_, ref) {
      ref.read(notificationProvider).init(FirebaseAuth.instance.currentUser!.uid);
    },
    mainRoute: const DashboardRoute(),
    forceUserConnection: false,
    clearUserSessionOnDebugMode: false,
    gmapKey: "AIzaSyArfwJCCv-KEj_ovlrxOJy6tkoqFsP11aU",
    showEditImageProfil: true,
    showEmailInProfile: false,
    dependenciesConfiguration: DependenciesConfiguration(
      applicationNeedsPermission: true,
      permissionNeedConnectedUser: true,
      enableOnBoarding: true,
      permissonWidgets: [
        (_, __, controller) {
          return NotificationsPermission(
            backgroundColor: Colors.white,
            pageController: controller,
            userCollection: "/users",
            title: "Notifications Push",
            titleStyle: TextStyle(
              color: Colors.black,
              fontSize: sp(24),
              fontWeight: FontWeight.w600,
            ),
            onSkip: () {
              CustomSharedPreferences.instance.setBooleanValue("permissionAlreadyLaunched", true);
              AutoRouter.of(_).pushAndPopUntil(GetIt.I<ApplicationDataModel>().mainRoute, predicate: (_) => false);
            },
            onValidate: () async {
              FirebaseMessaging.onBackgroundMessage(NotificationServices.firebaseMessagingBackgroundHandler);
              FirebaseMessaging messaging = FirebaseMessaging.instance;
              NotificationSettings settings = await messaging.requestPermission(
                alert: true,
                announcement: false,
                badge: true,
                carPlay: false,
                criticalAlert: false,
                provisional: false,
                sound: true,
              );

              if (settings.authorizationStatus == AuthorizationStatus.authorized ||
                  settings.authorizationStatus == AuthorizationStatus.provisional) {
                FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

                final token = await firebaseMessaging.getToken();
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  "fcmToken": token,
                  "enablePushNotification": true,
                });
              } else {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  "fcmToken": null,
                  "enablePushNotification": false,
                });
                Navigator.pop(_);
              }
              CustomSharedPreferences.instance.setBooleanValue("permissionAlreadyLaunched", true);
              AutoRouter.of(_).pushAndPopUntil(GetIt.I<ApplicationDataModel>().mainRoute, predicate: (_) => false);
            },
            onBack: () {
              CustomSharedPreferences.instance.setBooleanValue("permissionAlreadyLaunched", true);
              AutoRouter.of(_).pushAndPopUntil(GetIt.I<ApplicationDataModel>().mainRoute, predicate: (_) => false);
            },
            themeValidate: CtaThemeData(
                borderRadius: 12,
                gradient: LinearGradient(
                    begin: const Alignment(-2.0, -2.0),
                    end: const Alignment(0.0, 0.0),
                    colors: [AppColor.linearFirst, AppColor.linearSecond, AppColor.linearThird, AppColor.linearFour])),
            assetSize: Size(formatWidth(277), formatHeight(277)),
            subtitleStyle: TextStyle(color: AppColor.subtitle, fontSize: sp(13), fontWeight: FontWeight.w500),
            subtitle:
                "Souhaitez-vous activer notre service de notifications Push ? Il vous aidera à exploiter tout le potentiel de notre application.",
            validateText: "Activer les notifications",
            asset: "assets/images/img_permission_push_notif.png",
          );
        },
      ],
    ),
    applicationConfig: AppConfigModel(
      enableConnexionWithPhone: true,
      cguContentBuilder: (ctx, ref) {
        return const HtmlWidget(
          legalHtmlContent,
          textStyle: TextStyle(color: Colors.black),
        );
      },
      createAccountNeedPhone: true,
      logoOnAuthenticationPage: false,
      applicationNeedsPermission: true,
      showBottomBarOnWeb: false,
      completeProfilPopup: const CompleteProfilPage(),
      bottomNavigationBarInMobile: false,
      navigationItems: const [dz.Tuple2("default", [])],
      emailMustBeVerified: false,
      settingsNodes: [
        dz.Tuple2(
          "Mon compte",
          [
            SettingsNode(
              tag: 'personnal',
              type: SettingsType.personnalData,
              children: [
                dz.Tuple2(
                  "Modifier",
                  [
                    SettingsNode(
                      tag: 'information',
                      type: SettingsType.custom,
                      data: SettingsData(
                        childBuilder: (_, __) => const PersonnalDataPage(),
                        title: 'settings.personnal-data.main.title',
                        subTitle: 'settings.personnal-data.main.desc',
                      ),
                    ),
                    SettingsNode(
                      tag: 'aditional',
                      type: SettingsType.custom,
                      data: SettingsData(
                          childBuilder: (_, ref) {
                            return const PersonnalProfilTypePage();
                          },
                          title: 'settings.personnal-data.aditional.title',
                          subTitle: 'Particulier / Professionnel / Créateur '),
                    ),
                  ],
                )
              ],
            ),
            SettingsNode(
              tag: 'security',
              type: SettingsType.security,
              data: const SettingsData(),
              children: [
                dz.Tuple2(
                  "Sécurité",
                  [
                    SettingsNode(
                      tag: 'information-security',
                      type: SettingsType.custom,
                      data: SettingsData(
                        childBuilder: (p0, p1) =>
                            SettingsBuilder.generateDefaultSettings(type: GeneralSettingsType.email),
                        title: 'Adresse email',
                        subTitle: 'Modifier mon adresse e-mail',
                      ),
                    ),
                    SettingsNode(
                      tag: 'password',
                      type: SettingsType.custom,
                      data: SettingsData(
                          childBuilder: (p0, p1) =>
                              SettingsBuilder.generateDefaultSettings(type: GeneralSettingsType.password),
                          title: 'Mot de passe',
                          subTitle: 'Modifier mon mot de passe'),
                    ),
                    SettingsNode(
                      tag: 'phone-number',
                      type: SettingsType.custom,
                      data: SettingsData(
                        childBuilder: (p0, p1) =>
                            SettingsBuilder.generateDefaultSettings(type: GeneralSettingsType.phone),
                        title: 'Numéro de téléphone',
                        subTitle: 'Modifier mon numéro de téléphone',
                      ),
                    ),
                  ],
                )
              ],
            ),
            SettingsNode(
              tag: 'subscription',
              type: SettingsType.custom,
              data: SettingsData(
                  title: "app.settings.subscription.title",
                  subTitle: "app.settings.subscription.desc",
                  prefix: Center(
                    child: SvgPicture.asset("assets/svg/ic_subscription.svg"),
                  ),
                  onTap: (_, __) async {
                    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
                    DocumentSnapshot<Map<String, dynamic>> currentUserInfo = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get();
                    if (customerInfo.managementURL != null && currentUserInfo.data()!["premium"] == true) {
                      launchUrl(Uri.parse(customerInfo.managementURL!));
                    } else {
                      if (ProfilType.value.toEnum(currentUserInfo['type']) != ProfilType.particular) {
                        AutoRouter.of(_).navigateNamed("/dashboard/subscription");
                      } else {
                        NotifBanner.showToast(
                          context: _,
                          fToast: FToast().init(_),
                          title: 'subscription.settings.particular-subscribe-title'.tr(),
                          subTitle: 'subscription.settings.particular-subscribe-subtitle'.tr(),
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                  }),
            ),
            SettingsNode(
              tag: 'historic',
              type: SettingsType.custom,
              data: SettingsData(
                  title: "app.settings.historic.title",
                  subTitle: "app.settings.historic.subtitle",
                  prefix: const Center(
                    child: Icon(
                      Iconsax.archive_14,
                      color: Colors.white,
                    ),
                  ),
                  onTap: (_, __) async {
                    AutoRouter.of(_).navigateNamed("/dashboard/historic");
                  }),
            )
          ],
        ),
        dz.Tuple2(
          "app.settings.settings-title",
          [
            SettingsNode(
              tag: 'push-notifications',
              type: SettingsType.switcher,
              data: SettingsData(
                activeSwitchColor: AppColor.linearFirst,
                onSwicth: ((p0, ref, val) async {
                  log(val.toString());

                  FirebaseMessaging messaging = FirebaseMessaging.instance;
                  NotificationSettings settings = await messaging.requestPermission(
                    alert: true,
                    announcement: false,
                    badge: true,
                    carPlay: false,
                    criticalAlert: false,
                    provisional: false,
                    sound: true,
                  );
                  if (settings.authorizationStatus == AuthorizationStatus.authorized ||
                      settings.authorizationStatus == AuthorizationStatus.provisional) {
                    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
                    log('message4');

                    if (val == false) {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "fcmToken": null,
                        "enablePushNotification": false,
                      });
                      log('message11');
                    } else {
                      final token = await firebaseMessaging.getToken();

                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "fcmToken": token,
                        "enablePushNotification": true,
                      });
                      log('message1');
                    }
                    log('message2');
                  } else {
                    log('test');
                    AppSettings.openAppSettings();
                  }
                }),
                switchValue: (ref) => ref.watch(userChangeNotifierProvider).userData!.enablePushNotification ?? false,
                title: "Notifications Push",
                subTitle: "Activer les notifications push",
                prefix: Center(
                  child: SvgPicture.asset("assets/svg/ic_notif.svg"),
                ),
              ),
            )
          ],
        ),
        dz.Tuple2(
          "app.settings.other-title",
          [
            SettingsNode(
              tag: 'help',
              type: SettingsType.custom,
              data: SettingsData(
                title: "app.settings.help.title",
                subTitle: "app.settings.help.desc",
                onTap: (_, p1) async {
                  var uri = Uri.parse("mailto:contact@findyourdresses.com");
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    NotifBanner.showToast(
                        context: _, fToast: FToast().init(_), title: "Impossible d'ouvrir la boite mail");
                  }
                },
                prefix: Center(
                  child: SvgPicture.asset("assets/svg/ic_help.svg"),
                ),
              ),
            ),
            SettingsNode(
              tag: 'share',
              type: SettingsType.custom,
              data: SettingsData(
                title: "app.settings.share.title",
                subTitle: "app.settings.share.desc",
                onTap: (_, __) {
                  Share.share(
                      'Télécharge Find Your Dresses cette application te permet de réserver un essayage de robe haute couture, conçues par des créateurs. Le lien : https://findyourdresses.page.link/partage',
                      subject: 'Find Your Dresses');
                },
                prefix: Center(
                  child: SvgPicture.asset("assets/svg/ic_share.svg"),
                ),
              ),
            ),
          ],
        ),
        dz.Tuple2(
          "app.settings.link-title",
          [
            SettingsNode(
              tag: 'confidentiality',
              type: SettingsType.link,
              data: SettingsData(
                title: "app.settings.confidentiality",
                onTap: (ctx, ref) {
                  AutoRouter.of(ctx).navigate(LegalDocRoute(type: LegalDoc.privacyPolicy));
                },
              ),
            ),
            SettingsNode(
              tag: 'cgvu',
              type: SettingsType.link,
              data: SettingsData(
                title: "app.settings.cgvu",
                onTap: (ctx, ref) {
                  AutoRouter.of(ctx).navigate(LegalDocRoute(type: LegalDoc.termsOfUse));
                },
              ),
            ),
            SettingsNode(
              tag: 'legal-notice',
              type: SettingsType.link,
              data: SettingsData(
                title: "app.settings.legal-notice",
                onTap: (ctx, ref) {
                  AutoRouter.of(ctx).navigate(LegalDocRoute(type: LegalDoc.legalNotice));
                },
              ),
            ),
          ],
        ),
        dz.Tuple2(
          "app.settings.social-title",
          [
            SettingsNode(
              tag: 'instagram',
              type: SettingsType.instagram,
              data: SettingsData(
                onTap: (ctx, ref) {
                  launchUrl(Uri.parse('https://instagram.com/find_your_dresses?igshid=YmMyMTA2M2Y='));
                },
              ),
            ),
            SettingsNode(
              tag: 'tiktok',
              type: SettingsType.custom,
              data: SettingsData(
                title: "Notre TikTok",
                prefix: Image.asset("assets/images/img_tiktok.png"),
                onTap: (ctx, ref) {
                  launchUrl(Uri.parse('https://www.tiktok.com/@findyourdresses?_t=8azMj38Zx3N&_r=1'));
                },
              ),
            ),
            SettingsNode(
              tag: 'snapchat',
              type: SettingsType.custom,
              data: SettingsData(
                title: "Notre Youtube",
                prefix: Image.asset("assets/images/img_youtube.png"),
                onTap: (ctx, ref) {
                  launchUrl(Uri.parse('https://youtube.com/@findyourdresses'));
                },
              ),
            ),
            SettingsNode(
              tag: 'facebook',
              type: SettingsType.facebook,
              data: SettingsData(
                onTap: (ctx, ref) {
                  https: //www.facebook.com/findyourdress
                  launchUrl(Uri.parse('https://www.facebook.com/findyourdress'));
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );

  await LaunchApplication.launch(
    applicationModel: appModel,
    appRouter: AppRouter(
      alreadyLoggedGuardCustom: AlreadyLoggedGuardCustom(),
      logoutGuard: LogoutGuard(),
      // fydLoginGuard: FydLoginGuard(),
      onboardingGuardCustom: OnboardingGuardCustom(),
    ),
    initTheme: initTheme,
  );
  // await FirebaseAuth.instance.signOut();
  return;
}
