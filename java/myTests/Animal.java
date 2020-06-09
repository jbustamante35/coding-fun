class Animal {
	String myKingdom, mySpecies;

	public Animal () {
		this.myKingdom = null;
		this.mySpecies = null;
	}

	public Animal (String kingdom, String species) {
		this.myKingdom = kingdom;
		this.mySpecies = species;
	}

	public void getSpecies() throws NullPointerException {
		System.out.println("You are an animal");

		try {
			if (myKingdom != null && mySpecies != null) {
				System.out.printf("You are from Kindgom: %s and " +
							"your Species is: %s %n", myKingdom, mySpecies);
			}
		} catch (NullPointerException e) {
			System.err.println("WARNING"); 
		}
	}

	public static void main(String[] args) {
		Animal animal = new Animal();
		String[] stuff = {"Prokaryote", "Escherichia"};
		Animal another = new Animal(stuff[0], stuff[1]);
		animal.getSpecies();
		another.getSpecies();
	}
}