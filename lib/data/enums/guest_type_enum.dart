import 'package:flutter/foundation.dart';

enum GuestType{
  Adult,
  Child
}

extension GuestTypeName on GuestType {
  String get name => describeEnum(this);
}