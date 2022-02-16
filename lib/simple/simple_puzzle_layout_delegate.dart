import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:very_good_slide_puzzle/colors/colors.dart';
import 'package:very_good_slide_puzzle/festival/festival_month.dart';
import 'package:very_good_slide_puzzle/festival/season_theme.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/simple/simple.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template simple_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [SimpleTheme].
/// {@endtemplate}
class SimplePuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro simple_puzzle_layout_delegate}
  const SimplePuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => SimpleStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        SimplePuzzleShuffleButton(),
        SimplePuzzleAnswerButton(),
      ],
    );

    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => row, //const SimplePuzzleShuffleButton(),
          medium: (_, child) => row, //const SimplePuzzleShuffleButton(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: ResponsiveLayoutBuilder(
        small: (_, __) => SizedBox(
          width: 184,
          height: 118,
          child: Image.asset(
            'assets/images/simple_dash_small.png',
            key: const Key('simple_puzzle_dash_small'),
          ),
        ),
        medium: (_, __) => SizedBox(
          width: 380.44,
          height: 214,
          child: Image.asset(
            'assets/images/simple_dash_medium.png',
            key: const Key('simple_puzzle_dash_medium'),
          ),
        ),
        large: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 53),
          child: SizedBox(
            width: 568.99,
            height: 320,
            child: Image.asset(
              'assets/images/simple_dash_large.png',
              key: const Key('simple_puzzle_dash_large'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => SizedBox.square(
            dimension: _BoardSize.small,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_small'),
              size: size,
              tiles: tiles,
              spacing: 5,
            ),
          ),
          medium: (_, __) => SizedBox.square(
            dimension: _BoardSize.medium,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_medium'),
              size: size,
              tiles: tiles,
            ),
          ),
          large: (_, __) => SizedBox.square(
            dimension: _BoardSize.large,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_large'),
              size: size,
              tiles: tiles,
            ),
          ),
        ),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => SimplePuzzleTile(
          key: Key('simple_puzzle_tile_${tile.value}_small'),
          tile: tile,
          tileFontSize: _TileFontSize.small,
          state: state),
      medium: (_, __) => SimplePuzzleTile(
          key: Key('simple_puzzle_tile_${tile.value}_medium'),
          tile: tile,
          tileFontSize: _TileFontSize.medium,
          state: state),
      large: (_, __) => SimplePuzzleTile(
          key: Key('simple_puzzle_tile_${tile.value}_large'),
          tile: tile,
          tileFontSize: _TileFontSize.large,
          state: state),
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class SimpleStartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const SimpleStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        SimplePuzzleShuffleButton(),
        SimplePuzzleAnswerButton(),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        PuzzleName(
          key: puzzleNameKey,
        ),
        const ResponsiveGap(large: 16),
        SimplePuzzleTitle(
          status: state.puzzleStatus,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndTilesLeft(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: state.numberOfTilesLeft,
        ),
        const ResponsiveGap(
          large: 32,
          small: 16,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => row, //SimplePuzzleShuffleButton(),
        ),
      ],
    );
  }
}

/// {@template simple_puzzle_title}
/// Displays the title of the puzzle based on [status].
///
/// Shows the success state when the puzzle is completed,
/// otherwise defaults to the Puzzle Challenge title.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTitle extends StatelessWidget {
  /// {@macro simple_puzzle_title}
  const SimplePuzzleTitle({
    Key? key,
    required this.status,
  }) : super(key: key);

  /// The status of the puzzle.
  final PuzzleStatus status;

  @override
  Widget build(BuildContext context) {
    return PuzzleTitle(
      key: puzzleTitleKey,
      title: status == PuzzleStatus.complete
          ? context.l10n.puzzleCompleted
          : context.l10n.puzzleChallengeTitle,
    );
  }
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template simple_puzzle_board}
/// Display the board of the puzzle in a [size]x[size] layout
/// filled with [tiles]. Each tile is spaced with [spacing].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleBoard extends StatelessWidget {
  /// {@macro simple_puzzle_board}
  const SimplePuzzleBoard({
    Key? key,
    required this.size,
    required this.tiles,
    this.spacing = 8,
  }) : super(key: key);

  /// The size of the board.
  final int size;

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The spacing between each tile from [tiles].
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: tiles,
    );
  }
}

abstract class _TileFontSize {
  static double small = 36;
  static double medium = 50;
  static double large = 54;
}

/// {@template simple_puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTile extends StatelessWidget {
  /// {@macro simple_puzzle_tile}
  const SimplePuzzleTile(
      {Key? key,
      required this.tile,
      required this.tileFontSize,
      required this.state})
      : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    //context.read<PuzzleBloc>()(const PuzzleReset(dateTime: ''));

    //https://stackoverflow.com/questions/51513429/how-to-do-rounded-corners-image-in-flutter

    //2022-01-21_Jason
    const puzzleShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    );

    DateTime selectedDateTime;
    {
      final answerDate = context.read<PuzzleBloc>().answerDate;
      //2022-01-26_Jason
      if (answerDate.isEmpty) {
        final dateTimeNow = DateTime.now();
        selectedDateTime = dateTimeNow;
      } else {
        selectedDateTime = DateFormat('yyyy/MM/dd').parse(answerDate);
      }
    }

    var puzzleText = tile.value.toString();
    final year = selectedDateTime.year;
    final day = selectedDateTime.day;
    var festivalMonth = FestivalMonth.January;
    {
      //https://zh.wikipedia.org/wiki/%E5%9B%BD%E5%BA%86%E6%97%A5#1%E6%9C%88
      switch (selectedDateTime.month) {
        case 1:
          festivalMonth = FestivalMonth.January;
          break;
        case 2:
          festivalMonth = FestivalMonth.February;
          break;
        case 3:
          festivalMonth = FestivalMonth.March;
          break;
        case 4:
          festivalMonth = FestivalMonth.April;
          break;
        case 5:
          festivalMonth = FestivalMonth.May;
          break;
        case 6:
          festivalMonth = FestivalMonth.June;
          break;
        case 7:
          festivalMonth = FestivalMonth.July;
          break;
        case 8:
          festivalMonth = FestivalMonth.August;
          break;
        case 9:
          festivalMonth = FestivalMonth.September;
          break;
        case 10:
          festivalMonth = FestivalMonth.October;
          break;
        case 11:
          festivalMonth = FestivalMonth.November;
          break;
        case 12:
          festivalMonth = FestivalMonth.December;
          break;
        default:
          festivalMonth = FestivalMonth.January;
      }
    }

    //Puzzle black friday calendar
    var defaultColor = theme.normalDayColor; //theme.defaultColors[index];
    {
      switch (tile.value % 7) {
        case 1:
        case 0:
          defaultColor = theme.holidayColor;
          break;
        default:
          defaultColor = theme.normalDayColor;
      }

      switch (tile.value) {
        case 1:
        case 7:
          defaultColor = theme.holidayColor;
          break;
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
          defaultColor = theme.normalDayTitleColor;
          break;
        default:
      }
    }

    final screenWidth = MediaQuery.of(context).size.width;

    var textFontSize = 8.toDouble();

    switch (tile.value) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        //『星期』字大小
        if (screenWidth <= PuzzleBreakpoints.small) {
          textFontSize = 8.toDouble();
          //web 10
          if (kIsWeb) {
            textFontSize = 10.toDouble();
          }
        } else if (screenWidth <= PuzzleBreakpoints.medium) {
          textFontSize = 16.toDouble();
        } else if (screenWidth <= PuzzleBreakpoints.large) {
          textFontSize = 16.toDouble();
        }
        break;
      default:
        if (screenWidth <= PuzzleBreakpoints.small) {
          textFontSize = 8.toDouble();
          //web 10
          if (kIsWeb) {
            textFontSize = 10.toDouble();
          }

          if (festivalMonth.isDayInMonth(year, tile.value)) {
            textFontSize = 14.toDouble();
          }
        } else if (screenWidth <= PuzzleBreakpoints.medium) {
          textFontSize = 16.toDouble();
        } else if (screenWidth <= PuzzleBreakpoints.large) {
          textFontSize = 16.toDouble();
        }
    }

    puzzleText = festivalMonth.puzzleText(year, day, tile.value);

    for (final position in festivalMonth.pixelPattern) {
      if (tile.value == position) {
        defaultColor = theme.pixelPatternColor;
      }
    }

    var textColor = theme.defaultColor;
    if (festivalMonth.isBlackDay(year, tile.value)) {
      textColor = PuzzleColors.white;
      defaultColor = PuzzleColors.primaryWhite2;
    }

    //https://zh.wikipedia.org/wiki/%E5%85%AB%E5%8D%A6
    final textButton = TextButton(
      style: TextButton.styleFrom(
        primary: PuzzleColors.white,
        textStyle: PuzzleTextStyle.headline2.copyWith(
          fontSize: textFontSize, //16, //tileFontSize,
        ),
        shape: puzzleShape,
      ).copyWith(
        foregroundColor: MaterialStateProperty.all(textColor),
        //PuzzleColors.white),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (tile.value == state.lastTappedTile?.value) {
              return theme.pressedColor;
            } else if (states.contains(MaterialState.hovered)) {
              //ToDo 2022-01-25_Jason
              return theme.hoverColor;
            } else {
              return defaultColor;
            }
          },
        ),
      ),
      onPressed: state.puzzleStatus == PuzzleStatus.incomplete
          ? () => context.read<PuzzleBloc>().add(TileTapped(tile))
          : null,
      onLongPress: () {
        // if (state.puzzleStatus == PuzzleStatus.incomplete) {
        //
        final dayInMonth = festivalMonth.getDayInMonth(year, tile.value);

        final titleText = '$year/${festivalMonth.currentMonth}/$dayInMonth';

        final isFestivalDay = festivalMonth.isFestivalDay(year, dayInMonth);

        String? dialogTitle02 = '';
        String? dialogContent = '';

        if (isFestivalDay) {
          final festivalDay =
              festivalMonth.getFestivalDay(context, year, dayInMonth);

          final dialogTitle01 =
              '${festivalDay?.dayName}\n${festivalDay?.country}';
          dialogContent = festivalDay?.content;

          if (dialogTitle01.isNotEmpty) {
            dialogTitle02 = '$titleText\n$dialogTitle01';
          }

          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(dialogTitle02!), //Text(titleText),
                //content: Text(dialogContent!), //const Text('Text'),
                content: SingleChildScrollView(child: Text(dialogContent!)),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        // }
      },
      child: Text(
        puzzleText,
        textAlign: TextAlign.center,
        semanticsLabel: context.l10n.puzzleTileLabelText(
          tile.value.toString(),
          tile.currentPosition.x.toString(),
          tile.currentPosition.y.toString(),
        ),
      ),
    );

    final stack = Stack(
      children: <Widget>[textButton],
    );

    return textButton; //textButton;
  }
}

class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker(
      {required DateTime currentTime,
      required DateTime minTime,
      required DateTime maxTime,
      required LocaleType locale})
      : super(
            locale: locale,
            minTime: minTime,
            maxTime: maxTime,
            currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleShuffleButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleShuffleButton({Key? key}) : super(key: key);

  //static PuzzleTheme theme = const SimpleTheme();
  static String selectedDateTime =
      DateFormat('yyyy/MM/dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeBloc>().state.theme;
    //var selectedDateTime = DateFormat('yyyy/MM/dd').format(DateTime.now());

    var textColor = PuzzleColors.primary0;
    if (theme is SimpleTheme) {
      textColor = theme.defaultColor;
    }

    return PuzzleButton(
      textColor: textColor,
      backgroundColor: theme.buttonColor,
      onPressed: () async {
        // if(kIsWeb){
        //   final date = await showDatePicker(
        //     context: context,
        //     initialDate: DateFormat('yyyy/MM/dd').parse(selectedDateTime),
        //     firstDate: DateTime(2022),
        //     lastDate: DateTime(2022, 12, 31),
        //     helpText: 'Pick a day in 2022',
        //     cancelText: 'Cancel',
        //     confirmText: 'Confirm',
        //   );
        //
        //   selectedDateTime = DateFormat('yyyy/MM/dd').format(date!);
        // }else
        {
          for (final localType in LocaleType.values) {
            if (Intl.getCurrentLocale().contains(localType.name)) {
              //https://pub.dev/packages/flutter_datetime_picker
              await DatePicker.showPicker(
                context,
                pickerModel: CustomMonthPicker(
                  minTime: DateTime(2022),
                  maxTime: DateTime(2022, 12, 31),
                  currentTime: DateFormat('yyyy/MM/dd').parse(selectedDateTime),
                  locale: localType,
                ),
                onConfirm: (date) {
                  selectedDateTime = DateFormat('yyyy/MM/dd').format(date);
                },
              );

              break;
            }
          }
        }

        final selectedDate = DateFormat('yyyy/MM/dd').parse(selectedDateTime);
        var festivalMonth = const Festival().getFestivalMonth(selectedDate);

        //2022-01-28_Jason
        //更新主題，四季主題
        context.read<ThemeBloc>().add(ThemeUpdated(theme: festivalMonth.theme));

        context.read<PuzzleBloc>().add(PuzzleReset(
              dateTime: selectedDateTime,
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/shuffle_icon.png',
            width: 17,
            height: 17,
            color: textColor,
          ),
          const Gap(10),
          Text(context.l10n.puzzleShuffle),
        ],
      ),
    );
  }
}

class SimplePuzzleAnswerButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleAnswerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //2022-01-28_Jason
    final theme = context.watch<ThemeBloc>().state.theme;

    var textColor = PuzzleColors.primary0;
    if (theme is SimpleTheme) {
      textColor = theme.defaultColor;
    }

    return PuzzleButton(
      textColor: textColor,
      backgroundColor: theme.buttonColor,
      onPressed: () {
        context.read<PuzzleBloc>().add(const PuzzleAnswer());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.l10n.puzzleAnswer),
        ],
      ),
    );
  }
}
