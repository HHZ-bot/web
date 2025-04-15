enum ColorTheme {
  greylaw,
  greyblue,
  blue,
  green,
  greenmoney,
  redwine,
  purple,
  gold,
  pink,
  lime
}

class AppTheme {
  String themeName;
  ColorTheme colorTheme;

  AppTheme({
    required this.themeName,
    required this.colorTheme,
  });
}
