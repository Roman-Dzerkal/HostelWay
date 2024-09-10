import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'otp_verifyer_event.dart';
part 'otp_verifyer_state.dart';

class OtpVerifyerBloc extends Bloc<OtpVerifyerEvent, OtpVerifyerState> {
  final SupabaseClient client = Supabase.instance.client;

  OtpVerifyerBloc() : super(const OtpVerifyerInitial()) {
    on<OtpVerifyerEvent>((event, emit) {
    });

    on<OtpVerifyerSubmitEvent>((event, emit) async {
      String otpToken = event.otp;
      AuthResponse response =
          await client.auth.verifyOTP(token: otpToken, type: OtpType.recovery);

      if (response.user != null) {
        client.auth.admin.updateUserById(response.user!.id,
            attributes: AdminUserAttributes(
              email: response.user!.email,
              password: '_dz-r0m4N_',
            ));
      }

    });

    on<OtpVerifyerChangeOtpEvent>((event, emit) {});
  }
}
