import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/provider/notification_manage_provider.dart';
import 'package:findyourdresse_app/routes/app_router.gr.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class BookingWidget extends ConsumerStatefulWidget {
  final String creatorId;
  final ProductModel? product;
  const BookingWidget({Key? key, required this.creatorId, this.product}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends ConsumerState<BookingWidget> {
  final formatDate = DateFormat("'Le' dd/MM/y 'à' HH'h'mm");
  DateTime? bookingDate;

  @override
  Widget build(BuildContext context) {
    return CTA.primary(
        textButton: widget.product != null ? 'title.book-a-product'.tr() : 'title.book-product'.tr(),
        onTap: () async {
          if (FirebaseAuth.instance.currentUser != null) {
            AutoRouter.of(context).navigate(FittingRequestRoute(creatorId: widget.creatorId, product: widget.product));
          } else {
            AutoRouter.of(context).navigateNamed('/login');
          }
          return;
        });
  }
}
