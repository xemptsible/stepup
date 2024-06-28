import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff405f90),
      surfaceTint: Color(0xff405f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd6e3ff),
      onPrimaryContainer: Color(0xff001b3d),
      secondary: Color(0xff29638a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcbe6ff),
      onSecondaryContainer: Color(0xff001e30),
      tertiary: Color(0xff2a638a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcbe6ff),
      onTertiaryContainer: Color(0xff001e31),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff44474e),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3036),
      inversePrimary: Color(0xffa9c7ff),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3d),
      primaryFixedDim: Color(0xffa9c7ff),
      onPrimaryFixedVariant: Color(0xff274777),
      secondaryFixed: Color(0xffcbe6ff),
      onSecondaryFixed: Color(0xff001e30),
      secondaryFixedDim: Color(0xff97ccf8),
      onSecondaryFixedVariant: Color(0xff004b71),
      tertiaryFixed: Color(0xffcbe6ff),
      onTertiaryFixed: Color(0xff001e31),
      tertiaryFixedDim: Color(0xff98ccf9),
      onTertiaryFixedVariant: Color(0xff034b71),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe7e8ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff224373),
      surfaceTint: Color(0xff405f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5775a8),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00476b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff437aa2),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00476c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4479a2),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff40434a),
      outline: Color(0xff5c5f67),
      outlineVariant: Color(0xff787a83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3036),
      inversePrimary: Color(0xffa9c7ff),
      primaryFixed: Color(0xff5775a8),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3d5c8e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff437aa2),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff266187),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4479a2),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff276088),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe7e8ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002249),
      surfaceTint: Color(0xff405f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff224373),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00253a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff00476b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00253b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff00476c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff21242b),
      outline: Color(0xff40434a),
      outlineVariant: Color(0xff40434a),
      shadow: Color(0xff000000),
      scrim: Color.fromRGBO(0, 0, 0, 1),
      inverseSurface: Color(0xFF2E3036),
      inversePrimary: Color(0xffe5ecff),
      primaryFixed: Color(0xff224373),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff022c5b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff00476b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff00304a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff00476c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00304a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe7e8ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa9c7ff),
      surfaceTint: Color(0xffa9c7ff),
      onPrimary: Color(0xff08305f),
      primaryContainer: Color(0xff274777),
      onPrimaryContainer: Color(0xffd6e3ff),
      secondary: Color(0xff97ccf8),
      onSecondary: Color(0xff00344f),
      secondaryContainer: Color(0xff004b71),
      onSecondaryContainer: Color(0xffcbe6ff),
      tertiary: Color(0xff98ccf9),
      onTertiary: Color(0xff003350),
      tertiaryContainer: Color(0xff034b71),
      onTertiaryContainer: Color(0xffcbe6ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc4c6cf),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff405f90),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3d),
      primaryFixedDim: Color(0xffa9c7ff),
      onPrimaryFixedVariant: Color(0xff274777),
      secondaryFixed: Color(0xffcbe6ff),
      onSecondaryFixed: Color(0xff001e30),
      secondaryFixedDim: Color(0xff97ccf8),
      onSecondaryFixedVariant: Color(0xff004b71),
      tertiaryFixed: Color(0xffcbe6ff),
      onTertiaryFixed: Color(0xff001e31),
      tertiaryFixedDim: Color(0xff98ccf9),
      onTertiaryFixedVariant: Color(0xff034b71),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb0ccff),
      surfaceTint: Color(0xffa9c7ff),
      onPrimary: Color(0xff001634),
      primaryContainer: Color(0xff7391c6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff9bd1fd),
      onSecondary: Color(0xff001828),
      secondaryContainer: Color(0xff6096c0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff9cd0fd),
      onTertiary: Color(0xff001829),
      tertiaryContainer: Color(0xff6196c0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xfffbfaff),
      onSurfaceVariant: Color(0xffc8cad4),
      outline: Color(0xffa0a3ac),
      outlineVariant: Color(0xff80838c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff284878),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff00112a),
      primaryFixedDim: Color(0xffa9c7ff),
      onPrimaryFixedVariant: Color(0xff123665),
      secondaryFixed: Color(0xffcbe6ff),
      onSecondaryFixed: Color(0xff001321),
      secondaryFixedDim: Color(0xff97ccf8),
      onSecondaryFixedVariant: Color(0xff003a58),
      tertiaryFixed: Color(0xffcbe6ff),
      onTertiaryFixed: Color(0xff001321),
      tertiaryFixedDim: Color(0xff98ccf9),
      onTertiaryFixedVariant: Color(0xff003a59),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffa9c7ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb0ccff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff9fbff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff9bd1fd),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff9fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9cd0fd),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffbfaff),
      outline: Color(0xffc8cad4),
      outlineVariant: Color(0xffc8cad4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff002958),
      primaryFixed: Color(0xffdde7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb0ccff),
      onPrimaryFixedVariant: Color(0xff001634),
      secondaryFixed: Color(0xffd3e9ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff9bd1fd),
      onSecondaryFixedVariant: Color(0xff001828),
      tertiaryFixed: Color(0xffd4e9ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff9cd0fd),
      onTertiaryFixedVariant: Color(0xff001829),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
