import 'dart:io';

import 'package:mxc_logic/mxc_logic.dart';

class Bookmark extends Dapp {
  const Bookmark({
    required this.id,
    required this.title,
    required this.url,
    this.description,
    this.image,
  });

  final int id;
  final String title;
  final String url;
  final String? description;
  final String? image;
}
