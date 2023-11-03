import 'package:flutter/material.dart';
import 'package:news/Api/apiManager.dart';
import 'package:news/Model/NewsResponse.dart';
import 'package:news/News/newsItem.dart';
import 'package:news/Theming/my-theme.dart';

class searchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
      IconButton(onPressed:()=>showResults(context) , icon: Icon(Icons.search)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container(
      child:
      IconButton(onPressed:(){Navigator.pop(context);} , icon: Icon(Icons.close)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<NewsResponse?>(
                future: apiManager.getNewsBySourceId(q: query),
                builder: (_,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                        child: CircularProgressIndicator(color: myTheme.primaryLight,)
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: Column(
                        children: [
                          Text("SomeThing went Wrong"),
                          ElevatedButton(onPressed: (){
                            apiManager.getNewsBySourceId(q: query);

                          }, child: Text("Try Again"))
                        ],
                      ),
                    );
                  }
                  if(snapshot.data?.status != "ok"){
                    return Center(
                      child: Column(
                        children: [
                          Text("SomeThing went Wrong"),
                          ElevatedButton(onPressed: (){
                            apiManager.getNewsBySourceId(q: query);

                          }, child: Text("Try Again"))
                        ],
                      ),
                    );
                  }
                  var newsList = snapshot.data?.articles ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index){
                        if(index < newsList.length)
                        {
                          final item = newsList[index];
                          return
                            newsItem(news: item);
                        }
                        else{
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                      },
                      itemCount: newsList.length+1,
                    ),
                  );
                }
            ),
          ],
        ),
      );

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query == "")
      {
        return Center(child: Text("Suggestions"));
      }
    return
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<NewsResponse?>(
                future: apiManager.getNewsBySourceId(q: query),
                builder: (_,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                        child: CircularProgressIndicator(color: myTheme.primaryLight,)
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: Column(
                        children: [
                          Text("SomeThing went Wrong"),
                          ElevatedButton(onPressed: (){
                            apiManager.getNewsBySourceId(q: query);

                          }, child: Text("Try Again"))
                        ],
                      ),
                    );
                  }
                  if(snapshot.data?.status != "ok"){
                    return Center(
                      child: Column(
                        children: [
                          Text("SomeThing went Wrong"),
                          ElevatedButton(onPressed: (){
                            apiManager.getNewsBySourceId(q: query);

                          }, child: Text("Try Again"))
                        ],
                      ),
                    );
                  }
                  var newsList = snapshot.data?.articles ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index){
                        if(index < newsList.length)
                        {
                          final item = newsList[index];
                          return
                            newsItem(news: item);
                        }
                        else{
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                      },
                      itemCount: newsList.length+1,
                    ),
                  );
                }
            ),
          ],
        ),
      );


  }

  ThemeData appBarTheme(BuildContext context) {
     return ThemeData(
      textTheme: TextTheme(
        // Use this to change the query's text style
        headline6: TextStyle(fontSize: 24.0, color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,


        // Use this change the placeholder's text style
        hintStyle: TextStyle(fontSize: 20.0),
      ),
    );
  }
  
}