import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

///
/// This widget returns the image of the Logo.
///
/// It will return an [SvgPicture] in case we are in web.
///
/// It will return an [Image] in case we are in mobile.
///
/// The available options of the logoType are:
///
/// !! ATTENTION !!
///
/// "brandname_two_lines" is only available for mobile devices.
/// ```dart
///   logoType: ('brandname' ||
///    'logo_brandname' ||
///    'brandname_two_lines' ||
///    'default');
/// ```
///
///
///
/// The available options of the textColor are:
///
/// ```dart
///   textColor: ('white' || 'black'
///   || 'default'); //TODO Continuar por aquí con la documentación.
/// ```
///
/// In case you don't want to setup the variables can use the default values:
///
/// ```dart
///   ImageLogo(
///     height: -1,
///     logoType: 'default',
///     textColor: 'default',
///   );
/// ```
///
/// The default values are.
/// ```dart
///   height: isWeb ? 350 : 250;
///   logoType: isWeb ?
///           'logo_brandname' :
///           'brandname';
///   textColor: '_white';
/// ```
///
///
///
///
///
///
///
class ImageLogo extends StatelessWidget {
  double height;
  String logoType;
  String textColor; // ONLY BLACK AND WHITE AVAILABLE
  ImageLogo(
      {required this.height,
      required this.logoType,
      required this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fileFolder; //  The folder to search the asset
    final String fileExtension; //   The extension of the file
    final double defaultHeight;
    final String defaultLogoType;
    const String defaultTextColor = '_white';

    // Assign static values for mobile or desktop devices
    if (kIsWeb) {
      // If is an web screen we use svg to get better quality.
      fileFolder = 'svg/';
      fileExtension = '.svg';
      defaultHeight = 350;
      defaultLogoType = 'logo_brandname';
    } else {
      // If is a mobile screen we use png to get higher speed.
      fileFolder = 'images/';
      fileExtension = '.png';
      defaultHeight = 250;
      defaultLogoType = 'brandname';
    }

    // Before we create the object we will check if we have to use default data.
    height == -1 ? height = defaultHeight : '';
    logoType == 'default' ? logoType = defaultLogoType : '';
    textColor == 'default'
        ? textColor = defaultTextColor
        : textColor = '_' + textColor;

    if (kIsWeb) {
      // If is web , we return an SvgPicture object because we insert SVG file.
      if (logoType == 'logo') {
        return SvgPicture.asset(
          fileFolder + logoType + fileExtension,
          height: height,
        );
      }
      return SvgPicture.asset(
        fileFolder + logoType + textColor + fileExtension,
        height: height,
      );
    }

    // If is mobile , we return an Image object because we insert PNG file.
    if (logoType == 'logo') {
      return Image.asset(
        'assets/' + fileFolder + logoType + fileExtension,
        height: height,
      );
    }

    return Image.asset(
      'assets/' + fileFolder + logoType + textColor + fileExtension,
      height: height,
    );

    // switch (logoType) {

    //   //*****************************************************************
    //   //                          LOGO
    //   //*****************************************************************/
    //   case "logo":
    //     logo = SvgPicture.asset(
    //       fileFolder + 'logo' + fileExtension,
    //       height: height,
    //     );
    //     break;

    //   //*****************************************************************
    //   //                    LOGO AND BRANDNAME
    //   //*****************************************************************/
    //   case "logo_brandname":
    //     if (textColor == 'white') {
    //       logo = SvgPicture.asset(
    //         fileFolder + 'logo_brandname_white' + fileExtension,
    //         height: height,
    //       );
    //     } else {
    //       logo = SvgPicture.asset(
    //         'svg/logo_brandname_black.' + fileExtension,
    //         height: height,
    //       );
    //     }
    //     break;

    //   //*****************************************************************
    //   //                          BRANDNAME
    //   //*****************************************************************/
    //   case "brandname":
    //     if (textColor == 'white') {
    //       logo = SvgPicture.asset(
    //         fileFolder + 'brandname_white' + fileExtension,
    //         height: height,
    //       );
    //     } else {
    //       logo = SvgPicture.asset(
    //         fileFolder + 'brandname_black.' + fileExtension,
    //         height: height,
    //       );
    //     }
    //     break;

    //   //*****************************************************************
    //   //          BRANDNAME IN TWO LINES (ONLY FOR MOBILE)
    //   //*****************************************************************/
    //   case "brandname_two_lines":
    //     if (textColor == 'white') {
    //       logo = SvgPicture.asset(
    //         fileFolder + 'brandname_two_lines_white' + fileExtension,
    //         height: height,
    //       );
    //     } else {
    //       logo = SvgPicture.asset(
    //         fileFolder + 'brandname_two_lines_black.' + fileExtension,
    //         height: height,
    //       );
    //     }
    //     break;
    //   default:
    //     logo = SvgPicture.asset(
    //       fileFolder + 'logo' + fileExtension,
    //       height: height,
    //     );
    // }
    // return logo;
  }
}
