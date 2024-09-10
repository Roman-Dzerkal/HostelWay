part of 'otp_verifyer_bloc.dart';

sealed class OtpVerifyerEvent extends Equatable {
  const OtpVerifyerEvent();

  @override
  List<Object> get props => [];
}

class OtpVerifyerSubmitEvent extends OtpVerifyerEvent {
  final String otp;

  const OtpVerifyerSubmitEvent(this.otp);
}

class OtpVerifyerChangeOtpEvent extends OtpVerifyerEvent {
  final String otp;

  const OtpVerifyerChangeOtpEvent(this.otp);
}
