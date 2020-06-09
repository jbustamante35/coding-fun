import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;

public class ActionListenerExample extends JFrame {

	public ActionListenerExample() {
		super();
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JButton btn = new JButton("Click Me!");
		
		btn.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				JOptionPane.showMessageDialog(
						null,
						"You clicked me, nice!",
						"Aw yeah!",
						JOptionPane.PLAIN_MESSAGE);
			}		   
		});
		
		this.add(btn);
		
		pack();
		setVisible(true);
	}

	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				new ActionListenerExample();
		}
		});
	}
}