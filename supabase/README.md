# Supabase Configuration & Migrations — ScopeGuard

This directory holds the versioned database migrations, seed scripts, and secure Edge Functions for ScopeGuard.

## Structure

```
supabase/
├── migrations/       # Versioned SQL migrations (e.g. 001_auth_profiles.sql)
├── functions/        # Deno/TypeScript Edge Functions (privileged server actions)
└── README.md
```

## Security Invariants

1. **Row Level Security (RLS)** is enabled on all tables.
2. The `service_role` key is **never** bundled or exposed to the mobile app or browser web client.
3. Edge functions perform privileged operations such as snapshot creation and atomic approval event logging.
4. Terminal states (`approved`, `rejected`) and snapshots are immutable once committed.
