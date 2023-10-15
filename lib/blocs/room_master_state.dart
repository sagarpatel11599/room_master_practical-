part of 'room_master_bloc.dart';

@immutable
abstract class RoomMasterState {}

class RoomMasterInitial extends RoomMasterState {}

class ChangeRoomNoState extends RoomMasterState {}

class AddGuestDetailsState extends RoomMasterState {}

class ValidateAndSubmitState extends RoomMasterState {}

class GuestDetailsEmptyErrorState extends RoomMasterState {
  final int mnGuestDataErrorIndex;
  GuestDetailsEmptyErrorState({required this.mnGuestDataErrorIndex});
}
