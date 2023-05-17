import 'dart:developer';

import 'package:mxc_logic/internal.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';

import 'sembast_factory.dart'
    if (dart.library.io) 'sembast_factory_io.dart'
    if (dart.library.js) 'sembast_factory_web.dart';

const String _defaultCacheStore = 'cache';

class _CacheManagerSerializersBucket {
  final Map<Type, Serializer> _serializers = {};
  final Map<Type, Deserializer> _deserializers = {};

  void registerType<T>({
    required Serializer<T> serializer,
    required Deserializer<T> deserializer,
  }) {
    dynamic castedSerializer(dynamic t) => serializer(t as T);
    _registerType<T>(serializer: castedSerializer, deserializer: deserializer);
    _registerType<T?>(serializer: castedSerializer, deserializer: deserializer);
  }

  void _registerType<T>({
    required Serializer serializer,
    required Deserializer deserializer,
  }) {
    _serializers[T] = (dynamic t) => serializer(t as T);
    _deserializers[T] = deserializer;
  }
}

class CacheManagerSembast implements CacheManager {
  CacheManagerSembast(
    this.db, [
    _CacheManagerSerializersBucket? serializersBucket,
  ]) : _serializersBucket =
            serializersBucket ?? _CacheManagerSerializersBucket();

  final Database db;
  final _CacheManagerSerializersBucket _serializersBucket;

  static Future<CacheManagerSembast> load(String dbDirectory) async {
    final path = join(dbDirectory, sembastDbName);
    final db = await sembastFactory.openDatabase(path);
    return CacheManagerSembast(db);
  }

  @override
  void registerType<T extends Object>({
    required Serializer<T> serializer,
    required Deserializer<T> deserializer,
  }) {
    _serializersBucket.registerType(
      serializer: serializer,
      deserializer: deserializer,
    );
  }

  @override
  Future<CacheZoneSembast> loadZone(String name) async {
    return await CacheZoneSembast.load(
      db,
      '$_defaultCacheStore-$name-${name.hashCode}',
      _serializersBucket,
    );
  }
}

class CacheZoneSembast implements CacheZone {
  CacheZoneSembast(
    this._db,
    this._store,
    this._inMemory,
    this._serializersBucket,
  );

  final StoreRef<String, dynamic> _store;
  final Database _db;
  final _CacheManagerSerializersBucket _serializersBucket;

  final Map<String, dynamic> _inMemory;

  static Future<CacheZoneSembast> load(
    Database db,
    String storeName,
    _CacheManagerSerializersBucket cacheManagerSerializersBucket,
  ) async {
    final store = StoreRef<String, dynamic>(storeName);
    final snapshots = await store.query().getSnapshots(db);
    return CacheZoneSembast(
      db,
      store,
      snapshots.asMap().map<String, dynamic>(
            (key, ref) => MapEntry<String, dynamic>(ref.key, ref.value),
          ),
      cacheManagerSerializersBucket,
    );
  }

  @override
  T? read<T>(
    String key, [
    Deserializer<T>? deserializer,
  ]) {
    try {
      deserializer ??= _serializersBucket._deserializers[T] as Deserializer<T>?;
      dynamic raw = _inMemory[key];
      if (raw == null) return null;
      if (deserializer != null) {
        raw = deserializer(raw);
      }
      return raw as T;
    } catch (e) {
      log('Cant load field of type $T. Returning default...');
      return null;
    }
  }

  @override
  Future<void> write<T>(
    String key,
    T value, [
    Serializer<T>? serializer,
  ]) async {
    serializer ??= _serializersBucket._serializers[T];
    if (value == null) {
      _inMemory.remove(key);
      await _store.record(key).delete(_db);
    } else {
      final dynamic raw = serializer != null ? serializer(value) : value;
      _inMemory[key] = raw;
      await _store.record(key).put(_db, raw);
    }
  }
}
