import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:very_good_slide_puzzle/festival/season_theme.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/simple/simple.dart';

class Festival {
  const Festival();

  FestivalMonth getFestivalMonth(DateTime date) {
    switch (date.month) {
      case 1: // 一月
        return FestivalMonth.January;
      case 2: // 二月
        return FestivalMonth.February;
      case 3: // 三月
        return FestivalMonth.March;
      case 4: // 四月
        return FestivalMonth.April;
      case 5: // 五月
        return FestivalMonth.May;
      case 6: // 六月
        return FestivalMonth.June;
      case 7: // 七月
        return FestivalMonth.July;
      case 8: // 八月
        return FestivalMonth.August;
      case 9: // 九月
        return FestivalMonth.September;
      case 10: // 十月
        return FestivalMonth.October;
      case 11: // 十一月
        return FestivalMonth.November;
      case 12: // 十二月
        return FestivalMonth.December;
    }
    return FestivalMonth.January;
  }
}

// ignore: public_member_api_docs
enum FestivalMonth {
  // 一月
  January,
  // 二月
  February,
  // 三月
  March,
  // 四月
  April,
  // 五月
  May,
  // 六月
  June,
  // 七月
  July,
  // 八月
  August,
  // 九月
  September,
  // 十月
  October,
  // 十一月
  November,
  // 十二月
  December,
}

// ignore: public_member_api_docs
extension FestivalMonthExtension on FestivalMonth {
  String puzzleText(int year, int day, int tileValue) {
    var puzzleText = '';

    switch (tileValue) {
      case 1:
        puzzleText = 'Sun'; //'星期天';
        break;
      case 2:
        puzzleText = 'Mon'; //'星期一';
        break;
      case 3:
        puzzleText = 'Tue'; //'星期二';
        break;
      case 4:
        puzzleText = 'Wed'; //'星期三';
        break;
      case 5:
        puzzleText = 'Thu'; //'星期四';
        break;
      case 6:
        puzzleText = 'Fri'; //'星期五';
        break;
      case 7:
        puzzleText = 'Sat'; //'星期六';
        break;
      default:
    }

    const index07 = 7;
    final month = currentMonth;
    var beginDay = getBeginDay(year); //6
    var days = daysInCurrentMonth(year);

    beginDay += index07;
    days += beginDay;
    if (tileValue > index07 && tileValue <= days) {
      final dayInMonth = tileValue - beginDay;
      if (dayInMonth > 0) {
        puzzleText = dayInMonth.toString();
      } else {
        final date = DateTime.utc(year, month - 1);
        final days = DateTime(date.year, date.month + 1, 0).day;

        //ToDo 取得月名稱
        var name03 = getFestivalMonth(month - 1).name.substring(0, 3) + '\n';
        puzzleText = name03 + (days + dayInMonth).toString();
      }

      //節慶
      for (final festival in festivalDays) {
        final position = festival.dayNumber;
        if (position == dayInMonth) {
          puzzleText = festival.icon;
          //defaultColor = const Color(0xFFCCCCCC);
        }
      }

      //選取的日子
      // if (day == dayInMonth) {
      //   puzzleText = '🚩';
      // }
    } else if (tileValue > days) {
      final day = tileValue - days;
      var name03 = getFestivalMonth(month + 1).name.substring(0, 3) + '\n';
      puzzleText = name03 + (day).toString();
    }

    return puzzleText;
  }

  int getBeginDay(int year) {
    final date = DateTime.utc(year, currentMonth);
    return date.weekday;
  }

  //一個月前
  int get oneMonthAgo {
    return currentMonth - 1;
  }

  FestivalMonth getFestivalMonth(int month) {
    switch (month) {
      case 1: // 一月
        return FestivalMonth.January;
      case 2: // 二月
        return FestivalMonth.February;
      case 3: // 三月
        return FestivalMonth.March;
      case 4: // 四月
        return FestivalMonth.April;
      case 5: // 五月
        return FestivalMonth.May;
      case 6: // 六月
        return FestivalMonth.June;
      case 7: // 七月
        return FestivalMonth.July;
      case 8: // 八月
        return FestivalMonth.August;
      case 9: // 九月
        return FestivalMonth.September;
      case 10: // 十月
        return FestivalMonth.October;
      case 11: // 十一月
        return FestivalMonth.November;
      case 12: // 十二月
        return FestivalMonth.December;
    }
    return FestivalMonth.January;
  }

  //當月
  int get currentMonth {
    var month = 1;
    switch (this) {
      case FestivalMonth.January:
        month = 1;
        break;
      case FestivalMonth.February:
        month = 2;
        break;
      case FestivalMonth.March:
        month = 3;
        break;
      case FestivalMonth.April:
        month = 4;
        break;
      case FestivalMonth.May:
        month = 5;
        break;
      case FestivalMonth.June:
        month = 6;
        break;
      case FestivalMonth.July:
        month = 7;
        break;
      case FestivalMonth.August:
        month = 8;
        break;
      case FestivalMonth.September:
        month = 9;
        break;
      case FestivalMonth.October:
        month = 10;
        break;
      case FestivalMonth.November:
        month = 11;
        break;
      case FestivalMonth.December:
        month = 12;
        break;
    }
    return month;
  }

  int daysInCurrentMonth(int year) {
    return daysInMonth(year, currentMonth);
  }

  int daysInOneMonthAgo(int year) {
    return daysInMonth(year, oneMonthAgo);
  }

  int daysInMonth(int year, int month) {
    final date = DateTime.utc(year, month);
    final days = DateTime(date.year, date.month + 1, 0).day;
    return days;
  }

  List<int> get pixelPattern {
    switch (currentMonth) {
      case 1:
        return [11, 18, 25, 32, 39];
      case 2:
        return [10, 11, 12, 19, 24, 25, 26, 31, 38, 39, 40];
      case 3:
        return [10, 11, 12, 19, 24, 25, 26, 33, 38, 39, 40];
      case 4:
        return [10, 12, 17, 19, 24, 25, 26, 33, 40];
      case 5:
        return [10, 11, 12, 17, 24, 25, 26, 33, 38, 39, 40];
      case 6:
        return [10, 11, 12, 17, 24, 25, 26, 31, 33, 38, 39, 40];
      case 7:
        return [10, 11, 12, 17, 19, 26, 33, 40];
      case 8:
        return [10, 11, 12, 17, 19, 24, 25, 26, 31, 33, 38, 39, 40];
      case 9:
        return [10, 11, 12, 17, 19, 24, 25, 26, 33, 38, 39, 40];
      case 10:
        return [
          9, 16, 23, 30, 37, //1
          11, 12, 13, 18, 20, 25, 27, 32, 34, 39, 40, 41, //0
        ];
      case 11:
        return [
          9, 16, 23, 30, 37, //1
          12, 19, 26, 33, 40, //1
        ];
      case 12:
        return [
          9, 16, 23, 30, 37, //1
          11, 12, 13, 20, 25, 26, 27, 32, 39, 40, 41, //2
        ];
    }

    return [];
  }

  FestivalDay? getFestivalDay(BuildContext? context, int year, int day) {
    for (final festivalDay in getFestivalDays(context)) {
      //2022-01-29_Jason
      //Black13
      if (isBlackDay13(year, day)) {
        return FestivalDay.name(
          13,
          '13',
          country: '🌏︎🌍️🌎️',
          dayName: context?.l10n.february01,
          content: context?.l10n.february01_Content,
        );
      }

      if (festivalDay.dayNumber == day) {
        return festivalDay;
      }
    }

    return null;
  }

  List<FestivalDay> getFestivalDays(BuildContext? context) {
    switch (this) {
      case FestivalMonth.January:
        //
        return [
          //National Science Fiction Day
          //https://nationaltoday.com/national-science-fiction-day/
          FestivalDay.name(
            2,
            '🤖',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.january02,
            content: context?.l10n.january02_Content,
          ),

          //National Chocolate Covered Cherry Day
          //https://nationaltoday.com/national-chocolate-covered-cherry-day/
          // FestivalDay.name(
          //   3,
          //   '🍫',
          //   country: '🌏︎🌍️🌎️',
          //   dayName: context?.l10n.january03,
          //   content: context?.l10n.january03_Content,
          // ),

          //National Spaghetti Day
          //
          FestivalDay.name(
            4,
            '🍝',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.january04,
            content: context?.l10n.january04_Content,
          ),

          //National Milk Day
          //https://nationaltoday.com/national-milk-day/
          FestivalDay.name(
            11,
            '🥛',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.january11,
            content: context?.l10n.january11_Content,
          ),

          //National Bagel Day
          FestivalDay.name(
            15,
            '🥯',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.january15,
            content: context?.l10n.january15_Content,
          ),

          //National Popcorn Day
          //https://nationaltoday.com/national-popcorn-day/
          FestivalDay.name(
            19,
            '🍿',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.january15,
            content: context?.l10n.january15_Content,
          ),

        ];
      case FestivalMonth.February:
        return [
          //https://en.wikipedia.org/wiki/Chinese_New_Year
          // FestivalDay.name(
          //   1,
          //   '🧨',
          //   country: '🇹🇼🇨🇳',
          //   dayName: context?.l10n.february01,
          //   content: context?.l10n.february01_Content,
          // ),
          //World Wetlands Day
          //https://en.wikipedia.org/wiki/World_Wetlands_Day
          FestivalDay.name(
            2,
            '🌏︎',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.february02,
            content: context?.l10n.february02_Content,
          ),
          //情人節（2月14日）
          //https://en.wikipedia.org/wiki/Valentine%27s_Day
          FestivalDay.name(
            14,
            '💑',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.february14,
            content: context?.l10n.february14_Content,
          ),
          //國際母語日（2月21日）
          //https://en.wikipedia.org/wiki/International_Mother_Language_Day
          FestivalDay.name(
            21,
            '🌏︎',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.february21,
            content: context?.l10n.february21_Content,
          ),
          //國際北極熊日（2月27日）
          //https://en.wikipedia.org/wiki/List_of_environmental_dates
          //https://en.wikipedia.org/wiki/International_Polar_Bear_Day
          //
          FestivalDay.name(
            27,
            '🐻‍❄️',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.february27,
            content: context?.l10n.february27_Content,
          ),
        ];
      case FestivalMonth.March:
        return [
          //World Wildlife Day
          //https://en.wikipedia.org/wiki/List_of_environmental_dates
          //https://en.wikipedia.org/wiki/World_Wildlife_Day
          FestivalDay.name(
            3,
            '🌏︎',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.march03,
            content: context?.l10n.march03_Content,
          ),
          //World Consumer Rights Day
          //https://en.wikipedia.org/wiki/Consumers_International#World_Consumer_Rights_Day
          FestivalDay.name(
            15,
            '🌏︎',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.march15,
            content: context?.l10n.march15_Content,
          ),

          //International Day of Forests
          //https://en.wikipedia.org/wiki/International_Day_of_Forests
          FestivalDay.name(
            21,
            '🌳',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.march21,
            content: context?.l10n.march21_Content,
          ),
          //World Water Day
          //https://en.wikipedia.org/wiki/World_Water_Day
          FestivalDay.name(
            22,
            '🚰',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.march22,
            content: context?.l10n.march22_Content,
          ),
          //國際氣象節（2月10日）
          //https://en.wikipedia.org/wiki/World_Meteorological_Day
          FestivalDay.name(
            23,
            '⛅',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.march23,
            content: context?.l10n.march23_Content,
          ),
        ];
      case FestivalMonth.April:
        return [
          //Pillow Fight Day
          //https://en.wikipedia.org/wiki/Pillow_fight_flash_mob
          FestivalDay.name(
            2,
            '🛏️',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.april02,
            content: context?.l10n.april02_Content,
          ),
          //世界衛生日
          //World Health Day
          //https://en.wikipedia.org/wiki/World_Health_Day
          FestivalDay.name(
            7,
            '🥼',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.april07,
            content: context?.l10n.april07_Content,
          ),
          //National Pet Day
          //https://nationaldaycalendar.com/national-pet-day-april-11/
          FestivalDay.name(
            11,
            '🐶',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.april11,
            content: context?.l10n.april11_Content,
          ),
          //世界地球日
          //Earth Day
          //https://en.wikipedia.org/wiki/Earth_Day
          FestivalDay.name(
            22,
            '🌏',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.april22,
            content: context?.l10n.april22_Content,
          ),
          //World Book Night
          //https://en.wikipedia.org/wiki/World_Book_Day
          FestivalDay.name(
            23,
            '📖',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.april23,
            content: context?.l10n.april23_Content,
          ),
          //世界舞蹈日，芭雷舞
          //https://en.wikipedia.org/wiki/International_Dance_Day
          FestivalDay.name(
            29,
            '🩰',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.april29,
            content: context?.l10n.april29_Content,
          ),
        ];
      case FestivalMonth.May:
        return [
          //世界新聞自由日
          //World Press Freedom Day
          //https://en.wikipedia.org/wiki/World_Press_Freedom_Day
          FestivalDay.name(
            3,
            '🗞',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.may03,
            content: context?.l10n.may03_Content,
          ),
          //Children's Day
          //https://en.wikipedia.org/wiki/Children%27s_Day_(Japan)
          FestivalDay.name(
            5,
            '🎎',
            dayName: context?.l10n.may05,
            content: context?.l10n.may05_Content,
          ),
          //國際護士節
          //International Nurses Day
          //https://en.wikipedia.org/wiki/International_Nurses_Day
          FestivalDay.name(
            12,
            '👩‍⚕️',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.may12,
            content: context?.l10n.may12_Content,
          ),
          //世界無菸日
          //World No Tobacco Day
          //https://en.wikipedia.org/wiki/World_No_Tobacco_Day
          FestivalDay.name(
            31,
            '🚭',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.may31,
            content: context?.l10n.may31_Content,
          ),
        ];
      case FestivalMonth.June:
        return [
          //國際兒童節
          //International Children's Day
          //https://en.wikipedia.org/wiki/Children%27s_Day
          FestivalDay.name(
            1,
            '🧒',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.june01,
            content: context?.l10n.june01_Content,
          ),
          //世界環境日
          //World Environment Day
          //https://en.wikipedia.org/wiki/World_Environment_Day
          FestivalDay.name(
            5,
            '🌲',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.june05,
            content: context?.l10n.june05_Content,
          ),
          //世界海洋日
          //World Oceans Day
          //https://en.wikipedia.org/wiki/World_Oceans_Day
          FestivalDay.name(
            8,
            '🌊',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.june08,
            content: context?.l10n.june08_Content,
          ),
          //世界獻血日
          //World Blood Donor Day
          //https://en.wikipedia.org/wiki/World_Blood_Donor_Day
          FestivalDay.name(
            14,
            '🩸',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.june14,
            content: context?.l10n.june14_Content,
          ),
        ];
      case FestivalMonth.July:
        return [
          //7月2日：世界UFO日
          //World UFO Day
          //https://nationaltoday.com/world-ufo-day/
          FestivalDay.name(
            2,
            '🛸',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.july02,
            content: context?.l10n.july02_Content,
          ),
          //7月3日：讚賞你的鏡子日
          //National Compliment Your Mirror Day
          //https://nationaltoday.com/national-compliment-mirror-day/
          FestivalDay.name(
            3,
            '👍',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.july03,
            content: context?.l10n.july03_Content,
          ),
          //7月6日：世界接吻日
          //International Kissing Day
          //https://nationaltoday.com/international-kissing-day/
          FestivalDay.name(
            6,
            '💋',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.july06,
            content: context?.l10n.july06_Content,
          ),
          //7月18日：國際冰淇淋日
          //National Sour Candy Day
          //https://nationaltoday.com/national-sour-candy-day/
          FestivalDay.name(
            18,
            '🍬',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.july18,
            content: context?.l10n.july18_Content,
          ),
          //7月20日：月球日
          //National Moon Day
          //https://nationaltoday.com/national-moon-day/
          FestivalDay.name(
            20,
            '🌕',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.july20,
            content: context?.l10n.july20_Content,
          ),
          //7月21日：垃圾食物日
          //National Junk Food Day
          //https://nationaltoday.com/national-junk-food-day/
          FestivalDay.name(
            21,
            '🍔',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.july21,
            content: context?.l10n.july21_Content,
          ),
        ];
      case FestivalMonth.August:
        return [

          //National Watermelon Day
          //https://nationaltoday.com/national-watermelon-day/
          FestivalDay.name(
            3,
            '🍉',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.august03,
            content: context?.l10n.august03_Content,
          ),

          //National Root Beer Float Day
          //https://nationaltoday.com/national-root-beer-float-day/
          FestivalDay.name(
            6,
            '🍺',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.august06,
            content: context?.l10n.august06_Content,
          ),

          //International Cat Day
          //https://nationaltoday.com/international-cat-day/
          FestivalDay.name(
            8,
            '🐈',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.august08,
            content: context?.l10n.august08_Content,
          ),

          //International Lefthanders Day
          //https://nationaltoday.com/international-lefthanders-day/
          FestivalDay.name(
            13,
            '👋',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.august13,
            content: context?.l10n.august13_Content,
          ),

          //National Black Cat Appreciation Day
          //https://nationaltoday.com/national-black-cat-appreciation-day/
          FestivalDay.name(
            17,
            '🐈‍⬛',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.august17,
            content: context?.l10n.august17_Content,
          ),

          //International Dog Day
          //https://nationaltoday.com/national-dog-day/
          FestivalDay.name(
            26,
            '🐕',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.august26,
            content: context?.l10n.august26_Content,
          ),

        ];
      case FestivalMonth.September:
        return [
          //National Cheese Pizza Day
          //https://nationaltoday.com/national-cheese-pizza-day/
          FestivalDay.name(
            5,
            '🍕',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.september05,
            content: context?.l10n.september05_Content,
          ),

          //Harvest Moon Festival
          //https://nationaltoday.com/harvest-moon-festival-south-korea/
          FestivalDay.name(
            10,
            '🌕',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.september10,
            content: context?.l10n.september10_Content,
          ),

          //National Guacamole Day
          //https://nationaltoday.com/national-guacamole-day/
          //
          FestivalDay.name(
            16,
            '🥑',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.september16,
            content: context?.l10n.september16_Content,
          ),

          //國際和平日
          //International Day of Peace
          //https://nationaltoday.com/international-day-of-peace/
          FestivalDay.name(
            21,
            '🕊',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.september21,
            content: context?.l10n.september21_Content,
          ),
          //國際手語日
          //International Day of Sign Languages
          //https://nationaltoday.com/international-day-of-sign-languages/
          FestivalDay.name(
            23,
            '✋',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.september23,
            content: context?.l10n.september23_Content,
          ),
          //世界旅遊日
          //World Tourism Day
          //https://nationaltoday.com/world-tourism-day/
          FestivalDay.name(
            27,
            '🧳',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.september27,
            content: context?.l10n.september27_Content,
          ),
        ];
      case FestivalMonth.October:
        //4_世界動物日
        //5_世界教師日
        //9_世界郵政日
        //31_萬聖夜
        return [
          //International Coffee Day
          //https://nationaltoday.com/international-coffee-day/
          FestivalDay.name(
            1,
            '☕',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.october01,
            content: context?.l10n.october01_Content,
          ),

          //World Post Day
          FestivalDay.name(
            9,
            '📮',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.october09,
            content: context?.l10n.october09_Content,
          ),

          //National Cake Decorating Day
          //https://nationaltoday.com/national-cake-decorating-day/
          FestivalDay.name(
            10,
            '☕',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.october10,
            content: context?.l10n.october10_Content,
          ),

          //National Pregnancy and Infant Loss Remembrance Day
          //
          FestivalDay.name(
            15,
            '🤰',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.october15,
            content: context?.l10n.october15_Content,
          ),

          //National Apple Day
          //
          FestivalDay.name(
            21,
            '🍎',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.october21,
            content: context?.l10n.october21_Content,
          ),

          //Halloween
          //https://nationaltoday.com/halloween/
          FestivalDay.name(
            31,
            '🎃',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.october31,
            content: context?.l10n.october31_Content,
          ),
        ];
      case FestivalMonth.November:
        //4_世界動物日
        //5_世界教師日
        //9_世界郵政日
        //11_退伍軍人節
        //24_美國感恩節_第四個星期四
        return [

          //Day of the Dead
          //https://nationaltoday.com/day-of-the-dead/
          FestivalDay.name(
            2,
            '💀',
            country: '🇲🇽',
            dayName: context?.l10n.november02,
            content: context?.l10n.november02_Content,
          ),

          //Japanese Culture Day
          //https://nationaltoday.com/japanese-culture-day/
          FestivalDay.name(
            3,
            '👘',
            country: '🇯🇵',
            dayName: context?.l10n.november03,
            content: context?.l10n.november03_Content,
          ),

          //National Fried Chicken Sandwich Day
          FestivalDay.name(
            9,
            '🥪',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.november09,
            content: context?.l10n.november09_Content,
          ),

          //National Pickle Day
          //
          FestivalDay.name(
            14,
            '🥒',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.november14,
            content: context?.l10n.november14_Content,
          ),

          //火雞
          FestivalDay.name(
            24,
            '🦃',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.november24,
            content: context?.l10n.november24_Content,
          ),
        ];
      case FestivalMonth.December:
        //3_國際殘疾人日
        //25_聖誕節
        return [

          //International Ninja Day
          //:ninja
          FestivalDay.name(
            5,
            '🥷',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.december05,
            content: context?.l10n.december05_Content,
          ),


          //️National Miners Day
          FestivalDay.name(
            6,
            '⛏',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.december06,
            content: context?.l10n.december06_Content,
          ),

          //National Horse Day
          //
          FestivalDay.name(
          13,
            '🐴',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.december13,
            content: context?.l10n.december13_Content,
          ),

          //National Cookie Exchange Day
          //
          FestivalDay.name(
            22,
            '🍪',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.december22,
            content: context?.l10n.december22_Content,
          ),


          //Christmas
          FestivalDay.name(
            25,
            '🎄',
            country: '🌏︎🌍️🌎️',
            dayName: context?.l10n.december25,
            content: context?.l10n.december25_Content,
          ),
        ];
      default:
        return [];
    }

    //http://udel.edu/stu-org/tsa/newcomer_holidays.html
  }

  List<FestivalDay> get festivalDays => getFestivalDays(null);

  bool isFestivalDay(int year, int dayInMonth) {
    //節慶
    for (final festival in festivalDays) {
      final position = festival.dayNumber;
      if (position == dayInMonth) {
        return true;
      }
    }

    return false;
  }

  bool isDayInMonth(int year, int tileValue) {
    return getDayInMonth(year, tileValue) != -1;
  }

  int getDayInMonth(int year, int tileValue) {
    const index07 = 7;
    var beginDay = getBeginDay(year); //6
    var days = daysInCurrentMonth(year);

    beginDay += index07;
    days += beginDay;
    if (tileValue > index07 && tileValue <= days) {
      final dayInMonth = tileValue - beginDay;
      if (dayInMonth > 0) {
        return dayInMonth;
      }
    }

    return -1;
  }

  /// 黑色星期五
  bool isBlackDay(int year, int tileValue) {
    const blackDay = 13;

    bool isFriday;
    {
      final calendar = DateTime.utc(year, currentMonth, blackDay);
      isFriday = 5 == (calendar.weekday);
    }

    bool isBlack;
    {
      isBlack = getDayInMonth(year, tileValue) == blackDay;
    }

    if (isFriday && isBlack) {
      return true;
    }
    return false;
  }

  bool isBlackDay13(int year, int day) {
    const blackDay = 13;

    bool isFriday;
    {
      final calendar = DateTime.utc(year, currentMonth, blackDay);
      isFriday = 5 == (calendar.weekday);
    }

    bool isBlack;
    {
      isBlack = day == blackDay;
    }

    if (isFriday && isBlack) {
      return true;
    }
    return false;
  }

  /// 取得主題
  SimpleTheme get theme {
    var theme = const SimpleTheme();
    switch (this) {
      case FestivalMonth.January:
      case FestivalMonth.February:
        theme = const SeasonTheme02();
        break;
      case FestivalMonth.March:
      case FestivalMonth.April:
        theme = const SeasonTheme04();
        break;
      case FestivalMonth.May:
      case FestivalMonth.June:
        theme = const SeasonTheme06();
        break;
      case FestivalMonth.July:
      case FestivalMonth.August:
        theme = const SeasonTheme08();
        break;
      case FestivalMonth.September:
      case FestivalMonth.October:
        theme = const SeasonTheme10();
        break;
      case FestivalMonth.November:
      case FestivalMonth.December:
        theme = const SeasonTheme12();
        break;
    }

    return theme;
  }
}

class FestivalDay {
  FestivalDay.name(this.dayNumber, this.icon,
      {this.dayName, this.country, this.content});

  int dayNumber;
  String icon;
  String? country = '';
  String? dayName = '';
  String? content = '';
}
