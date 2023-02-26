import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showLoadingOverlayProvider = StateProvider<bool>((ref) => false);

class LoadingOverlay extends ConsumerWidget {
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoadingOverlay = ref.watch(showLoadingOverlayProvider);
    return Stack(
      children: [
        child,
        if (showLoadingOverlay)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Opacity(
              opacity: 0.8,
              child: ModalBarrier(
                  dismissible: false,
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        if (showLoadingOverlay)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
