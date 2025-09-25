import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/presentation/screens/splash/bloc/splash_screen_bloc.dart';
import 'package:flex_sense/presentation/widgets/commons/app_bar/custom_app_bar.dart';
import 'package:flex_sense/application/resource/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _bloc = serviceLocator.get<SplashScreenBloc>();

  @override
  void initState() {
    print('init state splash screen');;
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top, // show Status Bar and hide Bottom Navigation Bar
      ],
    );
    _bloc.setUpAppConfiguration(context);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _renderAppBar(),
        body: _renderBody(),
      ),
    );
  }

  CustomAppBar _renderAppBar() {
    return const CustomAppBar(
      backgroundColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    );
  }

  Widget _renderBody() {
    return Container(
      margin: const EdgeInsets.only(bottom: kToolbarHeight),
      child: Center(
        child: Image.asset(
          AppImages.appLogo,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
