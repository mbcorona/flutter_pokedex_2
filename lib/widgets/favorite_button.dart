import 'package:flutter/material.dart';
import 'package:flutter_pokedex_2/constants.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.onTap, required this.isFavorite});

  /// Called when the button is tapped.
  final VoidCallback onTap;

  /// Whether this item is currently a favorite.
  final bool isFavorite;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // A shorter duration makes the "pop" feel snappier.
      duration: const Duration(milliseconds: 150),
    );

    // Animate from normal size (1.0) to slightly larger (1.3) and back.
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the button just became a favorite.
    if (widget.isFavorite && !oldWidget.isFavorite) {
      // Play the animation forward, then reverse it to return to normal size.
      _controller.forward().then((_) {
        _controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.isFavorite ? kRedColor : Colors.grey[600],
          size: 30,
        ),
      ),
    );
  }
}
