import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_kosmos/core_package.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/search_provider.dart';
import 'package:findyourdresse_app/view/page/search/widget/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ui_kosmos_v4/cta/cta.dart';

import '../../../model/_enum/tag_enum.dart';

class SearchPage extends ConsumerStatefulWidget {
  final String tag;
  const SearchPage({super.key, @PathParam('tag') required this.tag});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(formatWidth(27), formatHeight(51), formatWidth(27), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Text(
                    'home-page.search-title'.tr(),
                    style: TextStyle(color: Colors.black, fontSize: sp(17), fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                Transform.translate(
                  offset: Offset(-formatWidth(15), 0),
                  child: CTA.back(
                    backgroundColor: Colors.transparent,
                    onTap: () {
                      ref.read(searchProvider).clear();
                      AutoRouter.of(context).navigateBack();
                    },
                  ),
                ),
              ],
            ),
          ),
          sh(30),
          SearchBarWidget(
            type: widget.tag,
          ),
          sh(12),
          if (widget.tag == TagEnum.model.label) ...[
            Text(
              () {
                var tmp = ref.watch(searchProvider).listModelLength;
                return tmp.toString() + ' ' + (tmp > 1 ? 'utils.models'.tr() : 'utils.model'.tr());
              }(),
              style: TextStyle(
                  color: Colors.black, fontSize: sp(16), fontWeight: FontWeight.w500, fontFamily: "PlayfairDisplay"),
            ),
          ],
          sh(11),
          Expanded(
            child: widget.tag == TagEnum.model.label
                ? ref.watch(searchProvider).listModel.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        clipBehavior: Clip.hardEdge,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return InkWell(
                              onTap: () {
                                AutoRouter.of(context).navigateNamed(
                                    "/dashboard/profil/model/${ref.watch(searchProvider).listModel[index].id}");
                              },
                              child: _resultModelCard(ref.watch(searchProvider).listModel[index]));
                        }),
                        separatorBuilder: ((context, index) => Container(
                              margin: EdgeInsets.symmetric(vertical: formatHeight(5)),
                              child: Divider(
                                indent: formatWidth(50),
                              ),
                            )),
                        itemCount: ref.watch(searchProvider).listModel.length,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '😕',
                            style: TextStyle(
                              fontSize: sp(24),
                            ),
                          ),
                          Text(
                            "utils.no-result".tr(),
                            style: AppThemeStyle.resultTitle,
                          ),
                          Text(
                            widget.tag == TagEnum.model.label ? 'utils.search-model'.tr() : 'utils.search-product'.tr(),
                            style: AppThemeStyle.detailSubtitle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                : ref.watch(searchProvider).listShop.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        clipBehavior: Clip.hardEdge,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return InkWell(
                              onTap: () {
                                AutoRouter.of(context).navigateNamed(
                                    "/dashboard/profil/creator/${ref.watch(searchProvider).listShop[index].id}");
                              },
                              child: _resultProductCard(ref.watch(searchProvider).listShop[index]));
                        }),
                        separatorBuilder: ((context, index) => sh(6)),
                        itemCount: ref.watch(searchProvider).listShopLength,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '😕',
                            style: TextStyle(
                              fontSize: sp(24),
                            ),
                          ),
                          Text(
                            "utils.no-result".tr(),
                            style: AppThemeStyle.resultTitle,
                          ),
                          Text(
                            widget.tag == TagEnum.model.label ? 'utils.search-model'.tr() : 'utils.search-product'.tr(),
                            style: AppThemeStyle.detailSubtitle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget _resultModelCard(e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            e.profilImage == null
                ? CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: const AssetImage(
                      "assets/images/img_user_profil.png",
                      package: "skeleton_kosmos",
                    ))
                : CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(e.profilImage),
                  ),
            sw(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.firstname + ' ' + e.lastname,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: sp(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '@' + e.nickname,
                  style: AppThemeStyle.subtitle,
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/svg/arrow_right_inc.svg',
              color: AppColor.cardSubtitle,
            )
          ],
        ),
      ],
    );
  }

  Widget _resultProductCard(UserModelFyd shop) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(13)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.04),
            offset: const Offset(0, 10),
            blurRadius: 30,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shop.profilImage == null
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
                      backgroundColor: Colors.transparent,
                      backgroundImage: CachedNetworkImageProvider(shop.profilImage!),
                    ),
              sw(15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.shopNickname!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: sp(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(shop.location!.city!, style: AppThemeStyle.subtitle),
                    sh(11),
                    Text(
                      shop.description ?? '',
                      style: AppThemeStyle.productCardDescription,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
          sh(14),
          Text(
            'title.see-reserve'.tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: sp(12),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
