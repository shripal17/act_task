import 'package:act_task/model/common/filter.dart';
import 'package:act_task/util/constants.dart';
import 'package:act_task/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

/// Filters Bottom Sheet Dialog
/// This screen automatically calls onFilterUpdated whenever user updates the filters
/// Accepts all cities, trainers and training titles list to display
/// Also, accepts existing applied filter (before this screen is opened)
class FilterDialog extends StatefulWidget {
  final List<String> availableCities;

  final List<String> availableTrainers;

  final List<String> availableTrainings;

  final Filter? existingFilter;

  final Function(Filter newFilter)? onFilterUpdated;

  const FilterDialog({
    Key? key,
    required this.availableCities,
    required this.availableTrainers,
    required this.availableTrainings,
    this.existingFilter,
    this.onFilterUpdated,
  }) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  // Local filter state object
  late final _filterIN = RM.inject(
    () => Filter()
      ..cities = List.of(widget.existingFilter?.cities ?? [])
      ..titles = List.of(widget.existingFilter?.titles ?? [])
      ..trainers = List.of(widget.existingFilter?.trainers ?? []),
  );

  // Which filter section/view is currently selected (Location/Training Names/Trainers)
  late final _currentFilterViewIN = RM.inject<_FilterView>(
    () => _FilterView.location,
    sideEffects: SideEffects(
      initState: () => _initDataSet(),
      onSetState: (_) {
        _searchTextIN.setState((s) => "");
        _searchController.text = "";
      },
    ),
  );

  // Holder for entered search text
  final _searchTextIN = RM.inject<String?>(() => null);

  // Actual locations, trainer names, training titles data set
  // It is a map of the filter sections and the possible values for that section along with each value's selected/checked state (true/false)
  late final _filterDataSetIN = RM.inject<Map<_FilterView, Map<String, bool>>>(
    () => {},
    sideEffects: SideEffects(onSetState: (_) => _updateFilter()),
  );

  // search controller to clear text in search box when switching filter views
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Scaffold(
        primary: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 6,
          automaticallyImplyLeading: false,
          title: const Text("Filters"),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => RM.navigate.back(),
              icon: Icon(Icons.close, color: Colors.black.withOpacity(0.7)),
              tooltip: "Close",
            ),
          ],
        ),
        body: SafeArea(
          child: OnBuilder(
            listenToMany: [_filterIN, _currentFilterViewIN, _searchTextIN],
            builder: () => Row(
              children: [
                // Left filter sections
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: _FilterView.values
                        .map((e) => _FilterLabelView(
                              filterView: e,
                              selectedFilterView: _currentFilterViewIN.state,
                              onClicked: (newFilter) => _currentFilterViewIN.setState((s) => newFilter),
                            ))
                        .toList(),
                  ),
                ),
                // right side search box and filter items list
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _searchController,
                          maxLines: 1,
                          onChanged: (searchText) => _searchTextIN.setState((s) {
                            s = searchText;
                            return s;
                          }),
                          textInputAction: TextInputAction.search,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Search",
                            hintStyle: TextStyle(color: Color(0xFFA1A1A1)),
                            prefixIcon: Icon(Icons.search, color: Color(0xFFA1A1A1)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: OnBuilder(
                            listenTo: _filterDataSetIN,
                            builder: () {
                              // further filter the data set as per the search text
                              final dataSet = _searchTextIN.state != null && _searchTextIN.state!.isNotEmpty
                                  ? _filterDataSetIN.state[_currentFilterViewIN.state]!.entries
                                      .where((element) => element.key.toLowerCase().contains(_searchTextIN.state!))
                                      .toList()
                                  : _filterDataSetIN.state[_currentFilterViewIN.state]!.entries.toList();
                              return ListView.builder(
                                controller: scrollController, // to synchronize scrolling with the bottom sheet expansion/collision
                                itemCount: dataSet.length,
                                itemBuilder: (_, index) {
                                  final currentItem = dataSet[index];
                                  return CheckboxListTile(
                                    title: Text(currentItem.key),
                                    value: currentItem.value,
                                    controlAffinity: ListTileControlAffinity.leading,
                                    onChanged: (bool? value) {
                                      _filterDataSetIN.setState((s) {
                                        s[_currentFilterViewIN.state]![currentItem.key] = value ?? false;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Initialise the data set as per all available filters v/s applied filters
  void _initDataSet() {
    _filterDataSetIN.setState((s) {
      s[_FilterView.location] = {};
      s[_FilterView.trainer] = {};
      s[_FilterView.trainingName] = {};

      for (String city in widget.availableCities) {
        s[_FilterView.location]![city] = _filterIN.state.cities.contains(city);
      }
      for (String trainer in widget.availableTrainers) {
        s[_FilterView.trainer]![trainer] = _filterIN.state.trainers.contains(trainer);
      }
      for (String trainingTitle in widget.availableTrainings) {
        s[_FilterView.trainingName]![trainingTitle] = _filterIN.state.titles.contains(trainingTitle);
      }
      return s;
    });
  }

  // Populate the filters as per user's selection and notify this screen's call-site about the updated filter
  void _updateFilter() {
    _filterIN.setState((s) {
      switch (_currentFilterViewIN.state) {
        case _FilterView.location:
          s.cities.clear();
          _filterDataSetIN.state[_FilterView.location]!.entries.where((element) => element.value).forEach((element) {
            s.cities.add(element.key);
          });
          break;
        case _FilterView.trainer:
          s.trainers.clear();
          _filterDataSetIN.state[_FilterView.trainer]!.entries.where((element) => element.value).forEach((element) {
            s.trainers.add(element.key);
          });
          break;
        case _FilterView.trainingName:
          s.titles.clear();
          _filterDataSetIN.state[_FilterView.trainingName]!.entries.where((element) => element.value).forEach((element) {
            s.titles.add(element.key);
          });
          break;
      }
      widget.onFilterUpdated?.call(s);
      return s;
    });
  }
}

/// Label View which is shown on the left side
class _FilterLabelView extends StatelessWidget {
  final _FilterView filterView;
  final _FilterView selectedFilterView;
  final Function(_FilterView)? onClicked;

  const _FilterLabelView({Key? key, required this.filterView, required this.selectedFilterView, this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClicked?.call(filterView),
      child: Ink(
        color: isCurrentSelected ? Colors.white : AppColors.background,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(color: isCurrentSelected ? AppColors.accent : AppColors.background, width: 4, height: 60),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  filterView.toString().split(".")[1].readableFromCamelCase,
                  style: TextStyle(fontWeight: isCurrentSelected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isCurrentSelected => filterView == selectedFilterView;
}

/// An enum to maintain which filter section is selected
enum _FilterView {
  location,
  trainer,
  trainingName,
}
