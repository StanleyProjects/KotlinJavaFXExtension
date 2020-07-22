package stan.kc.kjfex.scene.layout

import javafx.geometry.Insets
import javafx.geometry.Pos
import javafx.scene.CacheHint
import javafx.scene.control.Label
import javafx.scene.layout.Pane
import javafx.scene.paint.Color
import stan.kc.kjfex.scene.NodeDefault
import stan.kc.kjfex.scene.configure
import stan.kc.kjfex.scene.control.LabelDefault

fun pane(
    // node
    isCache: Boolean = NodeDefault.isCache,
    cacheHint: CacheHint = NodeDefault.cacheHint,
    style: String = "", // todo
    // region
    width: Double = RegionDefault.width,
    height: Double = RegionDefault.height,
    padding: Insets = RegionDefault.padding,
    //
    block: Pane.() -> Unit = {}
): Pane {
    val result = Pane()
    // node
    result.configure(
        isCache = isCache,
        cacheHint = cacheHint,
        style = style
    )
    // region
    result.configure(
        width = width,
        height = height,
        padding = padding
    )
    result.block()
    return result
}

fun Pane.label(
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
    needToAdd: Boolean = true,
    block: Label.() -> Unit = {}
): Label {
    val result = stan.kc.kjfex.scene.control.label(
        isCache = isCache,
        cacheHint = cacheHint,
        width = width,
        height = height,
        padding = padding,
        text = text,
        textSize = textSize,
        textColor = textColor,
        backgroundColor = backgroundColor,
        alignment = alignment,
        block = block
    )
    if (needToAdd) {
        children.add(result)
    }
    return result
}
