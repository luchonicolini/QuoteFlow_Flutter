import React, { Suspense } from "react";

interface ApprovalPageProps {
  params: Promise<{
    token: string;
  }>;
}

async function ProposalContent({ params }: ApprovalPageProps) {
  const { token } = await params;

  return (
    <div className="w-full max-w-lg flex flex-col gap-6">
      {/* Header Branding */}
      <header className="flex items-center justify-between border-b border-[#454B3D] pb-4">
        <div className="flex items-center gap-2">
          <span className="h-3 w-3 rounded-full bg-[#C5F277]"></span>
          <h1 className="font-semibold text-lg tracking-tight text-[#F7F8F3]">
            ScopeGuard
          </h1>
        </div>
        <span className="text-xs px-2.5 py-1 rounded-full bg-[#30352D] text-[#BFC7B7] border border-[#454B3D]">
          Propuesta v1
        </span>
      </header>

      {/* Status notice */}
      <div className="bg-[#30352D] border border-[#454B3D] p-4 rounded-xl">
        <p className="text-xs font-medium text-[#BFC7B7] uppercase tracking-wider mb-1">
          Revisión de solicitud de cambio
        </p>
        <h2 className="text-xl font-bold text-[#F7F8F3]">
          Diseño de sección de testimonios y filtros adicionales
        </h2>
        <p className="text-sm text-[#BFC7B7] mt-1">
          Proyecto: <strong className="text-[#F7F8F3]">Rediseño Web E-commerce</strong>
        </p>
      </div>

      {/* Change details & deliverables */}
      <section className="bg-[#30352D] border border-[#454B3D] p-5 rounded-xl space-y-4">
        <div>
          <h3 className="text-sm font-semibold text-[#F7F8F3] mb-2">
            Entregables acordados:
          </h3>
          <ul className="list-disc list-inside text-sm text-[#BFC7B7] space-y-1">
            <li>Diseño responsivo de sección de testimonios de clientes.</li>
            <li>Filtro interactivo por categoría y valoración.</li>
            <li>Hasta 2 rondas de revisión sobre esta propuesta.</li>
          </ul>
        </div>

        <div className="border-t border-[#454B3D] pt-4 grid grid-cols-2 gap-4">
          <div>
            <p className="text-xs text-[#BFC7B7]">Monto adicional:</p>
            <p className="text-2xl font-extrabold text-[#C5F277]">
              USD 150.00
            </p>
          </div>
          <div>
            <p className="text-xs text-[#BFC7B7]">Impacto en plazo:</p>
            <p className="text-lg font-semibold text-[#F7F8F3]">
              +3 días hábiles
            </p>
          </div>
        </div>
      </section>

      {/* Security & Invariant disclaimer */}
      <div className="p-4 rounded-xl bg-[#20231F] border border-[#454B3D] text-xs text-[#BFC7B7] leading-relaxed">
        <p>
          Esta revisión representa un acuerdo explícito sobre el alcance del proyecto.
          Al aceptar o rechazar, se genera un registro inmutable de la decisión.
        </p>
      </div>

      {/* Action buttons (Disabled mock until backend integration) */}
      <div className="space-y-3 pt-2">
        <button
          type="button"
          className="w-full min-h-[48px] bg-[#C5F277] hover:bg-[#b4e660] text-[#20231F] font-semibold text-base rounded-xl px-4 py-3 transition-colors shadow-sm flex items-center justify-center cursor-pointer"
        >
          Aceptar propuesta
        </button>

        <button
          type="button"
          className="w-full min-h-[48px] bg-[#30352D] hover:bg-[#383e34] text-[#BFC7B7] hover:text-[#F7F8F3] font-medium text-base rounded-xl px-4 py-3 border border-[#454B3D] transition-colors flex items-center justify-center cursor-pointer"
        >
          Rechazar propuesta
        </button>
      </div>

      <footer className="text-center text-xs text-[#62685B] pt-4">
        Enlace protegido • ScopeGuard (Token: {token.slice(0, 8)}...)
      </footer>
    </div>
  );
}

export default function ApprovalPage(props: ApprovalPageProps) {
  return (
    <main className="min-h-screen bg-[#20231F] text-[#F7F8F3] px-4 py-8 flex flex-col items-center">
      <Suspense fallback={<div className="text-sm text-[#BFC7B7]">Cargando propuesta...</div>}>
        <ProposalContent {...props} />
      </Suspense>
    </main>
  );
}
