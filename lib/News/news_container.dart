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

  newsContainer({required this.source});

  @override
  State<newsContainer> createState() => _newsContainerState();
}

class _newsContainerState extends State<newsContainer> {
  NewsViewModel newsViewModel = NewsViewModel();

  final scrollcontroller = ScrollController();

  List<News> news = [];
  int pageNumber = 1;
  bool shouldLoad = false;

  // final controller = ScrollController();
  // final _scrollController = ScrollController();
  // int _currentPage = 1;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  // }
  //
  // void _loadMore() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     _currentPage++;
  //     _fetchData(_currentPage, widget.source.id!);
  //   }
  // }
  //
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  // // Future<void> _fetchData(int pageKey, String id) async {
  //   Uri url = Uri.https(apiConstants.baseUrl, apiConstants.api, {
  //     "apiKey": "449fd89e1e904d3e99e0b7aed9724d97",
  //     "category": id,
  //     "page": pageKey.toString()
  //   });
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //
  //       widget.newsViewModel.newsList!.addAll(List<News>.from(json.decode(response.body)));
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
  //

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    scrollcontroller.addListener(() {
      //بمعنى هل انا فى الحافه بتاعت الصفحه يعنى ان فى الtop or bottom
      if (scrollcontroller.position.atEdge) {
        bool onTop = scrollcontroller.position.pixels == 0;
        if (!onTop) {
          print("$onTop");
          shouldLoad = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    newsViewModel.getNews(widget.source.id);
    if (shouldLoad == true) {
      apiManager
          .getNewsBySourceId(page: ++pageNumber, sourceId: widget.source.id)
          .then((NewsResponse) => news.addAll(NewsResponse?.articles ?? []));
      print('Page number ${pageNumber}');
      shouldLoad = false;
      setState(() {});
    }
    // print("----------------------");
    // print(widget.source.id);
    // print("----------------------");
    return ChangeNotifierProvider(
      create: (context) => newsViewModel,
      child: Consumer<NewsViewModel>(builder: (context, newsViewModel, child) {
        if (newsViewModel.errorMessage != null) {
          return Center(
            child: Column(
              children: [
                Text("SomeThing went Wrong"),
                ElevatedButton(
                    onPressed: () {
                      newsViewModel.getNews(widget.source.id ?? "");
                      setState(() {});
                    },
                    child: Text("Try Again"))
              ],
            ),
          );
        } else if (newsViewModel.newsList == null ) {
          return Center(
              child: CircularProgressIndicator(
            color: myTheme.primaryLight,
          ));
        } else {
          return Expanded(
            child: ListView.builder(
              controller: scrollcontroller,
              itemBuilder: (context, index) {
                var item = newsViewModel.newsList![index];
                if (news.isEmpty) {
                  news = newsViewModel.newsList!;
                  print("${news.length} in side if ");
                } else if (news.first.title !=
                    newsViewModel.newsList!.first.title) {
                  news = newsViewModel.newsList!;
                  scrollcontroller.jumpTo(0);
                }
                print("${news.length} out side if ");
                return newsItem(news: item);
              },
              itemCount: newsViewModel.newsList!.length,
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

  @override
  void dispose() {
    // TODO: implement dispose
    scrollcontroller.dispose();
    super.dispose();
  }
}
