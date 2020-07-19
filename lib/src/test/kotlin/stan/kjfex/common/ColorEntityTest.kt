package stan.kjfex.common

import javafx.scene.paint.Color
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.Assertions.assertEquals

internal class ColorEntityTest {
    @Test
    fun toHexTest() {
        val expected = "#ff00ffff"
        val color = Color.web(expected)
        val actual = color.toHex()
        assertEquals(expected, actual)
    }
}
