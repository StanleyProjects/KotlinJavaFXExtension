package stan.kc.kjfex

import javafx.application.Application
import javafx.application.Platform
import javafx.scene.Scene
import javafx.stage.Stage
import stan.kc.kjfex.common.Orientation
import stan.kc.kjfex.scene.control.textField
import stan.kc.kjfex.scene.layout.box
import stan.kc.kjfex.scene.layout.label
import stan.kc.kjfex.scene.layout.pane

class App : Application() {
    override fun start(primaryStage: Stage?) {
        requireNotNull(primaryStage)
//        primaryStage.initStyle(StageStyle.TRANSPARENT)
//        primaryStage.scene = Scene(Pane().also { it.setPrefSize(w, h) })
        primaryStage.scene = Scene(box(width = 640.0, height = 480.0, orientation = Orientation.VERTICAL) {
            label(text = "test", textSize = 14)
            val textField = textField(promptText = "test")
            children.add(textField)
            Platform.runLater { requestFocus() }
        })
        primaryStage.title = "stan.kjfex sample"
        primaryStage.show()
    }
}
