import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;

public class BMICalculatorFX extends Application {

	private final TextField txtMass = new TextField();
	private final TextField txtHeight = new TextField();
	private final Button btnCalc = new Button("Calculate BMI");
	
	public BMICalculatorFX() {
		/*
		btnCalc.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				double mass;
				double height;
				try {
					mass = Double.parseDouble(txtMass.getText());
					height = Double.parseDouble(txtHeight.getText());
				} catch (NumberFormatException e) {
					JOptionPane.showMessageDialog(self,
							"Please enter a valid number for mass and height.",
							"Input error",
							JOptionPane.ERROR_MESSAGE);
					return;
				}
				double result = calculateBMI(mass, height);
				JOptionPane.showMessageDialog(self,
						"Your BMI is: " + (Math.round(result*100.0)/100.0),
						"Your BMI result",
						JOptionPane.PLAIN_MESSAGE);
			}		   
		});
		*/
	}
	
	@Override
	public void start(Stage stage) throws Exception {
		VBox vbox = new VBox(10);
		
		Label lblTitle = new Label("BMI Calculator");
		lblTitle.setFont(Font.font(18));
		vbox.getChildren().add(lblTitle);
		
		vbox.getChildren().add(new Label("Your mass (kg):"));
		vbox.getChildren().add(txtMass);
				
		vbox.getChildren().add(new Label("Your height (cm):"));
		vbox.getChildren().add(txtHeight);
		
		vbox.getChildren().add(btnCalc);
		
		Scene scene = new Scene(new Group(vbox)); 

		stage.setTitle("JavaFX BMI Calculator"); 
		stage.setScene(scene); 
		stage.sizeToScene(); 
		stage.show();
	}

	protected double calculateBMI(double mass, double height) {
		return mass / Math.pow(height/100.0, 2.0);
	}

	
	public static void main(String[] args) {
		Application.launch(args);
	}
}