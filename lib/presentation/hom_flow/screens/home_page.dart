import 'package:flutter/material.dart';
import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:test_ososs/presentation/custom_widgets/custom_button.dart';
import 'package:test_ososs/presentation/custom_widgets/text_translation.dart';
import 'package:test_ososs/presentation/custom_widgets/textfield_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/state_home.dart';
import 'package:test_ososs/presentation/hom_flow/screens/animation_page.dart';
import 'package:test_ososs/presentation/hom_flow/screens/pokmon_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloc = locator<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(

        padding: EdgeInsets.all(ScreenUtil().setSp(70)),
        child: BlocBuilder<HomeBloc, HomeState>(
            bloc: homeBloc,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextfieldCustom(onValueChanged: (String value) {
                    homeBloc.setValue(value);
                  }, hintText:state.valueChanged??"",),

                  TextTranslation(
                    state.valueChanged ?? "", withTranslation: false,
                    style: TextStyle(fontSize: 20),),

                  Column(

                    children: [
                      TextButton(onPressed: () {
                        homeBloc.setClear();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete, color: locator<AppThemeColors>()
                              .redColor,),
                          Text("Clear text", style: TextStyle(
                              color: locator<AppThemeColors>().redColor,
                              fontSize: 18),),

                        ],
                      )),
                      SizedBox(height: ScreenUtil().setHeight(30),),
                      CustomButton("Go to Page 1", width: MediaQuery
                          .of(context)
                          .size
                          .width / 0.3,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 15,
                        colorBackground: locator<AppThemeColors>()
                            .primaryColor,onTapBut: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AnimationPage()));},),
                      SizedBox(height: ScreenUtil().setHeight(90),),
                      CustomButton("Go to Page 2", width: MediaQuery
                          .of(context)
                          .size
                          .width / 0.3,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 15,
                          colorBackground: locator<AppThemeColors>().lightblue,onTapBut: (){ Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PokemonListPage()));},)
                    ],

                  ),
                ],
              );
            }),
      ),
    );
  }
}