public class Section5_Lecture27_Methods {

	public static void main (String[] args) {
		
		boolean gameOver = true;
		int score = 800;
		int levelCompleted = 5;
		int bonus = 100;

		int highScore = calculateScore(gameOver, score, levelCompleted, bonus);
		System.out.println("Your final score is " + highScore);


		score = 10000;
		levelCompleted = 8;
		bonus = 200;

		calculateScore(gameOver, score, levelCompleted, bonus);

		String[] myNames = {"Oprah Winfrey", "Rachel Ray", "Queen Latifah", "Raven Simone"};
		int[] myScores = {1500, 900, 400, 50};
		int[] myPositions = new int[myNames.length];

		for (int i = 0; i < myScores.length; i++) {
			myPositions[i] = calculatHighScorePosition(myScores[i]);
			displayHighScorePosition(myNames[i], myPositions[i]);
		}

	}

	public static int calculateScore(boolean gameOver, int score, int levelCompleted, int bonus) {

		if (gameOver) {
			int finalScore = score + (levelCompleted * bonus);
			finalScore += 2000;			
			return finalScore;
		}

		return -1;
	}

	public static void displayHighScorePosition(String name, int position) {
		System.out.printf("%s is in Position %d %n", name, position);
	}

	public static int calculatHighScorePosition(int score) {

		if (score >= 1000) {
			return 1;
		}
		else if (score >= 500 && score < 1000) {
			return 2;
		}
		else if (score >= 100 && score < 500) {
			return 3;
		}
		else {
			return 4;
		}
	}
}