import 'package:chopper/chopper.dart';

class DecodedInput {
  String? methodCall;
  String? methodId;
  List<Parameters>? parameters;

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_call'] = this.methodCall;
    data['method_id'] = this.methodId;
    if (this.parameters != null) {
      data['parameters'] = this.parameters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parameters {
  String? name;
  String? type;
  String? value;

  Parameters({this.name, this.type, this.value});

  Parameters.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    value = (json['value'].runtimeType == List<dynamic>)
        ? json['value'][0]
        : json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}
