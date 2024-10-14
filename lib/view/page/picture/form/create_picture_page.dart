import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/controller/storage_controller.dart';
import 'package:findyourdresse_app/model/picture_model/picturemodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/picture_provider.dart';
import 'package:findyourdresse_app/services/mux_serivces.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class CreatePicturePage extends ConsumerStatefulWidget {
  final String? pictureId;
  const CreatePicturePage({super.key, @QueryParam('pictureId') this.pictureId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePicturePageState();
}

class _CreatePicturePageState extends ConsumerState<CreatePicturePage> {
  final GlobalKey<FormState> _formKeyPicture = GlobalKey<FormState>();
  PictureModel? picture;
  String? description;
  Tuple3<XFile, FileType, Uint8List?>? media;

  bool loading = false;

  @override
  void initState() {
    if (widget.pictureId != null) {
      initPicture();
    }
    super.initState();
  }

  initPicture() {
    setState(() {
      picture = ref.read(pictureProvider).getPictureById(widget.pictureId!)!;
      description = picture?.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: formatWidth(29)),
      color: Colors.white,
      child: Form(
        key: _formKeyPicture,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            sh(55),
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Text(
                      picture == null
                          ? 'title.form-picture-video-title'.tr()
                          : 'title.modification-picture-video-title'.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-formatWidth(19), 0),
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
            sh(45),
            Stack(
              children: [
                Input.image(
                  child: media != null && media!.value2 == FileType.video
                      ? Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 3.h,
                              ).copyWith(left: 5.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.memory(
                                  media!.value3!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30.r),
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0),
                          ],
                        )
                      : null,
                  contentTitle: "title.click-to-pick-picture-video".tr(),
                  updateContentTitle: "title.click-to-update-picture-video".tr(),
                  onTap: () async {
                    Tuple3<XFile, FileType, Uint8List?>? _media = await StorageController.selectMedia(context);
                    if (_media != null) {
                      switch (_media.value2) {
                        case FileType.image:
                          setState(() {
                            media = _media;
                          });
                          break;
                        case FileType.video:
                          setState(() {
                            media = _media;
                          });
                          break;
                        default:
                          break;
                      }
                    }
                  },
                  height: formatHeight(134),
                  contentPadding: const EdgeInsets.fromLTRB(7, 6, 30, 6),
                  fieldName: 'field.picture-video-field'.tr(),
                  iconColor: const Color.fromRGBO(114, 115, 135, 100),
                  imageMobile: media != null
                      ? media!.value2 == FileType.image
                          ? File(media!.value1.path)
                          : null
                      : null,
                  urlImage: picture?.pictureUrl,
                ),
              ],
            ),
            sh(18),
            TextFormUpdated.textarea(
              initialValue: description ?? picture?.description,
              fieldName: 'field.picture-description'.tr(),
              maxCharacter: 150,
              hintText: 'field.picture-description-hint'.tr(),
              validator: (value) {
                setState(() {
                  description = value;
                });
                if (value!.isEmpty) {
                  return 'field.picture-description-validator'.tr();
                } else {
                  return null;
                }
              },
              onChanged: (val) {
                setState(() {
                  description = val;
                });
              },
              maxLine: 5,
            ),
            sh(35),
            CTA.primary(
              loading: loading,
              textButton: widget.pictureId == null ? 'field.picture-create'.tr() : 'field.picture-modify'.tr(),
              onTap: (media == null && widget.pictureId == null) || description == null || description!.isEmpty
                  ? null
                  : () async {
                      setState(() {
                        loading = true;
                      });
                      PictureModel _picture = picture?.copyWith(
                            description: description!,
                          ) ??
                          PictureModel(
                            ownerId: FirebaseAuth.instance.currentUser!.uid,
                            description: description!,
                            createdAt: DateTime.now(),
                            premium: (ref.read(userChangeNotifierProvider).userData as UserModelFyd).premium ?? false,
                          );
                      if (media != null) {
                        switch (media!.value2) {
                          /// Image

                          case FileType.image:
                            var pictureUrl = await StorageController.uploadFile(
                                refPath: "users/${FirebaseAuth.instance.currentUser!.uid}/images/",
                                file: File(media!.value1.path));
                            if (pictureUrl == null) {
                              setState(() {
                                loading = false;
                              });
                              throw 'error.upload-picture-error'.tr();
                            }
                            _picture = _picture.copyWith(pictureUrl: pictureUrl, mediaType: FileType.image);

                            break;

                          ///
                          /// Video
                          ///

                          case FileType.video:
                            Tuple2<String, String>? _muxIds =
                                await MuxServices.pubVideoToMux(file: File(media!.value1.path));
                            if (_muxIds == null) {
                              setState(() {
                                loading = false;
                              });
                              throw 'error.mux-upload-error'.tr();
                            }
                            _picture = _picture.copyWith(
                              mediaType: FileType.video,
                              playBackId: _muxIds.value2,
                              assetId: _muxIds.value1,
                            );
                            break;
                        }
                      }
                      if (widget.pictureId != null) {
                        await ref.read(pictureProvider).updatePicture(_picture);
                      } else {
                        await ref.read(pictureProvider).addPicture(_picture);
                      }
                      await Utils.notifGreen(
                        context,
                        'banner.green-product-title'.tr(),
                        'banner.green-post-subtitle'.tr(),
                      );
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        setState(() {
                          loading = false;
                        });
                        AutoRouter.of(context).navigateBack();
                      });
                    },
            ),
            sh(14),
            Text(
              'signalement.footer'.tr(),
              style: AppThemeStyle.footerSignalenemnt,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
