import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/model/_enum/tag_enum.dart';
import 'package:findyourdresse_app/routes/app_router.gr.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:findyourdresse_app/view/page/signalment/signalment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ReportServices {
  static void reportModel(
    BuildContext context, {
    required String modelId,
    String? pictureId,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text("utils.what-do".tr()),
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              "utils.signal-user".tr(),
              style: const TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              Navigator.pop(_);
              // AutoRouter.of(context).navigate(SignalmentRoute(id: id));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignalmentPage(
                          reportType2: ReportType.user,
                          userId: modelId,
                          itemId: pictureId,
                          reportType: pictureId != null ? ReportFrom.reportFromPicture : ReportFrom.reportFromUser)));
              //   reportType2: ReportType.user,)));

              // AutoRouter.of(context).navigate(SignalmentRoute(
              //   reportType: pictureId != null ? ReportFrom.reportFromPicture : ReportFrom.reportFromUser,
              //   reportType2: ReportType.user,
              // ));
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "utils.signal-picture".tr(),
              style: const TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              Navigator.pop(_);
              // AutoRouter.of(context).navigate(SignalmentRoute(id: id));
              // AutoRouter.of(context).navigateNamed('/dashboard/signalment/$modelId');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignalmentPage(
                            reportType: pictureId != null ? ReportFrom.reportFromPicture : ReportFrom.reportFromUser,
                            reportType2: ReportType.picture,
                            userId: modelId,
                            itemId: pictureId,
                          )));
              // AutoRouter.of(context).navigate(SignalmentRoute(
              //   reportType: pictureId != null ? ReportFrom.reportFromPicture : ReportFrom.reportFromUser,
              //   reportType2: ReportType.picture,
              // ));
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("utils.cancel".tr()),
          onPressed: () => Navigator.pop(_, false),
        ),
      ),
    );
  }
}

signalemntCupertino(BuildContext context, ReportFrom tag, String id, String? itemId) async {
  await showCupertinoModalPopup(
    context: context,
    builder: (_) => CupertinoActionSheet(
      title: Text("utils.what-do".tr()),
      actions: [
        CupertinoActionSheetAction(
          child: Text(
            "utils.signal-user".tr(),
            style: const TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            Navigator.pop(_);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignalmentPage(
                          reportType: tag,
                          reportType2: ReportType.user,
                          userId: id,
                          itemId: itemId,
                        )));
          },
        ),
        if (tag == ReportFrom.reportFromProduct)
          CupertinoActionSheetAction(
            child: Text(
              "utils.signal-product".tr(),
              style: const TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              Navigator.pop(_);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignalmentPage(
                            reportType: tag,
                            reportType2: ReportType.product,
                            userId: id,
                            itemId: itemId,
                          )));
            },
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("utils.cancel".tr()),
        onPressed: () => Navigator.pop(_, false),
      ),
    ),
  );
}
