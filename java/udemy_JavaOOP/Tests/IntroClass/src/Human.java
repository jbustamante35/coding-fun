public class Human {

    String name;
    int age;
    int height_in;
    String eyeColor;

    public Human(String n, int a, int h, String e) {
        this.name = n;
        this.age = a;
        this.height_in = h;
        this.eyeColor = e;

    }

    public void speak() {
        System.out.println("Name: " + name + ", Age: " + age);
        System.out.println("Height: " + height_in + ", Eyes: " + eyeColor);
    }

    public void eat() {
        System.out.println(name + " is eating.");

    }

    public void walk() {
        System.out.println(name + " is walking.");
    }

}
