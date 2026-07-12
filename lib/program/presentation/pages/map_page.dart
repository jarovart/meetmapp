import 'package:casttime/program/app/dependency_injection.dart';
import 'package:casttime/program/presentation/bloc/mapbloc.dart';
import 'package:casttime/program/presentation/pages/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>.value(
      value: getIt<MapBloc>(),
      child: const MapView(),
    );
  }
}
