import 'package:act_task/model/common/filter.dart';
import 'package:act_task/model/response/training_listing_response.dart';
import 'package:act_task/screen/home/filter_dialog.dart';
import 'package:act_task/screen/home/highlights_view.dart';
import 'package:act_task/util/constants.dart';
import 'package:act_task/util/states.dart';
import 'package:act_task/widget/centered_progress.dart';
import 'package:act_task/widget/training_item_view.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Stateful wrapper for the response received from data source
  final _trainingResponseIN = RM.inject<TrainingListingResponse?>(() => null);

  // Stateful wrapper for the currently applied filter
  final _filterIN = RM.inject(() => Filter());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // avoid resizing when searching in the filter dialog
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.accent,
        toolbarHeight: kToolbarHeight + 26,
        title: const Text("Trainings", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SafeArea(
        child: OnBuilder(
          listenToMany: [_filterIN, _trainingResponseIN],
          sideEffects: SideEffects(initState: _loadAllTrainingItems),
          builder: () => _trainingResponseIN.isWaiting
              ? const CenteredProgressIndicator()
              : _trainingResponseIN.hasError || !_trainingResponseIN.hasData
                  ? Center(child: Text(_trainingResponseIN.error.toString()))
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: HighlightsView(
                            onFilterButtonClicked: () {
                              Filter updatedFilter = _filterIN.state;
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => FilterDialog(
                                  availableCities: _trainingResponseIN.state!.availableCities,
                                  availableTrainers: _trainingResponseIN.state!.availableTrainers,
                                  availableTrainings: _trainingResponseIN.state!.availableTrainings,
                                  existingFilter: _filterIN.state,
                                  onFilterUpdated: (newFilter) {
                                    updatedFilter = newFilter;
                                  },
                                ),
                              ).then((_) {
                                // wait for the filter dialog to be closed/dismissed, then re-load data
                                _filterIN.setState((s) {
                                  s = updatedFilter;
                                  return s;
                                });
                                _loadAllTrainingItems();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _trainingResponseIN.state!.trainingItems.length,
                            itemBuilder: (context, index) => TrainingItemView(trainingItem: _trainingResponseIN.state!.trainingItems[index]),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  /// loads the (filtered) data from the data source and updates the stateful wrapper with new data
  void _loadAllTrainingItems() {
    _trainingResponseIN.setState((s) async {
      s = await trainingRepository.getAllTrainingItems(filter: _filterIN.state);
      return s;
    });
  }
}
