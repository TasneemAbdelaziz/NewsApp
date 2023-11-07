import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Theming/my-theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsContent extends StatefulWidget {
  static String routeName = "NewsContent";

  @override
  State<NewsContent> createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  late Uri _url;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    _url = Uri.parse(arguments["url"]);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("News title")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
                imageUrl: arguments["image"] ?? "",
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: myTheme.primaryLight,
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Spacer(),
            Text(arguments["author"] ?? "",
                style: Theme.of(context).textTheme.titleSmall),
            Spacer(),
            Text(arguments["description"] ?? "",
                style: Theme.of(context).textTheme.bodyLarge),
            Spacer(),
            Text(
              arguments["publishedAt"] ?? "",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.end,
            ),
            Spacer(),
            Text(arguments["content"] ?? "",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: myTheme.blackColor, fontWeight: FontWeight.normal)),
            Spacer(
              flex: 5,
            ),
            TextButton(
              onPressed: _launchUrl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "View Full Artical",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: myTheme.blackColor,
                    size: 30,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
