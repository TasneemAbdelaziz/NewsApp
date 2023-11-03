import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class appConfigProvider extends ChangeNotifier{
   String appLanguage = "en";

   void changeAppLanguage(String newAppLanguage)
  {
    if(appLanguage == newAppLanguage){
      return;
    }
    else{
      appLanguage = newAppLanguage;
    }
    notifyListeners();
  }
}