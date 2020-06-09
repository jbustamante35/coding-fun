import java.awt.Container;
import java.awt.GridLayout;

import javax.swing.JButton;
import javax.swing.JFrame;

public class GridLayoutFrame {

	public static void main(String[] args) {
		JFrame frame = new JFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setTitle("GridLayout frame");

		// 7 8 9 0
		// 4 5 6 C
		// 1 2 3 =
		// + - * /

		frame.getContentPane().setLayout(new GridLayout(4, 4));
		
		addButtons(frame.getContentPane(),
			"7", "8", "9", "0", "4", "5", "6", "C",
			"1", "2", "3", "=", "+", "-", "*", "/"
		);

		frame.pack();
		frame.setVisible(true);
	}

	private static void addButtons(Container contentPane, String... strings) {
		for (String label : strings) {
			contentPane.add(new JButton(label));
		}
	}
}