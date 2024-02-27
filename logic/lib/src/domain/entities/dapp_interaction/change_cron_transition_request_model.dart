import 'dart:convert';
import 'dapp_interaction.dart';


class ChangeCronTransitionRequestModel<T> extends CronServiceDataModel<T> {
  ChangeCronTransitionRequestModel({
    String? name,
    T? data,
  }) : super(enabled: null, data: data, name: name);

  // Add this factory constructor
  factory ChangeCronTransitionRequestModel.fromJson(
          String source, T Function(Map<String, dynamic>) dataFromMap) =>
      ChangeCronTransitionRequestModel<T>.fromMap(
        json.decode(source),
        dataFromMap,
      );

  factory ChangeCronTransitionRequestModel.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) dataFromMap,
  ) =>
      ChangeCronTransitionRequestModel<T>(
        name: map['name'],
        data: map['data'] != null ? dataFromMap(map['data']) : null,
      );
}

// class ChangeCronTransitionRequestModel<T> {
//   factory ChangeCronTransitionRequestModel.fromJson(
//           String source, T Function(Map<String, dynamic>) fromMap) =>
//       ChangeCronTransitionRequestModel.fromMap(json.decode(source), fromMap);

//   factory ChangeCronTransitionRequestModel.fromMap(
//       Map<String, dynamic> map, T Function(Map<String, dynamic>) fromMap,) {
//     return ChangeCronTransitionRequestModel(
//       name: map['name'],
//       data:  fromMap(map['data']),
//     );
//   }

//   ChangeCronTransitionRequestModel({
//     required this.name,
//     required this.data,
//   });
//   String name;
//   CronServiceDataModel<T> data;

//   ChangeCronTransitionRequestModel<T> copyWith({
//     String? name,
//     T? data,
//   }) {
//     return ChangeCronTransitionRequestModel<T>(
//       name: name ?? this.name,
//       data: data ?? this.data,
//     );
//   }

//   Map<String, dynamic> toMap(Map<String, dynamic> Function(T?) dataToMap) {
//     return {
//       'name': name,
//       'data': data.toMap(dataToMap),
//     };
//   }

//   String toJson(Map<String, dynamic> Function(T?) dataToMap) => json.encode(toMap(dataToMap));

//   @override
//   String toString() =>
//       'ChangeCronTransitionRequestModel(name: $name, data: $data)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is ChangeCronTransitionRequestModel<T> &&
//         other.name == name &&
//         other.data == data;
//   }

//   @override
//   int get hashCode => name.hashCode ^ data.hashCode;
// }

