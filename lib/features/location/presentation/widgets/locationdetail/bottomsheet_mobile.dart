import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_event.dart';
import 'package:casttime/features/location/presentation/widgets/locationdetail/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationDetailsBottomSheet extends StatelessWidget {
  final bool canOpenInNewPage;

  const LocationDetailsBottomSheet({super.key, this.canOpenInNewPage = true});

  static Future<void> show(
    BuildContext context, {
    required Location location,
    bool canOpenInNewPage = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      //showDragHandle: true,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height - 110,
      ),
      builder: (_) {
        return BlocProvider(
          create: (_) =>
              getIt<LocationDetailBloc>()
                ..add(LocationDetailRequested(location: location)),
          child: LocationDetailsBottomSheet(canOpenInNewPage: canOpenInNewPage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailBloc = context.watch<LocationDetailBloc>();
    //detailBloc.canOpenInNewPage = canOpenInNewPage;

    if (detailBloc.state.status == LoadStatus.loading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return DraggableScrollableSheet(
      snap: true,
      snapSizes: const [0.55, 1.0],
      expand: false,
      initialChildSize: 0.55, // 40% Höhe beim Öffnen
      minChildSize: 0.25, // minimal (nach unten ziehen)
      maxChildSize: 1.0, // 🔥 volle Höhe beim Hochziehen
      builder: (_, scrollController) {
        return LocationDetailsContent(
          scrollController: scrollController,
          dragHandle: true,
        );
      },
    );
  }
}
