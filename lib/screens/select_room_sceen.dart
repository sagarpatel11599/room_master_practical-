import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_master/blocs/room_master_bloc.dart';
import 'package:room_master/data/enums/guest_type_enum.dart';
import 'package:room_master/data/models/guest_details_model.dart';
import 'package:room_master/data/models/room_details_model.dart';
import 'package:room_master/res/app_context_extension.dart';
import 'package:room_master/screens/custom_widgets/text_form_field_widget.dart';
import 'package:room_master/screens/selected_room_details_screen.dart';

class SelectRoomScreen extends StatefulWidget {
  const SelectRoomScreen({super.key});

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {

  RoomMasterBloc? mcRoomMasterBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: context.res.color.appBarBGColor,
        title: Text(context.res.lableName.selectRoom),
      ),
      body: SingleChildScrollView(
        child: BlocProvider<RoomMasterBloc>(
            create: (context){
              mcRoomMasterBloc = RoomMasterBloc();
              return mcRoomMasterBloc!;
            },
          child:BlocConsumer<RoomMasterBloc,RoomMasterState>(
            listener: (context,state){
              if(state is ValidateAndSubmitState){
                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SelectedRoomDetailsScreen(mlRoomDetailsModelList: mcRoomMasterBloc!.mlRoomDetailsModelList,)));
              }
            },
            builder: (context,state){
              return Container(
                color: context.res.color.lightGreyColor2,
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.res.color.lightGreyColor1,
                        borderRadius: BorderRadius.circular(5),
                      ),

                      child: DropdownButton<int>(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          isExpanded: true,
                          elevation: 4,
                          hint: Text(context.res.lableName.dropDownHintText),
                          value: (mcRoomMasterBloc!.mnSelectedItem ==-1) ? null : mcRoomMasterBloc!.mnSelectedItem,
                          items: mcRoomMasterBloc!.mlDropDownItem.map((item) =>
                              DropdownMenuItem<int>(
                                  value: item,
                                  child: Text("${context.res.lableName.room} $item"))).toList(),
                          onChanged: (int? val){
                            mcRoomMasterBloc!.mnSelectedItem = val!;
                            mcRoomMasterBloc!.add(ChangeRoomNoEvent());
                          }),
                    ),
                    Form(
                      key: mcRoomMasterBloc!.mcGuestValidateFormKey,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: mcRoomMasterBloc!.mlRoomDetailsModelList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            RoomDetailsModel lcmlRoomDetailsMasterModel =mcRoomMasterBloc!.mlRoomDetailsModelList[index];
                            return Container(
                              margin:EdgeInsets.symmetric(vertical: 10,horizontal: 4),
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              decoration: BoxDecoration(
                                color: context.res.color.screenWhiteColor,
                                border:mcRoomMasterBloc!.mnGuestDataErrorIndex ==index ? Border.all(width: 2,color: context.res.color.redColor) : null,
                                borderRadius:const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: context.res.color.darkgreyColor,
                                    blurRadius: 3.0,
                                    offset: const Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 12,top: 5),child: Text(lcmlRoomDetailsMasterModel.msRoomName),)
                                  ],
                                ),
                                Form(
                                  key: lcmlRoomDetailsMasterModel.mcFormKey,
                                  child: SizedBox(
                                    height: 80,
                                    child: Row(children: [
                                      Expanded(flex: 2,child: AppTextFormField(
                                        ctrl: lcmlRoomDetailsMasterModel.mcAdultTextEditingCntrl,
                                        keyboardType: TextInputType.number,
                                        hintText: context.res.lableName.enterAdult,
                                        isNumberOnly: true,
                                        validator: (value){
                                          if (value.isEmpty) {
                                            return context.res.lableName.emptyAdultErrorText;
                                          }
                                          return null;
                                        },
                                      )),
                                      Expanded(flex: 2,child: AppTextFormField(
                                        ctrl: lcmlRoomDetailsMasterModel.mcChildTextEditingCntrl,
                                        keyboardType: TextInputType.number,
                                        isNumberOnly: true,
                                        hintText: context.res.lableName.enterChild,
                                        validator: (value){
                                          if (value.isEmpty) {
                                            return context.res.lableName.emptyChildErrorText;
                                          }
                                          return null;
                                        },
                                      )),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: (){
                                            try{
                                              if (lcmlRoomDetailsMasterModel.mcFormKey.currentState!.validate()) {
                                                int adultCnt = int.parse(lcmlRoomDetailsMasterModel.mcAdultTextEditingCntrl.text);
                                                int childCnt = int.parse(lcmlRoomDetailsMasterModel.mcChildTextEditingCntrl.text);
                                                mcRoomMasterBloc!.add(AddGuestDetailsEvent(index: index,adultCnt:adultCnt,childCnt: childCnt));

                                              }
                                            }catch(e){
                                              print(e);
                                            }

                                          },
                                          child: Container(
                                            height: 40,alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: context.res.color.addBtnColor,
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child: Text(context.res.lableName.addBtn,style: TextStyle(color: context.res.color.screenWhiteColor,fontSize: 15),),
                                          ),
                                        ),
                                      )
                                    ],
                                    ),
                                  ),
                                ),
                                mcRoomMasterBloc!.mnGuestDataErrorIndex ==index ? Text('Please Add Guest Details to proceed more',style: TextStyle(color: Colors.red),maxLines: 2,) :SizedBox.shrink(),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: mcRoomMasterBloc!.mlRoomDetailsModelList[index].mlGuestDetailsModelList?.length ?? 0,
                                    itemBuilder: (context,ind){
                                      GuestDetailsModel? lcGuestDetailsModel = mcRoomMasterBloc!.mlRoomDetailsModelList[index].mlGuestDetailsModelList?[ind];
                                      return Container(
                                        margin: EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                          color: context.res.color.screenWhiteColor,
                                          borderRadius:const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: context.res.color.darkgreyColor,
                                              blurRadius: 3.0,
                                              offset: const Offset(0.0, 3.0),
                                            ),
                                          ],
                                        ),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Padding(padding: EdgeInsets.only(left: 12,top: 7),child: Text(lcGuestDetailsModel?.meGuestType?.name.toString() ?? ""),)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 80,
                                            child: Row(children: [
                                              Expanded(child: AppTextFormField(
                                                ctrl: lcGuestDetailsModel?.mcGuestNameTextEditingCntrl,
                                                keyboardType: TextInputType.name,
                                                isNumberOnly: false,
                                                hintText: context.res.lableName.enterName,
                                                validator: (value){
                                                  if (value.isEmpty) {
                                                    return context.res.lableName.emptyNameErrorText;
                                                  }
                                                  return null;
                                                },
                                              )),
                                              Expanded(child: AppTextFormField(
                                                ctrl: lcGuestDetailsModel?.mcGuestAgeTextEditingCntrl,
                                                keyboardType: TextInputType.number,
                                                isNumberOnly: true,
                                                hintText: context.res.lableName.enterAge,
                                                validator: (value){
                                                  if (value.isEmpty) {
                                                    return context.res.lableName.emptyAgeErrorText;
                                                  }else if(lcGuestDetailsModel?.meGuestType! == GuestType.Adult){
                                                    if (int.parse(value) <= 17){
                                                      return 'Age should be Above 18';
                                                    }
                                                  }
                                                  else if(lcGuestDetailsModel?.meGuestType! == GuestType.Child){
                                                    if (int.parse(value) > 17){
                                                      return 'Age should be Below 18';
                                                    }
                                                  }
                                                  return null;
                                                },
                                              )),
                                            ],
                                            ),
                                          ),
                                        ],),
                                      );
                                    }
                                ),
                              ],),
                            );
                          }),
                    ),

                    InkWell(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        mcRoomMasterBloc!.add(ValidateAndSubmitEvent());
                      },
                      child: Container(
                        height: 40,alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 15,bottom: 10),
                        decoration: BoxDecoration(
                            color: context.res.color.submitBtnColor,
                            borderRadius: BorderRadius.circular(3)
                        ),
                        child: Text(context.res.lableName.submit,style: TextStyle(color: context.res.color.screenWhiteColor,fontSize: 15),),
                      ),
                    ),
                  ],
                ),
              );
        },)
        ),),
    );
  }
}
