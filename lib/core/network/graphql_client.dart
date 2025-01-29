import 'package:e_commerce_frontend/utils/shared_pref_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    dotenv.env['API_URL']!,
  );

  static ValueNotifier<GraphQLClient> initializeClient() {
    return ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: CustomCache(),
      ),
    );
  }

  static GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: httpLink,
      cache: CustomCache(),
    );
  }
}

class CustomCache extends GraphQLCache {
  final SharedPreferencesCache _cache = SharedPreferencesCache();

  Future<void> write(String key, dynamic value) async {
    await _cache.saveCache({key: value});
  }

  Future<dynamic> read(String key) async {
    Map<String, dynamic>? cacheData = await _cache.getCache();
    if (cacheData != null && cacheData.containsKey(key)) {
      return cacheData[key];
    }
    return null;
  }

  Future<void> clear() async {
    await _cache.clearCache();
  }
}
