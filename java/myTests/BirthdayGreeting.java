class BirthdayGreeting {
    public static void main (String args[]) {
        String name = args[0];
        String g    = greet_happy_birthday(name);
        System.out.println(g);
    }

    public static String greet_happy_birthday(String name) {
        String g = "Happy birthday, " + name + "!";
        return g;
    }
}

