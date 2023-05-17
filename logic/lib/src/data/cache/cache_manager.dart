import 'cache_manager_sembast.dart';

typedef Serializer<T> = dynamic Function(T);
typedef Deserializer<T> = T Function(dynamic);

abstract class CacheManager {
  static Future<CacheManagerSembast> load([String dbDirectory = './']) =>
      CacheManagerSembast.load(dbDirectory);

  void registerType<T extends Object>({
    required Serializer<T> serializer,
    required Deserializer<T> deserializer,
  });

  Future<CacheZone> loadZone(String name);
}

abstract class CacheZone {
  T? read<T>(
    String key, [
    Deserializer<T>? deserializer,
  ]);

  Future<void> write<T>(
    String key,
    T value, [
    Serializer<T>? serializer,
  ]);
}
