import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/core/app_images.dart';
import 'package:la_vie/core/app_repository.dart';
import 'package:la_vie/core/app_web_services.dart';
import 'package:la_vie/model/blog.dart';
import 'package:la_vie/model/filter_model.dart';
import 'package:la_vie/model/product.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.webServices, required this.appRepository})
      : super(HomeFiltersInitial());
  final AppWebServices webServices;
  final AppRepository appRepository;

  static HomeCubit get(context) => BlocProvider.of(context);
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

  List<Product> products = [];
  getProducts() async {
    appRepository.getAllProducts().then((products) {
      this.products = products;
      emit(GetProducts(products));
    }).catchError((onError) {
      print(onError.toString());
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
