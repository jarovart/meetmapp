import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/config/appscrollbehavior.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/navigation/app_router.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/theme/themedesign.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';
import 'package:casttime/features/setting/presentation/cubit/app_settings_cubit.dart';
import 'package:casttime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasttimeApp extends StatelessWidget {
  const CasttimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBannerCubit>.value(value: getIt<AppBannerCubit>()),
        BlocProvider<AuthCubit>.value(
          value: getIt<AuthCubit>()..checkAuthStatus(),
        ),
        BlocProvider.value(value: getIt<AppSettingsCubit>()..loadLocal()),
        BlocProvider<MapBloc>.value(value: getIt<MapBloc>()),
      ],
      child: BlocBuilder<AppSettingsCubit, AppSettings>(
        builder: (context, settings) {
          return MaterialApp.router(
            title: AppConfig.appName,
            routerConfig: appRouter,
            locale: settings.locale,
            theme: ThemeDesign.getThemeByAppDesign(settings.design),
            darkTheme: ThemeDesign.mapDarkTheme(settings.design),
            themeMode: ThemeDesign.getThemeModeByAppDesign(settings.design),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            scrollBehavior: const AppScrollBehavior(),
          );
        },
      ),
    );
  }
}
