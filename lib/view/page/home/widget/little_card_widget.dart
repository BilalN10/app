import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/utils/enum.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class LittleCardWidget extends ConsumerStatefulWidget {
  final String image;
  final FileType mediaType;
  final String ownerId;
  const LittleCardWidget({
    super.key,
    required this.image,
    required this.mediaType,
    required this.ownerId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LittleCardWidgetState();
}

class _LittleCardWidgetState extends ConsumerState<LittleCardWidget> {
  @override
  Widget build(BuildContext context) {
    UserModelFyd? owner = ref.watch(userModelProvider).getModelById(widget.ownerId);
    return owner != null
        ? Stack(
            children: [
              Container(
                height: formatHeight(188),
                width: formatWidth(144),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  image: DecorationImage(image: CachedNetworkImageProvider(widget.image), fit: BoxFit.cover),
                ),
                child: Column(children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    constraints: BoxConstraints(minHeight: formatHeight(52)),
                    decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(2.r))),
                    clipBehavior: Clip.hardEdge,
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 15.0, tileMode: TileMode.mirror),
                        child: Row(
                          children: [
                            owner.profilImage == null
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
                                : CircleAvatar(
                                    radius: 15.r,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: CachedNetworkImageProvider(
                                      owner.profilImage!,
                                    ),
                                  ),
                            sw(11),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: owner.location != null && owner.location!.city != null
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                Text(
                                    owner.id == FirebaseAuth.instance.currentUser?.uid
                                        ? "Moi"
                                        : owner.firstname! + ' ' + owner.lastname!,
                                    style: AppThemeStyle.littleCardTitle),
                                owner.location != null && owner.location!.city != null
                                    ? Text(owner.location!.city!,
                                        style: AppThemeStyle.littleCardSubTitle, overflow: TextOverflow.ellipsis)
                                    : const SizedBox(),
                              ],
                            ))
                          ],
                        )),
                  )
                ]),
              ),
              widget.mediaType == FileType.video
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Icon(Icons.play_arrow, color: Colors.white, size: 30.sp),
                    )
                  : const SizedBox(),
            ],
          )
        : Shimmer(
            child: Container(
              height: formatHeight(188),
              width: formatWidth(144),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                color: Colors.white,
              ),
            ),
            gradient: LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Colors.grey.shade100, Colors.grey]));
  }
}
