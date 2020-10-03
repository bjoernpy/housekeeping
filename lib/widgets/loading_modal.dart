import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.5,
          child: const ModalBarrier(
            dismissible: false,
            color: Colors.grey,
          ),
        ),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
