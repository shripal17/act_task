import 'package:act_task/model/common/filter.dart';
import 'package:act_task/model/common/training_item.dart';
import 'package:act_task/model/response/training_listing_response.dart';

/// Base repository to fetch all training items or just featured items
abstract class TrainingRepository {
  Future<TrainingListingResponse> getAllTrainingItems({Filter? filter});

  Future<List<TrainingItem>> getFeaturedTrainingItems();
}
