import 'package:casttime/app/config/app_config.dart';
import 'package:flutter/material.dart';

class BottomBarLayoutWidget extends StatelessWidget {
  final Widget childWidget;

  const BottomBarLayoutWidget({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                AppConfig.maxNavigationDockBarHeight,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppConfig.maxAppWidth,
                  ),
                  child: childWidget,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
