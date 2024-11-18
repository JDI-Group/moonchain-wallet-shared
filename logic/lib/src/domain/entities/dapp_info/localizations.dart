import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'en.dart';
import 'es.dart';

class Localizations extends Equatable {

  const Localizations({this.en, this.es});

  factory Localizations.fromMap(Map<String, dynamic> data) => Localizations(
        en: data['en'] == null
            ? null
            : En.fromMap(data['en'] as Map<String, dynamic>),
        es: data['es'] == null
            ? null
            : Es.fromMap(data['es'] as Map<String, dynamic>),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Localizations].
  factory Localizations.fromJson(String data) {
    return Localizations.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final En? en;
  final Es? es;

  Map<String, dynamic> toMap() => {
        'en': en?.toMap(),
        'es': es?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [Localizations] to a JSON string.
  String toJson() => json.encode(toMap());

  Localizations copyWith({
    En? en,
    Es? es,
  }) {
    return Localizations(
      en: en ?? this.en,
      es: es ?? this.es,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [en, es];
}
