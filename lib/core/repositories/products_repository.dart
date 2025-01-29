import 'dart:developer';

import 'package:e_commerce_frontend/core/graphql/product_graphql_resolvers/product_graphql_queries.dart';
import 'package:e_commerce_frontend/core/network/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductsRepository {
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final client = GraphQLConfig.clientToQuery();

    final response = await client.query(
      QueryOptions(document: gql(getProductsQuery)),
    );

    if (response.hasException) {
      log(response.exception.toString());
      return [];
    }

    return List<Map<String, dynamic>>.from(response.data?['getProducts'] ?? []);
  }
}
