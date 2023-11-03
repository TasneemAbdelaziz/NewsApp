
import 'package:flutter/cupertino.dart';
import 'package:news/Api/apiManager.dart';
import 'package:news/Model/NewsResponse.dart';

class NewsViewModel extends ChangeNotifier{
  List<News>? newsList;
  String? errorMessage;

  void getNews(String? sourceId)async{
    newsList = null;
    errorMessage=null;
    notifyListeners();
    try{
      var response = await apiManager.getNewsBySourceId(sourceId: sourceId);
      if(response?.status != 'ok'){
        errorMessage = response?.message;
      }else{
        newsList = response?.articles;
      }

    }
    catch(e){
      errorMessage = "Loading Connection";
    }
    notifyListeners();

  }
}