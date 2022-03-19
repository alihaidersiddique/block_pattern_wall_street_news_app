import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:block_pattern_wall_street_news_app/news_model.dart';

enum NewsAction { fetch, delete }

class NewsBloc {
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get eventStream => _eventStreamController.stream;

  NewsBloc() {
    eventStream.listen((event) async {
      if (event == NewsAction.fetch) {
        try {
          var news = await getNews();
          if (news != null) {
            newsSink.add(news.articles);
          } else {
            newsSink.addError("Something went wrong");
          }
        } on Exception catch (e) {
          newsSink.addError("Something went wrong");
        }
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(
        Uri.parse(
            'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=47a3c5168a474cc0ae09933287bfa059'),
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } on Exception {
      return newsModel;
    }

    return newsModel;
  }
}
