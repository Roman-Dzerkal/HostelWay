import 'package:flutter/foundation.dart';
import 'package:hostelway/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorizationRepository {
  Future<UserModel?> getUser() async {
    try {
      if (Supabase.instance.client.auth.currentUser != null) {
        final doc = await Supabase.instance.client
            .from('users')
            .select()
            .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
            .single();

        UserModel userModel = UserModel.fromJson(doc);

        return userModel;
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return null;
  }
}
