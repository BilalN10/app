import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class ProductRouter extends StatelessWidget {
  const ProductRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const AutoRouter(),
    );
  }
}
