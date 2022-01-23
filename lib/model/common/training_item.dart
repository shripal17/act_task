import 'package:act_task/model/common/trainer_info.dart';
import 'package:act_task/model/common/training_location.dart';
import 'package:act_task/model/common/training_price.dart';

class TrainingItem {
  String title;
  TrainerInfo trainerInfo;
  TrainingLocation location;
  String? bigImage;
  String date;
  String time;
  String? promotionText;
  TrainingPrice? price;
  double? rating;
  bool isFeatured;
  String? summary;

  TrainingItem({
    required this.title,
    required this.trainerInfo,
    required this.location,
    this.bigImage,
    required this.date,
    required this.time,
    this.promotionText,
    this.price,
    this.rating,
    this.isFeatured = false,
    this.summary,
  }) {
    if (rating != null) {
      assert(rating! >= 0 && rating! <= 5);
    }
  }
}
