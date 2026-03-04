#!/bin/bash
# ============================================================
# Q360 SND — Crear nueva página de artifact con OG tags
# Uso: ./new-artifact.sh "slug" "Título" "Descripción" "URL_CLAUDE"
#
# Ejemplo:
#   ./new-artifact.sh "incentivos-v2" \
#     "Q360 Incentivos Taxonomía v2.1" \
#     "Dashboard interactivo del programa de incentivos Q360" \
#     "https://claude.ai/artifacts/abc123..."
# ============================================================

SLUG="$1"
TITULO="$2"
DESCRIPCION="$3"
CLAUDE_URL="$4"

if [ -z "$SLUG" ] || [ -z "$TITULO" ] || [ -z "$CLAUDE_URL" ]; then
  echo "❌ Uso: ./new-artifact.sh <slug> <titulo> <descripcion> <url_claude>"
  echo ""
  echo "Ejemplo:"
  echo '  ./new-artifact.sh "incentivos-v2" "Q360 Incentivos v2.1" "Dashboard incentivos" "https://claude.ai/artifacts/..."'
  exit 1
fi

# Default description si no se proporciona
if [ -z "$DESCRIPCION" ]; then
  DESCRIPCION="Quantum 360° — Artifact SND"
fi

OUTPUT="artifacts/${SLUG}.html"

# Copiar template y reemplazar placeholders
cp artifacts/TEMPLATE.html "$OUTPUT"
sed -i "s|{{SLUG}}|${SLUG}|g" "$OUTPUT"
sed -i "s|{{TITULO}}|${TITULO}|g" "$OUTPUT"
sed -i "s|{{DESCRIPCION}}|${DESCRIPCION}|g" "$OUTPUT"
sed -i "s|{{CLAUDE_URL}}|${CLAUDE_URL}|g" "$OUTPUT"

echo "✅ Artifact creado: ${OUTPUT}"
echo "🔗 URL para compartir en WhatsApp:"
echo "   https://trismegisto88.github.io/q360-snd-artifacts-/artifacts/${SLUG}.html"
echo ""
echo "📋 Próximos pasos:"
echo "   git add ${OUTPUT}"
echo "   git commit -m 'Nuevo artifact: ${TITULO}'"
echo "   git push"
echo ""
echo "⏱️  GitHub Pages se actualiza en ~1-2 min después del push"
