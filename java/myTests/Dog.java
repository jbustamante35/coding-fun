class Dog extends Animal {
	int age;
	String name;

	public Dog(String dogsName, int dogsAge) {
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
		Dog bubbles = new Dog("Bubbles", 4);
		bubbles.bark();
		bubbles.run(12);
		bubbles.getSpecies();
	}
}