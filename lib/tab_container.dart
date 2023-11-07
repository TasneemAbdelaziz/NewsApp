import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Model/NewsResponse.dart';
import 'package:news/Model/sourceRespond.dart';
import 'package:news/News/news_container.dart';
import 'package:news/tab_item.dart';

class tabContainer extends StatefulWidget {
  List<Source> sourceList;

  tabContainer({
    required this.sourceList,
  });

  @override
  State<tabContainer> createState() => _tabContainerState();
}

class _tabContainerState extends State<tabContainer> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              selectedIndex = index;
              setState(() {

              });
            },
            isScrollable: true,
            indicatorColor: Colors.transparent,
            tabs: widget.sourceList
                .map((source) => tabItem(
                      isSelected:
                          selectedIndex == widget.sourceList.indexOf(source),
                      source: source,
                    ))
                .toList(),
          ),
          newsContainer(
            source: widget.sourceList[selectedIndex],
          ),
        ],
      ),
    );
  }
}
