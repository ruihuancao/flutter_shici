import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_shici/widget/page_status.dart';
import 'package:flutter_shici/utils/pagination.dart';
import 'package:flutter_shici/data/model/movie.dart';
import 'package:flutter_shici/data/movie_api.dart';
import 'package:flutter_shici/page/page_loading.dart';
import 'package:flutter_shici/page/video_player.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

class ListContentView extends StatelessWidget {
  List<Movie> list = [];
  ScrollController _scrollController = new ScrollController();
  Function loadMore;
  Function refush;
  Function hasNext;

  ListContentView(this.list, this.loadMore, this.refush, this.hasNext);

  Widget _buildLoadText() {
    String text = hasNext() ? "正在加载..." : "我是有底线的";
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }

  itemClick(BuildContext context) {}

  Widget getRow(BuildContext context, int i, Movie movie) {
    return GestureDetector(
      child: new Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  title: Text(movie.name),
                  subtitle: Text(movie.category),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoDetailPage(movie: movie),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoFullPage('https://youku.cdn-56.com/20180622/3878_d3968706/index.m3u8',)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });

    return new RefreshIndicator(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: list.length + 1,
            itemBuilder: (BuildContext context, int position) {
              if (position == list.length) {
                return _buildLoadText();
              } else {
                return getRow(context, position, list[position]);
              }
            }),
        onRefresh: refush);
  }
}

class MovieListPage extends StatefulWidget {
  int type;

  MovieListPage(this.type);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage>
    with AutomaticKeepAliveClientMixin<MovieListPage> {
  PageStatus status = PageStatus.loading;
  Pagination<Movie> pagination = Pagination();
  List<String> allLinkList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    int type = widget.type;
    print("--------------------init_state $type-----------");
    _initPage();
  }

  @override
  dispose() {
    super.dispose();
    allLinkList == null;
  }

  _initPage() async {
    if (allLinkList == null) {
      allLinkList = await getAllPageLink(type: widget.type);
      pagination.totalPage = allLinkList.length;
      _refushList();
    }
  }

  /// 下拉刷新
  Future<Null> _refushList() async {
    if (pagination.canRefush()) {
      pagination.currentPage = 0;
      pagination.refushing = true;
      List<Movie> movieList = await getPageListMovie(allLinkList[0]);
      if (movieList != null) {
        setState(() {
          status = PageStatus.success;
          pagination.list = movieList;
          pagination.currentPage = 0;
        });
      } else {
        setState(() {
          status = PageStatus.error;
        });
      }
      pagination.refushEnd();
    }
  }

  ///上拉加载更多
  _loadMoreList() async {
    if (pagination.canNext()) {
      pagination.loading = true;
      List<Movie> movieList =
          await getPageListMovie(allLinkList[pagination.currentPage + 1]);
      if (movieList != null) {
        setState(() {
          pagination.currentPage++;
          pagination.list.addAll(movieList);
        });
      }
      pagination.loadEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    int type = widget.type;
    return new Container(
        key: new PageStorageKey('$type'),
        child: new PageStatusView(
            status: status,
            loading: PageLoadingWidget(),
            error: PageErrorWidget(_refushList, "load error"),
            content: ListContentView(pagination.list, _loadMoreList,
                _refushList, pagination.hasNext)));
  }
}
