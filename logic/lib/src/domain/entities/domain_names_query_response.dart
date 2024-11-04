import 'dart:convert';

class DomainNamesQueryResponse {
  factory DomainNamesQueryResponse.fromJson(String source) =>
      DomainNamesQueryResponse.fromMap(json.decode(source));

  factory DomainNamesQueryResponse.fromMap(Map<String, dynamic> map) {
    return DomainNamesQueryResponse(
      domains:(map['domains'] as List<dynamic>?) == null ? [] : List<Domain>.from( (map['domains'] as List<dynamic>).where((element) => (element as Map<String, dynamic>)['wrappedDomain'] != null,).map((x) => Domain.fromMap(x))),
    );
  }
  DomainNamesQueryResponse({
    required this.domains,
  });
  final List<Domain> domains;

  DomainNamesQueryResponse copyWith({
    List<Domain>? domains,
  }) {
    return DomainNamesQueryResponse(
      domains: domains ?? this.domains,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'domains': domains.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'DomainNamesQueryResponse(domains: $domains)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is DomainNamesQueryResponse &&
  //     listEquals(other.domains, domains);
  // }

  @override
  int get hashCode => domains.hashCode;
}

class Domain {
  factory Domain.fromJson(String source) => Domain.fromMap(json.decode(source));

  factory Domain.fromMap(Map<String, dynamic> map) {
    return Domain(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      wrappedDomain: WrappedDomain.fromMap(map['wrappedDomain']),
    );
  }
  Domain({
    required this.id,
    required this.name,
    required this.wrappedDomain,
  });
  final String id;
  final String name;
  final WrappedDomain wrappedDomain;

  Domain copyWith({
    String? id,
    String? name,
    WrappedDomain? wrappedDomain,
  }) {
    return Domain(
      id: id ?? this.id,
      name: name ?? this.name,
      wrappedDomain: wrappedDomain ?? this.wrappedDomain,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'wrappedDomain': wrappedDomain.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Domain(id: $id, name: $name, wrappedDomain: $wrappedDomain)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Domain &&
        other.id == id &&
        other.name == name &&
        other.wrappedDomain == wrappedDomain;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ wrappedDomain.hashCode;
}

class WrappedDomain {
  factory WrappedDomain.fromJson(String source) =>
      WrappedDomain.fromMap(json.decode(source));

  factory WrappedDomain.fromMap(Map<String, dynamic> map) {
    return WrappedDomain(
      owner: Owner.fromMap(map['owner']),
      name: map['name'] ?? '',
    );
  }
  WrappedDomain({
    required this.owner,
    required this.name,
  });
  final Owner owner;
  final String name;

  WrappedDomain copyWith({
    Owner? owner,
    String? name,
  }) {
    return WrappedDomain(
      owner: owner ?? this.owner,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'owner': owner.toMap(),
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'WrappedDomain(owner: $owner, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WrappedDomain && other.owner == owner && other.name == name;
  }

  @override
  int get hashCode => owner.hashCode ^ name.hashCode;
}

class Owner {
  factory Owner.fromJson(String source) => Owner.fromMap(json.decode(source));

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'] ?? '',
    );
  }
  Owner({
    required this.id,
  });
  final String id;

  Owner copyWith({
    String? id,
  }) {
    return Owner(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Owner(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Owner && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
