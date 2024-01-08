import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:paila_kicks/core/ui.dart';
import 'package:paila_kicks/presentation/screens/splash/splash_screen.dart';
import 'package:paila_kicks/presentation/widgets/gap_widget.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  static const routeName = "get_started";

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _position;
  late Animation<double> _opacity;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _position = Tween<double>(begin: 20, end: 50).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 1))
          ..addListener(() {
            setState(() {});
          }));

    _opacity = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0, 1))
          ..addListener(() {
            setState(() {});
          }));

    _controller.repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors.myBlack,
        child: Stack(
          children: [
            Positioned(
              bottom: -250,
              child: Container(
                width: size.width,
                height: size.height + 250,
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        radius: 0.65,
                        colors: [Colors.red, AppColors.myBlack])),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(50),
                width: size.width,
                child: Image.asset(
                  "assets/img/Applogo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(top: 40),
                height: size.height / 2,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: "Crafting Soles",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 37,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const GapWidget(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: "Crafting Stories",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      // behavior: HitTestBehavior.translucent,
                      // onVerticalDragUpdate: (details) {
                      //   int sensitivity = 8;
                      //   if (details.delta.dy < -sensitivity) {
                      //     // Navigator.push(
                      //     //     context,
                      //     //     PageTransition(
                      //     //         child: Container(),
                      //     //         type: PageTransitionType.bottomToTop));
                      //     Navigator.push(context, PageTransition(child: JumpScreen(), type: PageTransitionType.bottomToTop));
                      //   }
                      // },
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SplashScreen.routeName);
                      },
                      child: AbsorbPointer(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Opacity(
                                  opacity: _opacity.value,
                                  child: const Icon(
                                    CommunityMaterialIcons.chevron_double_up,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  text: "Get Started",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
