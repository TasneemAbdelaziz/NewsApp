import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Model/categoryItemsModel.dart';
import 'package:news/category/category_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class categoryItems extends StatefulWidget {
  static String routeName = "categoryItems";

  Function categoryOnClick;


  categoryItems({required this.categoryOnClick});

  @override
  State<categoryItems> createState() => _categoryItemsState();
}

class _categoryItemsState extends State<categoryItems> {
  late List<categoryItemsModel> s;


  final seachTextController = TextEditingController();

  late List<categoryItemsModel> categoriesList;

  // Widget bulidField(){
  @override
  Widget build(BuildContext context) {
    categoriesList = categoryItemsModel.getCategory(context);

    return Stack(
      children: [
        Image.asset(
          'assets/images/pattern.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: seachTextController,
                onChanged: (searchedCategory) {
                  addSearchedItemsTOSearchedList(searchedCategory);
                },
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: Text(
                AppLocalizations.of(context)!.pick_category,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 25),
                textAlign: TextAlign.start,
              )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          widget.categoryOnClick(categoriesList[index]);
                        },
                        child: categoryItem(
                            categoryItemsModel1:seachTextController.text.isEmpty? categoriesList[index] : s[index] ,
                            index: index));
                  },
                  itemCount:seachTextController.text.isEmpty? categoriesList.length : s.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addSearchedItemsTOSearchedList(String searchedCategory) {
    s = categoriesList
        .where((element) =>
            element.title.toLowerCase().startsWith(searchedCategory))
        .toList();
        setState(() {

        });
  }
}
