import 'package:casttime/features/map/presentation/widgets/mapslider/map_slider.dart';
import 'package:casttime/features/map/presentation/widgets/mapslider/map_slider_daterange.dart';
import 'package:flutter/material.dart';

class CollapsibleFilterBar extends StatelessWidget {
  const CollapsibleFilterBar({required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    debugPrint("main_collapsebuilder");
    return AnimatedSize(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000),
        opacity: visible ? 1 : 0,
        child: visible ? MapSlider() : const SizedBox.shrink(),
      ),
    );
  }
}
