import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_bloc.dart';
import 'package:flex_sense/presentation/globals/global_states/system/system_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocProviders extends StatelessWidget {
  final Widget child;

  const GlobalBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SystemBloc>.value(
          value: serviceLocator.get<SystemBloc>(),
        ),
        BlocProvider<GlobalBloc>.value(
          value: serviceLocator.get<GlobalBloc>(),
        ),
      ],
      child: child,
    );
  }
}
