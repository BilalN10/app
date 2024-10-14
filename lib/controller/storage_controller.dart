import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/utils/enum.dart' as in_media;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:core_kosmos/core_package.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class StorageController {
  static Future<String> uploadProfilPicture(File file) async {
    late Reference _ref;
    _ref = FirebaseStorage.instance.ref('profilPicture').child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask taskUpload = _ref.putFile(file);
    var task = await taskUpload;
    return await task.ref.getDownloadURL();
  }

  static Future<File?> selectFile() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (result == null) {
      return null;
    } else {
      return File(result.path);
    }
  }

  static Future<Tuple3<XFile, in_media.FileType, Uint8List?>?> selectMedia(BuildContext ctx) async {
    in_media.FileType? _type = await showCupertinoModalPopup<in_media.FileType?>(
      context: ctx,
      builder: (context) => CupertinoActionSheet(
        title: Text(
          "utils.pick-media-type".tr(),
          style: TextStyle(fontSize: 19.sp),
        ),
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              "utils.photo".tr(),
              style: const TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              Navigator.pop(context, in_media.FileType.image);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "utils.video".tr(),
              style: const TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              Navigator.pop(context, in_media.FileType.video);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "utils.cancel".tr(),
            style: const TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
    );
    if (_type != null) {
      PermissionStatus status = await Permission.photos.status;
      if (status.isDenied) {
        await Permission.photos.request();
      } else if (status.isPermanentlyDenied) {
        await showCupertinoDialog(
          context: ctx,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Photos permission'),
              content: const Text('Please accept the Photos permission in settings to select a photo.'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () async {
                    await openAppSettings();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Open app settings'),
                ),
              ],
            );
          },
        );
      }
    }

    XFile? result;
    Uint8List? _thumbnail;
    switch (_type) {
      case in_media.FileType.image:
        result = await ImagePicker().pickImage(source: ImageSource.gallery);
        break;
      case in_media.FileType.video:
        result = await ImagePicker().pickVideo(source: ImageSource.gallery);
        if (result != null) {
          _thumbnail = await VideoThumbnail.thumbnailData(
            video: result.path,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 128,
            quality: 25,
          );
        }
        break;
      case null:
        return null;
    }

    if (result == null) {
      return null;
    } else {
      return Tuple3(result, _type!, _thumbnail);
    }
  }

  static Future<File> fileFromImageUrl(String url, String name) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, name));
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }

  static Future<String?> uploadFile({
    required String refPath,
    File? file,
    PlatformFile? platformFile,
    VoidCallback? whenComplete,
  }) async {
    assert(file != null || platformFile != null, "You must provide a file or a platformFile");
    try {
      final ref = FirebaseStorage.instance.ref("$refPath${file != null ? basename(file.path) : platformFile!.name}");
      UploadTask? task;
      task = file != null ? ref.putFile(file) : ref.putData(platformFile!.bytes!);
      final snapshot = await task.whenComplete(() => whenComplete?.call());
      final url = await snapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      printInDebug("[FirebaseException] $e");
    } catch (e) {
      printInDebug("[Exception] $e");
    }
    return null;
  }
}
