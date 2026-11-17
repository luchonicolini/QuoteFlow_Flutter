# Flutter code structure

The mobile app is organized by feature, with shared app/core code kept separate.

```text
apps/mobile/lib/
  app/                       App root and theme
  core/
    domain/value_objects/    Shared business values such as Money
    data/models/             Cross-feature persistence DTOs (when introduced)
    routing/                 go_router setup and navigation shell
    design/widgets/          Reusable, feature-neutral UI components
  features/
    projects/
      application/           Riverpod providers and feature orchestration
      data/repositories/     Repository contracts and implementations
      domain/                Entities, value objects, and pure use cases
      presentation/          Screens and feature-specific widgets
    change_requests/
      application/
      data/
      domain/
      presentation/
    settings/
      application/
      data/
      domain/
      presentation/
```

## Dependency direction

`presentation -> application -> domain` and `data -> domain`. Domain code must not import Flutter widgets, repositories, or presentation components. Repositories implement contracts consumed by application providers. Shared design widgets may depend on theme tokens and domain display values, but domain entities must never depend on a widget.

## Current implementation status

- Projects have a domain entity/status, a repository contract, an in-memory demo repository, Riverpod providers and a pure search/status filter use case.
- The demo repository is not persistence. Replace it with a data implementation when local/remote storage is deliberately introduced.
- Change request and settings features are still mostly presentation-only. Their `application`, `data`, and `domain` folders should be added with the first real use case, not filled with empty placeholder files.
- Screen sample data must remain visibly identified as demo data. UI must not report success for operations that have not persisted.
- Shared money uses integer minor units and ISO currency precision. Do arithmetic on `amountMinor`; format only at display boundaries.

## Test placement

Mirror source paths under `apps/mobile/test/`: domain/value object and use-case unit tests, repository tests, then widget tests for presentation behavior. Keep large fixture data in repositories or test support files rather than screen widgets.
