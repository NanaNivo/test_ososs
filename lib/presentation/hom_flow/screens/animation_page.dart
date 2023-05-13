import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ososs/presentation/custom_widgets/text_translation.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/state_home.dart';

class AnimationPage extends StatefulWidget
{
  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
 // int _changeShape = 0;
  final homeBloc = locator<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
          bloc: homeBloc,
          builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     // mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child:
                       TextTranslation(
                      state.valueChanged ?? "", withTranslation: false,
                      style: TextStyle(fontSize: 20),),

              ),

              GestureDetector(
                // onTap: () {
                //  homeBloc.shangeShape(0);
                // },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 300,
                  width: 300,

                  decoration: BoxDecoration(
                    color:state.shapeChanged==0 ?locator<AppThemeColors>().primaryColor:state.shapeChanged==1?locator<AppThemeColors>().lightblue:locator<AppThemeColors>().redColor,
                    shape:  BoxShape.rectangle ,
                    borderRadius: state.shapeChanged==0 ? BorderRadius.circular(0) :state.shapeChanged==1?  BorderRadius.circular(50):BorderRadius.circular(150)
                  ),

                ),

              ),
              SizedBox(height: ScreenUtil().setHeight(200),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               // crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisSize: MainAxisSize.max,
                children: [

                FlatButton(
                    minWidth: ScreenUtil().setHeight(200),
             focusColor: Colors.transparent,
             //   height: ScreenUtil().setHeight(200),
                padding: EdgeInsets.zero,
                    onPressed: (){
                      homeBloc.shangeShape(0);
                }, child: Icon(Icons.rectangle,color: locator<AppThemeColors>().primaryColor,size: ScreenUtil().setHeight(200),)),

                  FlatButton(
                      minWidth: ScreenUtil().setHeight(200),
                      padding: EdgeInsets.zero,
                      focusColor: Colors.transparent,
                      onPressed: (){
                        homeBloc.shangeShape(1);
                }, child: Icon(Icons.rectangle_rounded,color: locator<AppThemeColors>().lightblue,size: ScreenUtil().setHeight(200))),

                  FlatButton(
                      minWidth: ScreenUtil().setHeight(200),
                      padding: EdgeInsets.zero,
                      focusColor: Colors.transparent,
                      onPressed: (){
                        homeBloc.shangeShape(2);
                }, child: Icon(Icons.circle,color: locator<AppThemeColors>().redColor,size: ScreenUtil().setHeight(200)))
              ],)
            ],
          );
        }
      ),
    );
  }

}
