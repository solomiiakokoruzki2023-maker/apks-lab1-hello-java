package apks.lab1.hello.java;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BasicAddition {
    @Test
    void addsTwoNumbers() {
        assertEquals(5, Hello.add(2, 3));
    }
}
