import 'package:flutter_test/flutter_test.dart';
import 'package:scopeguard/features/projects/data/repositories/demo_project_repository.dart';

void main() {
  test('returns stable demo fixtures without claiming persistence', () async {
    const repository = DemoProjectRepository();
    final projects = await repository.getProjects();

    expect(projects, hasLength(4));
    expect(projects.first.id, 'estudio-norte');
    expect(projects.map((project) => project.id).toSet(), hasLength(4));
  });
}
