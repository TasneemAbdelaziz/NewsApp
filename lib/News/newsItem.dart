import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/Model/NewsResponse.dart';
import 'package:news/News/NewsContent.dart';
import 'package:news/Theming/my-theme.dart';

class newsItem extends StatelessWidget {
  News news;

  newsItem({required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(NewsContent.routeName, arguments: {
          "image": news.urlToImage,
          "author": news.author,
          "description": news.description,
          "publishedAt": news.publishedAt,
          "content": news.content,
          "url": news.url
        });

      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
                imageUrl: news.urlToImage ?? "",
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: myTheme.primaryLight,
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(news.author ?? "",
                style: Theme.of(context).textTheme.titleSmall),
            SizedBox(
              height: 8,
            ),
            Text(news.description ?? "",
                style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: 8,
            ),
            Text(
              news.publishedAt ?? "",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
