import 'package:flutter/material.dart';
import '../widget/see_more_list_widget.dart';

class SeeMorePage extends StatelessWidget {
  final String api;
  final String bookImage;
  final String saveKey;
  final String bookName;
  final String bookCreatorName;
  const SeeMorePage({
    super.key,
    required this.api,
    required this.bookImage,
    required this.bookName,
    required this.bookCreatorName,
    required this.saveKey,
  });

  @override
  Widget build(BuildContext context) {
    return SeeMoreListWidget(
      api: api,
      bookImage: bookImage,
      bookName: bookName,
      bookCreatorName: bookCreatorName,
      saveKey: saveKey,
    );
  }
}
