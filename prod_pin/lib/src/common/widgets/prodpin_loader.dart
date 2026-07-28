import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';

class ProdPinLoader extends StatelessWidget {
  const ProdPinLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.appColors.accent),
    );
  }
}
