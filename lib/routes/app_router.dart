import 'package:auto_route/auto_route.dart';
import 'package:findyourdresse_app/legalDoc/legal_doc.dart';
import 'package:findyourdresse_app/routes/guards/fyd_login.dart';
import 'package:findyourdresse_app/routes/guards/onboardingguardcustom.dart';
import 'package:findyourdresse_app/view/page/home/fitting_page.dart';
import 'package:findyourdresse_app/view/page/home/home_page.dart';
import 'package:findyourdresse_app/view/page/picture/form/create_picture_page.dart';
import 'package:findyourdresse_app/view/page/picture/picture_index_page.dart';
import 'package:findyourdresse_app/view/page/home/index_page.dart';
import 'package:findyourdresse_app/view/page/product/form/fitting_request.dart';
import 'package:findyourdresse_app/view/page/profil/form/slots/choose_slots.dart';
import 'package:findyourdresse_app/view/page/profil/form/slots/offert_slots.dart';
import 'package:findyourdresse_app/view/page/profil/notification_new_page.dart';
import 'package:findyourdresse_app/view/page/profil/notification_page.dart';
import 'package:findyourdresse_app/view/page/home_screen_page.dart';
import 'package:findyourdresse_app/view/page/picture/picture_details_page.dart';
import 'package:findyourdresse_app/view/page/picture/picture_router.dart';
import 'package:findyourdresse_app/view/page/product/form/create_product_page.dart';
import 'package:findyourdresse_app/view/page/product/product_details_page.dart';
import 'package:findyourdresse_app/view/page/product/product_router.dart';
import 'package:findyourdresse_app/view/page/profil/profil_creator_page.dart';
import 'package:findyourdresse_app/view/page/profil/profil_model_page.dart';
import 'package:findyourdresse_app/view/page/profil/profil_router.dart';
import 'package:findyourdresse_app/view/page/search/search_page.dart';
import 'package:findyourdresse_app/view/page/settings/historic/historic_page.dart';
import 'package:findyourdresse_app/view/page/settings/personnal_data/personnal_data_page.dart';
import 'package:findyourdresse_app/view/page/settings/personnal_data/personnal_profil_type_data_page.dart';
import 'package:findyourdresse_app/view/page/settings/personnal_data/personnal_profil_type_page.dart';
import 'package:findyourdresse_app/view/page/signalment/signalment_page.dart';
import 'package:findyourdresse_app/view/page/subscription/subscription_page.dart';
import 'package:findyourdresse_app/widget/full_carousel_widget.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import 'guards/alreadyloggedguard.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    // AutoRoute(path: "/home-screen", page: HomeScreenPage, guards: [AlreadyLoggedGuard]),
    AutoRoute(
      path: "/dashboard",
      page: DashboardPage,
      initial: true,
      guards: [OnboardingGuardCustom],
      children: [
        AutoRoute(
          path: "index",
          page: IndexPage,
          initial: true,
          children: [
            CustomRoute(
                path: "home", page: HomePage, transitionsBuilder: TransitionsBuilders.noTransition, initial: true),
            CustomRoute(path: "fitting", page: FittingPage, transitionsBuilder: TransitionsBuilders.noTransition),
          ],
        ),
        AutoRoute(
          path: "picture",
          page: PictureRouter,
          children: [
            AutoRoute(path: "index", page: PictureIndexPage),
            AutoRoute(path: "details/:id", page: PictureDetailsPage),
            AutoRoute(path: "form/", page: CreatePicturePage),
          ],
        ),
        AutoRoute(
          path: "product",
          page: ProductRouter,
          children: [
            AutoRoute(path: "details/:productId", page: ProductDetailsPage),
            AutoRoute(path: "form/", page: CreateProductPage),
          ],
        ),
        AutoRoute(path: "full/carousel", page: FullCarouselWidget),

        AutoRoute(path: 'request/', page: FittingRequestPage),

        AutoRoute(
          path: "profil",
          page: ProfilRouter,
          children: [
            AutoRoute(path: "model/:profilId", page: ProfilModelPage),
            AutoRoute(path: "creator/:profilId", page: ProfilCreatorPage),
            AutoRoute(path: "notification", page: NotificationPage)
          ],
        ),

        AutoRoute(path: "research/:tag", page: SearchPage),
        AutoRoute(path: "personnaldata", page: PersonnalDataPage),
        AutoRoute(path: "personnalprofil", page: PersonnalProfilTypePage),
        AutoRoute(path: "personnalprofil/data", page: PersonnalProfilTypeDataPage),
        AutoRoute(path: "signalment/:id", page: SignalmentPage),
        AutoRoute(path: "subscription", page: SubscriptionPage),
        AutoRoute(path: "historic", page: HistoricPage),
        AutoRoute(path: "notification/page", page: NotificationNewPage),
        AutoRoute(path: "slots/offer", page: OfferSlotsPage),
        AutoRoute(path: "slots/choose", page: ChooseSlotPage),

        // AutoRoute(
        //   path: "research",
        //   page: SearchPage,
        //   children: [
        //     CustomRoute(path: "research/:tag", page: SearchPage, transitionsBuilder: TransitionsBuilders.noTransition),
        //     // CustomRoute(
        //     //     path: "product", page: NotificationPage, transitionsBuilder: TransitionsBuilders.noTransition),
        //   ],
        // ),

        /// Don't modify profile default (settings) page.
        AutoRoute(
          path: "profile",
          page: ProfilePage,
          children: [
            AutoRoute(path: "settings", page: SettingsPage, initial: true),
            AutoRoute(path: "settings/:nodeTag", page: ResponsiveSettingsPage),
          ],
        ),
      ],
    ),
    AutoRoute(path: "/legal", page: LegalDocPage),
    AutoRoute(path: "/login", page: LoginPage, guards: [AlreadyLoggedGuardCustom]),
    AutoRoute(path: "/onboarding", page: HomeScreenPage, initial: true),
    AutoRoute(path: "/login-with-phone", page: LoginWithPhonePage, guards: [AlreadyLoggedGuardCustom]),
    AutoRoute(path: "/create-account", page: CreateAccountPage, guards: [AlreadyLoggedGuardCustom]),
    AutoRoute(path: "/forgot-password", page: ForgotPasswordPage, guards: [AlreadyLoggedGuardCustom]),
    AutoRoute(path: "/logout", page: LogoutPage, guards: [LogoutGuard]),
    RedirectRoute(path: '*', redirectTo: '/dashboard'),
  ],
)
class $AppRouter {
  $AppRouter({
    required LoginGuard loginGuard,
    required AlreadyLoggedGuardCustom alreadyLoggedGuard,
    required LogoutGuard logoutGuard,
  });
}
