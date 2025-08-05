import 'package:flutter/material.dart';

class CancelRefillWidget extends StatelessWidget {
  final bool canCancel;
  final bool canRefill;
  final VoidCallback? onCancel;
  final VoidCallback? onRefill;

  const CancelRefillWidget({super.key, this.canCancel = false, this.canRefill = false, this.onCancel, this.onRefill});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (canCancel)
          ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              textStyle: const TextStyle(fontSize: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("Cancel"),
          ),
        if (canRefill) const SizedBox(width: 8),
        if (canRefill)
          ElevatedButton(
            onPressed: onRefill,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              textStyle: const TextStyle(fontSize: 12, color: Colors.black),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("Refill", style: TextStyle(color: Colors.black)),
          ),
      ],
    );
  }
}
