part of 'room_master_bloc.dart';

@immutable
abstract class RoomMasterEvent {}

class ChangeRoomNoEvent extends RoomMasterEvent {

}

class AddGuestDetailsEvent extends RoomMasterEvent{
  final int index;
  final int adultCnt;
  final int childCnt;
  AddGuestDetailsEvent({required this.index,required this.adultCnt,required this.childCnt});
}
class ValidateAndSubmitEvent extends RoomMasterEvent{

}