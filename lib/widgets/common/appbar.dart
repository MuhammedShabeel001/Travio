import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:travio/utils/theme.dart';
// import 'package:travio/widgets/profile/profile_body.dart';

DraggableHome ttAppBar(BuildContext context,String title,  body){
  return DraggableHome(

    appBarColor: TTthemeClass().ttLightPrimary,
    title: Text(title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: TTthemeClass().ttLightText,),),
    centerTitle: false,
    headerExpandedHeight: 0.15,
    backgroundColor: TTthemeClass().ttSecondary,
    headerWidget: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30,),
      color: TTthemeClass().ttLightPrimary,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: TTthemeClass().ttLightText,),),
        ],
      ),
    ),

    body: [body,const SizedBox(height: 100,)]);
}