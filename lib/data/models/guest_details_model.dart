import 'package:flutter/material.dart';
import 'package:room_master/data/enums/guest_type_enum.dart';

class GuestDetailsModel{
  GuestType? meGuestType;
  TextEditingController? mcGuestNameTextEditingCntrl;
  TextEditingController? mcGuestAgeTextEditingCntrl;
  //GlobalKey<FormState>? mcFormKey;
  GuestDetailsModel(
      {
        required this.meGuestType,
        required this.mcGuestAgeTextEditingCntrl,
        required this.mcGuestNameTextEditingCntrl,
        // required this.mcFormKey
      });
}