import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitname;
  final bool habitcompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  HabitTile(
      {super.key,
      required this.habitname,
      required this.habitcompleted,
      required this.onChanged,
      required this.settingsTapped,
      required this.deleteTapped,
      });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Slidable(
          endActionPane: ActionPane(
            motion:const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: settingsTapped,
                backgroundColor:Color.fromARGB(255, 84, 79, 79),
                icon:Icons.settings,
                borderRadius: BorderRadius.circular(12),
          ),
              SlidableAction(
                onPressed: deleteTapped,
                backgroundColor:Color.fromARGB(255, 205, 61, 61),
                icon:Icons.delete,
                borderRadius: BorderRadius.circular(12),
          )]),
          child: Container(
            
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                
                color: habitcompleted ? Colors.green[300]:Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                //checkbox
                Checkbox(value: habitcompleted, onChanged: onChanged ),
                Text(habitname,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                Spacer(),
                Icon(Icons.arrow_back_ios,color: Colors.grey[800], )
              ,]
            ),
          ),
        ));
  }
}
