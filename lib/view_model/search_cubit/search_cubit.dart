import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  bool isSearching = false;
  void toggleSearch(bool isSearching) {
    this.isSearching = isSearching;
    emit(SearchToggling());
  }

  void deleteSearchItem({required List<String> list, required int index}) {
    list.removeAt(index);
    emit(SearchDeleteHistory());
  }
}
