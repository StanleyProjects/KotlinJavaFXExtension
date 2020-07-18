package stan.kjfex.scene

import javafx.scene.CacheHint
import javafx.scene.Node
import javafx.scene.paint.Color
import stan.kjfex.common.ColorEntity

internal object NodeDefault {
    const val isCache: Boolean = true
    val cacheHint: CacheHint = CacheHint.QUALITY
    val backgroundColor: Color = ColorEntity.TRANSPARENT
}

fun <T : Node> T.configure(
    isCache: Boolean,
    cacheHint: CacheHint,
    style: String
) {
    this.isCache = isCache
    this.cacheHint = cacheHint
    this.style = style
}
