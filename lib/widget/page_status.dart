import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PageStatusView extends StatefulWidget {
  static const Key loadingContentKey = ValueKey('loading');
  static const Key errorContentKey = ValueKey('error');
  static const Key successContentKey = ValueKey('success');

  const PageStatusView({
    @required this.status,
    @required this.loading,
    @required this.error,
    @required this.content,
  });

  final PageStatus status;
  final Widget loading;
  final Widget error;
  final Widget content;

  @override
  PageStateViewState createState() => PageStateViewState();
}

class PageStateViewState extends State<PageStatusView>
    with TickerProviderStateMixin {
  AnimationController _loadingController;
  AnimationController _errorController;
  AnimationController _successController;

  bool get loadingContentVisible => _loadingController.value == 1.0;
  bool get errorContentVisible => _errorController.value == 1.0;
  bool get successContentVisible => _successController.value == 1.0;

  Widget firstChild;
  Widget secondChild;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _errorController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _successController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    switch (widget.status) {
      case PageStatus.loading:
        _loadingController.value = 1.0;
        break;
      case PageStatus.error:
        _errorController.value = 1.0;
        break;
      case PageStatus.success:
        _successController.value = 1.0;
        break;
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _errorController.dispose();
    _successController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PageStatusView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.status != widget.status) {
      ValueGetter<TickerFuture> reverseAnimation;

      switch (oldWidget.status) {
        case PageStatus.loading:
          reverseAnimation = () => _loadingController.reverse();
          break;
        case PageStatus.error:
          reverseAnimation = () => _errorController.reverse();
          break;
        case PageStatus.success:
          reverseAnimation = () => _successController.reverse();
          break;
      }

      reverseAnimation().then<TickerFuture>((_) {
        switch (widget.status) {
          case PageStatus.loading:
            _loadingController.forward();
            break;
          case PageStatus.error:
            _errorController.forward();
            break;
          case PageStatus.success:
            _successController.forward();
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _TransitionAnimation(
          key: PageStatusView.loadingContentKey,
          controller: _loadingController,
          child: widget.loading,
          isVisible: widget.status == PageStatus.loading,
        ),
        _TransitionAnimation(
          key: PageStatusView.errorContentKey,
          controller: _errorController,
          child: widget.error,
          isVisible: widget.status == PageStatus.error,
        ),
        _TransitionAnimation(
          key: PageStatusView.successContentKey,
          controller: _successController,
          child: widget.content,
          isVisible: widget.status == PageStatus.success,
        ),
      ],
    );
  }
}

class _TransitionAnimation extends StatelessWidget {
  _TransitionAnimation({
    @required Key key,
    @required this.controller,
    @required this.child,
    @required this.isVisible,
  })  : _opacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.000,
              0.650,
              curve: Curves.ease,
            ),
          ),
        ),
        _yTranslation = Tween(begin: 40.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.000,
              0.650,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Widget child;
  final bool isVisible;

  final Animation<double> _opacity;
  final Animation<double> _yTranslation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, _) {
        return IgnorePointer(
          ignoring: !isVisible,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              _yTranslation.value,
              0.0,
            ),
            child: Opacity(
              opacity: _opacity.value,
              child: child,
            ),
          ),
        );
      },
    );
  }
}


enum PageStatus {
  loading,
  error,
  success,
}