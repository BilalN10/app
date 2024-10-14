import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/picture_model/picturemodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class PictureCardWidget extends ConsumerStatefulWidget {
  final PictureModel pictureModel;
  final String ownerId;
  const PictureCardWidget({super.key, required this.pictureModel, required this.ownerId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PictureCardWidgetState();
}

class _PictureCardWidgetState extends ConsumerState<PictureCardWidget> {
  @override
  Widget build(BuildContext context) {
    UserModelFyd? owner = ref.watch(userModelProvider).getModelById(widget.ownerId);
    return owner != null
        ? Stack(
            children: [
              Container(
                height: formatHeight(320),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.pictureModel.mediaType == FileType.image
                          ? widget.pictureModel.pictureUrl!
                          : "https://image.mux.com/${widget.pictureModel.playBackId}/thumbnail.png?width=400"),
                      fit: BoxFit.cover),
                ),
                child: Column(children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: formatHeight(83),
                    decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(2.r))),
                    clipBehavior: Clip.hardEdge,
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 15.0, tileMode: TileMode.mirror),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    radius: 20.r,
                                    backgroundImage: CachedNetworkImageProvider(
                                      owner.profilImage!,
                                    ),
                                  ),
                            sw(11),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(owner.firstname! + ' ' + owner.lastname!, style: AppThemeStyle.titleCardTitle),
                                Row(
                                  children: [
                                    Text("@${owner.nickname!} - ", style: AppThemeStyle.cardSubtitle),
                                    Timeago(
                                      builder: (context, str) {
                                        return Text(str, style: AppThemeStyle.cardSubtitle);
                                      },
                                      date: widget.pictureModel.createdAt!,
                                      locale: "fr",
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(top: formatHeight(6)),
                                    width: MediaQuery.of(context).size.width / 1.7,
                                    child: Text(
                                      widget.pictureModel.description!,
                                      style:
                                          TextStyle(color: Colors.white, fontSize: sp(11), fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  )
                ]),
              ),
              widget.pictureModel.mediaType == FileType.video
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 35.sp),
                    )
                  : const SizedBox(),
            ],
          )
        : const LoaderClassique();
  }
}
