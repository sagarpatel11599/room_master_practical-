import 'package:flutter/cupertino.dart';
import 'package:room_master/res/colors/app_colors.dart';
import 'package:room_master/res/strings/app_strings.dart';

class Resources{
  final BuildContext _context;
   Resources(this._context);

  static Resources of(BuildContext context){
    return Resources(context);
  }

  AppColors get color{
    return AppColors();
  }

  AppStrings get lableName{
    return AppStrings();
  }


}