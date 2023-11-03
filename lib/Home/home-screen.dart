import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Home/homeDrawer.dart';
import 'package:news/Model/categoryItemsModel.dart';
import 'package:news/Search/search_delegate.dart';
import 'package:news/Theming/my-theme.dart';
import 'package:news/category/category_details.dart';
import 'package:news/category/category_items.dart';
import 'package:news/settings_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class homeScreen extends StatefulWidget {
  static String routeName = "homeScreen";

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: homeDrawer(ClickonDrawerItem: ClickonDrawerItem),
      ),
      appBar: AppBar(
        actions: [IconButton(onPressed: ()=>showSearch(context: context, delegate:searchDelegate() ), icon: Icon(Icons.search))],
        title: Text(selectedDrawerItem == 1
            ? AppLocalizations.of(context)!.settings
            : selectedCategory == null
                ? AppLocalizations.of(context)!.news_app
                : selectedCategory!.title),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      body: selectedDrawerItem == 1
          ? Settings()
          : selectedCategory == null
              ? categoryItems(categoryOnClick: categoryOnClick)
              : categoryDetails(categoryItemsModel1: selectedCategory!),
    );
  }

  categoryItemsModel? selectedCategory;

  void categoryOnClick(categoryItemsModel newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  int selectedDrawerItem = 0;
  void ClickonDrawerItem(int newSelectedDrawerItem) {
    selectedDrawerItem = newSelectedDrawerItem;
    selectedCategory = null;
    setState(() {});
  }
}
