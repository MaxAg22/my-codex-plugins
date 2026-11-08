# Cambios de la migración

Las rutas son relativas a `my-skills/`. Se omiten los archivos copiados sin modificaciones.

## Criterios generales

- No copiar la skill `commit-changes` ni incluir instrucciones para crear commits.
- Eliminar los flujos que coordinan el trabajo entre múltiples repositorios; conservar el contexto del repositorio del proyecto y operaciones como revisar `git diff`.

| Archivo | Cambios respecto del original |
|---|---|
| `README.md` | Describe la filosofía, las skills y los agentes disponibles, el recorrido de trabajo y el uso en Codex. Explica cómo copiar las skills a `.agents/skills/` y los agentes a `.codex/agents/`, además de las dependencias opcionales del canvas. Elimina el catálogo de capacidades ausentes y las instrucciones de instalación de Claude. |
| `skills/basics/SKILL.md` | Adopta la wiki del proyecto y la espera ante definiciones faltantes. Elimina la ubicación fija `.mahou/wiki/` y la consulta de convenciones globales. |
| `skills/wiki/SKILL.md` | Simplifica la consulta a un único índice. Cada proyecto define ubicación, estructura y contenido. Elimina la configuración específica de Claude y exige consultar al usuario ante definiciones faltantes. |
| `skills/wiki/references/INDEX.md` | Se deja un único índice vacío, sin los artículos ni los índices secundarios del autor. |
| `agents/code-scout.toml` | Adapta el rol de investigación de código a la configuración de agentes de Codex y usa `AGENTS.md` como guía del proyecto. |
| `agents/docs-scout.toml` | Adapta el rol de investigación documental a la configuración de agentes de Codex. |
| `agents/researcher.toml` | Adapta el rol de investigación externa a la configuración de agentes de Codex y elimina las restricciones específicas del entorno del autor. |
| `agents/{altitude-reviewer,consistency-checker,conventions-reviewer,documentation-reviewer,efficiency-reviewer,reuse-reviewer,simplification-reviewer,usage-tracer}.toml` | Convierte los roles Markdown en configuraciones de agente TOML de Codex y conserva sus instrucciones de especialidad. |
| `skills/**/SKILL.md` | Cambia las referencias internas de skills al formato `$skill-name` de Codex, elimina campos de frontmatter específicos de otros harnesses y actualiza la delegación de subagentes al uso de agentes personalizados de Codex. |
| `skills/canvas/SKILL.md` | Elimina las dependencias de las skills `superpowers:mermaid` y `superpowers:unslop`. Conserva el renderizado de Mermaid y la comprobación visual mediante capturas. |
| `skills/canvas/scripts/canvas.sh` y `skills/canvas/scripts/app/document/canvasDocument.ts` | Describe la caché y la actualización del canvas en términos de los archivos de la skill, no de una instalación de plugin. |
| `skills/design-tree/SKILL.md` | Elimina las dependencias y referencias a las skills `superpowers:unslop` y `superpowers:mermaid`. Conserva las reglas propias de preguntas y el uso de diagramas Mermaid. |
| `skills/report/SKILL.md` | Elimina las dependencias de `superpowers:unslop` y `superpowers:mermaid`. Conserva las reglas propias de presentación de informes y diagramas. Encierra la descripción entre comillas para que sea YAML válido. |
| `skills/lookup/SKILL.md` | Elimina la validación mediante `superpowers:mermaid`. Conserva los diagramas cuando ayudan a explicar una respuesta. |
| `skills/docs/SKILL.md` | Usa `AGENTS.md` como una posible fuente para localizar la documentación, pero deja que el charter del proyecto defina su estructura. Si no hay documentación configurada, pregunta cómo organizarla. |
| `skills/design/SKILL.md` | Elimina la dependencia de `superpowers:mermaid` y las referencias a su validación de diagramas. Conserva los diagramas Mermaid. |
| `skills/design/references/types/{component-architecture,contract,data-flow,rules}.md` | Elimina las instrucciones que dependen de la paleta de `superpowers:mermaid`. Conserva las representaciones y sus ejemplos. |
| `skills/write-documentation/SKILL.md` | Sustituye `CLAUDE.md` por `AGENTS.md`. Elimina las dependencias de `superpowers:unslop` y `superpowers:mermaid`, las referencias a su revisión y validación y el campo `argument-hint` no admitido por Codex. Conserva la revisión por `documentation-reviewer`. |
| `skills/design-with-canvas/references/types/data-flow.md` | Elimina la referencia implícita a las formas de la paleta externa. Conserva el flujo dibujado en el canvas. |
| `skills/program-design/SKILL.md` | Elimina la dependencia de `changeset`, la localización y comprobación inicial de repositorios y la organización por raíces/repositorios. Trabaja las ramas directamente y registra el resultado en `program-design.md`. Sustituye `CLAUDE.md` por `AGENTS.md` y elimina la validación por la skill `superpowers:mermaid`. |
| `skills/program-design/references/representations/class-diagram.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. Elimina las referencias a la paleta o reglas externas de la skill `mermaid`; conserva la representación y las marcas de cambios. |
| `skills/program-design/references/representations/component-tree.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design/references/representations/control-flow.md` | Elimina las referencias a la paleta o reglas externas de la skill `mermaid`; conserva la representación y las marcas de cambios. |
| `skills/program-design/references/representations/derivation-ledger.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design/references/representations/interfaces.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design/references/representations/module-list.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design/references/representations/package-layout.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design/references/representations/standards.md` | Sustituye `CLAUDE.md` por `AGENTS.md`. Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design-with-canvas/SKILL.md` | Elimina las raíces por repositorio de las etiquetas y del flujo. Usa el registro `program-design.md`. |
| `skills/program-design-with-canvas/mockups/component-cards.tsx` | Elimina el campo `repo` y su etiqueta visual; conserva el resto del mockup. |
| `skills/program-design-with-canvas/mockups/hook-card.tsx` | Elimina el campo `repo` y su etiqueta visual; conserva el resto del mockup. |
| `skills/program-design-with-canvas/mockups/interface-card.tsx` | Elimina el campo `repo` y su etiqueta visual; conserva el resto del mockup. |
| `skills/program-design-with-canvas/mockups/state-card.tsx` | Elimina el campo `repo` y su etiqueta visual; conserva el resto del mockup. |
| `skills/program-design-with-canvas/references/representations/callstack.md` | Elimina las referencias a la paleta o reglas externas de la skill `mermaid`; conserva la representación y las marcas de cambios. |
| `skills/program-design-with-canvas/references/representations/component-tree.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. Elimina los campos `repo` de los ejemplos. |
| `skills/program-design-with-canvas/references/representations/interfaces.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. Elimina los campos `repo` de los ejemplos. |
| `skills/program-design-with-canvas/references/representations/module-list.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design-with-canvas/references/representations/package-layout.md` | Elimina las referencias a la paleta o reglas externas de la skill `mermaid`; conserva la representación y las marcas de cambios. |
| `skills/program-design-with-canvas/references/representations/standards.md` | Elimina la agrupación por repositorios o adapta las referencias al proyecto y al árbol del cambio. |
| `skills/program-design-with-canvas/references/representations/derivation-ledger.md` | Elimina el campo `repo` de los ejemplos de datos de las tarjetas de estado y hooks. |
| `skills/test-design/SKILL.md` | Elimina la organización y el orden entre repositorios; usa un árbol del cambio, identificadores `A1`, `A2`, etc. y el registro `test-design.md`. Sustituye `CLAUDE.md` por `AGENTS.md`, consulta el índice único de la wiki y elimina la referencia a la revisión con `unslop`. Encierra la descripción entre comillas para que sea YAML válido. Conserva el método de clasificación, las confirmaciones y las matrices. |
| `skills/test-design-with-canvas/SKILL.md` | Elimina las áreas, etiquetas y el avance entre árboles por repositorio; representa el árbol del cambio y conserva sus ramas completas como propuestas. Usa el registro `test-design.md`. |
| `skills/implement/SKILL.md` | Coordina una sola implementación en el proyecto; consulta `AGENTS.md` y `.mahou/basics.md` cuando existen, y conserva el contexto Git. Omite instrucciones para crear commits y los campos de frontmatter no admitidos por Codex. Mantiene validación manual, revisión por rondas, consistencia y reporte de estado. Encierra la descripción en YAML entre comillas. |
| `skills/implement-with-tdd/SKILL.md` | Agrega la variante TDD para el proyecto: un tester y un implementer colaboran mediante la sesión, y al aprobarse las pruebas continúa la validación manual de `implement`. Elimina la coordinación por repositorio y el paso de `commit-changes`; adapta el frontmatter a los campos admitidos por Codex. |
| `skills/explore-with-canvas/SKILL.md` y sus referencias | Agrega la variante visual de `explore`, con las instrucciones de moodboard y sus mockups de apoyo. |
| `skills/architecture-exploration/SKILL.md` | Quita la referencia a `one-page-design`, que no forma parte del flujo ni se copia en esta migración. |
| `skills/validate/SKILL.md` | Conserva validación manual sobre el sistema local, con evidencia y restauración de los datos mutados; excluye Android, no incluye instrucciones de commits ni campos de frontmatter no admitidos por Codex. |
| `skills/validate/references/browser.md` | Adapta la guía de navegador al proyecto. |
| `skills/agentic-review/SKILL.md` | Revisa los cambios del proyecto con `git diff` y `git diff --cached`, admite archivos nuevos del cambio, registra rondas en `agentic-review.md` y deja las ediciones en el árbol de trabajo. |
| `skills/implementation-status-report/SKILL.md` | Informa el estado de una ejecución de `implement` o `implement-with-tdd` en el proyecto. |
| `skills/changeset/SKILL.md` | Define el proyecto, la base y la composición del diff; elimina la configuración de Claude y la coordinación entre repositorios. Mantiene la comparación entre cambios nuevos y preexistentes. |
| `skills/changeset/scripts/find-base-branch.sh` | Conserva el cálculo de la rama base y usa `project-path` en la documentación del argumento. Se ejecuta desde la ubicación de la skill, sin `CLAUDE_PLUGIN_ROOT`. |
| `skills/code-blast-radius/SKILL.md` | Lee `AGENTS.md` cuando existe y usa el README u otra documentación disponible para orientarse si no está; rastrea los consumidores dentro del proyecto. |
| `skills/human-review/SKILL.md` | Sustituye las anotaciones recibidas por Plannotator por observaciones del usuario en la conversación. Mantiene la verificación contra el código y espera la decisión del usuario antes de editar. Usa `AGENTS.md`, el proyecto único y `changeset`; elimina la coordinación por repositorios y los commits. Quita la directiva de invocación propia de Claude. |
