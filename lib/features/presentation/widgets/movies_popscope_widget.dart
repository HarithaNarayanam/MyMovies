import 'package:flutter/material.dart';

class MoviesPopScope extends StatelessWidget {
  final bool canPop;
  final VoidCallback? onPopInvoked;
  final Widget child;
  const MoviesPopScope({super.key, this.canPop = false, this.onPopInvoked, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: canPop,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          if (onPopInvoked != null) {
            onPopInvoked!();
          }
        },
        child: child);
  }
}
