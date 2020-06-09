class Player {
	String playerName, playerPosition;
	int playerOffense, playerDefense, playerTactics, playerOverall;

	public Player (String name, String position, int offense, int defense, int tactics) {
		this.playerName = name;
		this.playerPosition = position;
		this.playerOffense = offense;
		this.playerDefense = defense;
		this.playerTactics = tactics;
		this.playerOverall = (offense + defense + tactics) / 3;
	}

	public void getRatings () {
		System.out.print(playerName + "\t" + playerPosition + "\t" + playerOffense + "\t" + playerDefense + "\t" + playerTactics + "\t" + playerOverall);
	}

	public static void main (String[] args) {				
		Player gerrard = new Player("Steven Gerrard", "Midfielder", 88, 77, 95);
		System.out.println(gerrard.playerName + ", " + gerrard.playerPosition + ", " + gerrard.playerOffense + ", " + gerrard.playerDefense+ ", " + gerrard.playerTactics+ ", " + gerrard.playerOverall);
		gerrard.getRatings();
		System.out.println("\n");
	}
}