import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Api/apiManager.dart';
import 'package:news/Model/categoryItemsModel.dart';
import 'package:news/Model/sourceRespond.dart';
import 'package:news/Theming/my-theme.dart';
import 'package:news/category/category_item.dart';
import 'package:news/category/category_view_model.dart';
import 'package:news/tab_container.dart';
import 'package:provider/provider.dart';

class categoryDetails extends StatefulWidget{
  static String routeName = "categoryDetails";
   // late Source source;
   categoryItemsModel categoryItemsModel1;

  CategoryViewModel categoryViewModel = CategoryViewModel();

  @override
  State<categoryDetails> createState() => _categoryDetailsState();

  categoryDetails({required this.categoryItemsModel1});

}


class _categoryDetailsState extends State<categoryDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.categoryViewModel.getSources(widget.categoryItemsModel1.id);
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:

        // FutureBuilder<SourceRespond?>(
        //   future: apiManager.getSource(widget.categoryItemsModel1.id),
        //   builder:(_,snapshot){
        //     if(snapshot.connectionState == ConnectionState.waiting){
        //       return Center(
        //         child: CircularProgressIndicator(color: myTheme.primaryLight,),
        //       );
        //     }else if(snapshot.hasError){
        //       return Center(
        //         child: Column(
        //           children: [
        //             Text("SomeThing wrong"),
        //             ElevatedButton(onPressed: (){
        //               apiManager.getSource(widget.categoryItemsModel1.id);
        //               setState(() {
        //
        //               });
        //             }, child: Text("Try Again"))
        //           ],
        //         ),
        //       );
        //       }
        //     if(snapshot.data?.status != 'ok'){
        //       return Center(
        //         child: Column(
        //           children: [
        //             Text(snapshot.data?.message??""),
        //             ElevatedButton(onPressed: (){
        //               apiManager.getSource(widget.categoryItemsModel1.id);
        //               setState(() {
        //
        //               });
        //             }, child: Text("Try Again"))
        //           ],
        //         ),
        //       );
        //     }
        //       var sourceList = snapshot.data?.sources ?? [];
        //       SourceRespond s = new SourceRespond();
        //       return tabContainer(sourceList: sourceList);
        //   },
        // ),
        ChangeNotifierProvider(
          create: (context) => widget.categoryViewModel,
          child: Consumer<CategoryViewModel>(
              builder: (context, categoryViewModel, child) {
                if (categoryViewModel.errorMessage != null) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          categoryViewModel.errorMessage!,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myTheme.greyColor),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              myTheme.whitColor, // background (button) color
                              foregroundColor: Colors.white, // foreground (text) color
                            ),
                            onPressed: () {
                              widget.categoryViewModel.getSources(widget.categoryItemsModel1.id);
                            },
                            child: Text("Try Again"))
                      ],
                    ),
                  );
                } else if (categoryViewModel.sourceList == null) {
                  return Center(
                      child: CircularProgressIndicator(
                        color: myTheme.primaryLight,
                      ));
                } else {
                  return tabContainer(sourceList: widget.categoryViewModel.sourceList ??[]);
                }
              }),
        ),

      );
  }
}