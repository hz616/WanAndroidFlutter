import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/net/http.dart';

class WanAndroidRepository {
  static Future fetchArticles(int pageNum, {int cid}) async {
    await Future.delayed(Duration(seconds: 1));
    var response = await http.get('article/list/$pageNum/json',
        queryParameters: (cid != null ? {'cid': cid} : null));
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }
}
