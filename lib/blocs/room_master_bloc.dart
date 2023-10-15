import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:room_master/data/enums/guest_type_enum.dart';
import 'package:room_master/data/models/guest_details_model.dart';
import 'package:room_master/data/models/room_details_model.dart';

part 'room_master_event.dart';
part 'room_master_state.dart';

class RoomMasterBloc extends Bloc<RoomMasterEvent, RoomMasterState> {

  List<int> mlDropDownItem = [1,2,3,4,5];
  int mnSelectedItem =-1;
  List<RoomDetailsModel> mlRoomDetailsModelList = [];
  GlobalKey<FormState> mcGuestValidateFormKey = GlobalKey<FormState>();
  int mnGuestDataErrorIndex =-1;

  RoomMasterBloc() : super(RoomMasterInitial()) {
    on<RoomMasterEvent>((event, emit) {
     });

    on<ChangeRoomNoEvent>((event, emit) {
      changeNoOfRoomFun(emit);
    });

    on<AddGuestDetailsEvent>((event, emit) {
      if(mnGuestDataErrorIndex == event.index) {mnGuestDataErrorIndex =-1 ;}
      mlRoomDetailsModelList[event.index].mlGuestDetailsModelList?.clear();
      addGuestDetailsFormFun(event.index,event.adultCnt,GuestType.Adult);
      addGuestDetailsFormFun(event.index,event.childCnt,GuestType.Child);
      emit(AddGuestDetailsState());
    });

    on<ValidateAndSubmitEvent>((event,emit){
      _validateRoomDataAndSubmit(event,emit);
    });
  }

  changeNoOfRoomFun(Emitter<RoomMasterState> emit){
    mlRoomDetailsModelList.clear();
    mnGuestDataErrorIndex =-1;
    for(int i=1;i<=mnSelectedItem;i++){
      mlRoomDetailsModelList.add(
          RoomDetailsModel(mnRoomId: i,msRoomName:'Room $i',
              mcAdultTextEditingCntrl: TextEditingController(),
              mcChildTextEditingCntrl: TextEditingController(),
              mcFormKey: GlobalKey<FormState>(),
              mlGuestDetailsModelList: []
          )
      );
    }
    emit(ChangeRoomNoState());
  }

  addGuestDetailsFormFun(int pnParentIndex,int pnGuestCnt,peGuestType){
    for(int i=1;i<=pnGuestCnt;i++){
      mlRoomDetailsModelList[pnParentIndex].mlGuestDetailsModelList!.add(
          GuestDetailsModel(
            meGuestType: peGuestType,
            mcGuestAgeTextEditingCntrl: TextEditingController(),
            mcGuestNameTextEditingCntrl: TextEditingController(),
          )
      );
    }
    mlRoomDetailsModelList[pnParentIndex].mlGuestDetailsModelList!.sort((a,b)=>a.meGuestType!.name.compareTo(b.meGuestType!.name));
  }

  _validateRoomDataAndSubmit(RoomMasterEvent event, Emitter<RoomMasterState> emit){


    bool isParentForm = mlRoomDetailsModelList.every((element) {

      if(element.mcFormKey.currentState!.validate()){
        return true;
      }else{return false;}
    } );

    final isValid = mcGuestValidateFormKey.currentState!.validate();
    if (isValid && isParentForm) {
      if(isGuestDataEmptyFun()){
        emit(GuestDetailsEmptyErrorState(mnGuestDataErrorIndex:mnGuestDataErrorIndex));
        return;
      }
      emit(ValidateAndSubmitState());
    }
    mcGuestValidateFormKey.currentState!.save();

  }

  bool isGuestDataEmptyFun(){
    for(int i=0;i<mlRoomDetailsModelList.length;i++){
      if(mlRoomDetailsModelList[i].mlGuestDetailsModelList!.isEmpty){
        mnGuestDataErrorIndex = i;//mlRoomDetailsMasterModelList.indexOf(element);
        return true;
      }
    }
    return false;
  }
}
