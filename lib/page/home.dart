import 'package:flutter/material.dart';
import 'package:flutter_shici/res/string.dart';

import 'dart:async';

import 'package:flutter_shici/widget/page_status.dart';
import 'package:flutter_shici/utils/pagination.dart';
import 'package:flutter_shici/data/poetry_api.dart';
import 'package:flutter_shici/data/model/poetry.dart';
import 'package:flutter_shici/page/page_loading.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageStatus status = PageStatus.loading;
  Pagination<Poetry> pagination = Pagination();

  @override
  void initState() {
    super.initState();
    _refushList();
  }


  @override
  void dispose() {
    super.dispose();
  }

  /// 下拉刷新
  Future<Null> _refushList() async {
    if(pagination.list.isEmpty){
      setState(() {
        status = PageStatus.loading;
      });
    }
    if (pagination.canRefush()) {
      pagination.currentPage = 0;
      pagination.refushing = true;
      PoetryList poetryList = await fetchPoetry(0);
      if (poetryList != null) {
        pagination.totalPage = poetryList.totalPage;
        setState(() {
          status = PageStatus.success;
          pagination.list = poetryList.list;
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
      PoetryList poetryList = await fetchPoetry(pagination.currentPage + 1);
      if (poetryList != null) {
        setState(() {
          pagination.currentPage++;
          pagination.list.addAll(poetryList.list);
        });
      }
      pagination.loadEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.menu_home),
        ),
        body: PageStatusView(
          status: status,
          error: PageErrorWidget(_refushList, "出错了点击页面重试"),
          loading: PageLoadingWidget(),
          content: ListContentView(
              pagination.list, _loadMoreList, _refushList, pagination.hasNext),
        ));
  }
}

class ListContentView extends StatelessWidget {
  List<Poetry> list = [];
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

  Widget getRow(int i, Poetry poetry) {
    return GestureDetector(
      child: new Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Card(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    poetry.name,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(poetry.content)
                ],
              ),
            ),
          )),
      onTap: () {},
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
                return getRow(position, list[position]);
              }
            }),
        onRefresh: refush);
  }
}