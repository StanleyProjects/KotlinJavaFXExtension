package stan.kc.kjfex.scene.layout

import javafx.geometry.Insets
import javafx.scene.layout.Region

internal object RegionDefault {
    const val width: Double = Region.USE_COMPUTED_SIZE
    const val height: Double = Region.USE_COMPUTED_SIZE
    val padding: Insets = Insets(0.0, 0.0, 0.0, 0.0)
}

fun <T : Region> T.configure(
    width: Double,
    height: Double,
    padding: Insets
) {
    setPrefSize(width, height)
    this.padding = padding
}
