import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/controller/booking_controller.dart';
import 'package:findyourdresse_app/model/booking_model/bookingmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bookingProvider = ChangeNotifierProvider<BookingChangeNotifier>((ref) {
  return BookingChangeNotifier(ref);
});

class BookingChangeNotifier with ChangeNotifier {
  // ignore: unused_field
  final ChangeNotifierProviderRef _ref;

  late List<BookingModel> booking;
  StreamSubscription? bookingStream;

  BookingChangeNotifier(this._ref) {
    booking = [];

    bookingStream = FirebaseFirestore.instance.collection("bookings").snapshots().listen((event) {
      for (final e in event.docChanges) {
        switch (e.type) {
          case DocumentChangeType.added:
            booking.add(BookingModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id));
            break;
          case DocumentChangeType.modified:
            final index = booking.indexWhere((element) => element.id == e.doc.id);
            if (index == -1) return;
            booking[index] = BookingModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
            break;
          case DocumentChangeType.removed:
            booking.removeWhere((element) => element.id == e.doc.id);
            break;
        }
        notifyListeners();
      }
    });
  }

  List<BookingModel> getBooking() => booking;

  BookingModel? getBookingById(String id) => booking.firstWhereOrNull((element) => element.id == id);

  List<BookingModel> getBookingByOwnerId(String id) => booking.where((element) => element.requestorId == id && element.historic != true).toList();

  List<BookingModel> getHistoricByOwnerId(String id) => booking.where((element) => element.requestorId == id && element.historic == true).toList();

  int getLengthByOwnerId(String id) => getBookingByOwnerId(id).length;

  List<BookingModel> getBookingByCreatorId(String id) => booking.where((element) => element.creatorInfo?.id == id && element.historic != true).toList();

  List<BookingModel> getHistoricgByCreatorId(String id) => booking.where((element) => element.creatorInfo?.id == id && element.historic == true).toList();

  Future<String?> addBooking(BookingModel booking) async {
    return BookingController.addBooking(booking);
  }

  Future<void> updateBooking(BookingModel bookingModel) async {
    print(bookingModel);
    return BookingController.updateBooking(bookingModel);
  }

  Future<void> removeBooking(String bookingId, {bool? isCreator}) async {
    BookingController.removeBooking(bookingId, isCreator: isCreator);
  }
}
