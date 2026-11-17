import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/demo_project_repository.dart';
import '../data/repositories/project_repository.dart';
import '../domain/entities/project.dart';

final projectRepositoryProvider = Provider<ProjectRepository>(
  (ref) => const DemoProjectRepository(),
);

final projectsProvider = FutureProvider<List<Project>>(
  (ref) => ref.watch(projectRepositoryProvider).getProjects(),
);
