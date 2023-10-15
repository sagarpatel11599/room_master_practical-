
import 'package:flutter/material.dart';
import 'package:room_master/data/enums/guest_type_enum.dart';
import 'package:room_master/data/models/guest_details_model.dart';
import 'package:room_master/data/models/room_details_model.dart';
import 'package:room_master/res/app_context_extension.dart';

class SelectedRoomDetailsScreen extends StatelessWidget {
   List<RoomDetailsModel> mlRoomDetailsModelList ;

   SelectedRoomDetailsScreen({super.key,required this.mlRoomDetailsModelList});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor:context.res.color.appBarBGColor,
        title: Text(context.res.lableName.submitTest),
      ),
      body: Container(
        color: context.res.color.lightGreyColor2,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount:mlRoomDetailsModelList.length,
            itemBuilder: (context,index){
              RoomDetailsModel lcmlRoomDetailsMasterModel = mlRoomDetailsModelList[index];
              //int lcAdultCnt =
              var lcGuestcntMap = lcmlRoomDetailsMasterModel.mlGuestDetailsModelList!.
              fold<Map<String,int>>({}, (map, element) {
                map[element.meGuestType!.name] = (map[element.meGuestType!.name] ?? 0) +1;
                return map;
              } );
              print(lcGuestcntMap);
              return  Container(
                margin:EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                  color: context.res.color.screenWhiteColor,
                  borderRadius:const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: context.res.color.darkgreyColor,
                      blurRadius: 4.0,
                      offset: const Offset(0.5, 2.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,children: [

                  Text(lcmlRoomDetailsMasterModel.msRoomName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  Text("Adult : ${lcGuestcntMap[GuestType.Adult.name].toString() ?? 0}"),
                  Text("child : ${lcGuestcntMap[GuestType.Child.name].toString() ?? 0}"),
                  SizedBox(height: 10,),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: lcmlRoomDetailsMasterModel.mlGuestDetailsModelList?.length ??0,
                      itemBuilder: (context,ind){
                        GuestDetailsModel lcGuestDetailsModel = lcmlRoomDetailsMasterModel.mlGuestDetailsModelList![ind];
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          margin:EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                          decoration: BoxDecoration(
                            color: context.res.color.screenWhiteColor,
                            borderRadius:const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: context.res.color.darkgreyColor,
                                blurRadius: 4.0,
                                offset: const Offset(0.5, 2.0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('${ind + 1}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            Text("Name :${lcGuestDetailsModel.mcGuestNameTextEditingCntrl?.text ??''}"),
                            Text("Age :${lcGuestDetailsModel.mcGuestAgeTextEditingCntrl?.text ??''}"),
                          ],),);
                      })

                ],),
              );
            }),
      ),
    );
  }
}
