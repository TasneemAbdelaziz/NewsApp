import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Api/apiManager.dart';
import 'package:news/Api/api_constants.dart';
import 'package:news/Model/NewsResponse.dart';
import 'package:news/Model/sourceRespond.dart';
import 'package:news/News/news_view_model.dart';
import 'package:news/Theming/my-theme.dart';
import 'package:news/News/newsItem.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class newsContainer extends StatefulWidget {
  Source source;
  NewsViewModel newsViewModel = NewsViewModel();

  newsContainer({required this.source});

  @override
  State<newsContainer> createState() => _newsContainerState();

}

class _newsContainerState extends State<newsContainer> {
  final controller = ScrollController();
  final _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    widget.newsViewModel.getNews(widget.source.id);
    _scrollController.addListener(_loadMore);
    _fetchData(_currentPage, widget.source.id!);

  }

  Future<void> _fetchData(int pageKey, String id) async {
    Uri url = Uri.https(apiConstants.baseUrl, apiConstants.api, {
      "apiKey": "449fd89e1e904d3e99e0b7aed9724d97",
      "category": id,
      "page": pageKey.toString()
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {

        widget.newsViewModel.newsList!.addAll(List<News>.from(json.decode(response.body)));
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _fetchData(_currentPage, widget.source.id!);
    }
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => widget.newsViewModel,
      child: Consumer<NewsViewModel>(builder: (context, newsViewModel, child) {
        if (newsViewModel.errorMessage != null) {
          return Center(
            child: Column(
              children: [
                Text("SomeThing went Wrong"),
                ElevatedButton(
                    onPressed: () {
                      apiManager.getNewsBySourceId(
                          sourceId: widget.source.id ?? "");
                      setState(() {});
                    },
                    child: Text("Try Again"))
              ],
            ),
          );
        } else if (newsViewModel.newsList == null) {
          return Center(
              child: CircularProgressIndicator(
            color: myTheme.primaryLight,
          ));
        } else {
          return Expanded(
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                final item =newsViewModel.newsList![index];
                return newsItem(news: item);
              },
              itemCount:newsViewModel.newsList!.length,
            ),
          );
        }
      }),
    );

    // Expanded(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       FutureBuilder<NewsResponse?>(
    //           future: apiManager.getNewsBySourceId(sourceId: widget.source.id??""),
    //           builder: (_,snapshot){
    //             if(snapshot.connectionState == ConnectionState.waiting){
    //               return Center(
    //                   child: CircularProgressIndicator(color: myTheme.primaryLight,)
    //               );
    //             }
    //             else if(snapshot.hasError){
    //               return Center(
    //                 child: Column(
    //                   children: [
    //                     Text("SomeThing went Wrong"),
    //                     ElevatedButton(onPressed: (){
    //                       apiManager.getNewsBySourceId(sourceId: widget.source.id??"");
    //                       setState(() {
    //
    //                       });
    //                     }, child: Text("Try Again"))
    //                   ],
    //                 ),
    //               );
    //             }
    //             if(snapshot.data?.status != "ok"){
    //               return Center(
    //                 child: Column(
    //                   children: [
    //                     Text("SomeThing went Wrong"),
    //                     ElevatedButton(onPressed: (){
    //                       apiManager.getNewsBySourceId(sourceId: widget.source?.id??"");
    //                       setState(() {
    //
    //                       });
    //                     }, child: Text("Try Again"))
    //                   ],
    //                 ),
    //               );
    //             }
    //              newsList = snapshot.data?.articles ?? [];
    //             return Expanded(
    //               child: ListView.builder(
    //                 controller: controller,
    //                 itemBuilder: (context,index){
    //                   final item = newsList[index];
    //                   return
    //                     newsItem(news: item);
    //               },
    //               itemCount: newsList.length,
    //               ),
    //             );
    //           }
    //       ),
    //     ],
    //   ),
    // );
  }
}
