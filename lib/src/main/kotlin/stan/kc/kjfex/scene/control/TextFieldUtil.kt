package stan.kc.kjfex.scene.control

import javafx.geometry.Insets
import javafx.scene.CacheHint
import javafx.scene.control.TextField
import javafx.scene.control.TextInputControl
import javafx.scene.paint.Color
import stan.kc.kjfex.common.toHex
import stan.kc.kjfex.scene.CSSProperty
import stan.kc.kjfex.scene.NodeDefault
import stan.kc.kjfex.scene.configure
import stan.kc.kjfex.scene.layout.RegionDefault
import stan.kc.kjfex.scene.layout.configure
import stan.kc.kjfex.scene.styleOf

fun TextInputControl.configure(
    text: String,
    promptText: String
) {
    this.text = text
    this.promptText = promptText
}

fun textField(
    // node
    isCache: Boolean = NodeDefault.isCache,
    cacheHint: CacheHint = NodeDefault.cacheHint,
    backgroundColor: Color = NodeDefault.backgroundColor,
    // region
    width: Double = RegionDefault.width,
    height: Double = RegionDefault.height,
    padding: Insets = RegionDefault.padding,
    // textField
    text: String = "", // todo
    promptText: String = "", // todo
    //
    block: TextField.() -> Unit = {}
): TextField {
    val result = TextField()
    // node
    result.configure(
        isCache = isCache,
        cacheHint = cacheHint,
        style = styleOf(
            CSSProperty.BACKGROUND_COLOR to backgroundColor.toHex()
        )
    )
    // region
    result.configure(
        width = width,
        height = height,
        padding = padding
    )
    // textField
    result.configure(
        text = text,
        promptText = promptText
    )
    //
    result.block()
    return result
}
