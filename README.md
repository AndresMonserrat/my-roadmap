# Mis Roadmaps

| Roadmap  | Estado         | Progreso | Enlace |
|----------|----------------|----------|--------|
| Backend  | 🟡 En progreso | 20%      | [Ver](./roadmaps/backend/README.md) |
| Frontend | ⚪ Pendiente   | 0%       | [Ver](./roadmaps/frontend/README.md) | xample 
| DevOps   | ⚪ Pendiente   | 0%       | [Ver](./roadmaps/devops/README.md) |   xample

## Cómo agregar un nuevo roadmap
1. Copiar `plantillas/roadmap.md` a `roadmaps/nombre/README.md`.
2. Añadirlo a esta tabla.
3. Crear label y milestone en GitHub.


## Estructura recomendada
Esta estructura se escogio para generalizar los roadmaps que tengas por estudiar.




# Workflow de Commits (GIT)

Guía de convenciones y flujo de trabajo con Git para este repositorio de roadmaps.

---

## 1. Formato base

Usamos **Conventional Commits** adaptado a un repo de documentación y aprendizaje.

```
<tipo>(<scope>): <descripción corta>

[cuerpo opcional]

[footer opcional]
```

---

## 2. Tipos permitidos

| Tipo       | Cuándo usarlo                                                        |
|------------|----------------------------------------------------------------------|
| `feat`     | Agregar un roadmap nuevo, sección nueva, plantilla o proyecto        |
| `docs`     | Escribir o actualizar contenido de un tema, apuntes, README          |
| `fix`      | Corregir enlaces rotos, typos, errores de contenido                  |
| `refactor` | Reorganizar carpetas o renombrar archivos sin cambiar contenido      |
| `style`    | Formato markdown, tablas, saltos de línea, sin cambio de contenido   |
| `chore`    | Configuración, labels, workflows, estructura del repo                |
| `test`     | Validaciones, scripts de lint de docs (poco común aquí)              |
| `wip`      | Borradores que aún no quieres marcar como `docs` (opcional)          |

---

## 3. Scopes permitidos

Los scopes corresponden a las carpetas raíz de cada roadmap o área del repo.

- `backend`
- `frontend`
- `devops`
- `mobile`
- `recursos`
- `plantillas`
- `repo` (cambios globales: README raíz, `.github/`, configs)

> Al agregar un roadmap nuevo, agrega también su scope a esta lista.

---

## 4. Reglas de oro

1. **Un commit = un cambio lógico.**
   No mezcles "agregar tema HTTP" con "corregir typo en frontend".
2. **Verbo en imperativo** en la descripción: `agregar`, no `agregué` ni `agregando`.
3. **Minúsculas y sin punto final.**
4. **Máximo ~72 caracteres** en la primera línea.
5. **Si necesitas explicar el por qué**, usa el cuerpo del commit.
6. **Vincula issues** con `Closes #12` o `Refs #12` en el footer.
7. **Una rama por tema.** No trabajes directo en `main` para cambios grandes.

---

## 5. Ejemplos

### Agregar un tema nuevo de backend
```
feat(backend): agregar tema HTTP y APIs REST
```

### Escribir contenido de un tema
```
docs(backend): apuntes de bases de datos SQL
```

### Marcar progreso
```
docs(backend): completar ejercicios de Git y GitHub
```

### Inicializar un roadmap nuevo
```
feat(frontend): inicializar estructura del roadmap frontend
```

### Plantilla nueva
```
feat(plantillas): plantilla de tema con ejercicios
```

### Configurar labels y milestones
```
chore(repo): agregar labels por roadmap y tipo
```

### Corregir enlace roto
```
fix(backend): corregir enlace a documentación de Docker
```

### Reorganizar sin cambiar contenido
```
refactor(backend): mover apuntes a subcarpeta 03-bases-de-datos
```

### Actualizar tabla de progreso del README raíz
```
docs(repo): actualizar progreso general de roadmaps
```

### Commit con cuerpo explicativo
```
docs(backend): apuntes de autenticación JWT

Investigué tres enfoques: sesiones, JWT y OAuth.
Me quedo con JWT para el proyecto práctico porque
ya lo uso en el trabajo.

Refs: #12
```

---

## 6. Convención de ramas

Formato: `<scope>/<tema-en-kebab-case>`

Ejemplos:

```
backend/http-rest
backend/bases-de-datos-sql
frontend/react-hooks
frontend/estado-global
docs/plantilla-tema
chore/labels-roadmaps
fix/enlaces-roto-backend
```

Reglas:
- Siempre partir de `main` actualizado.
- Ramas cortas: un tema por rama.
- Borrar la rama después del merge.

---

## 7. Flujo de trabajo paso a paso

```bash
# 1. Actualizar main
git checkout main
git pull origin main

# 2. Crear rama para el tema
git checkout -b backend/http-rest

# 3. Trabajar y commitear en pasos lógicos
git add roadmaps/backend/
git commit -m "docs(backend): apuntes de HTTP y métodos"

git add roadmaps/backend/
git commit -m "docs(backend): ejemplos de códigos de estado"

# 4. Marcar progreso
git add roadmaps/backend/README.md
git commit -m "docs(backend): marcar HTTP y APIs REST como completado"

# 5. Volver a main y hacer merge
git checkout main
git merge --no-ff backend/http-rest

# 6. Subir cambios
git push origin main

# 7. Borrar la rama local
git branch -d backend/http-rest
```

> `--no-ff` mantiene el historial del tema agrupado, útil para verlo como bloque en `git log`.

---

## 8. Plantilla de commit

Archivo `.gitmessage` en la raíz del repo:

```
# <tipo>(<scope>): <descripción>
#
# tipos: feat, docs, fix, refactor, style, chore, test, wip
# scopes: backend, frontend, devops, mobile, recursos, plantillas, repo
#
# cuerpo (opcional):
# explica el qué y el por qué
#
# footer (opcional):
# Closes #0
```

Actívala localmente:

```bash
git config commit.template .gitmessage
```

Para que sea global en todos tus repos:

```bash
git config --global commit.template ~/.gitmessage
```

---

## 9. Validación automática (opcional)

Cuando el repo crezca, puedes agregar:

### commitlint + Husky

```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional husky
npx husky install
npx husky add .husky/commit-msg 'npx --no -- commitlint --edit "$1"'
```

`.commitlintrc.json`:

```json
{
  "extends": ["@commitlint/config-conventional"],
  "rules": {
    "scope-enum": [
      2,
      "always",
      ["backend", "frontend", "devops", "mobile", "recursos", "plantillas", "repo"]
    ]
  }
}
```

### GitHub Actions (validar en PRs)

`.github/workflows/commitlint.yml`:

```yaml
name: commitlint
on: [pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: wagoid/commitlint-github-action@v5
```

Para un repo personal, esto es **opcional**. Actívalo solo si sientes que el historial se está desordenando.

---

## 10. Errores comunes a evitar

| ❌ Mal                                  | ✅ Bien                                        |
|-----------------------------------------|-----------------------------------------------|
| `update`                                | `docs(backend): apuntes de HTTP`              |
| `agregué tema de docker`                | `docs(backend): agregar tema de Docker`       |
| `fix typo`                              | `fix(frontend): corregir typo en README`      |
| `WIP`                                   | `wip(backend): borrador de apuntes de Redis`  |
| `cambios varios`                        | Dividir en varios commits con scopes claros   |
| `feat: cosas`                           | `feat(backend): proyecto API de tareas`       |

---

## 11. Checklist antes de commitear

- [ ] ¿El cambio es un solo tema lógico?
- [ ] ¿El tipo corresponde al cambio (`docs`, `feat`, `fix`, etc.)?
- [ ] ¿El scope corresponde al roadmap o área tocada?
- [ ] ¿La descripción está en imperativo, minúsculas y sin punto?
- [ ] ¿La primera línea tiene menos de ~72 caracteres?
- [ ] Si apliqué cambios en varios roadmaps, ¿los separé en commits distintos?
- [ ] Si cierra un issue, ¿agregué `Closes #N` en el footer?

---

## 12. Referencias

- [Conventional Commits](https://www.conventionalcommits.org/)
- [commitlint](https://commitlint.js.org/)
- [Husky](https://typicode.github.io/husky/)