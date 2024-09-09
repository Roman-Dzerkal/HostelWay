part of 'otp_verifyer_bloc.dart';

sealed class OtpVerifyerState extends Equatable {
  final String otp;

  const OtpVerifyerState({
    this.otp = '',
  });

  OtpVerifyerState copyWith({
    String? otp,
  }) {
    return OtpVerifyerInitial(
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object> get props => [otp];
}

final class OtpVerifyerInitial extends OtpVerifyerState {
  const OtpVerifyerInitial({
    super.otp,
  });
}
