import 'package:ecommerce_app_huma_volve/features/home/models/categorie_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

// ─── Categories States ───────────────────────────────────────────────────────

class CategoriesLoading extends HomeStates {}

class CategoriesSuccess extends HomeStates {
  final List<CategorieModel> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesError extends HomeStates {
  final String errorMessage;
  CategoriesError(this.errorMessage);
}

// ─── Products States ─────────────────────────────────────────────────────────

class ProductLoading extends HomeStates {}

class ProductSuccess extends HomeStates {
  final List<ProductModel> products;
  ProductSuccess(this.products);
}

class ProductError extends HomeStates {
  final String errorMessage;
  ProductError(this.errorMessage);
}
