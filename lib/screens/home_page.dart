import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/components/add_habit.dart';
import 'package:habit_tracker_flutter/components/alert_box.dart';
import 'package:habit_tracker_flutter/components/monthly_summary.dart';
import 'package:habit_tracker_flutter/data/habit_database.dart';
import 'package:hive/hive.dart';

import '../components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db =HabitDatabase();
  final _myBox = Hive.box('Habit_Database' );


 @override
 void initState(){
//Data loading, reading and updating

  if (_myBox.get("CURRENT_HABIT_LIST")==null) {
    db.createDefaultData();
    
  }
  else{
    db.loadData();
  }
  db.updateData();
  super.initState();
  }
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitlist[index][1] = value;
      
    }
    );
    db.updateData();

    super.initState();
  }

  //variable
  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            controller: _newHabitNameController,
            onPressedsave: saveNewHabit,
            onPressedcancel: cancelDialogBox,
          );
        });
        db.updateData();
  }

  //save the habit
  void saveNewHabit() {
    setState(() {
      db.todaysHabitlist.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateData();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

//open habit settings
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
            onPressedsave: () => saveExistingHabit(index),
            onPressedcancel: cancelDialogBox,
            controller: _newHabitNameController);
      },
    );
  }

//method for saving existing habit with new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitlist[index][0] = _newHabitNameController.text;
      
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
    db.updateData();

  }

//method to delete a habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitlist.removeAt(index);

    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        body: ListView(children: [
          //monthly summary
          MonthlySummary(datasets: db.heatMapDataSet, startDate: _myBox.get("START_DATE")), 
        
          //habit lists
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitlist.length,
              itemBuilder: (context, index) {
            return HabitTile(
              habitname: db.todaysHabitlist[index][0],
              habitcompleted: db.todaysHabitlist[index][1],
              onChanged: (value) => checkBoxTapped(value, index),
              settingsTapped: (context) => openHabitSettings(index),
              deleteTapped: (context) => deleteHabit(index),
            );
          },
        )
        ],
          
        ));
  }
}
