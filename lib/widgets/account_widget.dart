import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';


class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color:  Color(0xFFFFFDF6),
      padding: EdgeInsets.only(left:Dimensions.width20,
      top: Dimensions.width10,
      bottom: Dimensions.height10
    ),
    child: Row(
      children: [
        appIcon,
        SizedBox(width: Dimensions.width20,),
        bigText
      ],),
      decoration: BoxDecoration(
        color:  Color(0xFFFFFDF6),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,2),
            color:Colors.grey.withOpacity(0.2),
           )
          
      
      ],
    ),);
  }
}