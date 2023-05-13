import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../../app+injection/di.dart';
import '../../../core/helper/screen_util/screen_helper.dart';
import '../../../core/resources/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../custom_widgets/animation/fade_tans_animation.dart';


class SplashPage extends StatefulWidget {
  static String routeName = 'SplashPage';

 const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final Duration _animationDuration =  const Duration(seconds: 1, milliseconds: 1);

  Animation<double> _animation;
  Animation<double> _animationRounded;
  AnimationController _animationController;

  bool isWordsAnimationFinished = false;
  bool isShapesAnimationFinished = false;

 // final _bloc = AuthBloc();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      lowerBound: 0.2,
      upperBound: 1.0,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
    _animation.addStatusListener((AnimationStatus state) {
      if (state == AnimationStatus.completed) {
        isShapesAnimationFinished = true;
        setState(() {});
      }
    });

    _animationRounded = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCubic);
    _animation.addListener(() {
      setState(() {});
    });

   // _bloc.add(AppStarted());

    Future.delayed(
       const Duration(
          milliseconds: 300,
        ), () {
      _animationController.forward();
    });

    // Future.delayed(
    //    const Duration(
    //       seconds: 8,
    //     ), () {
    // //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    // //     return BlocBuilder(
    // //         bloc: _bloc,
    // //         builder: (c, state) {
    // //           return state is IsAuthenticated ? RootPage() : LoginPage();
    // //         });
    // //   }));
    //  });

  }

  @override
  Widget build(BuildContext context) {
    ScreensHelper(context);

    return Scaffold(
      body:  SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Container(
        //  color: locator<AppThemeColors>().background,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // Positioned.fill(
              //   top: MediaQuery.of(context).size.height * 0.0001,
              //   child: _getMiddleContents(),
              // ),
              Center(
                child: FlutterLogo(
                  size: ScreenUtil().setWidth(500), // adjust the size as needed
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: ScreenUtil().setHeight(30),
                child: _getBottomLoader(),
              )
            ],
          ),
        ),
      ),
    );
  } // end build

  Widget _getBottomLoader() {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4,
            ),
            child: AnimatedOpacity(
              opacity: isShapesAnimationFinished ? 1.0 : 0.0,
              duration: _animationDuration,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade200,
                valueColor:
                    AlwaysStoppedAnimation<Color>(locator<AppThemeColors>().secondaryColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        RichText(
          text: TextSpan(
            text: 'Powered by ',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: locator<AppThemeColors>().black,
                fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(
                  text: 'Test',
                  style: TextStyle(
                      color: locator<AppThemeColors>().black,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }
    _getAppNameText() {
      if (!isShapesAnimationFinished) {
        return Container();
      } else if (isWordsAnimationFinished) {
        return FadeTransAnimation(
          delayInMillisecond: 0,
          child: Text(
            "Sheen Store",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'courgette',
                fontSize: ScreenUtil().setSp(130)),
          ),
        );
      } else {
        return DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'courgette',
              fontSize: ScreenUtil().setSp(120),
            ),
            textAlign: TextAlign.center,
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 800),
              animatedTexts: [
                FadeAnimatedText('Sheen', duration:  const Duration(milliseconds: 1000)),
                FadeAnimatedText('Store', duration:  const Duration(milliseconds: 1000)),
                FadeAnimatedText('Sheen Store', duration:  const Duration(milliseconds: 1000)),
              ],
              isRepeatingAnimation: false,

              onFinished: () {
                setState(() {
                  isWordsAnimationFinished = true;
                });
              },
            ));
      }
    }

  Widget _getMiddleContents() {
    return Container(
 //     color: locator<AppThemeColors>().background ,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Positioned(
            top: -ScreenUtil().setHeight(430),
            left: -ScreenUtil().setWidth(50),
            child: Container(
              width: ScreenUtil().setWidth(1200 * _animation.value),
              height: ScreenUtil().setWidth(1800),
              transform: Matrix4.rotationZ(0.697), // 50 deg
              decoration: BoxDecoration(
                  color: const Color(0xffe6e6e6),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(100))),
            ),
          ),
          Positioned(
            top: -ScreenUtil().setHeight(420),
            left: -ScreenUtil().setWidth(310),
            child: Opacity(
              opacity: _animation.value,
              child: Container(
                width: ScreenUtil().setWidth(1600),
                height: ScreenUtil().setWidth(1600),
                transform: Matrix4.rotationZ(
                    0.697 * ((1.6) / (_animation.value + 0.6))),
                decoration: BoxDecoration(
                    color: locator<AppThemeColors>().primaryColor,
                    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(
                        110 * ((1.6) / (_animationRounded.value + 0.6))))),
              ),
            ),
          ),
          Positioned(
            left: ScreenUtil().setWidth(80),
            top: ScreenUtil().setWidth(530),
            child: _getAppNameText(),
          )
        ],
      ),
    );
  }



  @override
  void dispose() {
    _animationController.dispose();
   // _bloc.close();
    super.dispose();
  }
}
