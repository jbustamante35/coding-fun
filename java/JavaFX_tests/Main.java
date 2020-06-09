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

public class Main extends Application implements EventHandler<ActionEvent> { // Inherititing functionality for JavaFX application

    Button myButton;

    public static void main(String[] args) {
        launch(args); // Go into Application and start application
    }

    @Override
    public void start(Stage primaryStage) throws Exception{ // Called after launch --> Application set-up
        Parent root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        primaryStage.setTitle("Cool Runnings 2: A Divot in the Journey");


        myButton = new Button();
        myButton.setText("Bobsled");
        // Lambda expression for calling function for event handler
        myButton.setOnAction(e -> {
            System.out.println("FEEL THE RHYTHM");
            System.out.println("FEEL THE RIDE");
            System.out.println("GET ON UP");
            System.out.println("IT'S BOBSLED TIME!!");
            System.out.println("COOL RUNNINGS!!!");
        });

        StackPane layout = new StackPane();
        layout.getChildren().add(myButton);

        // Create the Scene
        Scene scene = new Scene(layout, 300 , 250);
        primaryStage.setScene(scene);
        primaryStage.show();
//        primaryStage.setScene(new Scene(root, 300, 275)); // Window's contents is the "Scene"
//        primaryStage.show(); // Main window is the "Stage"
    }

    public void handle(ActionEvent event) { // handle describes function after action event

    }

}
