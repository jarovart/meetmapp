import 'package:flutter/material.dart';
import 'package:casttime/app/model/enums/appdesign.dart';

class DesignOption {
  final AppDesign design;
  final String label;
  final IconData icon;

  const DesignOption({
    required this.design,
    required this.label,
    required this.icon,
  });
}
