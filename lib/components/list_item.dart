import 'package:flutter/cupertino.dart';

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildDate(BuildContext context);

  Widget buildLength(BuildContext context);
}

class SimpleItemRecord implements ListItem {
  final String? title;
  final String? date;
  final String? length;

  SimpleItemRecord(this.title, this.date, this.length);

  @override
  Widget buildDate(BuildContext context) {
    return Text(
      date ?? '',
      style: const TextStyle(
        fontSize: 12.0,
      ),
    );
  }

  @override
  Widget buildLength(BuildContext context) {
    return Text(
      length ?? '',
      style: const TextStyle(
        fontSize: 12,
      ),
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      title ?? '',
      style: const TextStyle(
        fontSize: 15.0,
      ),
    );
  }
}
