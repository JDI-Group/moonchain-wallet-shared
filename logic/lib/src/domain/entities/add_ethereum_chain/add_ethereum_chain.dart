import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'native_currency.dart';

class AddEthereumChain extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddEthereumChain].
  factory AddEthereumChain.fromJson(String data) {
    return AddEthereumChain.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory AddEthereumChain.fromMap(Map<String, dynamic> data) {
    return AddEthereumChain(
      chainId: data['chainId'] as String,
      chainName: data['chainName'] as String,
      rpcUrls: (data['rpcUrls'] as List<dynamic>).cast<String>(),
      iconUrls: data['iconUrls'] != null
          ? (data['iconUrls'] as List<dynamic>).cast<String>()
          : null,
      nativeCurrency: NativeCurrency.fromMap(
        data['nativeCurrency'] as Map<String, dynamic>,
      ),
      blockExplorerUrls: data['blockExplorerUrls'] != null
          ? (data['blockExplorerUrls'] as List<dynamic>).cast<String>()
          : null,
    );
  }

  const AddEthereumChain({
    required this.chainId,
    required this.chainName,
    required this.rpcUrls,
    this.iconUrls,
    required this.nativeCurrency,
    required this.blockExplorerUrls,
  });
  final String chainId;
  final String chainName;
  final List<String> rpcUrls;
  final List<String>? iconUrls;
  final NativeCurrency nativeCurrency;
  final List<String>? blockExplorerUrls;

  Map<String, dynamic> toMap() => {
        'chainId': chainId,
        'chainName': chainName,
        'rpcUrls': rpcUrls,
        'iconUrls': iconUrls,
        'nativeCurrency': nativeCurrency.toMap(),
        'blockExplorerUrls': blockExplorerUrls,
      };

  /// `dart:convert`
  ///
  /// Converts [AddEthereumChain] to a JSON string.
  String toJson() => json.encode(toMap());

  AddEthereumChain copyWith({
    String? chainId,
    String? chainName,
    List<String>? rpcUrls,
    List<String>? iconUrls,
    NativeCurrency? nativeCurrency,
    List<String>? blockExplorerUrls,
  }) {
    return AddEthereumChain(
      chainId: chainId ?? this.chainId,
      chainName: chainName ?? this.chainName,
      rpcUrls: rpcUrls ?? this.rpcUrls,
      iconUrls: iconUrls ?? this.iconUrls,
      nativeCurrency: nativeCurrency ?? this.nativeCurrency,
      blockExplorerUrls: blockExplorerUrls ?? this.blockExplorerUrls,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      chainId,
      chainName,
      rpcUrls,
      iconUrls,
      nativeCurrency,
      blockExplorerUrls,
    ];
  }
}
