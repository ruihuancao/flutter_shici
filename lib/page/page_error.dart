import 'package:flutter/material.dart';
import 'package:flutter_shici/widget/page_message.dart';

class PageErrorWidget extends PageMessageWidget {
  static const Key tryAgainButtonKey = Key('tryAgainButton');

  const PageErrorWidget({
    String title,
    String description,
    @required VoidCallback onRetry,
  }) : super(
    actionButtonKey: tryAgainButtonKey,
    title: title ?? '出现错误',
    description:
    description ?? '错误信息',
    onActionButtonTapped: onRetry,
  );
}
