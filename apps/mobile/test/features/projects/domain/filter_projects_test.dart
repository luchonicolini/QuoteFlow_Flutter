import 'package:flutter_test/flutter_test.dart';
import 'package:scopeguard/features/projects/data/repositories/demo_project_repository.dart';
import 'package:scopeguard/features/projects/domain/use_cases/filter_projects.dart';
import 'package:scopeguard/features/projects/domain/value_objects/project_status.dart';

void main() {
  const filterProjects = FilterProjects();
  final projects = DemoProjectRepository.projects;

  test('filters by title, client, and service case-insensitively', () {
    expect(filterProjects(projects, query: 'hotel'), hasLength(1));
    expect(
      filterProjects(projects, query: 'reservas').single.title,
      'Hotel Intermonti',
    );
    expect(
      filterProjects(projects, query: 'CRISMALU').single.client,
      'Crismalu Joyas',
    );
  });

  test('filters by status and combines status with search', () {
    expect(
      filterProjects(projects, status: ProjectStatus.inProgress),
      hasLength(1),
    );
    expect(
      filterProjects(
        projects,
        query: 'hotel',
        status: ProjectStatus.inProgress,
      ).single.title,
      'Hotel Intermonti',
    );
    expect(filterProjects(projects, query: 'unknown'), isEmpty);
  });
}
