import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter/material.dart';

class LocationMarker extends StatelessWidget {
  final Location location;
  final bool isSelected;
  final VoidCallback onTap;

  const LocationMarker({
    super.key,
    required this.location,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final pinColor = isSelected ? colors.primary : Colors.red;
    final pinSize = isSelected ? 44.0 : 34.0;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TitleLabel(title: location.title, isSelected: isSelected),
          const SizedBox(height: 2),
          _Pin(
            imageUrl: location.thumbnailImage?.imageUrl,
            color: pinColor,
            size: pinSize,
          ),
        ],
      ),
    );
  }
}

class _TitleLabel extends StatelessWidget {
  const _TitleLabel({required this.title, required this.isSelected});

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? colors.primary : colors.outlineVariant,
          width: isSelected ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          color: colors.onSurface,
        ),
      ),
    );
  }
}

class _Pin extends StatelessWidget {
  const _Pin({required this.imageUrl, required this.color, required this.size});

  final String? imageUrl;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.25,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Spitze nach unten
          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: Size(size * 0.34, size * 0.3),
              painter: _PinTipPainter(color: color),
            ),
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(2.5),
            child: ClipOval(
              child: imageUrl == null
                  ? Container(
                      color: Colors.white,
                      child: Icon(Icons.place, size: size * 0.55, color: color),
                    )
                  : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: Colors.white,
                        child: Icon(
                          Icons.place,
                          size: size * 0.55,
                          color: color,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PinTipPainter extends CustomPainter {
  const _PinTipPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PinTipPainter oldDelegate) => oldDelegate.color != color;
}
