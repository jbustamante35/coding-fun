class SoccerTeam {
	
	String teamname;
	Player[] players = new Player[4];
	int teamRating;

	public SoccerTeam (String teamName, Player forwards, Player midfielders, Player defenders, Player goalkeepers) {
		this.teamname = teamName;
		this.players[0] = forwards;
		this.players[1] = midfielders;
		this.players[2] = defenders;
		this.players[3] = goalkeepers;
	}

	public void getPlayerNames() {					
		for (int i = 0; i < 4 ; i++) {
			players[i].getRatings();
			System.out.println("");
		}	
	}

	public void getOverall () {
		int playerRating[] = new int[4];
		int teamOverall;

		for (int i = 0; i < 4; i++) {
			playerRating[i] = (players[i]. )
		}

	}

	public static void main (String[] args) {
		String myTeam = "Liverpool";		
		Player forward = new Player("Roberto Firmino", "Forward", 86, 62, 77);
		Player midfielder = new Player("Phillipe Coutinho", "Midfielder", 92, 74, 90);
		Player defender = new Player("Nathaniel Clyne", "Defender", 67, 81, 75);
		Player goalkeeper = new Player("Simon Mignolet", "Goalkeeper", 32, 85, 80);

		SoccerTeam liverpool = new SoccerTeam(myTeam, forward, midfielder, defender, goalkeeper);
		System.out.println("Create your soccer team!");
		System.out.println("Team: " + myTeam);
		System.out.println("Name\tPosition\tOffense\tDefense\tTactics\tOverall");
		liverpool.getPlayerNames();

	}	
}