import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../graphql/auth_graphql_resolvers/auth_graphql_mutations.dart';
import '../network/graphql_client.dart';

class AuthRepository {
  Future<bool> signup(String firstName, String lastName, String email,
      String password, String userType) async {
    final client = GraphQLConfig.clientToQuery();
    log("Sign-Up repo: $userType");
    final QueryResult<Object?> response;
    if (userType == "Customer") {
      response = await client.mutate(
        MutationOptions(
          document: gql(signupMutation),
          variables: {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
          },
        ),
      );
      if (response.hasException) {
        log(response.exception.toString());
        return false;
      }

      return response.data!['createUser']['success'];
    } else {
      response = await client.mutate(
        MutationOptions(
          document: gql(retailerSignupMutation),
          variables: {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
          },
        ),
      );

      if (response.hasException) {
        log(response.exception.toString());
        log("suceess");
        return false;
      }

      bool isSignUp = response.data!['createRetailer']['success'];
      return isSignUp;
    }
  }

  Future<bool> login(String email, String password, String userType) async {
    final client = GraphQLConfig.clientToQuery();
    log("Sign in role : $userType");
    final QueryResult<Object?> response;
    // ignore: prefer_typing_uninitialized_variables
    final token;
    if (userType == 'Customer') {
      response = await client.mutate(
        MutationOptions(
          document: gql(signInMutation),
          variables: {
            "email": email,
            "password": password,
          },
        ),
      );

      if (response.hasException) {
        log(response.exception.toString());
        return false;
      }

      token = response.data!['signIn']['token'];
    } else {
      response = await client.mutate(
        MutationOptions(
          document: gql(retailerSignInMutation),
          variables: {
            "email": email,
            "password": password,
          },
        ),
      );

      if (response.hasException) {
        log(response.exception.toString());
        return false;
      }

      token = response.data!['retailerSignIn']['token'];
    }

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('role', userType);
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
