import 'package:azlistview/azlistview.dart';

class AZItem extends ISuspensionBean {
  //  Alphabetical Title
  final String title;

  //  The tags
  final String tag;

  AZItem({required this.title, required this.tag});

  @override
  String getSuspensionTag() => tag;
}
