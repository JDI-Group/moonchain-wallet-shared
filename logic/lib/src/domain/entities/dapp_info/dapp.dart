import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mxc_logic/src/domain/const/config.dart';

import '../bookmark.dart';
import 'app.dart';
import 'review_api.dart';
import 'store.dart';

class Dapp extends Equatable {
  Dapp fromBookmark(Bookmark bookMark) {
    return Dapp(
      app: AppInfo(
          url: bookMark.url,
          name: bookMark.title,
          description: bookMark.description,
          ageRating: app?.ageRating,
          developer: app?.developer,
          localizations: app?.localizations,
          permissions: app?.permissions,
          supportedPlatforms: ['android', 'ios'],
          version: app?.version),
      store: Store(
          chainid: store?.chainid,
          mnsid: store?.mnsid,
          category: store?.category),
      reviewApi: ReviewApi(
          body: reviewApi?.body,
          headers: reviewApi?.headers,
          icons: reviewApi?.icons,
          method: reviewApi?.method,
          url: reviewApi?.url),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Dapp].
  factory Dapp.fromJson(String data) {
    return Dapp.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory Dapp.fromMap(Map<String, dynamic> data) => Dapp(
        app: data['app'] == null
            ? null
            : AppInfo.fromMap(data['app'] as Map<String, dynamic>),
        store: data['store'] == null
            ? null
            : Store.fromMap(data['store'] as Map<String, dynamic>),
        reviewApi: data['reviewAPI'] == null
            ? null
            : ReviewApi.fromMap(data['reviewAPI'] as Map<String, dynamic>),
      );

  const Dapp({this.app, this.store, this.reviewApi});
  final AppInfo? app;
  final Store? store;
  final ReviewApi? reviewApi;

  Map<String, dynamic> toMap() => {
        'app': app?.toMap(),
        'store': store?.toMap(),
        'reviewAPI': reviewApi?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [Dapp] to a JSON string.
  String toJson() => json.encode(toMap());

  Dapp copyWith({
    AppInfo? app,
    Store? store,
    ReviewApi? reviewApi,
  }) {
    return Dapp(
      app: app ?? this.app,
      store: store ?? this.store,
      reviewApi: reviewApi ?? this.reviewApi,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [app, store, reviewApi];
}
