---
name: build-and-test
description: "Налаштовуй Maven build для Java 17 з JUnit 5, виконуваним hello.jar, тестом BasicAddition і CI-скриптами. Використовуй для створення або перевірки збірки та тестів."
---

# Призначення

Налаштувати Maven-збірку Java 17 з JUnit 5, створенням виконуваного `hello.jar`, юніт-тестом `BasicAddition` і скриптами `ci.sh` та `ci.bat`.

# Коли застосовувати

- Коли потрібно додати чи налаштувати Maven build і JUnit 5.
- Коли потрібно зібрати та запустити `hello.jar`.
- Коли потрібно підготувати однакові CI-команди для Linux, macOS і Windows.

# Вхідні дані

- Java-проєкт із `Hello.java`, його package та методом `add(int, int)`.
- Maven (`mvn`) і JDK 17, доступні в середовищі для виконання перевірок.

# Вихідні файли

- `pom.xml` з Java 17, JUnit 5, `maven-jar-plugin` і `Main-Class`, що відповідає класу `Hello`.
- `pom.xml` з `finalName` зі значенням `hello`, щоб створювався `target/hello.jar`.
- `src/test/java/<package-path>/BasicAddition.java` або `src/test/java/BasicAddition.java` для default package.
- `ci.sh` і `ci.bat`; обидва запускають `mvn clean verify` і завершуються помилкою, якщо `target/hello.jar` не існує.

# Кроки

1. Перевір наявні `pom.xml`, `Hello.java`, тести та CI-скрипти; прочитай файли, яких торкнеться робота, і з’ясуй package головного класу.
2. Не перезаписуй наявні файли. Для відсутніх файлів створи нові; якщо наявна конфігурація конфліктує з вимогами або зміна потребує перезапису, зупинись, поясни конфлікт і не руйнуй наявну збірку.
3. Створи або доповни узгоджено `pom.xml`: compiler release 17, JUnit 5 test dependency та сумісні версії Maven plugins, зокрема `maven-surefire-plugin` для JUnit 5.
4. Налаштуй `maven-jar-plugin` так, щоб manifest `Main-Class` указував на повне ім’я `Hello` (з package, якщо він є), а `finalName` дорівнював `hello`.
5. Створи `BasicAddition` у відповідному test package. Тест має перевіряти, що `Hello.add(2, 3)` повертає `5`, використовуючи JUnit 5.
6. Створи `ci.sh`, який запускає `mvn clean verify`, перевіряє наявність `target/hello.jar` і повертає ненульовий exit code у разі помилки. Зроби скрипт executable у Unix-середовищі, якщо це підтримується.
7. Створи `ci.bat`, який запускає `mvn clean verify`, перевіряє наявність `target\hello.jar` і повертає ненульовий exit code у разі помилки. Зупиняй виконання, якщо Maven-команда не пройшла.
8. Запускай перевірки з кореня Maven-проєкту та повідомляй фактичні помилки без приховування їх успішним кодом завершення чи запасним результатом.

# Перевірки

- `mvn test` завершується успішно, зокрема проходить `BasicAddition`.
- `mvn clean verify` створює `target/hello.jar`.
- Файл запускається командою `java -jar target/hello.jar` і виводить `Hello, World!`.
- `ci.sh` і `ci.bat` обидва викликають `mvn clean verify` та перевіряють наявність `target/hello.jar`.

# Типова помилка та що робити

- **JUnit 5 тест не виявляється:** перевір залежність JUnit Jupiter, сумісність `maven-surefire-plugin`, test package та відповідність package головному класу.
- **`no main manifest attribute` або клас не знайдено:** перевір `Main-Class`, package `Hello` і конфігурацію `maven-jar-plugin`.
- **JAR має інше ім’я або відсутній:** перевір `finalName` зі значенням `hello`, успіх `mvn clean verify` та перевірку шляху в CI-скрипті.
- **Maven завершився помилкою:** збережи його ненульовий exit code, покажи діагностику та виправ першопричину; не маскуй збій.

# Приклад входу

```text
У проєкті є src/main/java/com/example/helloworld/Hello.java
Потрібно налаштувати Java 17, JUnit 5, target/hello.jar та скрипти ci.sh і ci.bat.
```
