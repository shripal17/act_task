import 'package:act_task/repository/training_repository.dart';
import 'package:act_task/service/fake_training_repository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final _trainingRepository = RM.inject(() => FakeTrainingRepository());

TrainingRepository get trainingRepository => _trainingRepository.state;