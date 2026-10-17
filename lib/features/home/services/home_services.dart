import 'package:ecommerce_app_huma_volve/core/constant/api_constant.dart';
import 'package:ecommerce_app_huma_volve/core/error_handling/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/networking/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/categorie_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';

class HomeServices {
  final ApiClient apiClient;
  HomeServices(this.apiClient);

  Future<List<CategorieModel>> getcategories() async {
    try {
      final response = await apiClient.dio.get(ApiConstant.categoriesEndpoint);
      return (response.data as List)
          .map((e) => CategorieModel.fromJson(e))
          .toList();
    } catch (e) {
      throw handleDioError(e);
    }
  }

  Future<List<ProductModel>> getproducts(int? categoryId) async {
    try {
      // ✅ الـ URL الصح: /products?categoryId=X
      final String url = categoryId != null
          ? '${ApiConstant.productsEndpoint}?categoryId=$categoryId'
          : ApiConstant.productsEndpoint;

      final response = await apiClient.dio.get(url);
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      throw handleDioError(e);
    }
  }
}
