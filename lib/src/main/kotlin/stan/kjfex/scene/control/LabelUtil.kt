package stan.kjfex.scene.control

import javafx.geometry.Insets
import javafx.geometry.Pos
import javafx.scene.CacheHint
import javafx.scene.control.Label
import javafx.scene.control.Labeled
import javafx.scene.paint.Color
import stan.kjfex.common.ColorEntity
import stan.kjfex.common.toHex
import stan.kjfex.scene.CSSProperty
import stan.kjfex.scene.NodeDefault
import stan.kjfex.scene.configure
import stan.kjfex.scene.layout.RegionDefault
import stan.kjfex.scene.layout.configure
import stan.kjfex.scene.styleOf

internal object LabelDefault {
    val alignment: Pos = Pos.CENTER_LEFT
    val textColor: Color = ColorEntity.BLACK
}

fun Labeled.configure(
    text: String,
    alignment: Pos
) {
    this.text = text
    this.alignment = alignment
}

fun label(
    // node
    isCache: Boolean = NodeDefault.isCache,
    cacheHint: CacheHint = NodeDefault.cacheHint,
    backgroundColor: Color = NodeDefault.backgroundColor,
    // region
    width: Double = RegionDefault.width,
    height: Double = RegionDefault.height,
    padding: Insets = RegionDefault.padding,
    // label
    text: String,
    textSize: Int,
    textColor: Color = LabelDefault.textColor,
    alignment: Pos = LabelDefault.alignment,
    //
    block: Label.() -> Unit = {}
): Label {
    val result = Label()
    // node
    result.configure(
        isCache = isCache,
        cacheHint = cacheHint,
        style = styleOf(
            CSSProperty.FONT_SIZE to textSize.toString(),
            CSSProperty.TEXT_FILL to textColor.toHex(),
            CSSProperty.BACKGROUND_COLOR to backgroundColor.toHex()
        )
    )
    // region
    result.configure(
        width = width,
        height = height,
        padding = padding
    )
    // label
    result.configure(
        text = text,
        alignment = alignment
    )
    //
    result.block()
    return result
}
