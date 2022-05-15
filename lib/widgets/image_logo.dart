import 'package:flutter/material.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ImageLogo extends StatelessWidget {
  const ImageLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double? desktopHeight = 350;
    const double? mobileHeight = 150;
    final logo;
    if (kIsWeb) {
      logo = SvgPicture.asset(
        'svg/logo_brandname_white.svg',
        height: desktopHeight,
      );
    } else {
      logo = Expanded(
        child: KeyboardVisibilityBuilder(builder: (context, visible) {
          if (visible) {
            return const Text(
              '',
            );
          } else {
            return Image.asset(
              'assets/images/brandname_white.png',
              height: mobileHeight,
            );
          }
        }),
        // child: Image.asset(
        //   'assets/images/brandname_white.png',
        //   height: mobileHeight,
        // ),
      );
    }
    return logo;
  }
}
