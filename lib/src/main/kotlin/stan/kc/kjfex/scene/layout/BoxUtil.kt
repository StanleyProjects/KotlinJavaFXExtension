package stan.kc.kjfex.scene.layout

import javafx.geometry.Insets
import javafx.scene.CacheHint
import javafx.scene.layout.HBox
import javafx.scene.layout.Pane
import javafx.scene.layout.VBox
import stan.kc.kjfex.common.Orientation
import stan.kc.kjfex.scene.NodeDefault
import stan.kc.kjfex.scene.configure

fun box(
    // node
    isCache: Boolean = NodeDefault.isCache,
    cacheHint: CacheHint = NodeDefault.cacheHint,
    style: String = "", // todo
    // region
    width: Double = RegionDefault.width,
    height: Double = RegionDefault.height,
    padding: Insets = RegionDefault.padding,
    // box
    orientation: Orientation,
    //
    block: Pane.() -> Unit = {}
): Pane {
    val result = when (orientation) {
        Orientation.HORIZONTAL -> HBox()
        Orientation.VERTICAL -> VBox()
    }
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
