import 'package:act_task/model/common/training_item.dart';
import 'package:act_task/screen/training_detail/training_detail_screen.dart';
import 'package:act_task/util/constants.dart';
import 'package:act_task/util/platform_cached_network_image_provider.dart';
import 'package:act_task/widget/vertical_dashed_divider.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

/// This widget is one item of the training items listing
class TrainingItemView extends StatelessWidget {
  final TrainingItem trainingItem;

  const TrainingItemView({Key? key, required this.trainingItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 190),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(trainingItem.date, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text(trainingItem.time, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      const Spacer(),
                      Text(trainingItem.location.toString(), style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const VerticalDashedDivider(thickness: 1, height: 2),
                const SizedBox(width: 12),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (trainingItem.promotionText != null) ...{
                        Text(trainingItem.promotionText!, style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                      },
                      Text(
                        "${trainingItem.title} (${trainingItem.rating ?? ""})",
                        style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (trainingItem.trainerInfo.profileImage != null) ...{
                            CircleAvatar(backgroundImage: PlatformCachedNetworkImageProvider(trainingItem.trainerInfo.profileImage!), radius: 24),
                            const SizedBox(width: 8),
                          },
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Keynote Speaker", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                                const SizedBox(height: 2),
                                Text(trainingItem.trainerInfo.name, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => RM.navigate.to(TrainingDetailScreen(trainingItem: trainingItem)),
                          child: const Text("Enrol Now"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
