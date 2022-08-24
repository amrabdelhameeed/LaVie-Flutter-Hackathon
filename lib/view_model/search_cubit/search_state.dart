part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchToggling extends SearchState {}

class SearchDeleteHistory extends SearchState {}
