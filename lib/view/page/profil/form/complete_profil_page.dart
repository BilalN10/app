import 'package:findyourdresse_app/view/page/profil/form/complete_profil_page_one.dart';
import 'package:findyourdresse_app/view/page/profil/form/complete_profil_page_two.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompleteProfilPage extends ConsumerStatefulWidget {
  const CompleteProfilPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteProfilPageState();
}

class _CompleteProfilPageState extends ConsumerState<CompleteProfilPage> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        CompleteProfilPageOne(
          pageController: pageController,
        ),
        CompleteProfilPageTwo(pageController: pageController),
      ],
    );
  }
}
