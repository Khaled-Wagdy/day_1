import 'package:ecommerce_app_huma_volve/core/error_handling/error_handling.dart';
import 'package:ecommerce_app_huma_volve/features/home/cubit/home_states.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeServices homeServices;

  HomeCubit(this.homeServices) : super(HomeInitialState());

  void loadHomeData() async {
    emit(CategoriesLoading());
    try {
      final categories = await homeServices.getcategories();
      emit(CategoriesSuccess(categories));
    } on AppException catch (e) {
      emit(CategoriesError(e.message));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void loadProducts(int? categoryId) async {
    emit(ProductLoading());
    try {
      final products = await homeServices.getproducts(categoryId);
      emit(ProductSuccess(products));
    } on AppException catch (e) {
      emit(ProductError(e.message));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
