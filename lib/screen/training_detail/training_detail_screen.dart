import 'package:act_task/model/common/training_item.dart';
import 'package:act_task/util/constants.dart';
import 'package:act_task/util/platform_cached_network_image_provider.dart';
import 'package:act_task/widget/platform_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class TrainingDetailScreen extends StatelessWidget {
  final TrainingItem trainingItem;

  TrainingDetailScreen({Key? key, required this.trainingItem}) : super(key: key);

  final _scrollController = ScrollController(); // Links the NestedScrollView with the extended floating action button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollingFabAnimated(
        // this FAB expands when the scrolling view is at scroll position 0 and shrinks when the scroll position > 0
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        animateIcon: false,
        text: const Text("Buy", style: TextStyle(color: Colors.white)),
        color: AppColors.accent,
        onPress: () => RM.scaffold.showSnackBar(const SnackBar(content: Text("Enrol Now"))),
        scrollController: _scrollController,
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            floating: false,
            actions: [
              Align(alignment: Alignment.centerRight, child: Text(trainingItem.rating.toString())),
              const SizedBox(width: 6),
              const Icon(Icons.star),
              const SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(trainingItem.title),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: PlatformCachedNetworkImage(trainingItem.bigImage ?? '', fit: BoxFit.cover),
                  ),
                  Positioned.fill(
                    child: Container(
                      // This container acts as a gradient for the image
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.black87, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 4,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  _DetailItem(
                    detail: Text(trainingItem.date, style: const TextStyle(fontSize: 16, color: Colors.black)),
                    icon: const Icon(Icons.calendar_today),
                  ),
                  _DetailItem(
                    detail: Text(
                      trainingItem.location.toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.end,
                    ),
                    icon: const Icon(Icons.location_pin),
                    listTileControlAffinity: ListTileControlAffinity.trailing,
                  ),
                  _DetailItem(
                    detail: Text(trainingItem.time, style: const TextStyle(fontSize: 16, color: Colors.black)),
                    icon: const Icon(Icons.watch_later_outlined),
                  ),
                  _DetailItem(
                    detail: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${trainingItem.price?.currency}${trainingItem.price?.originalPrice}",
                          style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(width: 8),
                        Text("${trainingItem.price?.currency}${trainingItem.price?.discountedPrice}", style: const TextStyle(fontSize: 16, color: Colors.black)),
                      ],
                    ),
                    icon: const Icon(Icons.money),
                    listTileControlAffinity: ListTileControlAffinity.trailing,
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 16),
              Text(trainingItem.summary ?? 'No Summary Available'),
            ],
          ),
        ),
      ),
    );
  }
}

/// This widget displays a detail with a relevant icon
/// It also accepts control affinity which controls alignment of the detail and icon widgets
class _DetailItem extends StatelessWidget {
  final Widget detail;
  final Widget icon;
  final ListTileControlAffinity listTileControlAffinity;

  const _DetailItem({Key? key, required this.icon, required this.detail, this.listTileControlAffinity = ListTileControlAffinity.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: listTileControlAffinity == ListTileControlAffinity.trailing ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (listTileControlAffinity == ListTileControlAffinity.leading || listTileControlAffinity == ListTileControlAffinity.platform) ...{
            icon,
            const SizedBox(width: 16),
          },
          Expanded(child: detail),
          if (listTileControlAffinity == ListTileControlAffinity.trailing) ...{
            const SizedBox(width: 16),
            icon,
          },
        ],
      ),
    );
  }
}
