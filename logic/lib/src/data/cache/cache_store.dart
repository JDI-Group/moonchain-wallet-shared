import 'package:meta/meta.dart';
import 'package:mxc_logic/internal.dart';
import 'package:mxc_logic/mxc_logic.dart';

abstract class BaseCacheStore {
  CacheZone get _zone;

  @protected
  String get zone;

  @protected
  Field<T?> field<T>(
    String name, {
    Serializer<T>? serializer,
    Deserializer<T>? deserializer,
  }) =>
      CacheField.nullable<T>(
        _zone,
        name,
        serializer: serializer,
        deserializer: deserializer,
      );

  @protected
  Field<T> fieldWithDefault<T>(
    String name,
    T defaultValue, {
    Serializer<T>? serializer,
    Deserializer<T>? deserializer,
  }) =>
      CacheField.withDefault(
        _zone,
        name,
        defaultValue,
        serializer: serializer,
        deserializer: deserializer,
      );

  @protected
  Future<void> cleanFields(List<Field> fields) {
    return Future.wait(
      fields.whereType<CacheField>().map((e) => e.save(e.defaultValue)),
    );
  }
}

abstract class GlobalCacheStore extends BaseCacheStore {
  @override
  late final CacheZone _zone;

  Future<void> load(CacheManager manager) async {
    _zone = await manager.loadZone(zone);
  }
}

abstract class ControlledCacheStore extends BaseCacheStore {
  CacheZone? _backedZone;

  @override
  CacheZone get _zone =>
      _backedZone ?? (throw Exception('Zone has not been loaded.'));

  Future<void> _load(CacheManager manager, String key) async {
    _backedZone = await manager.loadZone('$key/$zone');
  }

  void unload() => _backedZone = null;
}

class CacheController {
  CacheController(this._manager, this.prefixKey);

  final List<ControlledCacheStore> _innerRepositories = [];

  final CacheManager _manager;
  final String prefixKey;

  void register(ControlledCacheStore repository) {
    _innerRepositories.add(repository);
  }

  void unload() {
    // not working
    _innerRepositories.map((e) => e.unload());
  }

  Future<void> load(String key) async {
    await Future.wait(
      _innerRepositories.map(
        (e) async {
          await e._load(_manager, '$prefixKey/$key');
        },
      ),
    );
  }
}
