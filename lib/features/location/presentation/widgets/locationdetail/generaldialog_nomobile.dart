import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_event.dart';
import 'package:casttime/features/location/presentation/widgets/locationdetail/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationDetailsGeneralDialog extends StatelessWidget {
  final bool canOpenInNewPage;
  const LocationDetailsGeneralDialog({super.key, this.canOpenInNewPage = true});

  static Future<void> show(
    BuildContext context, {
    required Location location,
    bool canOpenInNewPage = true,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Location details',
      barrierColor: Colors.black.withValues(alpha: 0.25),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (dialogContext, _, _) {
        return BlocProvider(
          create: (_) =>
              getIt<LocationDetailBloc>()
                ..add(LocationDetailRequested(location: location)),
          child: SafeArea(
            left: false,
            right: true,
            bottom: false,
            top: true,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Material(
                elevation: 16,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: 420,
                  height: MediaQuery.of(dialogContext).size.height,
                  child: SafeArea(
                    left: true,
                    child: LocationDetailsGeneralDialog(
                      canOpenInNewPage: canOpenInNewPage,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, _, child) {
        final slideAnimation =
            Tween<Offset>(
              begin: const Offset(-1, 0), // 👈 von links
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        return SlideTransition(position: slideAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailBloc = context.watch<LocationDetailBloc>();
    //detailBloc.canOpenInNewPage = canOpenInNewPage;
    debugPrint("super rebuild");

    if (detailBloc.state.status == LoadStatus.loading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return LocationDetailsContent();
  }
}
