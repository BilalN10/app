import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

const ACCESS_TOKEN_ID = "94063187-6ecf-4b3c-a07b-985da057a516";
const SECRET_KEY = "0T+vIUEb/bKdS7eFD+Mc2BsEyYxuUlNqpOm+X4ghf6mvq3VHoFXdTgWqVKnsNmuRHiKiPg6KcRr";

final base64Auth = base64.encode(latin1.encode('$ACCESS_TOKEN_ID:$SECRET_KEY'));
final muxHeaders = {
  HttpHeaders.authorizationHeader: 'Basic $base64Auth',
  HttpHeaders.contentTypeHeader: 'application/json',
};

abstract class MuxServices {
  ///value 1 is for assetId
  ///value 2 is for playbackId
  static Future<Tuple2<String, String>?> pubVideoToMux({required File file}) async {
    String? assetId;
    String? playbackId;
    File _file = File(file.path);
    final uploadAsset = await MuxServices.getUploadAsset();
    await MuxServices.uploadFileToUrl(_file, uploadAsset!['url']);
    assetId = await MuxServices.getAssetId(uploadAsset['id']);
    if (assetId != null) {
      playbackId = await MuxServices.getPlaybackId(assetId);
      if (playbackId != null) {
        return Tuple2(assetId, playbackId);
      }
    }
    return null;
  }

  static Future<Map<String, String>?> getUploadAsset() async {
    final client = http.Client();

    final req = await client.post(
      Uri.parse('https://api.mux.com/video/v1/uploads'),
      body: json.encode({
        'new_asset_settings': {
          'playback_policy': ['public'],
        }
      }),
      headers: muxHeaders,
    );

    final res = json.decode(req.body);
    client.close();

    if (res['error'] != null) {
      return null;
    } else {
      return {'url': res['data']['url'], 'id': res['data']['id']};
    }
  }

  static Future<void> uploadFileToUrl(File video, String? url) async {
    final client = http.Client();
    final bytes = await video.readAsBytes();
    await client.put(Uri.parse(url!), body: bytes);
    client.close();
  }

  static Future<String?> getAssetId(String? uploadId) async {
    final client = http.Client();
    final req = await client.get(
      Uri.parse('https://api.mux.com/video/v1/uploads/$uploadId'),
      headers: muxHeaders,
    );

    final res = json.decode(req.body);

    if (res['data']['status'] != 'asset_created') {
      return null;
    } else {
      return res['data']['asset_id'];
    }
  }

  static Future<String?> getPlaybackId(String assetId) async {
    final client = http.Client();
    final req = await client.get(
      Uri.parse('https://api.mux.com/video/v1/assets/$assetId'),
      headers: muxHeaders,
    );

    final res = json.decode(req.body);
    client.close();

    if (res['error'] != null) {
      return null;
    } else {
      return res['data']['playback_ids'][0]['id'];
    }
  }
}
