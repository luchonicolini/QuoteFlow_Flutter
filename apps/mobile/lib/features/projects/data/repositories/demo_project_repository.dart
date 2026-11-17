import '../../../../core/domain/value_objects/money.dart';
import '../../domain/entities/project.dart';
import '../../domain/value_objects/project_status.dart';
import 'project_repository.dart';

/// In-memory fixtures for the visual prototype. Replace with a real repository
/// implementation when persistence is added; these records are not user data.
class DemoProjectRepository implements ProjectRepository {
  const DemoProjectRepository();

  static const projects = <Project>[
    Project(
      id: 'estudio-norte',
      title: 'Estudio Norte',
      client: 'Estudio Norte SRL',
      serviceType: 'Rediseño sitio web',
      status: ProjectStatus.inReview,
      progress: .6,
      baseBudget: Money(amountMinor: 250000, currency: 'USD'),
      approvedChangesCount: 2,
      extraAmount: Money(amountMinor: 45000, currency: 'USD'),
      imageUrl: '',
      deliverables: [
        'Diseño UI/UX en Figma (5 vistas clave)',
        'Desarrollo responsive en Next.js',
        'Optimización SEO y Core Web Vitals',
        'Hasta 2 rondas de revisiones',
      ],
      exclusions: [
        'Redacción de contenidos y copywriting',
        'Integración con CRM de terceros',
        'Mantenimiento mensual post-lanzamiento',
      ],
      scopeSummary:
          'Rediseño completo del sitio web, UX/UI, implementación y optimización.',
      milestones: [
        ProjectMilestone(
          title: 'Diseño UX/UI',
          dateLabel: '10 ene',
          isComplete: true,
        ),
        ProjectMilestone(
          title: 'Desarrollo frontend',
          dateLabel: '12 ene',
          isComplete: true,
        ),
        ProjectMilestone(
          title: 'Optimización y entrega',
          dateLabel: '—',
          isComplete: false,
        ),
      ],
      latestActivity: ProjectActivity(
        title: 'Se actualizó la cotización',
        description: 'Cambio en el alcance y ajuste de presupuesto.',
        dateLabel: 'Hoy, 09:14',
      ),
    ),
    Project(
      id: 'hotel-intermonti',
      title: 'Hotel Intermonti',
      client: 'Grupo Intermonti SA',
      serviceType: 'Sitio web + reservas',
      status: ProjectStatus.inProgress,
      progress: .4,
      baseBudget: Money(amountMinor: 420000, currency: 'USD'),
      approvedChangesCount: 1,
      extraAmount: Money(amountMinor: 60000, currency: 'USD'),
      imageUrl: '',
      deliverables: [
        'Motor de reservas embebido',
        'Galería fotográfica de habitaciones',
        'Panel de administración de disponibilidad',
      ],
      exclusions: [
        'Comisiones de pasarelas de pago',
        'Sesiones de fotografía en locación',
      ],
      scopeSummary:
          'Sitio web del hotel con motor de reservas y panel de disponibilidad.',
      milestones: [
        ProjectMilestone(
          title: 'Estructura y contenidos',
          dateLabel: '8 ene',
          isComplete: true,
        ),
        ProjectMilestone(
          title: 'Motor de reservas',
          dateLabel: '—',
          isComplete: false,
        ),
        ProjectMilestone(
          title: 'Pruebas y entrega',
          dateLabel: '—',
          isComplete: false,
        ),
      ],
      latestActivity: ProjectActivity(
        title: 'Avance del motor de reservas',
        description: 'Se está preparando la integración de disponibilidad.',
        dateLabel: 'Ayer',
      ),
    ),
    Project(
      id: 'crismalu',
      title: 'Crismalu',
      client: 'Crismalu Joyas',
      serviceType: 'Actualización web',
      status: ProjectStatus.paused,
      progress: .2,
      baseBudget: Money(amountMinor: 180000, currency: 'USD'),
      approvedChangesCount: 0,
      extraAmount: Money(amountMinor: 0, currency: 'USD'),
      imageUrl: '',
      deliverables: [
        'Catálogo online de productos',
        'Filtros por metal y categoría',
      ],
      exclusions: ['Carro de compras transaccional'],
      scopeSummary: 'Actualización visual del catálogo y filtros de productos.',
      milestones: [
        ProjectMilestone(
          title: 'Relevamiento',
          dateLabel: '3 ene',
          isComplete: true,
        ),
        ProjectMilestone(
          title: 'Actualización visual',
          dateLabel: '—',
          isComplete: false,
        ),
        ProjectMilestone(
          title: 'Revisión final',
          dateLabel: '—',
          isComplete: false,
        ),
      ],
      latestActivity: null,
    ),
    Project(
      id: 'fintech-nova',
      title: 'Fintech Nova',
      client: 'Nova Payments Ltd',
      serviceType: 'App móvil & Dashboard',
      status: ProjectStatus.completed,
      progress: 1,
      baseBudget: Money(amountMinor: 650000, currency: 'USD'),
      approvedChangesCount: 3,
      extraAmount: Money(amountMinor: 110000, currency: 'USD'),
      imageUrl: '',
      deliverables: [
        'Arquitectura base en Flutter',
        'Autenticación biométrica',
        'Historial de transacciones',
      ],
      exclusions: ['Integración con redes bancarias locales'],
      scopeSummary:
          'Aplicación móvil y panel de operaciones para el producto Fintech Nova.',
      milestones: [
        ProjectMilestone(
          title: 'Arquitectura',
          dateLabel: '5 ene',
          isComplete: true,
        ),
        ProjectMilestone(
          title: 'App y dashboard',
          dateLabel: '—',
          isComplete: false,
        ),
        ProjectMilestone(
          title: 'Pruebas integrales',
          dateLabel: '—',
          isComplete: false,
        ),
      ],
      latestActivity: null,
    ),
  ];

  @override
  Future<List<Project>> getProjects() async => projects;
}
