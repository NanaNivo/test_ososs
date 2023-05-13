
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_ososs/app+injection/di.dart';
import 'package:test_ososs/core/resources/colors.dart';

extension CustomWidgetExtension on double {
  Widget gap() {
    return SizedBox(height: this);
  }
}

class PaginationError extends StatelessWidget {
  final String error;
  const PaginationError({Key key, @required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'lib/assets/mobile.svg',
          fit: BoxFit.contain,
          height: 200,
        ),
        20.0.gap(),
        Center(
            child: Text(
              error.toString().toUpperCase(),
              style: TextStyle(
                  color: locator<AppThemeColors>().secondaryColor),
            )),
      ],
    );
  }
}
