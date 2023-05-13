import 'package:flutter/material.dart';
import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/models/pokemon_model.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokmonWidget extends StatefulWidget{
  Results item;
  PokmonWidget({this.item});
  @override
  State<PokmonWidget> createState() => _PokmonWidgetState();
}

class _PokmonWidgetState extends State<PokmonWidget> {
  bool isimage=true;
  @override
  Widget build(BuildContext context) {
     return Container(
       height: MediaQuery.of(context).size.height/7,
       margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30),vertical: ScreenUtil().setWidth(30) ),


       decoration: BoxDecoration(
         color: Colors.white,
       borderRadius: BorderRadius.circular(10),
         // border: Border.all(
         //   color: locator<AppThemeColors>().,
         // ),
       boxShadow: [
         BoxShadow(
           color: Colors.grey.withOpacity(0.9),
           spreadRadius: 2,
           blurRadius: 5,
           offset: Offset(0, 3),
         ),
       ],
     ),
       child: Row(
         children: [
           Flexible(flex: 2,child:Container(
            // padding:EdgeInsetsDirectional.only(start:  ScreenUtil().setWidth(30)) ,

             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               shape: BoxShape.rectangle,
               image: DecorationImage(
                 image: AssetImage("lib/assets/placeholder.jpg"),
                 fit: BoxFit.cover,
               ),
             ),
           )),
           Flexible(flex: 4,child: Container(alignment: Alignment.topCenter,  padding:EdgeInsetsDirectional.only(top:  ScreenUtil().setWidth(30)) ,child: Text(widget.item.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),))
         ],
       ),
     );
  }
}