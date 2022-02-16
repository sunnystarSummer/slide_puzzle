// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.themes,
    required this.theme,
    //2022-02-06_Jason
    //this.theme = const SeasonTheme02(),
  });

  /// The list of all available themes.
  final List<PuzzleTheme> themes;

  /// Currently selected theme.
  final PuzzleTheme theme;

  @override
  List<Object> get props => [themes, theme];

  ThemeState copyWith({
    List<PuzzleTheme>? themes,
    PuzzleTheme? theme,
  }) {
    return ThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }


  // SimpleTheme initialTheme(){
  //   final festival = Festival(selectedDate: DateTime.now());
  //   final festivalMonth = festival.festivalMonth();
  //   return festivalMonth.theme;
  // }
}
