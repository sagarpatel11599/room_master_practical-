

import 'package:flutter/material.dart';
import 'package:room_master/res/resources.dart';

extension AppContext on BuildContext{
  Resources get res => Resources.of(this);
}