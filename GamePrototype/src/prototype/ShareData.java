package prototype;

public class ShareData {

	private static ShareData uniqueInstance = null;

	public int width, height, max, clear;
	public int[][] matrix, flood;
	public int cx, cy, flag = -1;
	public boolean chosen;

	private int tclear;

	private ShareData() {
	}

	public static ShareData getInstance() {
		if (uniqueInstance == null) {
			uniqueInstance = new ShareData();
		}
		return uniqueInstance;
	}

	public void init(int h, int w, int m, int c) {
		height = h;
		width = w;
		max = m;
		clear = c;

		matrix = new int[height][width];
		for (int i = 0; i < height; i++) {
			for (int j = 0; j < width; j++) {
				matrix[i][j] = (int) (Math.random() * max);
			}
		}
		chosen = false;
	}

	public void click(int x, int y) {
		if (chosen) {
			hit(x, y);
		} else {
			choose(x, y);
		}
	}

	private void choose(int x, int y) {
		chosen = true;
		cx = x;
		cy = y;
	}

	private void hit(int x, int y) {
		chosen = false;
		if (cx == x && cy == y)
			return;

		// swap
		int t = matrix[y][x];
		matrix[y][x] = matrix[cy][cx];
		matrix[cy][cx] = t;

		// System.out.println(cx + " " + cy + " " + x + " " + y);

		// COPY TO TEMP ARRAY
		flood = new int[height][width];
		for (int i = 0; i < height; i++)
			for (int j = 0; j < width; j++)
				flood[i][j] = matrix[i][j];
		
		// COUNT FIRST CLEAR
		tclear = 0;
		floodfill(cy, cx, flood[cy][cx]);
		
		if (tclear < clear){
			// CLEAR UP FLOOR FLAGS
			for (int i = 0; i < height; i++)
				for (int j = 0; j < width; j++)
					flood[i][j] = matrix[i][j];
		} else {
			// RECORD INTO MATRIX
			for (int i = 0; i < height; i++)
				for (int j = 0; j < width; j++)
					if(flood[i][j] == flag) matrix[i][j] = flood[i][j];
		}
			
		// COUNT SECOND CLEAR
		if ( flood[y][x] != flag ){
			tclear = 0;
			floodfill(y, x, flood[y][x]);
			
			if (tclear < clear){
			} else {
			// RECORD INTO MATRIX
				for (int i = 0; i < height; i++)
					for (int j = 0; j < width; j++)
						if(flood[i][j] == flag) matrix[i][j] = flood[i][j];
			}
		}
		dropBlock();
	}

	private void dropBlock(){
		
		for (int i = 0; i < height; i++)
			for (int j = 0; j < width; j++)
				if (matrix[i][j] == flag){
					for (int k = i; k > 0; k--) {
						matrix[k][j] = matrix[k-1][j];
					}
					matrix[0][j] = (int) (Math.random() * max);
				}
		
	}
	
	private void floodfill(int y, int x, int color){
		
		if (flood[y][x] == color){
			tclear++;
			flood[y][x] = flag;
			
			if(y-1 >= 0) floodfill(y-1, x, color);
			if(x-1 >= 0) floodfill(y, x-1, color);
			if(y+1 < height) floodfill(y+1, x, color);
			if(x+1 < width) floodfill(y, x+1, color);
		}
	}
	
	/*
	private void debugIntArray(int[][] a, int h, int w){
		for (int i = 0; i < h; i++) {
			for (int j = 0; j < w; j++) {
				System.out.print(a[i][j]);
			}
			System.out.println();
		}
		System.out.println("--------------------");
	}
	*/
}
