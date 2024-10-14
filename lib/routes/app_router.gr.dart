// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:dartz/dartz.dart' as _i35;
import 'package:flutter/material.dart' as _i31;
import 'package:skeleton_kosmos/skeleton_kosmos.dart' as _i1;

import '../legalDoc/legal_doc.dart' as _i2;
import '../legalDoc/static_doc.dart' as _i34;
import '../model/notification_fyd/notificationfydmodel.dart' as _i38;
import '../model/product_model/productmodel.dart' as _i37;
import '../utils/enum.dart' as _i36;
import '../view/page/home/fitting_page.dart' as _i21;
import '../view/page/home/home_page.dart' as _i20;
import '../view/page/home/index_page.dart' as _i4;
import '../view/page/home_screen_page.dart' as _i3;
import '../view/page/picture/form/create_picture_page.dart' as _i24;
import '../view/page/picture/picture_details_page.dart' as _i23;
import '../view/page/picture/picture_index_page.dart' as _i22;
import '../view/page/picture/picture_router.dart' as _i5;
import '../view/page/product/form/create_product_page.dart' as _i26;
import '../view/page/product/form/fitting_request.dart' as _i8;
import '../view/page/product/product_details_page.dart' as _i25;
import '../view/page/product/product_router.dart' as _i6;
import '../view/page/profil/form/slots/choose_slots.dart' as _i19;
import '../view/page/profil/form/slots/offert_slots.dart' as _i18;
import '../view/page/profil/notification_new_page.dart' as _i17;
import '../view/page/profil/notification_page.dart' as _i29;
import '../view/page/profil/profil_creator_page.dart' as _i28;
import '../view/page/profil/profil_model_page.dart' as _i27;
import '../view/page/profil/profil_router.dart' as _i9;
import '../view/page/search/search_page.dart' as _i10;
import '../view/page/settings/historic/historic_page.dart' as _i16;
import '../view/page/settings/personnal_data/personnal_data_page.dart' as _i11;
import '../view/page/settings/personnal_data/personnal_profil_type_data_page.dart'
    as _i13;
import '../view/page/settings/personnal_data/personnal_profil_type_page.dart'
    as _i12;
import '../view/page/signalment/signalment_page.dart' as _i14;
import '../view/page/subscription/subscription_page.dart' as _i15;
import '../widget/full_carousel_widget.dart' as _i7;
import 'guards/alreadyloggedguard.dart' as _i33;
import 'guards/onboardingguardcustom.dart' as _i32;

class AppRouter extends _i30.RootStackRouter {
  AppRouter({
    _i31.GlobalKey<_i31.NavigatorState>? navigatorKey,
    required this.onboardingGuardCustom,
    required this.alreadyLoggedGuardCustom,
    required this.logoutGuard,
  }) : super(navigatorKey);

  final _i32.OnboardingGuardCustom onboardingGuardCustom;

  final _i33.AlreadyLoggedGuardCustom alreadyLoggedGuardCustom;

  final _i1.LogoutGuard logoutGuard;

  @override
  final Map<String, _i30.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    LegalDocRoute.name: (routeData) {
      final args = routeData.argsAs<LegalDocRouteArgs>();
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LegalDocPage(
          key: args.key,
          type: args.type,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreenPage(),
      );
    },
    LoginWithPhoneRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginWithPhonePage(),
      );
    },
    CreateAccountRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.CreateAccountPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ForgotPasswordPage(),
      );
    },
    LogoutRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LogoutPage(),
      );
    },
    IndexRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.IndexPage(),
      );
    },
    PictureRouter.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.PictureRouter(),
      );
    },
    ProductRouter.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ProductRouter(),
      );
    },
    FullCarouselWidget.name: (routeData) {
      final args = routeData.argsAs<FullCarouselWidgetArgs>();
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.FullCarouselWidget(
          pictures: args.pictures,
          index: args.index,
          key: args.key,
        ),
      );
    },
    FittingRequestRoute.name: (routeData) {
      final args = routeData.argsAs<FittingRequestRouteArgs>();
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.FittingRequestPage(
          key: args.key,
          creatorId: args.creatorId,
          product: args.product,
        ),
      );
    },
    ProfilRouter.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ProfilRouter(),
      );
    },
    SearchRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => SearchRouteArgs(tag: pathParams.getString('tag')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.SearchPage(
          key: args.key,
          tag: args.tag,
        ),
      );
    },
    PersonnalDataRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.PersonnalDataPage(),
      );
    },
    PersonnalProfilTypeRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.PersonnalProfilTypePage(),
      );
    },
    PersonnalProfilTypeDataRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.PersonnalProfilTypeDataPage(),
      );
    },
    SignalmentRoute.name: (routeData) {
      final args = routeData.argsAs<SignalmentRouteArgs>();
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.SignalmentPage(
          key: args.key,
          reportType: args.reportType,
          reportType2: args.reportType2,
          userId: args.userId,
          itemId: args.itemId,
        ),
      );
    },
    SubscriptionRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.SubscriptionPage(),
      );
    },
    HistoricRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.HistoricPage(),
      );
    },
    NotificationNewRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.NotificationNewPage(),
      );
    },
    OfferSlotsRoute.name: (routeData) {
      final args = routeData.argsAs<OfferSlotsRouteArgs>();
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.OfferSlotsPage(
          key: args.key,
          notification: args.notification,
        ),
      );
    },
    ChooseSlotRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseSlotRouteArgs>();
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.ChooseSlotPage(
          key: args.key,
          notification: args.notification,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProfilePage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i30.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i20.HomePage(),
        transitionsBuilder: _i30.TransitionsBuilders.noTransition,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FittingRoute.name: (routeData) {
      return _i30.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i21.FittingPage(),
        transitionsBuilder: _i30.TransitionsBuilders.noTransition,
        opaque: true,
        barrierDismissible: false,
      );
    },
    PictureIndexRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.PictureIndexPage(),
      );
    },
    PictureDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PictureDetailsRouteArgs>(
          orElse: () =>
              PictureDetailsRouteArgs(id: pathParams.getString('id')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i23.PictureDetailsPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    CreatePictureRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CreatePictureRouteArgs>(
          orElse: () => CreatePictureRouteArgs(
              pictureId: queryParams.optString('pictureId')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i24.CreatePicturePage(
          key: args.key,
          pictureId: args.pictureId,
        ),
      );
    },
    ProductDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailsRouteArgs>(
          orElse: () => ProductDetailsRouteArgs(
              productId: pathParams.getString('productId')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i25.ProductDetailsPage(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    CreateProductRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CreateProductRouteArgs>(
          orElse: () => CreateProductRouteArgs(
              productId: queryParams.optString('productId')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i26.CreateProductPage(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ProfilModelRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilModelRouteArgs>(
          orElse: () =>
              ProfilModelRouteArgs(profilId: pathParams.getString('profilId')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i27.ProfilModelPage(
          key: args.key,
          profilId: args.profilId,
        ),
      );
    },
    ProfilCreatorRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilCreatorRouteArgs>(
          orElse: () => ProfilCreatorRouteArgs(
              profilId: pathParams.getString('profilId')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i28.ProfilCreatorPage(
          key: args.key,
          profilId: args.profilId,
        ),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i29.NotificationPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouteArgs>(
          orElse: () => const SettingsRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SettingsPage(key: args.key),
      );
    },
    ResponsiveSettingsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ResponsiveSettingsRouteArgs>(
          orElse: () => ResponsiveSettingsRouteArgs(
              nodeTag: pathParams.getString('nodeTag')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.ResponsiveSettingsPage(
          key: args.key,
          nodeTag: args.nodeTag,
        ),
      );
    },
  };

  @override
  List<_i30.RouteConfig> get routes => [
        _i30.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/dashboard',
          fullMatch: true,
        ),
        _i30.RouteConfig(
          DashboardRoute.name,
          path: '/dashboard',
          guards: [onboardingGuardCustom],
          children: [
            _i30.RouteConfig(
              '#redirect',
              path: '',
              parent: DashboardRoute.name,
              redirectTo: 'index',
              fullMatch: true,
            ),
            _i30.RouteConfig(
              IndexRoute.name,
              path: 'index',
              parent: DashboardRoute.name,
              children: [
                _i30.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: IndexRoute.name,
                  redirectTo: 'home',
                  fullMatch: true,
                ),
                _i30.RouteConfig(
                  HomeRoute.name,
                  path: 'home',
                  parent: IndexRoute.name,
                ),
                _i30.RouteConfig(
                  FittingRoute.name,
                  path: 'fitting',
                  parent: IndexRoute.name,
                ),
              ],
            ),
            _i30.RouteConfig(
              PictureRouter.name,
              path: 'picture',
              parent: DashboardRoute.name,
              children: [
                _i30.RouteConfig(
                  PictureIndexRoute.name,
                  path: 'index',
                  parent: PictureRouter.name,
                ),
                _i30.RouteConfig(
                  PictureDetailsRoute.name,
                  path: 'details/:id',
                  parent: PictureRouter.name,
                ),
                _i30.RouteConfig(
                  CreatePictureRoute.name,
                  path: 'form/',
                  parent: PictureRouter.name,
                ),
              ],
            ),
            _i30.RouteConfig(
              ProductRouter.name,
              path: 'product',
              parent: DashboardRoute.name,
              children: [
                _i30.RouteConfig(
                  ProductDetailsRoute.name,
                  path: 'details/:productId',
                  parent: ProductRouter.name,
                ),
                _i30.RouteConfig(
                  CreateProductRoute.name,
                  path: 'form/',
                  parent: ProductRouter.name,
                ),
              ],
            ),
            _i30.RouteConfig(
              FullCarouselWidget.name,
              path: 'full/carousel',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              FittingRequestRoute.name,
              path: 'request/',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              ProfilRouter.name,
              path: 'profil',
              parent: DashboardRoute.name,
              children: [
                _i30.RouteConfig(
                  ProfilModelRoute.name,
                  path: 'model/:profilId',
                  parent: ProfilRouter.name,
                ),
                _i30.RouteConfig(
                  ProfilCreatorRoute.name,
                  path: 'creator/:profilId',
                  parent: ProfilRouter.name,
                ),
                _i30.RouteConfig(
                  NotificationRoute.name,
                  path: 'notification',
                  parent: ProfilRouter.name,
                ),
              ],
            ),
            _i30.RouteConfig(
              SearchRoute.name,
              path: 'research/:tag',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              PersonnalDataRoute.name,
              path: 'personnaldata',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              PersonnalProfilTypeRoute.name,
              path: 'personnalprofil',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              PersonnalProfilTypeDataRoute.name,
              path: 'personnalprofil/data',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              SignalmentRoute.name,
              path: 'signalment/:id',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              SubscriptionRoute.name,
              path: 'subscription',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              HistoricRoute.name,
              path: 'historic',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              NotificationNewRoute.name,
              path: 'notification/page',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              OfferSlotsRoute.name,
              path: 'slots/offer',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              ChooseSlotRoute.name,
              path: 'slots/choose',
              parent: DashboardRoute.name,
            ),
            _i30.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: DashboardRoute.name,
              children: [
                _i30.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: ProfileRoute.name,
                  redirectTo: 'settings',
                  fullMatch: true,
                ),
                _i30.RouteConfig(
                  SettingsRoute.name,
                  path: 'settings',
                  parent: ProfileRoute.name,
                ),
                _i30.RouteConfig(
                  ResponsiveSettingsRoute.name,
                  path: 'settings/:nodeTag',
                  parent: ProfileRoute.name,
                ),
              ],
            ),
          ],
        ),
        _i30.RouteConfig(
          LegalDocRoute.name,
          path: '/legal',
        ),
        _i30.RouteConfig(
          LoginRoute.name,
          path: '/login',
          guards: [alreadyLoggedGuardCustom],
        ),
        _i30.RouteConfig(
          HomeScreenRoute.name,
          path: '/onboarding',
        ),
        _i30.RouteConfig(
          LoginWithPhoneRoute.name,
          path: '/login-with-phone',
          guards: [alreadyLoggedGuardCustom],
        ),
        _i30.RouteConfig(
          CreateAccountRoute.name,
          path: '/create-account',
          guards: [alreadyLoggedGuardCustom],
        ),
        _i30.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password',
          guards: [alreadyLoggedGuardCustom],
        ),
        _i30.RouteConfig(
          LogoutRoute.name,
          path: '/logout',
          guards: [logoutGuard],
        ),
        _i30.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/dashboard',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i30.PageRouteInfo<void> {
  const DashboardRoute({List<_i30.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          path: '/dashboard',
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i2.LegalDocPage]
class LegalDocRoute extends _i30.PageRouteInfo<LegalDocRouteArgs> {
  LegalDocRoute({
    _i31.Key? key,
    required _i34.LegalDoc type,
  }) : super(
          LegalDocRoute.name,
          path: '/legal',
          args: LegalDocRouteArgs(
            key: key,
            type: type,
          ),
        );

  static const String name = 'LegalDocRoute';
}

class LegalDocRouteArgs {
  const LegalDocRouteArgs({
    this.key,
    required this.type,
  });

  final _i31.Key? key;

  final _i34.LegalDoc type;

  @override
  String toString() {
    return 'LegalDocRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i30.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.HomeScreenPage]
class HomeScreenRoute extends _i30.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: '/onboarding',
        );

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i1.LoginWithPhonePage]
class LoginWithPhoneRoute extends _i30.PageRouteInfo<void> {
  const LoginWithPhoneRoute()
      : super(
          LoginWithPhoneRoute.name,
          path: '/login-with-phone',
        );

  static const String name = 'LoginWithPhoneRoute';
}

/// generated route for
/// [_i1.CreateAccountPage]
class CreateAccountRoute extends _i30.PageRouteInfo<void> {
  const CreateAccountRoute()
      : super(
          CreateAccountRoute.name,
          path: '/create-account',
        );

  static const String name = 'CreateAccountRoute';
}

/// generated route for
/// [_i1.ForgotPasswordPage]
class ForgotPasswordRoute extends _i30.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i1.LogoutPage]
class LogoutRoute extends _i30.PageRouteInfo<void> {
  const LogoutRoute()
      : super(
          LogoutRoute.name,
          path: '/logout',
        );

  static const String name = 'LogoutRoute';
}

/// generated route for
/// [_i4.IndexPage]
class IndexRoute extends _i30.PageRouteInfo<void> {
  const IndexRoute({List<_i30.PageRouteInfo>? children})
      : super(
          IndexRoute.name,
          path: 'index',
          initialChildren: children,
        );

  static const String name = 'IndexRoute';
}

/// generated route for
/// [_i5.PictureRouter]
class PictureRouter extends _i30.PageRouteInfo<void> {
  const PictureRouter({List<_i30.PageRouteInfo>? children})
      : super(
          PictureRouter.name,
          path: 'picture',
          initialChildren: children,
        );

  static const String name = 'PictureRouter';
}

/// generated route for
/// [_i6.ProductRouter]
class ProductRouter extends _i30.PageRouteInfo<void> {
  const ProductRouter({List<_i30.PageRouteInfo>? children})
      : super(
          ProductRouter.name,
          path: 'product',
          initialChildren: children,
        );

  static const String name = 'ProductRouter';
}

/// generated route for
/// [_i7.FullCarouselWidget]
class FullCarouselWidget extends _i30.PageRouteInfo<FullCarouselWidgetArgs> {
  FullCarouselWidget({
    required List<_i35.Tuple3<String, _i36.FileType, String?>> pictures,
    required int index,
    _i31.Key? key,
  }) : super(
          FullCarouselWidget.name,
          path: 'full/carousel',
          args: FullCarouselWidgetArgs(
            pictures: pictures,
            index: index,
            key: key,
          ),
        );

  static const String name = 'FullCarouselWidget';
}

class FullCarouselWidgetArgs {
  const FullCarouselWidgetArgs({
    required this.pictures,
    required this.index,
    this.key,
  });

  final List<_i35.Tuple3<String, _i36.FileType, String?>> pictures;

  final int index;

  final _i31.Key? key;

  @override
  String toString() {
    return 'FullCarouselWidgetArgs{pictures: $pictures, index: $index, key: $key}';
  }
}

/// generated route for
/// [_i8.FittingRequestPage]
class FittingRequestRoute extends _i30.PageRouteInfo<FittingRequestRouteArgs> {
  FittingRequestRoute({
    _i31.Key? key,
    required String? creatorId,
    _i37.ProductModel? product,
  }) : super(
          FittingRequestRoute.name,
          path: 'request/',
          args: FittingRequestRouteArgs(
            key: key,
            creatorId: creatorId,
            product: product,
          ),
        );

  static const String name = 'FittingRequestRoute';
}

class FittingRequestRouteArgs {
  const FittingRequestRouteArgs({
    this.key,
    required this.creatorId,
    this.product,
  });

  final _i31.Key? key;

  final String? creatorId;

  final _i37.ProductModel? product;

  @override
  String toString() {
    return 'FittingRequestRouteArgs{key: $key, creatorId: $creatorId, product: $product}';
  }
}

/// generated route for
/// [_i9.ProfilRouter]
class ProfilRouter extends _i30.PageRouteInfo<void> {
  const ProfilRouter({List<_i30.PageRouteInfo>? children})
      : super(
          ProfilRouter.name,
          path: 'profil',
          initialChildren: children,
        );

  static const String name = 'ProfilRouter';
}

/// generated route for
/// [_i10.SearchPage]
class SearchRoute extends _i30.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i31.Key? key,
    required String tag,
  }) : super(
          SearchRoute.name,
          path: 'research/:tag',
          args: SearchRouteArgs(
            key: key,
            tag: tag,
          ),
          rawPathParams: {'tag': tag},
        );

  static const String name = 'SearchRoute';
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.tag,
  });

  final _i31.Key? key;

  final String tag;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, tag: $tag}';
  }
}

/// generated route for
/// [_i11.PersonnalDataPage]
class PersonnalDataRoute extends _i30.PageRouteInfo<void> {
  const PersonnalDataRoute()
      : super(
          PersonnalDataRoute.name,
          path: 'personnaldata',
        );

  static const String name = 'PersonnalDataRoute';
}

/// generated route for
/// [_i12.PersonnalProfilTypePage]
class PersonnalProfilTypeRoute extends _i30.PageRouteInfo<void> {
  const PersonnalProfilTypeRoute()
      : super(
          PersonnalProfilTypeRoute.name,
          path: 'personnalprofil',
        );

  static const String name = 'PersonnalProfilTypeRoute';
}

/// generated route for
/// [_i13.PersonnalProfilTypeDataPage]
class PersonnalProfilTypeDataRoute extends _i30.PageRouteInfo<void> {
  const PersonnalProfilTypeDataRoute()
      : super(
          PersonnalProfilTypeDataRoute.name,
          path: 'personnalprofil/data',
        );

  static const String name = 'PersonnalProfilTypeDataRoute';
}

/// generated route for
/// [_i14.SignalmentPage]
class SignalmentRoute extends _i30.PageRouteInfo<SignalmentRouteArgs> {
  SignalmentRoute({
    _i31.Key? key,
    required _i14.ReportFrom reportType,
    required _i36.ReportType reportType2,
    required String userId,
    String? itemId,
  }) : super(
          SignalmentRoute.name,
          path: 'signalment/:id',
          args: SignalmentRouteArgs(
            key: key,
            reportType: reportType,
            reportType2: reportType2,
            userId: userId,
            itemId: itemId,
          ),
        );

  static const String name = 'SignalmentRoute';
}

class SignalmentRouteArgs {
  const SignalmentRouteArgs({
    this.key,
    required this.reportType,
    required this.reportType2,
    required this.userId,
    this.itemId,
  });

  final _i31.Key? key;

  final _i14.ReportFrom reportType;

  final _i36.ReportType reportType2;

  final String userId;

  final String? itemId;

  @override
  String toString() {
    return 'SignalmentRouteArgs{key: $key, reportType: $reportType, reportType2: $reportType2, userId: $userId, itemId: $itemId}';
  }
}

/// generated route for
/// [_i15.SubscriptionPage]
class SubscriptionRoute extends _i30.PageRouteInfo<void> {
  const SubscriptionRoute()
      : super(
          SubscriptionRoute.name,
          path: 'subscription',
        );

  static const String name = 'SubscriptionRoute';
}

/// generated route for
/// [_i16.HistoricPage]
class HistoricRoute extends _i30.PageRouteInfo<void> {
  const HistoricRoute()
      : super(
          HistoricRoute.name,
          path: 'historic',
        );

  static const String name = 'HistoricRoute';
}

/// generated route for
/// [_i17.NotificationNewPage]
class NotificationNewRoute extends _i30.PageRouteInfo<void> {
  const NotificationNewRoute()
      : super(
          NotificationNewRoute.name,
          path: 'notification/page',
        );

  static const String name = 'NotificationNewRoute';
}

/// generated route for
/// [_i18.OfferSlotsPage]
class OfferSlotsRoute extends _i30.PageRouteInfo<OfferSlotsRouteArgs> {
  OfferSlotsRoute({
    _i31.Key? key,
    required _i38.NotificationFydModel notification,
  }) : super(
          OfferSlotsRoute.name,
          path: 'slots/offer',
          args: OfferSlotsRouteArgs(
            key: key,
            notification: notification,
          ),
        );

  static const String name = 'OfferSlotsRoute';
}

class OfferSlotsRouteArgs {
  const OfferSlotsRouteArgs({
    this.key,
    required this.notification,
  });

  final _i31.Key? key;

  final _i38.NotificationFydModel notification;

  @override
  String toString() {
    return 'OfferSlotsRouteArgs{key: $key, notification: $notification}';
  }
}

/// generated route for
/// [_i19.ChooseSlotPage]
class ChooseSlotRoute extends _i30.PageRouteInfo<ChooseSlotRouteArgs> {
  ChooseSlotRoute({
    _i31.Key? key,
    required _i38.NotificationFydModel notification,
  }) : super(
          ChooseSlotRoute.name,
          path: 'slots/choose',
          args: ChooseSlotRouteArgs(
            key: key,
            notification: notification,
          ),
        );

  static const String name = 'ChooseSlotRoute';
}

class ChooseSlotRouteArgs {
  const ChooseSlotRouteArgs({
    this.key,
    required this.notification,
  });

  final _i31.Key? key;

  final _i38.NotificationFydModel notification;

  @override
  String toString() {
    return 'ChooseSlotRouteArgs{key: $key, notification: $notification}';
  }
}

/// generated route for
/// [_i1.ProfilePage]
class ProfileRoute extends _i30.PageRouteInfo<void> {
  const ProfileRoute({List<_i30.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i20.HomePage]
class HomeRoute extends _i30.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i21.FittingPage]
class FittingRoute extends _i30.PageRouteInfo<void> {
  const FittingRoute()
      : super(
          FittingRoute.name,
          path: 'fitting',
        );

  static const String name = 'FittingRoute';
}

/// generated route for
/// [_i22.PictureIndexPage]
class PictureIndexRoute extends _i30.PageRouteInfo<void> {
  const PictureIndexRoute()
      : super(
          PictureIndexRoute.name,
          path: 'index',
        );

  static const String name = 'PictureIndexRoute';
}

/// generated route for
/// [_i23.PictureDetailsPage]
class PictureDetailsRoute extends _i30.PageRouteInfo<PictureDetailsRouteArgs> {
  PictureDetailsRoute({
    _i31.Key? key,
    required String id,
  }) : super(
          PictureDetailsRoute.name,
          path: 'details/:id',
          args: PictureDetailsRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'PictureDetailsRoute';
}

class PictureDetailsRouteArgs {
  const PictureDetailsRouteArgs({
    this.key,
    required this.id,
  });

  final _i31.Key? key;

  final String id;

  @override
  String toString() {
    return 'PictureDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i24.CreatePicturePage]
class CreatePictureRoute extends _i30.PageRouteInfo<CreatePictureRouteArgs> {
  CreatePictureRoute({
    _i31.Key? key,
    String? pictureId,
  }) : super(
          CreatePictureRoute.name,
          path: 'form/',
          args: CreatePictureRouteArgs(
            key: key,
            pictureId: pictureId,
          ),
          rawQueryParams: {'pictureId': pictureId},
        );

  static const String name = 'CreatePictureRoute';
}

class CreatePictureRouteArgs {
  const CreatePictureRouteArgs({
    this.key,
    this.pictureId,
  });

  final _i31.Key? key;

  final String? pictureId;

  @override
  String toString() {
    return 'CreatePictureRouteArgs{key: $key, pictureId: $pictureId}';
  }
}

/// generated route for
/// [_i25.ProductDetailsPage]
class ProductDetailsRoute extends _i30.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i31.Key? key,
    required String productId,
  }) : super(
          ProductDetailsRoute.name,
          path: 'details/:productId',
          args: ProductDetailsRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'productId': productId},
        );

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.productId,
  });

  final _i31.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i26.CreateProductPage]
class CreateProductRoute extends _i30.PageRouteInfo<CreateProductRouteArgs> {
  CreateProductRoute({
    _i31.Key? key,
    String? productId,
  }) : super(
          CreateProductRoute.name,
          path: 'form/',
          args: CreateProductRouteArgs(
            key: key,
            productId: productId,
          ),
          rawQueryParams: {'productId': productId},
        );

  static const String name = 'CreateProductRoute';
}

class CreateProductRouteArgs {
  const CreateProductRouteArgs({
    this.key,
    this.productId,
  });

  final _i31.Key? key;

  final String? productId;

  @override
  String toString() {
    return 'CreateProductRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i27.ProfilModelPage]
class ProfilModelRoute extends _i30.PageRouteInfo<ProfilModelRouteArgs> {
  ProfilModelRoute({
    _i31.Key? key,
    required String profilId,
  }) : super(
          ProfilModelRoute.name,
          path: 'model/:profilId',
          args: ProfilModelRouteArgs(
            key: key,
            profilId: profilId,
          ),
          rawPathParams: {'profilId': profilId},
        );

  static const String name = 'ProfilModelRoute';
}

class ProfilModelRouteArgs {
  const ProfilModelRouteArgs({
    this.key,
    required this.profilId,
  });

  final _i31.Key? key;

  final String profilId;

  @override
  String toString() {
    return 'ProfilModelRouteArgs{key: $key, profilId: $profilId}';
  }
}

/// generated route for
/// [_i28.ProfilCreatorPage]
class ProfilCreatorRoute extends _i30.PageRouteInfo<ProfilCreatorRouteArgs> {
  ProfilCreatorRoute({
    _i31.Key? key,
    required String profilId,
  }) : super(
          ProfilCreatorRoute.name,
          path: 'creator/:profilId',
          args: ProfilCreatorRouteArgs(
            key: key,
            profilId: profilId,
          ),
          rawPathParams: {'profilId': profilId},
        );

  static const String name = 'ProfilCreatorRoute';
}

class ProfilCreatorRouteArgs {
  const ProfilCreatorRouteArgs({
    this.key,
    required this.profilId,
  });

  final _i31.Key? key;

  final String profilId;

  @override
  String toString() {
    return 'ProfilCreatorRouteArgs{key: $key, profilId: $profilId}';
  }
}

/// generated route for
/// [_i29.NotificationPage]
class NotificationRoute extends _i30.PageRouteInfo<void> {
  const NotificationRoute()
      : super(
          NotificationRoute.name,
          path: 'notification',
        );

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [_i1.SettingsPage]
class SettingsRoute extends _i30.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({_i31.Key? key})
      : super(
          SettingsRoute.name,
          path: 'settings',
          args: SettingsRouteArgs(key: key),
        );

  static const String name = 'SettingsRoute';
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.ResponsiveSettingsPage]
class ResponsiveSettingsRoute
    extends _i30.PageRouteInfo<ResponsiveSettingsRouteArgs> {
  ResponsiveSettingsRoute({
    _i31.Key? key,
    required String nodeTag,
  }) : super(
          ResponsiveSettingsRoute.name,
          path: 'settings/:nodeTag',
          args: ResponsiveSettingsRouteArgs(
            key: key,
            nodeTag: nodeTag,
          ),
          rawPathParams: {'nodeTag': nodeTag},
        );

  static const String name = 'ResponsiveSettingsRoute';
}

class ResponsiveSettingsRouteArgs {
  const ResponsiveSettingsRouteArgs({
    this.key,
    required this.nodeTag,
  });

  final _i31.Key? key;

  final String nodeTag;

  @override
  String toString() {
    return 'ResponsiveSettingsRouteArgs{key: $key, nodeTag: $nodeTag}';
  }
}
