import 'dart:convert';

import 'package:equatable/equatable.dart';

class Permissions extends Equatable {

  const Permissions({
    this.notifications,
    this.camera,
    this.storage,
    this.clipboard,
    this.location,
  });

  factory Permissions.fromMap(Map<String, dynamic> data) => Permissions(
        notifications: data['notifications'] as String?,
        camera: data['camera'] as String?,
        storage: data['storage'] as String?,
        clipboard: data['clipboard'] as String?,
        location: data['location'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Permissions].
  factory Permissions.fromJson(String data) {
    return Permissions.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? notifications;
  final String? camera;
  final String? storage;
  final String? clipboard;
  final String? location;

  Map<String, dynamic> toMap() => {
        'notifications': notifications,
        'camera': camera,
        'storage': storage,
        'clipboard': clipboard,
        'location': location,
      };

  /// `dart:convert`
  ///
  /// Converts [Permissions] to a JSON string.
  String toJson() => json.encode(toMap());

  Permissions copyWith({
    String? notifications,
    String? camera,
    String? storage,
    String? clipboard,
    String? location,
  }) {
    return Permissions(
      notifications: notifications ?? this.notifications,
      camera: camera ?? this.camera,
      storage: storage ?? this.storage,
      clipboard: clipboard ?? this.clipboard,
      location: location ?? this.location,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      notifications,
      camera,
      storage,
      clipboard,
      location,
    ];
  }
}
