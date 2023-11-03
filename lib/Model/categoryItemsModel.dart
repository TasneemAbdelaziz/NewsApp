import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class categoryItemsModel {
  String imageUrl;
  String title;
  int color;
  String id;

  categoryItemsModel(
      {required this.imageUrl,
      required this.title,
      required this.color,
      required this.id});

  static List<categoryItemsModel> getCategory(BuildContext context) {
    return [
      //  entertainment general technology
      categoryItemsModel(
          imageUrl: "assets/images/sports.png",
          title: AppLocalizations.of(context)!.sports,
          id: 'sports',
          color: 0xffC91C22),
      categoryItemsModel(
          imageUrl: "assets/images/politics.png",
          title: AppLocalizations.of(context)!.entertainment,
          id: 'entertainment',
          color: 0xff003E90),
      categoryItemsModel(
          imageUrl: "assets/images/health.png",
          title: AppLocalizations.of(context)!.health,
          id: "health",
          color: 0xffED1E79),
      categoryItemsModel(
          imageUrl: "assets/images/bussines.png",
          title: AppLocalizations.of(context)!.business,
          id: "business",
          color: 0xffCF7E48),
      categoryItemsModel(
          imageUrl: "assets/images/environment.png",
          title: AppLocalizations.of(context)!.technology,
          id: "technology",
          color: 0xff4882CF),
      categoryItemsModel(
          imageUrl: "assets/images/science.png",
          title: AppLocalizations.of(context)!.science,
          id: "science",
          color: 0xffF2D352),
      categoryItemsModel(
          imageUrl: "assets/images/science.png",
          title: AppLocalizations.of(context)!.general,
          id: "general",
          color: 0xffF2D352),

    ];
  }
}
