import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class DataClass {
  static Future<T?> getUserMetadata<T>(String key, [String userId = '']) async {
    // If userId is empty, then we are getting the current user's metadata
    try {
      if (userId.isEmpty) {
        if (Supabase.instance.client.auth.currentUser == null) {
          return null;
        } else {
          return Supabase.instance.client.auth.currentUser!.userMetadata![key]
              as T;
        }
        // Else we are getting the metadata of another user
      } else {
        SupabaseClient adminClient = SupabaseClient(
          const String.fromEnvironment('SUPABASE_URL'),
          const String.fromEnvironment('SUPABASE_SERVICE_ROLE_KEY'),
        );
        UserResponse response = await adminClient.auth.admin.getUserById(userId); 
        // return response.user!.userMetadata![key];


      }
    } on Exception catch (e) {
      return null;
    }
  }
}
