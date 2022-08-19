import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chonburi_mobileapp/config/routes/route.dart';
import 'package:chonburi_mobileapp/constants/asset_path.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSplash extends StatefulWidget {
  const HomeSplash({Key? key}) : super(key: key);

  @override
  State<HomeSplash> createState() => _HomeSplashState();
}

class _HomeSplashState extends State<HomeSplash> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return AnimatedSplashScreen(
          splash: AppConstantAssets.logoImage,
          splashTransition: SplashTransition.scaleTransition,
          splashIconSize: 600,
          duration: 600,
          nextScreen: Routes.initialRoute(
            state.user.roles,
            state.user.token,
          ),
        );
      },
    );
  }
}
