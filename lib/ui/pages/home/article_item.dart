import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wan_android_flutter/helper/resource_mananger.dart';
import 'package:wan_android_flutter/model/article.dart';

class ArticleItem extends StatefulWidget {
  final Article article;
  final int index;

  ArticleItem(this.article, this.index) : super(key: ValueKey(article.id));

  @override
  _ArticleItemState createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border:
              Border(bottom: Divider.createBorderSide(context, width: 0.7))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: ImageHelper.randomUrl(
                      key: widget.article.author, width: 20, height: 20),
                  placeholder: (_, __) =>
                      ImageHelper.placeHolder(width: 20, height: 20),
                  errorWidget: (_, __, ___) =>
                      ImageHelper.error(width: 20, height: 20),
                  height: 20,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.article.author,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              Text(
                widget.article.niceDate,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          if (widget.article.envelopePic.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 7),
              child: ArticleTitleWidget(widget.article.title),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ArticleTitleWidget(widget.article.title),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.article.desc,
                        style: Theme.of(context).textTheme.caption,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CachedNetworkImage(
                  imageUrl: widget.article.envelopePic,
                  height: 60,
                  width: 60,
                  placeholder: (_, __) =>
                      ImageHelper.placeHolder(width: 60, height: 60),
                  errorWidget: (_, __, ___) =>
                      ImageHelper.error(width: 60, height: 60),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  (widget.article.superChapterName != null
                          ? widget.article.superChapterName + ' · '
                          : '') +
                      (widget.article.chapterName ?? ''),
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final String title;

  ArticleTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: title,
      padding: EdgeInsets.symmetric(vertical: 5),
      defaultTextStyle: Theme.of(context).textTheme.subtitle,
      useRichText: false,
    );
  }
}
