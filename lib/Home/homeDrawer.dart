import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Model/categoryItemsModel.dart';
import 'package:news/Theming/my-theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class homeDrawer extends StatelessWidget {
  Function ClickonDrawerItem ;
  homeDrawer({required this.ClickonDrawerItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.15,
          color: myTheme.primaryLight,
          child: Center(
              child: Text(
                  "${AppLocalizations.of(context)!.news_app}!",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: (){
            ClickonDrawerItem(0);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.list_rounded,size: 35,color: myTheme.blackColor,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.categories,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 25),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: (){
            ClickonDrawerItem(1);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.settings,size: 35,color: myTheme.blackColor,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.settings,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

}
