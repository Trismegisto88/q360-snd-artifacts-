# Q360 SND Artifacts — WhatsApp OG Preview System

## Problema
Los links de `claude.ai` siempre muestran la tarjeta de Claude en WhatsApp porque Anthropic controla los Open Graph meta tags. No se puede modificar.

## Solución
GitHub Pages como **proxy de redirect** con OG tags personalizados de Q360.

```
WhatsApp lee OG tags de → GitHub Pages (imagen Q360)
Usuario hace click → Redirect automático a → Claude Artifact
```

## Setup (una sola vez)

### 1. Habilitar GitHub Pages

1. Ir a **Settings** → **Pages** en tu repo
2. Source: **GitHub Actions**
3. Guardar

### 2. Subir estos archivos al repo

Reemplaza el contenido actual con esta estructura:

```
q360-snd-artifacts-/
├── .github/workflows/deploy-pages.yml   ← Auto-deploy
├── assets/
│   └── og-q360-default.png              ← Imagen OG 1200x630
├── artifacts/
│   ├── TEMPLATE.html                    ← Template base
│   └── incentivos-taxonomia-v2.html     ← Ejemplo
├── index.html                           ← Landing page
├── new-artifact.sh                      ← Script helper
└── README.md
```

### 3. Verificar deployment

Después del push, espera ~2 min y visita:
```
https://trismegisto88.github.io/q360-snd-artifacts-/
```

---

## Uso diario — Crear nuevo artifact

### Opción A: Script (terminal)

```bash
chmod +x new-artifact.sh

./new-artifact.sh "perfil-jorge" \
  "Q360 Perfil Supervisor Jorge Argenis" \
  "Perfil operativo del supervisor de UN MrCoop" \
  "https://claude.ai/artifacts/abc123-def456"

git add -A && git commit -m "Nuevo artifact: Perfil Jorge" && git push
```

### Opción B: Manual (GitHub web)

1. Ir a `artifacts/TEMPLATE.html` → copiar contenido
2. Crear archivo nuevo: `artifacts/mi-nuevo-artifact.html`
3. Reemplazar los 4 placeholders:
   - `{{TITULO}}` → título del artifact
   - `{{DESCRIPCION}}` → descripción breve
   - `{{SLUG}}` → nombre del archivo (sin .html)
   - `{{CLAUDE_URL}}` → URL completa del artifact de Claude
4. Commit → Push → Esperar ~2 min

### Compartir en WhatsApp

En lugar de compartir:
```
❌ https://claude.ai/artifacts/abc123...
```

Compartir:
```
✅ https://trismegisto88.github.io/q360-snd-artifacts-/artifacts/perfil-jorge.html
```

WhatsApp mostrará la tarjeta con imagen Q360 en lugar del logo de Claude.

---

## Notas técnicas

- **OG image**: 1200×630px (estándar). WhatsApp requiere <300KB y ANTES de cualquier `<style>` en el HTML.
- **Redirect**: Usa `<meta http-equiv="refresh" content="1;url=...">` (1 segundo de delay).
- **Cache WhatsApp**: WhatsApp cachea previews agresivamente. Si cambias la imagen, agrega `?v=2` al URL de la imagen en los OG tags.
- **Imagen personalizada por artifact**: Puedes crear imágenes específicas en `assets/` y referenciarlas en el `og:image` de cada HTML.

---

## Estructura de URLs

| Tipo | URL |
|------|-----|
| Landing | `https://trismegisto88.github.io/q360-snd-artifacts-/` |
| Artifact | `https://trismegisto88.github.io/q360-snd-artifacts-/artifacts/{slug}.html` |
| OG Image | `https://trismegisto88.github.io/q360-snd-artifacts-/assets/og-q360-default.png` |

---

*Q360 — Sin registro, no existe.*
