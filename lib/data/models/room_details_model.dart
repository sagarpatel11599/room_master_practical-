import 'package:flutter/material.dart';
import 'package:room_master/data/models/guest_details_model.dart';

class RoomDetailsModel {
  int mnRoomId;
  String msRoomName;
  TextEditingController mcAdultTextEditingCntrl;
  TextEditingController mcChildTextEditingCntrl;
  GlobalKey<FormState> mcFormKey;
  List<GuestDetailsModel>? mlGuestDetailsModelList = [];
  RoomDetailsModel(
      { required this.mnRoomId,
        required this.msRoomName,
        required this.mcAdultTextEditingCntrl,
        required this.mcChildTextEditingCntrl,
        required this.mcFormKey,
        this.mlGuestDetailsModelList
      });
}