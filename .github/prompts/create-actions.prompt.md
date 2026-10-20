---
description: "Створи кросплатформний GitHub Actions workflow через skill github-actions."
agent: build-engineer
---

# Передумови

- У корені проєкту наявні `ci.sh` і `ci.bat`; перевір їх перед налаштуванням workflow.
- Перевір наявність `.github/workflows/ci.yml`. Не перезаписуй наявний workflow і не створюй дубльовані конфігурації.

# Дії

1. Застосуй skill `github-actions`.
2. Створи `.github/workflows/ci.yml` з одним job і matrix `ubuntu-latest`, `windows-latest`, `macos-latest`.
3. Налаштуй workflow так, щоб на кожній ОС він запускав тільки відповідний скрипт: `ci.sh` на Linux/macOS і `ci.bat` на Windows. Дозволені підготовчі кроки, наприклад checkout і setup-java; не додавай окремих команд `mvn`.
4. Перевір YAML, matrix та умовні кроки запуску. Не додавай secrets або значення секретів.
5. Якщо цільовий workflow уже існує, збережи його без змін; якщо він не відповідає вимогам, повідом про конфлікт і зупинись.

# Очікувані файли

- `.github/workflows/ci.yml` з одним job та matrix `ubuntu-latest`, `windows-latest`, `macos-latest`.
- Інші файли не змінюються.

# Команди перевірки

- Перевір існування `.github/workflows/ci.yml`.
- Перевір уміст workflow: усі три runner-и присутні, а build/test запускаються лише командами `ci.sh` або `ci.bat`.
- Переконайся, що workflow не містить окремих команд `mvn` і secrets.

# Повідомлення про помилку

- Якщо skill `github-actions` недоступний або потрібний CI-скрипт відсутній, повідом про це й не підмінюй скрипт командою `mvn`.
- Якщо наявний workflow конфліктує з вимогами, не перезаписуй його; наведи шлях і суть конфлікту.
- Не повідомляй про успішну перевірку, якщо matrix або команда запуску не відповідають вимогам.
