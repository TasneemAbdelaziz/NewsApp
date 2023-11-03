import 'package:flutter/cupertino.dart';
import 'package:news/Api/apiManager.dart';
import 'package:news/Model/sourceRespond.dart';

class CategoryViewModel extends ChangeNotifier{
  List<Source>? sourceList ;
  String? errorMessage;

  void getSources (String sourceId)async{
    sourceList = null;
    errorMessage = null;
    notifyListeners();
    try{
      var response = await apiManager.getSource(sourceId);
      if(response?.status != 'ok' ){
        errorMessage = response?.message;
      }
      else{
        sourceList = response?.sources;
      }
    }
    catch(e){
      errorMessage = "Error Loading";
    }
    notifyListeners();
  }
}