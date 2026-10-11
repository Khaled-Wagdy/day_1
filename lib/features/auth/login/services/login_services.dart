import 'package:ecommerce_app_huma_volve/core/constant/api_constant.dart';
import 'package:ecommerce_app_huma_volve/core/networking/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/login_model.dart';

class LoginServices {
  ApiClient apiClient;

  LoginServices(this.apiClient);

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiConstant.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final Map<String, dynamic> data = response.data;
    final modeldata = LoginModel.fromJson(data);
    return modeldata;
  }
}
