import 'package:ecommerce_app_huma_volve/features/auth/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_res_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

// ─── Login States ─────────────────────────────────────────────────────────────

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginError extends AuthState {
  final String errorMessage;
  LoginError(this.errorMessage);
}

// ─── Sign Up States ───────────────────────────────────────────────────────────

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  final SignupRecModel user;
  SignUpSuccess(this.user);
}

class SignUpError extends AuthState {
  final String errorMessage;
  SignUpError(this.errorMessage);
}
