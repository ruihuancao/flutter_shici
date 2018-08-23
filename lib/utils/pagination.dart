
class Pagination<T>{
  int totalPage;
  int currentPage;
  bool loading = false;
  bool refushing = false;
  List<T> list = [];

  Pagination({this.totalPage : 0, this.currentPage : 0});

  bool hasNext(){
    return currentPage < totalPage;
  }

  bool canNext(){
    return !loading && hasNext();
  }

  bool canRefush(){
    return !refushing;
  }

  loadEnd(){
    loading = false;
  }

  refushEnd(){
    refushing = false;
  }
}
