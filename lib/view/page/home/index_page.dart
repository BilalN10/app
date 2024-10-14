import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/form/product_form_provider.dart';
import 'package:findyourdresse_app/provider/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class IndexPage extends ConsumerStatefulWidget {
  const IndexPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends ConsumerState<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: MediaQuery.of(context).padding.top),4
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: AutoRouter(),
                      ),
                      sh(0),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomBar(context),
                )
              ],
            ),
          ),
        ],
      ),

      // child: Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     const Expanded(child: AutoRouter()),
      //     _buildBottomBar(context),
      //   ],
      // ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            sh(27.5),
            Container(
              height: MediaQuery.of(context).padding.bottom + formatHeight(65),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.04),
                    blurRadius: 30,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: formatWidth(14)),
              child: ClipRRect(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBottomBarItem(context, tag: "home", iconName: "home"),
                    _buildBottomBarItem(context, tag: "fitting", iconName: "notification"),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (FirebaseAuth.instance.currentUser != null) ...[
          if (ref.watch(userChangeNotifierProvider).userData != null &&
              (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type != "ProfilType.particular") ...[
            Positioned(
              top: 0,
              width: formatWidth(55),
              height: formatHeight(55),
              child: InkWell(
                child: Container(
                  height: formatWidth(47),
                  width: formatWidth(47),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: const Alignment(-2.0, -2.0),
                          end: const Alignment(0.0, 0.0),
                          colors: [AppColor.linearFirst, AppColor.linearSecond, AppColor.linearThird, AppColor.linearFour])),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(color: Colors.white, fontSize: sp(38), fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                onTap: () async {
                  // check if platform is Android or iOS
                  // if (Platform.isAndroid) {
                  //   AutoRouter.of(context).navigateNamed("/dashboard/picture/form");
                  //   return;
                  // }

                  if ((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type == 'ProfilType.creator' && (ref.watch(userChangeNotifierProvider).userData as UserModelFyd).premium == true) {
                    ref.read(productFormProvider).clear();
                    AutoRouter.of(context).navigateNamed("/dashboard/product/form");
                  } else if ((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type == 'ProfilType.model' &&
                      (ref.watch(userChangeNotifierProvider).userData as UserModelFyd).premium == true) {
                    AutoRouter.of(context).navigateNamed("/dashboard/picture/form");
                  } else if ((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).premium == null || (ref.watch(userChangeNotifierProvider).userData as UserModelFyd).premium == false) {
                    AutoRouter.of(context).navigateNamed("/dashboard/subscription");
                  } else {
                    AutoRouter.of(context).navigateNamed("/dashboard/login");
                  }
                },
              ),
            ),
          ],
        ]
        // else ...[
        //   Positioned(
        //     top: 0,
        //     width: formatWidth(55),
        //     height: formatHeight(55),
        //     child: InkWell(
        //       child: Container(
        //         height: formatWidth(47),
        //         width: formatWidth(47),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             gradient: LinearGradient(
        //                 begin: const Alignment(-2.0, -2.0),
        //                 end: const Alignment(0.0, 0.0),
        //                 colors: [AppColor.linearFirst, AppColor.linearSecond, AppColor.linearThird, AppColor.linearFour])),
        //         child: Center(
        //           child: Text(
        //             "+",
        //             style: TextStyle(color: Colors.white, fontSize: sp(38), fontWeight: FontWeight.w300),
        //           ),
        //         ),
        //       ),
        //       onTap: () async {
        //         AutoRouter.of(context).navigateNamed("/login");
        //       },
        //     ),
        //   ),
        // ]
      ],
    );
  }

  Widget _buildBottomBarItem(
    BuildContext context, {
    required String tag,
    required String iconName,
    VoidCallback? onTap,
  }) {
    final isActive = ref.watch(navigationProvider) == tag;

    return Expanded(
      child: InkWell(
        onTap: () => onTap != null
            ? onTap.call()
            : () {
                AutoRouter.of(context).navigateNamed("/dashboard/index/$tag");
                ref.read(navigationProvider.notifier).update(tag);
              }.call(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/svg/$iconName${isActive ? "_active" : "_inactive"}.svg",
                      ),
                    ),
                    // Text(
                    //   iconName,
                    //   style: TextStyle(fontSize: sp(6), color: isActive ? AppColor.peach : Colors.black),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}




  // Widget _buildBottomBar(BuildContext context) {
  //   return Container(
  //     height: MediaQuery.of(context).padding.bottom + formatHeight(77),
  //     width: double.infinity,
  //     decoration: ref.watch(navigationProvider) == "home"
  //         ? BoxDecoration(
  //             border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withOpacity(.25))),
  //             color: Colors.white.withOpacity(.08))
  //         : const BoxDecoration(color: Colors.transparent),
  //     padding: EdgeInsets.symmetric(horizontal: formatWidth(14)),
  //     child: ClipRRect(
  //       child: BackdropFilter(
  //         filter: ref.watch(navigationProvider) == "home"
  //             ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
  //             : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             _buildBottomBarItem(context, tag: "home", iconName: "home"),
  //             _buildBottomBarItem(context, tag: "notification", iconName: "notification"),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   Widget _buildBottomBarItem(
//     BuildContext context, {
//     required String tag,
//     required String iconName,
//     VoidCallback? onTap,
//   }) {
//     final isActive = ref.watch(navigationProvider) == tag;

//     return Expanded(
//       child: InkWell(
//         onTap: () => onTap != null
//             ? onTap.call()
//             : () {
//                 AutoRouter.of(context).navigateNamed("/dashboard/index/$tag");
//                 ref.read(navigationProvider.notifier).update(tag);
//               }.call(),
//         child: Center(
//           child: SvgPicture.asset(
//             "assets/svg/$iconName${isActive ? "_active" : "_inactive"}.svg",
//           ),
//         ),
//       ),
//     );
//   }
// }
