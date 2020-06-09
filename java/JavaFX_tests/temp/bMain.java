package sample;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler; // User interaction
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class bMain extends Application implements EventHandler<ActionEvent> { // Inherititing functionality for JavaFX application

    Stage window;
    Scene scene1, scene2;

    public static void main(String[] args) {
        launch(args); // Go into Application and start application
    }

    @Override
    public void start(Stage primaryStage) throws Exception{ // Called after launch --> Application set-up

        // Set the Stage
        window = primaryStage;

        Label label1 = new Label("Welcome to  Mario Kart!");
        Button go2Scene2Button = new Button("Go to Scene 2");
        go2Scene2Button.setOnAction(e -> window.setScene(scene2));

        //Layout 1 - children are laid out in vertical column
        VBox layout1 = new VBox(20);
        layout1.getChildren().addAll(label1, go2Scene2Button);
        scene1 = new Scene(layout1, 200, 200 );

        //Button 2
        Button scene2Button = new Button("Go back to Scene 1");
        scene2Button.setOnAction(e -> window.setScene(scene1));

        StackPane layout2 = new StackPane();
        layout2.getChildren().add(scene2Button);
        scene2 = new Scene(layout2, 600,300);

        window.setScene(scene1);
        window.setTitle("I've been waiting for you, Star Fox.");
        window.show();

    }

    public void handle(ActionEvent event) { // handle describes function after action event

    }

}
