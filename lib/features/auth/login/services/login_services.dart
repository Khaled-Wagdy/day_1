import 'package:ecommerce_app_huma_volve/core/constant/api_constant.dart';
import 'package:ecommerce_app_huma_volve/core/error_handling/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/networking/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/login_model.dart';

class LoginServices {
  final ApiClient apiClient;
  LoginServices(this.apiClient);

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.dio.post(
        ApiConstant.loginEndpoint,
        data: {'email': email, 'password': password},
      );
      return LoginModel.fromJson(response.data);
    } catch (e) {
      throw handleDioError(e);
    }
  }
}
