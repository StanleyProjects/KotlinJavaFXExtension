package stan.kc.kjfex

import javafx.application.Application
import javafx.scene.Scene
import javafx.stage.Stage
import stan.kc.kjfex.scene.layout.label
import stan.kc.kjfex.scene.layout.pane

class App : Application() {
    override fun start(primaryStage: Stage?) {
        requireNotNull(primaryStage)
//        primaryStage.initStyle(StageStyle.TRANSPARENT)
//        primaryStage.scene = Scene(Pane().also { it.setPrefSize(w, h) })
        primaryStage.scene = Scene(pane(width = 640.0, height = 480.0) {
            label(text = "test", textSize = 14)
        })
        primaryStage.title = "stan.kjfex sample"
        primaryStage.show()
    }
}
