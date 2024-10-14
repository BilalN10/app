import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/provider/home_picture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class HomeScreenPage extends StatefulHookConsumerWidget {
  const HomeScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    String? homePicture = ref.watch(homePictureProvider).gethomePicture();
    return Scaffold(
      body: Stack(
        children: [
          if (homePicture != null)
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: CachedNetworkImageProvider(homePicture), fit: BoxFit.cover)),
              ),
            ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: formatHeight(448),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)), color: Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: formatWidth(49)),
                child: Column(
                  children: [
                    sh(35),
                    SvgPicture.asset(
                      "assets/svg/app_logo_gold.svg",
                      height: formatHeight(54),
                    ),
                    sh(12),
                    Text('home-screen.title'.tr(), style: AppThemeStyle.homeScreenTitle),
                    Text(
                      'home-screen.subtitle'.tr(),
                      style: AppThemeStyle.homeScreenSubTitle,
                      textAlign: TextAlign.center,
                    ),
                    sh(29),
                    CTA.primary(
                      textButton: 'home-screen.first-button'.tr(),
                      onTap: () {
                        CustomSharedPreferences.instance.setBooleanValue("alreadyRun", true);
                        AutoRouter.of(context).replaceNamed("/dashboard/index/home");
                      },
                    ),
                    sh(9),
                    CTA.secondary(
                      textButton: 'home-screen.second-button'.tr(),
                      onTap: () {
                        CustomSharedPreferences.instance.setBooleanValue("alreadyRun", true);

                        AutoRouter.of(context).navigateNamed("/login");
                      },
                    ),
                    sh(9),
                    CTA.secondary(
                      textButton: 'home-screen.third-button'.tr(),
                      onTap: () {
                        CustomSharedPreferences.instance.setBooleanValue("alreadyRun", true);

                        AutoRouter.of(context).navigateNamed("/login");
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
