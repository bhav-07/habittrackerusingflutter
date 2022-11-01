import 'package:habit_tracker_flutter/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  //initialize a empty list
  List todaysHabitlist = [];
  
  //dataset to store the date and the percentage string
  Map<DateTime, int> heatMapDataSet = {
    DateTime(2022, 10, 11): 4,
    DateTime(2022, 10, 12): 3,
    DateTime(2022, 10, 13): 8,
    DateTime(2022, 10, 14): 1,
    DateTime(2022, 10, 15): 0,
    DateTime(2022, 10, 17): 8,
    DateTime(2022, 10, 18): 6,
    DateTime(2022, 10, 19): 6,
    DateTime(2022, 10, 20): 2,
    DateTime(2022, 10, 21): 7,
    DateTime(2022, 10, 22): 8,
    DateTime(2022, 10, 23): 9,
    DateTime(2022, 10, 24): 5,
    DateTime(2022, 10, 25): 2,
    DateTime(2022, 10, 26): 4,
    DateTime(2022, 10, 28): 8,
    DateTime(2022, 10, 29): 6,
    DateTime(2022, 10, 30): 7,
  };

  //create
  void createDefaultData() {
    todaysHabitlist = [
      ["Meditate", false],
      ["Run", false]
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //read
  void loadData() {
    //new day
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitlist = _myBox.get("CURRENT_HABIT_LIST");
      //to set all habits to false
      for (int i = 0; i < todaysHabitlist.length; i++) {
        todaysHabitlist[i][1] == false;
      }
    } else {
      todaysHabitlist = _myBox.get(todaysDateFormatted());
    }
  }

  //update
  void updateData() {
    //update today's entry
    _myBox.put(todaysDateFormatted(), todaysHabitlist);
    //update universal habit list (if its changed)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitlist);
    calculateHabitPercentages();

    // load heat map
    loadHeatMap();
  }

  //habit percentage calculations
  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitlist.length; i++) {
      if (todaysHabitlist[i][1] == true) {
        countCompleted++;
      }
    }
    String percent = todaysHabitlist.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitlist.length).toStringAsFixed(1);
    //to put the values in the heatmap
    //key= "percentage summary of a particular day"
    //value= string percent which lies in 0-1
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    //number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;
    for (int i = 0; i < daysInBetween + 1; i++) {
      String? yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
