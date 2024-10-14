import 'package:core_kosmos/core_kosmos.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_enum/tag_enum.dart';
import 'package:findyourdresse_app/provider/search_provider.dart';
import 'package:findyourdresse_app/widget/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ui_kosmos_v4/form/form.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  final String type;
  const SearchBarWidget({super.key, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    // _focusNode.requestFocus();
    _controller.text = ref.read(searchProvider).searchText ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormUpdated.classic(
                autoFocus: true,
                radius: 7.r,
                focusNode: _focusNode,
                controller: _controller,
                onChanged: (val) async {
                  ref.read(searchProvider).setSearchText(val);
                  if (widget.type == TagEnum.model.label) {
                    ref.read(searchProvider).getSearchResult(val);
                  } else {
                    ref.read(searchProvider).getSearchProduct(val);
                  }
                },
                hintText: widget.type == TagEnum.model.label
                    ? 'title.search-hint-picture'.tr()
                    : 'title.search-hint-product'.tr(),
                suffixChild: InkWell(
                  onTap: (() {
                    _controller.clear();
                    ref.read(searchProvider).clear();
                  }),
                  child: Padding(
                    padding: EdgeInsets.all(formatHeight(20)),
                    child: _controller.text != ''
                        ? SvgPicture.asset(
                            'assets/svg/inc_close.svg',
                            color: AppColor.subtitle,
                            height: formatHeight(13),
                            width: formatWidth(13),
                          )
                        : const SizedBox(),
                  ),
                ),
                prefixChild: Padding(
                  padding: EdgeInsets.all(formatHeight(14)),
                  child: SvgPicture.asset(
                    'assets/svg/search_inc.svg',
                    color: AppColor.subtitle,
                    height: formatHeight(25),
                    width: formatWidth(25),
                  ),
                ),
              ),
            ),
            if (widget.type != TagEnum.model.label) ...const [
              Padding(padding: EdgeInsets.all(8.0), child: FilterWidget())
            ]
          ],
        ),
      ],
    );
  }
}
