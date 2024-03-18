// ignore_for_file: constant_identifier_names

part of 'constants.dart';

class AppAssets {
  static String getSVGIcon(String iconName) => 'assets/icons/$iconName.svg';

  static String getPNGIcon(String iconName) => 'assets/icons/$iconName.png';

  static String getSVGImage(String imageName) => 'assets/images/$imageName.svg';

  static String getPNGImage(String imageName) => 'assets/images/$imageName.png';

  static String getJPEGImage(String imageName) =>
      'assets/images/$imageName.jpeg';
}
