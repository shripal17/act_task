import 'package:act_task/model/common/training_item.dart';
import 'package:act_task/service/fake_training_repository.dart';
import 'package:act_task/util/constants.dart';
import 'package:act_task/util/extensions.dart';
import 'package:act_task/widget/carousel_item.dart';
import 'package:flutter/material.dart';

/// Loads featured training items and displays them in a carousel
class HighlightsView extends StatefulWidget {
  final VoidCallback? onFilterButtonClicked;

  const HighlightsView({Key? key, this.onFilterButtonClicked}) : super(key: key);

  @override
  _HighlightsViewState createState() => _HighlightsViewState();
}

class _HighlightsViewState extends State<HighlightsView> {
  final _carouselController = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TrainingItem>>(
      future: FakeTrainingRepository().getFeaturedTrainingItems(),
      builder: (context, snapshot) => snapshot.hasError
          ? Text(snapshot.error.toString())
          : !snapshot.hasData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: context.screenHeight * 0.25,
                        color: AppColors.accent,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: context.screenHeight * 0.25,
                        color: Colors.white,
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(left: 24, bottom: 36),
                            child: Text("Highlights", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: FractionallySizedBox(
                                    heightFactor: 0.3,
                                    child: RawMaterialButton(
                                      fillColor: Colors.transparent,
                                      onPressed: () {
                                        if ((_carouselController.page ?? 0).toInt() == 0) {
                                          // already on first carousel item, move to last item
                                          _carouselController.animateToPage(snapshot.data!.length - 1,
                                              duration: AnimationConstants.kDefaultAnimDuration, curve: AnimationConstants.kDefaultAnimCurve);
                                        } else {
                                          _carouselController.previousPage(
                                              duration: AnimationConstants.kDefaultAnimDuration, curve: AnimationConstants.kDefaultAnimCurve);
                                        }
                                      },
                                      child: const Center(child: Icon(Icons.chevron_left, color: Colors.white)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 13,
                                  child: Center(
                                    child: AspectRatio(
                                      aspectRatio: 2.2, // aspect ratio chosen as per dimensions
                                      child: PageView.builder(
                                        controller: _carouselController,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) => CarouselItem(trainingItem: snapshot.data![index]),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: FractionallySizedBox(
                                    heightFactor: 0.3,
                                    child: RawMaterialButton(
                                      fillColor: Colors.transparent,
                                      onPressed: () {
                                        if ((_carouselController.page ?? 0).toInt() == snapshot.data!.length - 1) {
                                          // already on last carousel item, move to first item
                                          _carouselController.animateToPage(0,
                                              duration: AnimationConstants.kDefaultAnimDuration, curve: AnimationConstants.kDefaultAnimCurve);
                                        } else {
                                          _carouselController.nextPage(duration: AnimationConstants.kDefaultAnimDuration, curve: AnimationConstants.kDefaultAnimCurve);
                                        }
                                      },
                                      child: const Center(child: Icon(Icons.chevron_right, color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16, left: 16, top: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(side: const BorderSide(color: Color(0xFFB5B5B5)), borderRadius: BorderRadius.circular(4)),
                                  ),
                                  foregroundColor: MaterialStateProperty.all(Colors.grey[700]),
                                ),
                                onPressed: widget.onFilterButtonClicked,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.filter_list, color: Colors.grey[700]),
                                    const SizedBox(width: 2),
                                    const Text("Filter"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
