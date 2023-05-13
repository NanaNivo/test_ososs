import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/resources/colors.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:test_ososs/presentation/hom_flow/bloc/state_home.dart';


class TextfieldCustom extends StatefulWidget {
  String hintText;
  bool onValidation;
 // String typeValidation;
  ValueChanged<String> onValueChanged;

  TextfieldCustom(
      {this.hintText, this.onValueChanged, this.onValidation = true});

  @override
  State<TextfieldCustom> createState() => _TextfieldCustomState();
}

class _TextfieldCustomState extends State<TextfieldCustom> {
  TextEditingController _textController = TextEditingController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
   final homeBloc=locator<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc,HomeState>(
      bloc: homeBloc,
      listenWhen: (prev,curr)
    {
        if(prev.valueCleared!=curr.valueCleared)
          {
            _textController = TextEditingController();
            return true;
          }
        return false;
  },
      listener: (context,state){},

        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 19),
            // height: MediaQuery.of(context).size.height/20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: locator<AppThemeColors>().black,
              ),
            ),

              child: TextFormField(
                controller: _textController,
                style: TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
//contentPadding: EdgeInsetsDirectional.zero,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: locator<AppThemeColors>().black,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none,

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                onChanged: (String value) async {
                  widget.onValueChanged(value);
                },
                validator: (String value) {


                    // if (!widget.onValidation) {
                    //   return null;
                    // } else if (value.isEmpty && widget.hintText.isEmpty) {
                    //   return 'the field is Required';
                    // }

                  return null;
                },
              ),
            ),

    );
  }


}
