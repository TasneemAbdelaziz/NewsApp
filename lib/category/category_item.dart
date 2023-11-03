import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Model/categoryItemsModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class categoryItem extends StatelessWidget {
  categoryItemsModel categoryItemsModel1;
  int index;
  categoryItem({required this.categoryItemsModel1, required this.index,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(categoryItemsModel1.color),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                index % 2 == 0 ? 0 : 40,
              ),
              bottomLeft: Radius.circular(
                index % 2 == 0 ? 40 : 0,
              ),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40))),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.asset(categoryItemsModel1.imageUrl, height: MediaQuery.of(context).size.height*0.14),
          Text(
            categoryItemsModel1.title,

            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
