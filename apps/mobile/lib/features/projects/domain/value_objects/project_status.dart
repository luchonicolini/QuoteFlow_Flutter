enum ProjectStatus {
  inReview('En revisión'),
  inProgress('En curso'),
  paused('Pausado'),
  completed('Finalizado');

  const ProjectStatus(this.label);

  final String label;
}
