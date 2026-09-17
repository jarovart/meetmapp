import 'package:flutter/material.dart';

class ThumbnailImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double iconSize;
  final BorderRadius? borderRadius;

  const ThumbnailImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.iconSize = 48,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final content = _hasImage
        ? Image.network(
            imageUrl!,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (_, _, _) => _placeholder(context),
          )
        : _placeholder(context);

    if (borderRadius == null) {
      return SizedBox(width: width, height: height, child: content);
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: SizedBox(width: width, height: height, child: content),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        Icons.groups_outlined,
        size: 64,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  bool get _hasImage => imageUrl != null && imageUrl!.trim().isNotEmpty;

  static String buildInitials({
    required String? firstName,
    required String? lastName,
    required String? username,
  }) {
    String result = '';

    if (firstName != null && firstName.trim().isNotEmpty) {
      result += firstName.trim()[0];
    }
    if (lastName != null && lastName.trim().isNotEmpty) {
      result += lastName.trim()[0];
    }

    if (result.isEmpty && username != null && username.trim().isNotEmpty) {
      final trimmed = username.trim();
      result = trimmed.length >= 2 ? trimmed.substring(0, 2) : trimmed[0];
    }

    return result.toUpperCase();
  }
}
