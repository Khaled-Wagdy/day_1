import 'package:ecommerce_app_huma_volve/core/error_handling/error_handling.dart';
import 'package:ecommerce_app_huma_volve/features/auth/cubit/auth_states.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/services/login_services.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/services/sign_up_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginServices loginServices;
  final SignUpServices signUpServices;

  AuthCubit({
    required this.loginServices,
    required this.signUpServices,
  }) : super(AuthInitial());

  // ─── Login ───────────────────────────────────────────────────────────────────

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final loginModel = await loginServices.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess(loginModel));
    } on AppException catch (e) {
      emit(LoginError(e.message));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  // ─── Sign Up ─────────────────────────────────────────────────────────────────

  Future<void> signUp(SignUpReqModel signUpReqModel) async {
    emit(SignUpLoading());
    try {
      final user = await signUpServices.signUp(signUpReqModel);
      emit(SignUpSuccess(user));
    } on AppException catch (e) {
      emit(SignUpError(e.message));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
