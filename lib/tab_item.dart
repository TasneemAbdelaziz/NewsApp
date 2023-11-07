import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Model/sourceRespond.dart';
import 'package:news/Theming/my-theme.dart';

class tabItem extends StatelessWidget{
  bool isSelected;
  Source source ;

  tabItem({required this.isSelected,required this.source });
  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 3,color: myTheme.primaryLight),
          color: isSelected == true ? myTheme.primaryLight:Colors.transparent,
        ),
        child: Text(source.name ?? '',style:isSelected == false? Theme.of(context).textTheme.titleMedium: Theme.of(context).textTheme.titleMedium!.copyWith(color: myTheme.whitColor) ),
      );
  }

}