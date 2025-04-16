import 'package:flutter/material.dart';
import '../core/app_export.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [newTheme].
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.gray100,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadowColor: appTheme.black900.withOpacity(0.4),
          elevation: 2,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: colorScheme.onPrimaryContainer.withOpacity(0.2),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: colorScheme.onPrimaryContainer.withOpacity(1),
          fontSize: 13.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.gray500,
          fontSize: 8.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
        headlineLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 30.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 25.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onPrimaryContainer.withOpacity(1),
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: colorScheme.onPrimaryContainer.withOpacity(1),
          fontSize: 10.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: colorScheme.onPrimaryContainer.withOpacity(1),
          fontSize: 8.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 20.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 18.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 14.fSize,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF8DB1F7),
    primaryContainer: Color(0XFF2E353E),
    errorContainer: Color(0XFF777777),
    onPrimary: Color(0XFF1C2026),
    onPrimaryContainer: Color(0X75FFFFFF),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => const Color(0XFF000000);
// Blue
  Color get blueA200 => const Color(0XFF5285E8);
// BlueGray
  Color get blueGray400 => const Color(0XFF888888);
  Color get blueGray50 => const Color(0XFFF1F1F1);
  Color get blueGray700 => const Color(0XFF535D67);
  Color get blueGray800 => const Color(0XFF454B55);
// Cyan
  Color get cyan600 => const Color(0XFF1DA1BE);
  Color get cyan900 => const Color(0XFF105955);
// Gray
  Color get gray100 => const Color(0XFFF0F5F4);
  Color get gray500 => const Color(0XFFAAAAAA);
  Color get gray700 => const Color(0XFF636363);
  Color get gray900 => const Color(0XFF1E232C);
// Green
  Color get green50 => const Color(0XFFD9F9DA);
  Color get green800 => const Color(0XFF159021);
  Color get green80001 => const Color(0XFF0CAC13);
  Color get gray50 => const Color(0XFFF7F8F9);

// Blue
  Color get blue400 => const Color(0XFF34AADF);
  Color get blueA100 => const Color(0XFF8DB1F7);
  Color get blueA400 => const Color(0XFF337FFF);
// BlueGray
  Color get blueGray200 => const Color(0XFFB8BCCA);
  Color get blueGray40001 => const Color(0XFF888888);

// DeepOrange
  Color get deepOrangeA400 => const Color(0XFFFF4500);
// Indigo
  Color get indigo50 => const Color(0XFFE8ECF4);
// LightGreen
  Color get lightGreenA200 => const Color(0XFFC7FC6C);
  Color get lightGreenA20001 => const Color(0XFFC0FE53);
// Red
  Color get red100 => const Color(0XFFF8C6CC);
  Color get red600 => const Color(0XFFE73E3E);
  Color get red700 => const Color(0XFFDA2037);
// Teal
  Color get teal100 => const Color(0XFFA5E0DD);
// Yellow
  Color get yellow900 => const Color(0XFFEE7429);
  Color get gray600 => const Color(0XFF6A707C);

// DeepPurple
  Color get deepPurpleA400 => const Color(0XFF5030E5);
// Gray
  Color get gray10001 => const Color(0XFFF0F5F4);

  Color get gray90001 => const Color(0XFF1B1919);
// Red
  Color get red500 => const Color(0XFFF14336);
// White
  Color get whiteA700 => const Color(0XFFFFFFFF);

// GrayB
  Color get gray100B2 => const Color(0XB2F7F7F7);

  Color get gray300 => const Color(0XFFE4E4E6);

  // Amber
  Color get amberA700 => const Color(0XFFFFAE00);

// LightBlue
  Color get lightBlue900 => const Color(0XFF006699);
  Color get lightBlueA200 => const Color(0XFF33CCFF);
  Color get lightBlueA20001 => const Color(0XFF36C5F0);
// BlueGray
  Color get blueGray100 => const Color(0XFFD9D9D9);

// LightGreen
  Color get lightGreen100 => const Color(0XFFDDF8BB);
  Color get lightGreenA20000 => const Color(0X00BBFB4C);

  // Lime
  Color get limeA200 => const Color(0XFFF8FF4A);

  // Yellow
  Color get yellow400 => const Color(0XFFE8FF61);

  // Amber
  Color get amber300 => const Color(0XFFFFDB61);

  Color get blueA20001 => const Color(0XFF4C7FE4);
  Color get blueA20002 => const Color(0XFF5285E8);

// DeepOrange
  Color get deepOrange300 => const Color(0XFFFF9969);
  Color get deepOrangeA200 => const Color(0XFFFF6C2C);

  Color get gray200 => const Color(0XFFEFEFEF);

  Color get gray800 => const Color(0XFF383838);

// Green
  Color get green600 => const Color(0XFF239F57);
  Color get green900 => const Color(0XFF096A2F);
  Color get greenA700 => const Color(0XFF13A445);

// Orange
  Color get orange900 => const Color(0XFFD15C0B);
// Pink
  Color get pink400 => const Color(0XFFD44164);

  Color get red900 => const Color(0XFFAF000D);

// Yellow
  Color get yellow600 => const Color(0XFFFFDA2B);
}
