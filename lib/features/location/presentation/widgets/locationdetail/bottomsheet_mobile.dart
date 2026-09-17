import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_event.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_state.dart';
import 'package:casttime/features/location/presentation/util/sheet_size_memory.dart';
import 'package:casttime/features/location/presentation/widgets/locationdetail/location_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationDetailsBottomSheet extends StatefulWidget {
  final bool canOpenInNewPage;

  const LocationDetailsBottomSheet({super.key, this.canOpenInNewPage = true});

  static Future<void> show(
    BuildContext context, {
    required Location location,
    bool canOpenInNewPage = true,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider(
          create: (_) =>
              getIt<LocationDetailBloc>(param1: location)
                ..add(LocationDetailRequested(location: location)),
          child: LocationDetailsBottomSheet(canOpenInNewPage: canOpenInNewPage),
        );
      },
    );
  }

  @override
  State<LocationDetailsBottomSheet> createState() =>
      _LocationDetailsBottomSheetState();
}

class _LocationDetailsBottomSheetState
    extends State<LocationDetailsBottomSheet> {
  static const _peekSize = 0.2;
  static const _maxSize = 0.8;
  static const _dismissSize = 0.08;
  bool _isDismissing = false;

  late final DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();
    _sheetController.addListener(_rememberSize);
    _sheetController.addListener(_onSheetSizeChanged);
  }

  void _rememberSize() {
    if (!_sheetController.isAttached) return;

    final route = ModalRoute.of(context);
    // Route wird gerade weggeanimiert -> keine Größe mehr merken
    if (route == null ||
        !route.isActive ||
        route.animation?.status == AnimationStatus.reverse) {
      return;
    }

    final size = _sheetController.size;
    // Nur gültige Größen im erlaubten Bereich
    if (size < _peekSize - 0.01 || size > _maxSize + 0.01) return;
    getIt<SheetSizeMemory>().lastSize = _sheetController.size;
  }

  void _onSheetSizeChanged() {
    if (!_sheetController.isAttached || _isDismissing) return;

    final route = ModalRoute.of(context);
    if (route == null ||
        !route.isActive ||
        route.animation?.status == AnimationStatus.reverse) {
      return;
    }

    final size = _sheetController.size;

    // 1. Unter Dismiss-Schwelle -> schließen
    if (size <= _dismissSize + 0.01) {
      _isDismissing = true;
      Navigator.of(context).pop();
      return;
    }

    // 2. Sonst: gültige Größe merken
    if (size < _peekSize - 0.01 || size > _maxSize + 0.01) return;
    getIt<SheetSizeMemory>().lastSize = size;
  }

  @override
  void dispose() {
    _sheetController.removeListener(_rememberSize);
    _sheetController.removeListener(_onSheetSizeChanged);
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationDetailBloc, LocationDetailState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == LoadStatus.success,
      listener: (context, state) {
        if (!_sheetController.isAttached) return;
        _sheetController.animateTo(
          getIt<SheetSizeMemory>().lastSize,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
        );
      },
      child: DraggableScrollableSheet(
        controller: _sheetController,
        expand: false,
        snap: true,
        shouldCloseOnMinExtent: false,
        snapSizes: const [_dismissSize, _peekSize, _maxSize],
        initialChildSize: getIt<SheetSizeMemory>().lastSize,
        minChildSize: _dismissSize,
        maxChildSize: _maxSize,
        builder: (_, scrollController) {
          return BlocBuilder<LocationDetailBloc, LocationDetailState>(
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.location != current.location ||
                previous.locationDetail != current.locationDetail ||
                previous.failure != current.failure,
            builder: (context, state) {
              if (state.status == LoadStatus.loading) {
                return Material(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ListView(
                    controller: scrollController,
                    children: const [
                      SizedBox(height: 32),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                );
              }

              return LocationDetailsContent(
                scrollController: scrollController,
                //canOpenInNewPage: widget.canOpenInNewPage,
                dragHandle: true,
              );
            },
          );
        },
      ),
    );
  }
}
