# Архітектура AI-агента build-engineer

## Які проблеми вирішує агент

Агент build-engineer автоматизує початкове налаштування та перевірку кросплатформного Java Hello World проєкту. Він допомагає уникнути ручних помилок у структурі Maven, JUnit 5 тестах, виконуваному JAR, CI-скриптах і GitHub Actions. Правила агента вимагають перевіряти файли перед змінами, не перезаписувати їх без перевірки та зупиняти процес із явною помилкою.

## Відповідність файлів ролям

| Роль | Файл або каталог | Призначення |
|---|---|---|
| Agent manifest | `.github/agents/build-engineer.agent.md` | Визначає роль, межі відповідальності, правила роботи, заборонені дії та критерії завершення агента. |
| Skills | `.github/skills/project-scaffold/SKILL.md`, `.github/skills/build-and-test/SKILL.md`, `.github/skills/github-actions/SKILL.md` | Описують повторювані робочі процеси створення каркаса, Maven-збірки та CI workflow. |
| Prompts як commands | `.github/prompts/*.prompt.md` | Надають окремі команди `/git-init`, `/create-project`, `/create-build`, `/create-actions`, `/check` та `/init-project`. |
| Orchestrator `init-project` | `.github/prompts/init-project.prompt.md` | Перевіряє інструменти, запускає етапи в правильному порядку та зупиняється при першій помилці. |
| GitHub Actions workflow | `.github/workflows/ci.yml` | Запускає CI на Linux, Windows і macOS через відповідні CI-скрипти. Створюється командою `/create-actions`. |

Файли в `.github/prompts/` є prompt-файлами та в цьому навчальному середовищі виконують роль команд для GitHub Copilot Chat. Вони надають доступні для запуску завдання, наприклад `/init-project`; це аналог команд у середовищі GitHub Copilot. Prompt `init-project` має таку назву через конфлікт із вбудованою командою VS Code.

## Skills агента

- `project-scaffold` створює мінімальний Java Hello World каркас, `Hello.java` з `main` і `add(int, int)`, README та початкові правила `.gitignore`.
- `build-and-test` налаштовує Java 17, Maven, JUnit 5, тест `BasicAddition`, виконуваний `hello.jar` і скрипти `ci.sh` та `ci.bat`.
- `github-actions` налаштовує кросплатформний GitHub Actions workflow, який запускає CI-скрипт відповідної операційної системи.

## Доступні commands

| Command | Призначення |
|---|---|
| `/git-init` | Перевіряє Git repository, ідемпотентно налаштовує правила `.gitignore` та показує Git status. |
| `/create-project` | Викликає `project-scaffold` для створення Hello World каркаса. |
| `/create-build` | Викликає `build-and-test` для налаштування Maven build, тесту та CI-скриптів. |
| `/create-actions` | Викликає `github-actions` для створення CI workflow. |
| `/check` | Перевіряє налаштування, структуру, збірку, тести, workflow та інші критерії й виводить звіт PASS/FAIL. |
| `/init-project` | Оркеструє повний процес у послідовності: `/git-init`, `/create-project`, `/create-build`, `/create-actions`, `/check`. |

## Дані між етапами

1. `init-project` перевіряє наявність Java, Maven і Git та передає контроль `git-init`.
2. `git-init` перевіряє Git repository і правила ігнорування; наступному етапу доступні корінь проєкту та актуальна конфігурація `.gitignore`.
3. `create-project` передає наступному етапу структуру вихідного коду, шлях і package `Hello.java`, методи `main` та `add(int, int)`, а також README.
4. `create-build` використовує цю структуру для `pom.xml`, тесту `BasicAddition` і CI-скриптів. Він має створити `target/hello.jar` після успішної збірки.
5. `create-actions` використовує `ci.sh` і `ci.bat` як точки входу до перевірок та налаштовує workflow для трьох ОС.
6. `check` читає створені файли, запускає перевірки й формує підсумок PASS/FAIL для `init-project`.

## Обробка помилок в `init-project`

Оркестратор перевіряє передумови до змін, після чого запускає команди послідовно. Якщо команда або перевірка завершується помилкою, `init-project` показує її, зупиняється на першій помилці й не запускає наступні етапи. Успіх оголошується лише після завершеного `/check` з результатом PASS; пропущена або невдала перевірка не вважається успішною.
