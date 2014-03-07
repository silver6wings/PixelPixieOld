package prototype;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.JPanel;

@SuppressWarnings("serial")
public class GamePanel extends JPanel implements MouseListener {

	private Color[] colors;

	public GamePanel() {
		this.addMouseListener(this);

		this.colors = new Color[6];
		colors[0] = new Color(255, 0, 0);
		colors[1] = new Color(255, 255, 0);
		colors[2] = new Color(0, 255, 0);
		colors[3] = new Color(0, 255, 255);
		colors[4] = new Color(0, 0, 255);
		colors[5] = new Color(255, 0, 255);
	}

	public void paintComponent(Graphics g) {
		int bw = this.getWidth();
		int bh = this.getHeight();
		int nw = ShareData.getInstance().width;
		int nh = ShareData.getInstance().height;
		int sw = bw / nw;
		int sh = bh / nh;
		int[][] m = ShareData.getInstance().matrix;

		for (int i = 0; i < nh; i++) {
			for (int j = 0; j < nw; j++) {
				if (m[i][j] >= 0) g.setColor(colors[m[i][j]]);
				else g.setColor(Color.BLACK);
				g.fillRect(j * sw, i * sh, sw, sh);
				g.setColor(Color.BLACK);
				g.drawRect(j * sw, i * sh, sw, sh);
			}
		}

		if (ShareData.getInstance().chosen) {
			int x = ShareData.getInstance().cx;
			int y = ShareData.getInstance().cy;

			g.setColor(Color.WHITE);
			g.drawRect(x * sw, y * sh, sw, sh);
		}
	}

	@Override
	public void mouseClicked(MouseEvent e) {
	}

	@Override
	public void mouseEntered(MouseEvent e) {
	}

	@Override
	public void mouseExited(MouseEvent e) {
	}

	@Override
	public void mousePressed(MouseEvent e) {
	}

	@Override
	public void mouseReleased(MouseEvent e) {

		int bw = this.getWidth();
		int bh = this.getHeight();
		int nw = ShareData.getInstance().width;
		int nh = ShareData.getInstance().height;
		int sw = bw / nw;
		int sh = bh / nh;

		int x = e.getX() / sw;
		int y = e.getY() / sh;

		ShareData.getInstance().click(x, y);

		this.repaint();
	}
}