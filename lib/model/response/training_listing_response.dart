import 'package:act_task/model/common/training_item.dart';

/// Expected response from API
class TrainingListingResponse {
  List<TrainingItem> trainingItems = [];
  List<String> availableCities = [];
  List<String> availableTrainers = [];
  List<String> availableTrainings = [];

  TrainingListingResponse({required this.trainingItems, required this.availableCities, required this.availableTrainers, required this.availableTrainings});
}
