---
description: "Налаштуй Maven Java 17, JUnit 5, BasicAddition і CI-скрипти через skill build-and-test."
agent: build-engineer
---

# Передумови

- Каркас проєкту з `Hello.java` і методом `add(int, int)` уже існує.
- Перевір package головного класу та наявність `pom.xml`, `BasicAddition.java`, `ci.sh` і `ci.bat`.
- Не перезаписуй наявні файли. Якщо існуюча конфігурація конфліктує з вимогами, зупинись і повідом про конфлікт замість руйнівної заміни.

# Дії

1. Застосуй skill `build-and-test`.
2. Створи сумісний `pom.xml` для Java 17 і JUnit 5; налаштуй `maven-jar-plugin` з правильним `Main-Class` та `finalName` зі значенням `hello`.
3. Створи юніт-тест `BasicAddition` у test package, який перевіряє додавання через `Hello.add(int, int)`.
4. Створи `ci.sh` і `ci.bat`. Кожен скрипт має запускати `mvn clean verify`, зупинятися на помилці команди та перевіряти існування `target/hello.jar` (у Windows — `target\hello.jar`).
5. Не перезаписуй наявні файли: створюй лише відсутні та зупиняйся, якщо для виконання вимог потрібна неузгоджена зміна вже наявного файла.
6. Запусти `mvn clean verify`, перевір результат і наявність `target/hello.jar`. Не маскуй ненульовий exit code Maven.

# Очікувані файли

- `pom.xml` з Java 17, JUnit 5, `maven-jar-plugin`, `Main-Class` і `finalName` `hello`.
- `src/test/java/<package-path>/BasicAddition.java` або `src/test/java/BasicAddition.java` для default package.
- `ci.sh`.
- `ci.bat`.
- `target/hello.jar` як build-артефакт.

# Команди перевірки

- `mvn clean verify`
- `Test-Path -LiteralPath 'target\hello.jar'`
- Переконайся, що тест `BasicAddition` позначений як успішний у результаті Maven.

# Повідомлення про помилку

- Якщо skill `build-and-test` недоступний, повідом про це й не стверджуй, що збірку виконано.
- Якщо Maven завершився з помилкою, покажи її діагностику й ненульовий результат; не оголошуй JAR готовим.
- Якщо тест не проходить або JAR відсутній, назви невдалу перевірку та зупинись, не підмінюючи її успішним результатом.
- Якщо наявний файл заважає безпечному налаштуванню, не перезаписуй його; поясни конфлікт.
