import 'package:cached_network_image/cached_network_image.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/utils/text_with_url.dart';
import '../utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class ProductCardWidget extends ConsumerStatefulWidget {
  final ProductModel productModel;
  final String ownerId;
  const ProductCardWidget({super.key, required this.productModel, required this.ownerId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends ConsumerState<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    UserModelFyd? owner = ref.watch(userModelProvider).getModelById(widget.ownerId);
    return owner != null
        ? Container(
            clipBehavior: Clip.hardEdge,
            height: formatHeight(290),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.04),
                  offset: const Offset(0, 10),
                  blurRadius: 30,
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                    child: CachedNetworkImage(
                  imageUrl: widget.productModel.productMedias![0].fileType == FileType.video
                      ? "https://image.mux.com/${widget.productModel.productMedias![0].playBackId}/thumbnail.png?width=325"
                      : widget.productModel.productMedias![0].url!,
                  fit: BoxFit.cover,
                  memCacheHeight: 450.h.toInt(),
                  memCacheWidth: 325.w.toInt(),
                )),
                Positioned.fill(
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.productModel.price != null) ...[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: formatHeight(12), horizontal: formatWidth(13)),
                            padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(15)),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            child: Text(
                              widget.productModel.price.toString() + ' €',
                              style: AppThemeStyle.productPrice,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                if (widget.productModel.productMedias![0].fileType == FileType.video)
                  Positioned(
                      child: Center(
                          child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 50.r,
                      )),
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 70.h),
                Positioned.fill(
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.scale(
                        scale: 1.002,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: formatWidth(14), vertical: formatHeight(20)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.r),
                                  topRight: Radius.circular(3.r),
                                ),
                                color: Colors.white),
                            clipBehavior: Clip.hardEdge,
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
                                sw(13),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(widget.productModel.name!, style: AppThemeStyle.productCardTitle),
                                      Row(
                                        children: [
                                          Text("@${owner.nickname ?? ''} - ", style: AppThemeStyle.productCardSubtitle),
                                          Timeago(
                                            builder: (context, str) {
                                              return Text(str, style: AppThemeStyle.productCardSubtitle);
                                            },
                                            date: widget.productModel.createdAt!,
                                            locale: "fr",
                                          ),
                                        ],
                                      ),
                                      sh(5),
                                      TextWithUrl(
                                        text: widget.productModel.description!,
                                        style: AppThemeStyle.productCardDescription,
                                        linkStyle: AppThemeStyle.productCardDescription
                                            .copyWith(decoration: TextDecoration.underline, decorationThickness: 1),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const LoaderClassique();
  }
}
