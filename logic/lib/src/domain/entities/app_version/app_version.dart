import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'distribution_group.dart';
import 'owner.dart';

class AppVersion extends Equatable {

  const AppVersion({
    this.appName,
    this.appDisplayName,
    this.appOs,
    this.appIconUrl,
    this.releaseNotesUrl,
    this.owner,
    this.isExternalBuild,
    this.origin,
    this.id,
    this.version,
    this.shortVersion,
    this.size,
    this.minOs,
    this.androidMinApiLevel,
    this.deviceFamily,
    this.bundleIdentifier,
    this.fingerprint,
    this.uploadedAt,
    this.downloadUrl,
    this.installUrl,
    this.mandatoryUpdate,
    this.enabled,
    this.fileExtension,
    this.isLatest,
    this.releaseNotes,
    this.isUdidProvisioned,
    this.canResign,
    this.packageHashes,
    this.destinationType,
    this.status,
    this.distributionGroupId,
    this.distributionGroups,
  });

  factory AppVersion.fromMap(Map<String, dynamic> data) => AppVersion(
        appName: data['app_name'] as String?,
        appDisplayName: data['app_display_name'] as String?,
        // appOs: data['app_os'] as String?,
        // appIconUrl: data['app_icon_url'] as String?,
        // releaseNotesUrl: data['release_notes_url'] as String?,
        // owner: data['owner'] == null
        // 		? null
        // 		: Owner.fromMap(data['owner'] as Map<String, dynamic>),
        isExternalBuild: data['is_external_build'] as bool?,
        // origin: data['origin'] as String?,
        id: data['id'] as int?,
        version: data['version'] as String?,
        shortVersion: data['short_version'] as String?,
        // size: data['size'] as int?,
        // minOs: data['min_os'] as String?,
        // androidMinApiLevel: data['android_min_api_level'] as String?,
        // deviceFamily: data['device_family'] as dynamic,
        // bundleIdentifier: data['bundle_identifier'] as String?,
        // fingerprint: data['fingerprint'] as String?,
        // uploadedAt: data['uploaded_at'] == null
        // 		? null
        // 		: DateTime.parse(data['uploaded_at'] as String),
        downloadUrl: data['download_url'] as String?,
        installUrl: data['install_url'] as String?,
        // mandatoryUpdate: data['mandatory_update'] as bool?,
        // enabled: data['enabled'] as bool?,
        // fileExtension: data['fileExtension'] as String?,
        // isLatest: data['is_latest'] as bool?,
        // releaseNotes: data['release_notes'] as String?,
        // isUdidProvisioned: data['is_udid_provisioned'] as dynamic,
        // canResign: data['can_resign'] as dynamic,
        // packageHashes: data['package_hashes'] as List<String>?,
        // destinationType: data['destination_type'] as String?,
        // status: data['status'] as String?,
        // distributionGroupId: data['distribution_group_id'] as String?,
        // distributionGroups: (data['distribution_groups'] as List<dynamic>?)
        // 		?.map((e) => DistributionGroup.fromMap(e as Map<String, dynamic>))
        // 		.toList(),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AppVersion].
  factory AppVersion.fromJson(String data) {
    return AppVersion.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? appName;
  final String? appDisplayName;
  final String? appOs;
  final String? appIconUrl;
  final String? releaseNotesUrl;
  final Owner? owner;
  final bool? isExternalBuild;
  final String? origin;
  final int? id;
  final String? version;
  final String? shortVersion;
  final int? size;
  final String? minOs;
  final String? androidMinApiLevel;
  final dynamic deviceFamily;
  final String? bundleIdentifier;
  final String? fingerprint;
  final DateTime? uploadedAt;
  final String? downloadUrl;
  final String? installUrl;
  final bool? mandatoryUpdate;
  final bool? enabled;
  final String? fileExtension;
  final bool? isLatest;
  final String? releaseNotes;
  final dynamic isUdidProvisioned;
  final dynamic canResign;
  final List<String>? packageHashes;
  final String? destinationType;
  final String? status;
  final String? distributionGroupId;
  final List<DistributionGroup>? distributionGroups;

  Map<String, dynamic> toMap() => {
        'app_name': appName,
        'app_display_name': appDisplayName,
        'app_os': appOs,
        'app_icon_url': appIconUrl,
        'release_notes_url': releaseNotesUrl,
        'owner': owner?.toMap(),
        'is_external_build': isExternalBuild,
        'origin': origin,
        'id': id,
        'version': version,
        'short_version': shortVersion,
        'size': size,
        'min_os': minOs,
        'android_min_api_level': androidMinApiLevel,
        'device_family': deviceFamily,
        'bundle_identifier': bundleIdentifier,
        'fingerprint': fingerprint,
        'uploaded_at': uploadedAt?.toIso8601String(),
        'download_url': downloadUrl,
        'install_url': installUrl,
        'mandatory_update': mandatoryUpdate,
        'enabled': enabled,
        'fileExtension': fileExtension,
        'is_latest': isLatest,
        'release_notes': releaseNotes,
        'is_udid_provisioned': isUdidProvisioned,
        'can_resign': canResign,
        'package_hashes': packageHashes,
        'destination_type': destinationType,
        'status': status,
        'distribution_group_id': distributionGroupId,
        'distribution_groups':
            distributionGroups?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Converts [AppVersion] to a JSON string.
  String toJson() => json.encode(toMap());

  AppVersion copyWith({
    String? appName,
    String? appDisplayName,
    String? appOs,
    String? appIconUrl,
    String? releaseNotesUrl,
    Owner? owner,
    bool? isExternalBuild,
    String? origin,
    int? id,
    String? version,
    String? shortVersion,
    int? size,
    String? minOs,
    String? androidMinApiLevel,
    dynamic deviceFamily,
    String? bundleIdentifier,
    String? fingerprint,
    DateTime? uploadedAt,
    String? downloadUrl,
    String? installUrl,
    bool? mandatoryUpdate,
    bool? enabled,
    String? fileExtension,
    bool? isLatest,
    String? releaseNotes,
    dynamic isUdidProvisioned,
    dynamic canResign,
    List<String>? packageHashes,
    String? destinationType,
    String? status,
    String? distributionGroupId,
    List<DistributionGroup>? distributionGroups,
  }) {
    return AppVersion(
      appName: appName ?? this.appName,
      appDisplayName: appDisplayName ?? this.appDisplayName,
      appOs: appOs ?? this.appOs,
      appIconUrl: appIconUrl ?? this.appIconUrl,
      releaseNotesUrl: releaseNotesUrl ?? this.releaseNotesUrl,
      owner: owner ?? this.owner,
      isExternalBuild: isExternalBuild ?? this.isExternalBuild,
      origin: origin ?? this.origin,
      id: id ?? this.id,
      version: version ?? this.version,
      shortVersion: shortVersion ?? this.shortVersion,
      size: size ?? this.size,
      minOs: minOs ?? this.minOs,
      androidMinApiLevel: androidMinApiLevel ?? this.androidMinApiLevel,
      deviceFamily: deviceFamily ?? this.deviceFamily,
      bundleIdentifier: bundleIdentifier ?? this.bundleIdentifier,
      fingerprint: fingerprint ?? this.fingerprint,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      installUrl: installUrl ?? this.installUrl,
      mandatoryUpdate: mandatoryUpdate ?? this.mandatoryUpdate,
      enabled: enabled ?? this.enabled,
      fileExtension: fileExtension ?? this.fileExtension,
      isLatest: isLatest ?? this.isLatest,
      releaseNotes: releaseNotes ?? this.releaseNotes,
      isUdidProvisioned: isUdidProvisioned ?? this.isUdidProvisioned,
      canResign: canResign ?? this.canResign,
      packageHashes: packageHashes ?? this.packageHashes,
      destinationType: destinationType ?? this.destinationType,
      status: status ?? this.status,
      distributionGroupId: distributionGroupId ?? this.distributionGroupId,
      distributionGroups: distributionGroups ?? this.distributionGroups,
    );
  }

  @override
  List<Object?> get props {
    return [
      appName,
      appDisplayName,
      appOs,
      appIconUrl,
      releaseNotesUrl,
      owner,
      isExternalBuild,
      origin,
      id,
      version,
      shortVersion,
      size,
      minOs,
      androidMinApiLevel,
      deviceFamily,
      bundleIdentifier,
      fingerprint,
      uploadedAt,
      downloadUrl,
      installUrl,
      mandatoryUpdate,
      enabled,
      fileExtension,
      isLatest,
      releaseNotes,
      isUdidProvisioned,
      canResign,
      packageHashes,
      destinationType,
      status,
      distributionGroupId,
      distributionGroups,
    ];
  }
}
