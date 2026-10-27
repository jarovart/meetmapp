import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/features/info/presentation/bloc/info_bloc.dart';
import 'package:casttime/features/info/presentation/bloc/info_event.dart';
import 'package:casttime/features/info/presentation/pages/widgets/about_card_widget.dart';
import 'package:casttime/features/info/presentation/pages/widgets/homepage_card_widget.dart';
import 'package:casttime/features/info/presentation/pages/widgets/status_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InfoBloc>()..add(InfoRequested()),
      child: const _InfoView(),
    );
  }
}

class _InfoView extends StatelessWidget {
  const _InfoView();

  @override
  Widget build(BuildContext context) {
    return BottomBarLayoutWidget(
      childWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Image.asset(AppConfig.appIconPath, width: 72, height: 72),
          ),
          const SizedBox(height: 12),
          const Text(
            AppConfig.appName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const StatusCard(),
          const SizedBox(height: 20),
          const AboutCard(),
          const SizedBox(height: 20),
          const HomepageCard(),
        ],
      ),
    );
  }
}
