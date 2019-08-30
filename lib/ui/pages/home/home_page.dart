import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_flutter/model/article.dart';
import 'package:wan_android_flutter/service/wan_android_repository.dart';
import 'package:wan_android_flutter/ui/pages/home/article_item.dart';
import 'package:wan_android_flutter/ui/widgets/refresh_widget.dart';
import 'package:wan_android_flutter/utils/log_utils.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const String TAG = "Homepage";
  int _pageNum = 0;
  bool _hasMore = true;
  int _pageSize = 20;
  List<Article> mData = List();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    refresh();
    LogUtils.d(TAG, 'initState');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mData == null || mData.length == 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(),
        footer: RefresherFooter(),
        child: getBody(),
        enablePullUp: _hasMore,
        onRefresh: refresh,
        onLoading: loadMore,
      );
  }

  Widget getBody() {
    Widget listView = ListView.builder(
        itemCount: mData.length,
        itemBuilder: (context, index) {
          return ArticleItem(mData[index], index);
        });
    return listView;
  }

  loadData() async {
    List<Article> data = await WanAndroidRepository.fetchArticles(_pageNum);
    LogUtils.d(TAG, "data size is ${data.length}");
    _hasMore = !(data.length < _pageSize);
    if (_pageNum > 0) {
      _refreshController.loadComplete();
      mData.addAll(data);
    } else {
      mData.clear();
      mData.addAll(data);
      _refreshController.refreshCompleted();
    }
    setState(() {});
  }

  refresh() {
    _pageNum = 0;
    LogUtils.d(TAG, "refresh ");
    loadData();
  }

  loadMore() {
    _pageNum++;
    LogUtils.d(TAG, "loadMore ");
    loadData();
  }
}
