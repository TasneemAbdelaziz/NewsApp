import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/Api/api_constants.dart';
import 'package:news/Model/NewsResponse.dart';
import 'package:news/Model/sourceRespond.dart';

class apiManager {
  static Future<SourceRespond?> getSource(String categoryId) async {
    // https://newsapi.org/v2/top-headlines/sources?apiKey=449fd89e1e904d3e99e0b7aed9724d97
    Uri url = Uri.https(apiConstants.baseUrl, apiConstants.api,
        {"apiKey": "46d659bda4d546a1881d231e0f16d1a7",
          "category":categoryId,
        });

    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return SourceRespond.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, String? q}
      ) async {
    // https://newsapi.org/v2/everything?q=apple&from=2023-10-21&to=2023-10-21&sortBy=popularity&apiKe
    Uri url = Uri.https(apiConstants.baseUrl, apiConstants.newsApi, {
      "apiKey": "46d659bda4d546a1881d231e0f16d1a7",
      'sources': sourceId,
      "q":q
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
