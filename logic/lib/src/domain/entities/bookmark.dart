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

  Bookmark copyWithBookmark({
    int? id,
    String? title,
    String? url,
    String? description,
    String? image,
  }) =>
      Bookmark(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        description: description ?? this.description,
        image: image ?? this.image,
      );

  final int id;
  final String title;
  final String url;
  final String? description;
  final String? image;
}
