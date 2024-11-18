import 'package:chopper/chopper.dart';

class DecodedInput {

  DecodedInput({this.methodCall, this.methodId, this.parameters});

  DecodedInput.fromJson(Map<String, dynamic> json) {
    methodCall = json['method_call'];
    methodId = json['method_id'];
    if (json['parameters'] != null) {
      parameters = <Parameters>[];
      if (json['parameters'].runtimeType == List<dynamic>) {
        json['parameters'].forEach((v) {
          parameters!.add(Parameters.fromJson(v));
        });
      }
    }
  }
  String? methodCall;
  String? methodId;
  List<Parameters>? parameters;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method_call'] = methodCall;
    data['method_id'] = methodId;
    if (parameters != null) {
      data['parameters'] = parameters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parameters {

  Parameters({this.name, this.type, this.value});

  Parameters.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    value = (json['value'].runtimeType == List<dynamic>)
        ? json['value'][0]
        : json['value'];
  }
  String? name;
  String? type;
  String? value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
