package stan.kjfex.common

import javafx.scene.paint.Color

object ColorEntity {
    val BLACK: Color = Color.web("#000")
    val RED: Color = Color.web("#f00")
    val GREEN: Color = Color.web("#0f0")
    val BLUE: Color = Color.web("#00f")
    val WHITE: Color = Color.web("#fff")
    val TRANSPARENT: Color = Color.web("#000", 0.0)
}

fun Color.toHex(): String {
    return "#" + toString().substring(2)
}
