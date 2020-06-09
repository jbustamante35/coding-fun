package backgroundapp

import javafx.animation.Animation
import javafx.animation.Interpolator
import javafx.animation.ParallelTransition
import javafx.animation.TranslateTransition
import javafx.geometry.Insets
import javafx.geometry.Pos
import javafx.scene.Node
import javafx.scene.control.Button
import javafx.util.Duration
import tornadofx.*


/**
 * @author carl
 */

class BackgroundView : View("Background App"){

    private val BACKGROUND_WIDTH = 2000.0
    private val BACKGROUND_DURATION = Duration.seconds(5.0)
    private val CLOUDS_DURATION = Duration.seconds(11.0)

    private val backgroundWrapper = ParallelTransition()
    private val cloudsWrapper = ParallelTransition()

    private val parallelTransition = ParallelTransition(
            backgroundWrapper, cloudsWrapper
    )

    private var btnControl: Button by singleAssign()

    override val root = stackpane {

        pane {
            imageview("/backgroundapp-images/background2.svg.png") {
                backgroundWrapper.children += createTranslateTransition(this)
            }
            imageview("/backgroundapp-images/background2.svg.png") {
                x = BACKGROUND_WIDTH
                backgroundWrapper.children += createTranslateTransition(this)
            }
            imageview("/backgroundapp-images/clouds.svg.png") {
                cloudsWrapper.children += createTranslateTransition(this, CLOUDS_DURATION)
            }
            imageview("/backgroundapp-images/clouds.svg.png") {
                x = BACKGROUND_WIDTH
                cloudsWrapper.children += createTranslateTransition(this, CLOUDS_DURATION)
            }
        }

        btnControl = button(">") {
            stackpaneConstraints {
                alignment = Pos.BOTTOM_CENTER
                margin = Insets(0.0, 0.0, 40.0, 0.0)
            }
            setOnAction {
                controlPressed()
            }
        }

        alignment = Pos.CENTER

        minWidth = 768.0
        minHeight = 320.0

        prefWidth = 1024.0
        prefHeight = 768.0

        maxWidth = 1920.0
        maxHeight = 800.0
    }

    init {

        backgroundWrapper.cycleCount = Animation.INDEFINITE
        cloudsWrapper.cycleCount = Animation.INDEFINITE
        parallelTransition.cycleCount = Animation.INDEFINITE

        parallelTransition.statusProperty().addListener { _, _, newValue ->
            if (newValue === Animation.Status.RUNNING) {
                btnControl.text = "||"
            } else {
                btnControl.text = ">"
            }
        }
    }

    private fun createTranslateTransition(
            n : Node,
            duration : Duration = BACKGROUND_DURATION
        ) : TranslateTransition {

        val ttrans = TranslateTransition(duration, n)
        ttrans.fromX = 0.0
        ttrans.toX = -1 * BACKGROUND_WIDTH
        ttrans.interpolator = Interpolator.LINEAR

        return ttrans
    }

    private fun controlPressed() {
        if( parallelTransition.status == Animation.Status.RUNNING ) {
            parallelTransition.pause()
        } else {
            parallelTransition.play()
        }
    }
}

class BackgroundApp : App(BackgroundView::class)