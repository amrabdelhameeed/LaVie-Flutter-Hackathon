part of 'home_cubit.dart';

abstract class HomeState {}

class HomeFiltersInitial extends HomeState {}

class HomeFilterSelectedState extends HomeState {
  final String filterName;

  HomeFilterSelectedState(this.filterName);
}

class GetProducts extends HomeState {
  final List<Product> products;

  GetProducts(this.products);
}

class GetProductsError extends HomeState {
  final String error;

  GetProductsError(this.error);
}

class AddOrRemoveFromQuantity extends HomeState {}

class AddedToCart extends HomeState {}

class DeleteFromCart extends HomeState {}
