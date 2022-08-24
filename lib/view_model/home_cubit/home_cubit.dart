import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_repository.dart';
import '../../model/filter_model.dart';
import '../../model/product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.appRepository}) : super(HomeFiltersInitial());
  final AppRepository appRepository;

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Product> products = [];
  List<Product> cart = [];

  String currentFilter = 'ALL';
  void selectFilterAndGetItsList(
      FilterModel filter, List<FilterModel> filters) async {
    for (var filter in filters) {
      filter.unSelectFilter();
    }
    filter.selectFilter();
    currentFilter = filter.filterName.toUpperCase();
    emit(HomeFilterSelectedState(currentFilter.toUpperCase()));
  }

  getProducts() async {
    appRepository.getAllProducts().then((products) {
      this.products = products;
      emit(GetProducts(products));
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(GetProductsError(onError.toString()));
    });
  }

  void addOrRemoveFromQuantity(bool isAdding, Product product) {
    product.addOrRemoveFromQuantity(isAdding);
    emit(AddOrRemoveFromQuantity());
  }

  void addToCart(Product product) {
    if (!cart.contains(product)) {
      cart.add(product);
    }
    emit(AddedToCart());
  }

  void deleteFromCart(Product product) {
    cart.remove(product);
    emit(DeleteFromCart());
  }

  num getTotalprice() => cart
      .map((e) => e.price * e.quantity!)
      .reduce((value, element) => value + element);
}
