import 'package:act_task/model/common/filter.dart';
import 'package:act_task/model/common/trainer_info.dart';
import 'package:act_task/model/common/training_item.dart';
import 'package:act_task/model/common/training_location.dart';
import 'package:act_task/model/common/training_price.dart';
import 'package:act_task/model/response/training_listing_response.dart';
import 'package:act_task/repository/training_repository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class FakeTrainingRepository implements TrainingRepository {
  static const _summaryText = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In fringilla libero sollicitudin quam pellentesque, quis rhoncus leo maximus. Mauris sodales eu enim malesuada porta. Mauris mollis turpis a lorem tempus convallis. Phasellus dictum odio diam, ut facilisis lectus pulvinar at. Vivamus venenatis justo sit amet neque molestie varius. In tristique feugiat dolor id rutrum. In consequat aliquet ipsum, ut laoreet eros tempus non. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque aliquam accumsan ipsum, sit amet hendrerit arcu faucibus vitae.

Nullam ut porttitor sapien. Sed ac mi sit amet magna porttitor dictum a a leo. Morbi tristique a sem a aliquam. Cras vehicula, quam at condimentum ultrices, massa elit pellentesque nisl, in aliquam massa ipsum eget ipsum. Sed vestibulum nec orci nec ornare. Curabitur in sollicitudin ligula. Phasellus vulputate luctus massa ac commodo. Curabitur varius metus quis varius tincidunt. Nam sit amet augue semper, semper tortor eget, mattis ligula. Suspendisse non lacus risus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent laoreet blandit vehicula.

Sed eget feugiat enim, at posuere mauris. Nullam sed accumsan quam. Aenean libero turpis, venenatis vitae facilisis porta, placerat vitae ligula. In dui massa, convallis bibendum fringilla eget, tincidunt in dui. Donec id bibendum velit, sed efficitur libero. Quisque diam ipsum, laoreet vel sem eu, ultricies bibendum elit. In aliquet est risus, eu ullamcorper nulla egestas sit amet. Nam pellentesque eget elit in tincidunt. Ut consectetur condimentum ligula, vel imperdiet eros. Fusce et euismod lorem. Nulla gravida magna sed nisi accumsan, efficitur consequat ipsum pulvinar. Donec risus velit, auctor sed mi sed, fringilla cursus orci. Phasellus id rutrum erat, id feugiat urna. Quisque odio purus, suscipit sit amet tortor a, molestie vehicula lacus. Curabitur aliquet urna dui.

Aliquam non tincidunt odio. Maecenas non nisi ut mauris egestas aliquet. Vestibulum tristique accumsan tincidunt. Mauris et porta orci, at iaculis mauris. Sed id dolor suscipit, ultricies leo ac, gravida ex. Fusce interdum euismod nulla a varius. Morbi at lobortis ipsum. Suspendisse id consequat sapien. Phasellus fringilla a eros vel volutpat.

Vestibulum orci est, tempus non congue vel, mattis ut massa. Curabitur ac purus est. Duis ac sapien non nunc lacinia consequat. Nulla nec orci et arcu viverra viverra vitae sit amet risus. Duis lacinia porttitor molestie. Vestibulum tellus odio, semper ac metus a, lacinia ultricies eros. Vestibulum consequat quam sem, ut hendrerit augue maximus sit amet. Morbi vehicula malesuada quam at lobortis. Donec imperdiet volutpat sem ac fermentum. Vivamus interdum ex a enim cursus, sed scelerisque nulla faucibus. Duis vitae mi id massa imperdiet vulputate eget eu sapien. Morbi nec pharetra lorem, sed pulvinar eros. Donec varius turpis mi, at efficitur justo venenatis sit amet. Phasellus eleifend accumsan neque, sed efficitur enim dignissim ultricies.
''';

  final _allTrainingItems = <TrainingItem>[
    TrainingItem(
      title: "Safe Scrum Master",
      trainerInfo: TrainerInfo(name: "Helen Gribble", profileImage: "https://picsum.photos/200?q=1"),
      location: TrainingLocation(address: 'Convention Hall', city: 'Greater Des Moines'),
      bigImage: 'https://picsum.photos/400/150?q=1',
      date: "Feb 11 - 13, 2022",
      time: "08:30AM - 12:30PM",
      promotionText: "Filling Fast!",
      price: TrainingPrice(currency: "\$", originalPrice: 975, discountedPrice: 825),
      rating: 4.6,
      isFeatured: true,
      summary: _summaryText,
    ),
    TrainingItem(
      title: "Scrum Expert",
      trainerInfo: TrainerInfo(name: "Shripal Jain", profileImage: "https://picsum.photos/200?q=2"),
      location: TrainingLocation(address: 'Town Hall', city: 'New York'),
      bigImage: 'https://picsum.photos/400/150?q=2',
      date: "Feb 15 - 17, 2022",
      time: "09:30AM - 01:00PM",
      promotionText: "Early bird!",
      price: TrainingPrice(currency: "\$", originalPrice: 1000, discountedPrice: 800),
      rating: 4.8,
      isFeatured: true,
      summary: _summaryText,
    ),
    TrainingItem(
      title: "Flutter Bootcamp",
      trainerInfo: TrainerInfo(name: "Angela Yu", profileImage: "https://picsum.photos/200?q=3"),
      location: TrainingLocation(address: 'South Ampton', city: 'Dallas'),
      bigImage: 'https://picsum.photos/400/150?q=3',
      date: "Feb 12 - 14, 2022",
      time: "10:30AM - 12:30PM",
      promotionText: "Exclusive!",
      price: TrainingPrice(currency: "\$", originalPrice: 600, discountedPrice: 550),
      rating: 4.3,
      isFeatured: true,
      summary: _summaryText,
    ),
    TrainingItem(
      title: "Flutter Expert",
      trainerInfo: TrainerInfo(name: "Jeff Bezos", profileImage: "https://picsum.photos/200?q=4"),
      location: TrainingLocation(address: 'Times Square', city: 'New York'),
      bigImage: 'https://picsum.photos/400/150?q=4',
      date: "Feb 20 - 25, 2022",
      time: "10:30AM - 02:30PM",
      promotionText: "Filling Fast!",
      price: TrainingPrice(currency: "\$", originalPrice: 1200, discountedPrice: 100),
      rating: 4.7,
      isFeatured: false,
      summary: _summaryText,
    ),
    TrainingItem(
      title: "Android with Kotlin Bootcamp",
      trainerInfo: TrainerInfo(name: "JetBrains", profileImage: "https://picsum.photos/200?q=5"),
      location: TrainingLocation(address: 'JetBrains HQ', city: 'Silicon Valley'),
      bigImage: 'https://picsum.photos/400/150?q=5',
      date: "Feb 25 - 28, 2022",
      time: "08:30AM - 12:30PM",
      promotionText: "Early bird!",
      price: TrainingPrice(currency: "\$", originalPrice: 1300, discountedPrice: 1150),
      rating: 4.9,
      isFeatured: false,
      summary: _summaryText,
    ),
    TrainingItem(
      title: "Android with Kotlin Expert",
      trainerInfo: TrainerInfo(name: "JetBrains", profileImage: "https://picsum.photos/200?q=6"),
      location: TrainingLocation(address: 'JetBrains HQ 2', city: 'Silicon Valley'),
      bigImage: 'https://picsum.photos/400/150?q=6',
      date: "Mar 04 - 07, 2022",
      time: "08:30AM - 12:30PM",
      promotionText: "From the HQ!",
      price: TrainingPrice(currency: "\$", originalPrice: 1500, discountedPrice: 1200),
      rating: 4.7,
      isFeatured: false,
      summary: _summaryText,
    ),
    TrainingItem(
      title: "Spring Boot with Java Bootcamp",
      trainerInfo: TrainerInfo(name: "Mark Zuckerberg", profileImage: "https://picsum.photos/200?q=7"),
      location: TrainingLocation(address: 'Facebook HQ', city: 'Silicon Valley'),
      bigImage: 'https://picsum.photos/400/150?q=7',
      date: "Feb 21 - 24, 2022",
      time: "10:30AM - 12:30PM",
      promotionText: "Official!",
      price: TrainingPrice(currency: "\$", originalPrice: 1500, discountedPrice: 1200),
      rating: 4.5,
      isFeatured: false,
      summary: _summaryText,
    ),
    TrainingItem(
      title: "Spring Boot with Java Expert",
      trainerInfo: TrainerInfo(name: "Mark Zuckerberg", profileImage: "https://picsum.photos/200?q=8"),
      location: TrainingLocation(address: 'Facebook HQ 2', city: 'Silicon Valley'),
      bigImage: 'https://picsum.photos/400/150?q=8',
      date: "Feb 26 - 28, 2022",
      time: "11:30AM - 02:30PM",
      promotionText: "Official!",
      price: TrainingPrice(currency: "\$", originalPrice: 1500, discountedPrice: 1200),
      rating: 4.3,
      isFeatured: false,
      summary: _summaryText,
    ),
  ];

  final Set<String> _allCities = {};
  final Set<String> _allTitles = {};
  final Set<String> _allTrainers = {};

  FakeTrainingRepository() {
    /// Populate a list of all cities, titles and trainers for the filters to be shown
    for (TrainingItem item in _allTrainingItems) {
      _allCities.add(item.location.city);
      _allTitles.add(item.title);
      _allTrainers.add(item.trainerInfo.name);
    }
  }

  @override
  Future<TrainingListingResponse> getAllTrainingItems({Filter? filter}) async {
    await Future.delayed(300.milliseconds); // Add delay to fake loading
    if (filter != null && filter.isActive) {
      final filteredItems = <TrainingItem>[];
      if (filter.cities.isNotEmpty) {
        filteredItems.addAll(_allTrainingItems.where((element) => filter.cities.contains(element.location.city)));
      }
      if (filter.titles.isNotEmpty) {
        filteredItems.addAll(_allTrainingItems.where((element) => filter.titles.contains(element.title)));
      }
      if (filter.trainers.isNotEmpty) {
        filteredItems.addAll(_allTrainingItems.where((element) => filter.trainers.contains(element.trainerInfo.name)));
      }
      return TrainingListingResponse(
        trainingItems: filteredItems,
        availableCities: _allCities.toList(),
        availableTrainers: _allTrainers.toList(),
        availableTrainings: _allTitles.toList(),
      );
    } else {
      return TrainingListingResponse(
        trainingItems: _allTrainingItems,
        availableCities: _allCities.toList(),
        availableTrainers: _allTrainers.toList(),
        availableTrainings: _allTitles.toList(),
      );
    }
  }

  @override
  Future<List<TrainingItem>> getFeaturedTrainingItems() async {
    await Future.delayed(300.milliseconds); // Add delay to fake loading
    return _allTrainingItems.where((element) => element.isFeatured).toList();
  }
}
