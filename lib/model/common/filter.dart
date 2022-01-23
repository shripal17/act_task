/// Holder class for filters
class Filter {
  List<String> cities = [];
  List<String> trainers = [];
  List<String> titles = [];

  Filter();

  bool get isActive => cities.isNotEmpty || trainers.isNotEmpty || titles.isNotEmpty;
}
