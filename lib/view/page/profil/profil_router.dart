import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

class ProfilRouter extends StatelessWidget {
  const ProfilRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const AutoRouter(),
    );
  }
}
