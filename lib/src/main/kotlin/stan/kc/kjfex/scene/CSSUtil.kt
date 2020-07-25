package stan.kc.kjfex.scene

enum class CSSProperty {
    FONT_SIZE,
    TEXT_FILL,
    BACKGROUND_COLOR;
}

fun styleOf(firstPair: Pair<CSSProperty, String>, vararg pairs: Pair<CSSProperty, String>): String {
    return (pairs.toList() + firstPair).joinToString(separator = ";") { (k, v) ->
        "-fx-${k.name.toLowerCase()}:$v"
    }
}
