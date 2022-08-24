class FilterModel {
  final String filterName;
  bool isSelected;

  FilterModel({required this.filterName, this.isSelected = false});
  void selectFilter() {
    isSelected = true;
  }

  void unSelectFilter() {
    isSelected = false;
  }

  static List<FilterModel> filters = [
    FilterModel(filterName: 'all', isSelected: true),
    FilterModel(
      filterName: 'plant',
    ),
    FilterModel(filterName: 'seed'),
    FilterModel(filterName: 'tool'),
  ];
  static List<FilterModel> Postsfilters = [
    FilterModel(filterName: 'all', isSelected: true),
    FilterModel(
      filterName: 'me',
    ),
  ];
}
