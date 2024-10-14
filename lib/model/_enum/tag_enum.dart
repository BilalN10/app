enum TagEnum {
  model,
  product,
}

extension TagEnumExtension on TagEnum {
  String get label {
    switch (this) {
      case TagEnum.model:
        return "model";
      case TagEnum.product:
        return "creator";

      default:
        return '';
    }
  }
}
