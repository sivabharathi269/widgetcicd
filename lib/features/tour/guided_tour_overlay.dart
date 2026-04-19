import 'package:flutter/material.dart';

class GuidedTourOverlay {
  static void showTour(BuildContext context, {required GlobalKey targetKey, required VoidCallback onDismiss}) {
    final RenderBox? renderBox = targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Darkened background
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  overlayEntry?.remove();
                  onDismiss();
                },
                child: Container(
                  color: Colors.black54,
                ),
              ),
            ),
            // Highlighted area cutout (simulated via positioned widget over the spot)
            Positioned(
              left: position.dx,
              top: position.dy,
              width: size.width,
              height: size.height,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                //IgnorePointer ignors the tap or click on the widget
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            // Tooltip box
            Positioned(
              left: position.dx,
              top: position.dy + size.height + 16,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Guided Tour',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This is a card you can interact with. Tap anywhere to continue the tour.',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            overlayEntry?.remove();
                            onDismiss();
                          },
                          child: const Text('Got it'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlayState.insert(overlayEntry);
  }
}
