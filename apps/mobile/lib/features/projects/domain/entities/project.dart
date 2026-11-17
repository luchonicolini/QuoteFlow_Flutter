import '../../../../core/domain/value_objects/money.dart';
import '../value_objects/project_status.dart';

class Project {
  const Project({
    required this.id,
    required this.title,
    required this.client,
    required this.serviceType,
    required this.status,
    required this.progress,
    required this.baseBudget,
    required this.approvedChangesCount,
    required this.extraAmount,
    required this.imageUrl,
    required this.deliverables,
    required this.exclusions,
    required this.scopeSummary,
    required this.milestones,
    required this.latestActivity,
  });

  final String id;
  final String title;
  final String client;
  final String serviceType;
  final ProjectStatus status;
  final double progress;
  final Money baseBudget;
  final int approvedChangesCount;
  final Money extraAmount;
  final String imageUrl;
  final List<String> deliverables;
  final List<String> exclusions;
  final String scopeSummary;
  final List<ProjectMilestone> milestones;
  final ProjectActivity? latestActivity;
}

class ProjectMilestone {
  const ProjectMilestone({
    required this.title,
    required this.dateLabel,
    required this.isComplete,
  });

  final String title;
  final String dateLabel;
  final bool isComplete;
}

class ProjectActivity {
  const ProjectActivity({
    required this.title,
    required this.description,
    required this.dateLabel,
  });

  final String title;
  final String description;
  final String dateLabel;
}
