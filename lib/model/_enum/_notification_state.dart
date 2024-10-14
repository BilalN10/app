enum NotificationState {
  request,
  propose,
  cancel,
  accept,
  newRequest,
  //
  none,
  validate,
  decline,
  slotRequest,
  offertSlot,
  creatorDecline,
}

extension NotificationStateExtension on NotificationState {
  String get label {
    switch (this) {
      case NotificationState.none:
        return "envoyé";
      case NotificationState.validate:
        return "accepté";
      case NotificationState.decline:
        return "refusé";
      case NotificationState.slotRequest:
        return "slotRequest";
      case NotificationState.offertSlot:
        return "offerSlot";
      default:
        return '';
    }
  }
}
