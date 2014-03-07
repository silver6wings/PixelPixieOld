package prototype;

import java.awt.Color;
import javax.swing.JFrame;

@SuppressWarnings("serial")
public class MainForm extends JFrame {

	public static void main(String[] args) {
		MainForm mf = new MainForm();
		mf.setVisible(true);
	}

	private GamePanel gp;

	public MainForm() {
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setTitle("Prototype");
		this.setSize(550, 550);
		this.setResizable(false);
		this.setLayout(null);

		ShareData.getInstance().init(15, 15, 6, 3);

		gp = new GamePanel();
		gp.setBackground(new Color(0, 0, 0));
		gp.setBounds(0, 0, 500, 500);

		this.add(gp);
	}
}
