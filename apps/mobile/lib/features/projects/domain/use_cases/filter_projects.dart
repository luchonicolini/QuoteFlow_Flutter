import '../entities/project.dart';
import '../value_objects/project_status.dart';

class FilterProjects {
  const FilterProjects();

  List<Project> call(
    Iterable<Project> projects, {
    String query = '',
    ProjectStatus? status,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    return projects
        .where((project) {
          final matchesQuery =
              normalizedQuery.isEmpty ||
              project.title.toLowerCase().contains(normalizedQuery) ||
              project.client.toLowerCase().contains(normalizedQuery) ||
              project.serviceType.toLowerCase().contains(normalizedQuery);
          final matchesStatus = status == null || project.status == status;
          return matchesQuery && matchesStatus;
        })
        .toList(growable: false);
  }
}
