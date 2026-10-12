import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constant/api_constant.dart';
import 'package:ecommerce_app_huma_volve/core/networking/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_res_model.dart';

class SignUpServices {
  ApiClient apiClient;
  SignUpServices(this.apiClient);

  Future<SignupRecModel> signUp(SignUpReqModel signUpReqModel) async {
    final response = await apiClient.dio.post(
      ApiConstant.signUpEndpoint,
      data: {
        "email": signUpReqModel.email,
        "name": signUpReqModel.name,
        "password": signUpReqModel.password,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480&r=867",
      },
    );
    return SignupRecModel.fromJson(response.data);
  }
}
