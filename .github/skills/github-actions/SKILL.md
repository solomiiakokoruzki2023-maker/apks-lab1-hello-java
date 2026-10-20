---
name: github-actions
description: "Створюй GitHub Actions CI для Maven Java проєкту з матрицею Linux, Windows і macOS та запуском тільки ci.sh або ci.bat."
---

# Призначення

Створити GitHub Actions workflow для перевірки Java/Maven-проєкту на Linux, Windows і macOS, використовуючи наявні CI-скрипти замість окремих Maven-команд у workflow.

# Коли застосовувати

- Коли потрібно додати GitHub Actions CI до Java/Maven-проєкту.
- Коли потрібно запускати перевірки на `ubuntu-latest`, `windows-latest` і `macos-latest` під час `push` або `pull_request`.

# Вхідні дані

- GitHub-репозиторій із Maven-проєктом.
- Скрипт `ci.sh` для Linux/macOS і `ci.bat` для Windows, які виконують потрібні build та test перевірки.
- Гілки `develop` і `master`.

# Вихідні файли

- `.github/workflows/ci.yml` з одним job, matrix `os: [ubuntu-latest, windows-latest, macos-latest]`, тригерами `push` і `pull_request` лише для `develop` та `master`, кроками checkout, setup-java (Temurin 17) і запуску платформного CI-скрипту.

# Кроки

1. Перевір, що `ci.sh` і `ci.bat` існують, та прочитай їх, щоб підтвердити, що вони виконують перевірки проєкту. Якщо потрібний скрипт відсутній, повідом про це; не замінюй його окремими Maven-командами у workflow.
2. Перевір наявність `.github/workflows/ci.yml`. Якщо він існує, прочитай його та збережи сумісну наявну конфігурацію; не перезаписуй файл і не додавай дубльований workflow. Якщо без конфліктної зміни досягти вимог не можна, зупинись і повідом про конфлікт.
3. Створи `.github/workflows/ci.yml` з тригерами:

   ```yaml
   on:
     push:
       branches: [develop, master]
     pull_request:
       branches: [develop, master]
   ```

4. Додай рівно один job з `strategy.matrix.os: [ubuntu-latest, windows-latest, macos-latest]` і `runs-on: ${{ matrix.os }}`.
5. Додай послідовні кроки `actions/checkout` та `actions/setup-java` з `distribution: temurin` і `java-version: '17'`.
6. Додай умовні кроки запуску: для `runner.os == 'Windows'` викликай тільки `ci.bat` через `cmd`; для Linux і macOS викликай тільки `bash ci.sh`.
7. Не додавай окремі кроки чи команди `mvn`, secrets або значення секретів до workflow.
8. Перевір структуру та умови workflow. Якщо перевірка вимагає зовнішнього доступу або GitHub runner, поясни обмеження і не повідомляй неперевірений результат як успішний.

# Перевірки

- `.github/workflows/ci.yml` містить тригери `push` і `pull_request` для `develop` та `master`.
- Workflow має один job і matrix з `ubuntu-latest`, `windows-latest`, `macos-latest`.
- Є кроки checkout і setup-java з Temurin 17.
- Linux/macOS запускають `ci.sh`, Windows запускає `ci.bat`.
- У workflow немає окремих команд `mvn` і немає secrets.

# Типова помилка та що робити

- **CI запускає Maven напряму:** прибери окрему Maven-команду після узгодження змін з наявним workflow і залиш запуск лише через відповідний CI-скрипт.
- **Windows запускає Unix shell script або навпаки:** перевір умови `runner.os` і виконуй `ci.bat` через `cmd`, а `ci.sh` через `bash`.
- **CI-скрипт відсутній або завершується помилкою:** не приховуй збій і не підмінюй його командою у workflow; повідом про відсутній скрипт або фактичну помилку.
- **Workflow уже існує з іншою конфігурацією:** не перезаписуй його; опиши конкретний конфлікт і зупинись, якщо без узгодження вимоги не виконати.

# Приклад входу

```text
Додай GitHub Actions CI для Java 17 Maven-проєкту.
Використовуй ci.sh на ubuntu-latest і macos-latest та ci.bat на windows-latest.
Запускай workflow на push і pull_request до develop та master.
```
