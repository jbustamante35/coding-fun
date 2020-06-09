class Doggy {
	int age;
	String name;

	public Doggy (String dogsName, int dogsAge) {
		this.name = dogsName;
		this.age = dogsAge;
	}

	public void bark() {
		System.out.println(name + " says WOOF!");
	}

	public void run(int feet) {
		System.out.println(name + " ran " + feet + " feet!");
	}

	public static void main(String[] args) {
		Doggy bubbles = new Doggy("Bubbles", 4);
		bubbles.bark();
		bubbles.run(12);		
	}
}