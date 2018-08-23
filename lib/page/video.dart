import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shici/page/movie_list.dart';

class _Page {
  const _Page({this.text, this.type});
  final String text;
  final int type;
}

// 1 电影 2连续剧 3 综艺 4动漫 5动作片 6喜剧 7爱情 8科幻 9恐怖
// 10 剧情 11战争 12 国产剧 13 香港剧 14韩国 15 欧美 16 台湾
// 17 日本 18 海外19记录 20 微电影 21 伦理片 22 福利
const List<_Page> _allPages = const <_Page>[
  const _Page(text: '电影', type: 1),
  const _Page(text: '连续剧', type: 2),
  const _Page(text: '综艺', type: 3),
  const _Page(text: '动漫', type: 4),
  const _Page(text: '动作片', type: 5),
  const _Page(text: '喜剧片', type: 6),
  const _Page(text: '爱情片', type: 7),
  const _Page(text: '科幻片', type: 8),
  const _Page(text: '恐怖片', type: 9),
  const _Page(text: '剧情片', type: 10),
  const _Page(text: '战争片', type: 11),
  const _Page(text: '国产剧', type: 12),
  const _Page(text: '香港剧', type: 13),
  const _Page(text: '韩国剧', type: 14),
  const _Page(text: '欧美剧', type: 15),
  const _Page(text: '台湾剧', type: 16),
  const _Page(text: '日本剧', type: 17),
  const _Page(text: '海外剧', type: 18),
  const _Page(text: '纪录片', type: 19),
  const _Page(text: '微电影', type: 20),
  const _Page(text: '伦理片', type: 21),
  const _Page(text: '福利片', type: 22),
];

class VideoPage extends StatelessWidget {
  Widget getMovieListWidget(int type) {
    return new Container(
      child: new Center(
        child: new Text("测试页面$type"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _allPages.length,
        child: new Scaffold(
          appBar: PreferredSize(
              child: new Container(
                child: SafeArea(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.search, color: Colors.white,),
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      ),
                      Expanded(
                        child: new TabBar(
                          isScrollable: true,
                          tabs: _allPages.map((_Page page) {
                            return Tab(text: page.text);
                          }).toList(),
                        ),
                      ),
                      Container(
                        child: Icon(Icons.more_vert, color: Colors.white,),
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.blue,
              ),
              preferredSize: Size.fromHeight(kToolbarHeight)),
          body: TabBarView(
            children: <Widget>[
              MovieListPage(1),
              MovieListPage(2),
              MovieListPage(3),
              MovieListPage(4),
              MovieListPage(5),
              MovieListPage(6),
              MovieListPage(7),
              MovieListPage(8),
              MovieListPage(9),
              MovieListPage(10),
              MovieListPage(11),
              MovieListPage(12),
              MovieListPage(13),
              MovieListPage(14),
              MovieListPage(15),
              MovieListPage(16),
              MovieListPage(17),
              MovieListPage(18),
              MovieListPage(19),
              MovieListPage(20),
              MovieListPage(21),
              MovieListPage(22),
            ],
          ),
        ));
  }
}
