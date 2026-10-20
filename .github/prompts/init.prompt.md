---
description: "Оркеструй повне налаштування Java Hello World від перевірки середовища до фінального check."
agent: build-engineer
---

# Передумови

- Працюй із коренем Git repository.
- Перед будь-якими змінами перевір наявність Java, Maven і Git командами `java -version`, `mvn -version`, `git --version`, а також перевір Git repository командою `git rev-parse --is-inside-work-tree`.
- Не перезаписуй наявні файли, не видаляй файли, не переписуй Git history та не приховуй помилки.

# Дії

1. Перевір передумови по черзі: Java, Maven, Git і Git repository. Якщо будь-яка перевірка завершується помилкою або інструмент відсутній, покажи фактичну помилку та зупинись до змін.
2. Після успішних передумов послідовно виконай завдання відповідних prompt-файлів:
   1. [git-init.prompt.md](./git-init.prompt.md)
   2. [create-project.prompt.md](./create-project.prompt.md)
   3. [create-build.prompt.md](./create-build.prompt.md)
   4. [create-actions.prompt.md](./create-actions.prompt.md)
   5. [check.prompt.md](./check.prompt.md)
3. Після кожного кроку перевір його результат. Якщо виникла помилка, покажи її без редагування діагностики, зупинись і не запускай наступні кроки.
4. Заверши процес лише після виконання `check`. Загальний успіх можна оголосити тільки якщо всі обов’язкові пункти `check` мають `PASS`.
5. Зберігай ідемпотентність: повторний запуск не має перезаписувати наявні файли або дублювати `.gitignore` чи workflow конфігурацію.

# Очікувані файли

- `.gitignore`.
- `README.md`.
- `src/main/java/.../Hello.java`.
- `pom.xml`.
- `src/test/java/.../BasicAddition.java`.
- `ci.sh` і `ci.bat`.
- `.github/workflows/ci.yml`.
- Артефакт `target/hello.jar`.
- Наявні manifest, Skills і prompt-файли зберігаються; повторний запуск їх не перезаписує.

# Команди перевірки

- Передумови: `java -version`, `mvn -version`, `git --version`, `git rev-parse --is-inside-work-tree`.
- Запускай кожен prompt-процес послідовно та використовуй його перевірки.
- Фінальна перевірка — усі пункти [check.prompt.md](./check.prompt.md) мають `PASS`.

# Повідомлення про помилку

- Зупиняйся на першій помилці: назви крок, команду та фактичну діагностику без приховування exit code.
- Не запускай наступний prompt після невдалого кроку.
- Не оголошуй успіх без завершеного `check` із загальним `PASS`.
- Якщо необхідна зміна вимагала б перезапису наявного файла, зупинись і поясни конфлікт замість руйнівної дії.
