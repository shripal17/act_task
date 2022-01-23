import 'package:flutter/material.dart';

/// This widget just shows a circular progress indicator wrapper in a center widget
class CenteredProgressIndicator extends StatelessWidget {
  const CenteredProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
