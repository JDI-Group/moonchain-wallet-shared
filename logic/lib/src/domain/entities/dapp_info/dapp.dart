import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../bookmark.dart';
import 'app.dart';
import 'review_api.dart';
import 'store.dart';

export 'app.dart';

class Dapp extends Equatable {

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
  Dapp fromBookmark(Bookmark bookMark) {
    return Dapp(
      app: AppInfo(
        url: bookMark.url,
        name: bookMark.title,
        // Bookmark can't be most used
        mostUsed: false,
        description: bookMark.description,
        ageRating: app?.ageRating,
        developer: app?.developer,
        localizations: app?.localizations,
        permissions: app?.permissions,
        supportedPlatforms: const ['android', 'ios'],
        version: app?.version,
        providerType: app?.providerType,
      ),
      store: Store(
        chainid: store?.chainid,
        mnsid: store?.mnsid,
        category: store?.category,
      ),
      reviewApi: ReviewApi(
        body: reviewApi?.body,
        headers: reviewApi?.headers,
        icons: reviewApi?.icons,
        method: reviewApi?.method,
        url: reviewApi?.url,
        icon: bookMark.image,
        iconV2: bookMark.image,
        iconV3: bookMark.image,
      ),
    );
  }
  final AppInfo? app;
  final Store? store;
  final ReviewApi? reviewApi;

  // Appends the given
  Dapp appendPrefixToIcons(
    String prefix,
  ) {
    return Dapp(
      app: app,
      store: store,
      reviewApi: ReviewApi(
        body: reviewApi?.body,
        headers: reviewApi?.headers,
        icons: reviewApi?.icons?.copyWith(
          iconLarge: '$prefix${reviewApi?.icons?.iconLarge}',
          iconSmall: '$prefix${reviewApi?.icons?.iconSmall}',
        ),
        icon: reviewApi?.icon != null ? '$prefix${reviewApi?.icon}' : null,
        iconV2:
            reviewApi?.iconV2 != null ? '$prefix${reviewApi?.iconV2}' : null,
        iconV3:
            reviewApi?.iconV3 != null ? '$prefix${reviewApi?.iconV3}' : null,
        method: reviewApi?.method,
        url: reviewApi?.url,
      ),
    );
  }

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
