import javax.swing.DefaultListModel;
import javax.swing.JFrame;
import javax.swing.JList;

public class MultiThreadedFrame extends JFrame {
	public static final int LENGTH = 100;
	public static final JList<String> COMPONENT = new JList<>();
	
	public class CountingTask implements Runnable {
		public void run() {
			for (int i = 1; i <= LENGTH; i++) {
				// Add an item
				((DefaultListModel<String>) COMPONENT.getModel()).clear();
				((DefaultListModel<String>) COMPONENT.getModel()).addElement("At: "+i);
				// Force component repaint
				COMPONENT.repaint();
				COMPONENT.invalidate();
				COMPONENT.repaint();
				// Sleep for a little to give other threads a chance
				try {
					Thread.sleep(1);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public MultiThreadedFrame() {
		DefaultListModel<String> listModel = new DefaultListModel<>();
		COMPONENT.setModel(listModel);
		getContentPane().add(COMPONENT);
		pack();
		setSize(300,500);
		setVisible(true);
		
		// Increase the number of threads if problem does not appear
		for (int t = 0; t < 16; t++) {
			Thread thread = new Thread(new CountingTask());
			thread.start();
		}
	}
	
	public static void main(String[] args) {
		new MultiThreadedFrame();
	}
}