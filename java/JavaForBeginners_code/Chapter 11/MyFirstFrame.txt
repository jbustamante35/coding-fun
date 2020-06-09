import java.awt.BorderLayout;
import java.awt.Color;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;


public class MyFirstFrame {
	public static void main(String[] args) {
		JFrame frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setTitle("My First Frame");
		
		JPanel bluePanel = new JPanel();
		JPanel redPanel = new JPanel();
		
		JLabel label = new JLabel("<-- pick your side -->");
		
		frame.getContentPane().add(label, BorderLayout.CENTER);
		
		bluePanel.setBackground(Color.blue);
		redPanel.setBackground(Color.red);
		
		frame.getContentPane().add(bluePanel, BorderLayout.LINE_START);
		frame.getContentPane().add(redPanel, BorderLayout.LINE_END);
		
		JButton blueButton = new JButton("PICK BLUE TEAM");
		JButton redButton = new JButton("PICK RED TEAM");
		
		bluePanel.add(blueButton);
		redPanel.add(redButton);
		
		frame.pack();
		frame.setVisible(true);
	}
}