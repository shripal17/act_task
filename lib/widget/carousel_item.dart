import 'package:act_task/model/common/training_item.dart';
import 'package:act_task/screen/training_detail/training_detail_screen.dart';
import 'package:act_task/util/constants.dart';
import 'package:act_task/util/platform_cached_network_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

/// This widget is one item of the carousel
class CarouselItem extends StatelessWidget {
  final TrainingItem trainingItem;

  const CarouselItem({Key? key, required this.trainingItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => RM.navigate.to(TrainingDetailScreen(trainingItem: trainingItem)),
        child: Card(
          elevation: 6,
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(image: PlatformCachedNetworkImageProvider(trainingItem.bigImage ?? ''), fit: BoxFit.cover),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(trainingItem.title, style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("${trainingItem.location.city} - ${trainingItem.date}", style: const TextStyle(fontSize: 20, color: Colors.white60)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Text(
                        "${trainingItem.price?.currency}${trainingItem.price?.originalPrice}",
                        style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12, color: AppColors.accent),
                      ),
                      const SizedBox(width: 8),
                      Text("${trainingItem.price?.currency}${trainingItem.price?.discountedPrice}",
                          style: const TextStyle(fontSize: 16, color: AppColors.accent, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      const Text("View Details", style: TextStyle(fontSize: 14, color: Colors.white70)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, color: Colors.white70, size: 14),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
