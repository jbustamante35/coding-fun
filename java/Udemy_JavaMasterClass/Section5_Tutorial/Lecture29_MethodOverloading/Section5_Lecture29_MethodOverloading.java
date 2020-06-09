public class Section5_Lecture29_MethodOverloading {


    public static void main(String[] args) {
        int newScore = calculateScore("Bart", 500);
        System.out.println("New score is " + newScore);

        newScore = calculateScore(800);
        System.out.println("New score is " + newScore);

        calculateScore();

        System.out.println("\n\n");

        double myFeet = 5.0;
        double myInches = 4.0;
        double myHeight = calcFeetAndInches2Centimeters(myFeet, myInches);
        System.out.printf("I am %.00f\'%.00f\" tall.%n", myFeet, myInches);
        System.out.printf("My Height is %.02f cm.%n", myHeight);

        myFeet = 6.0;
        myInches = 7.0;
        myHeight = calcFeetAndInches2Centimeters(myFeet, myInches);
        System.out.printf("I am %.00f\'%.00f\" tall.%n", myFeet, myInches);
        System.out.printf("My Height is %.02f cm.%n", myHeight);

        myFeet = 8.0;
        myInches = 4.0;
        myHeight = calcFeetAndInches2Centimeters(myFeet, myInches);
        System.out.printf("I am %.00f\'%.00f\" tall.%n", myFeet, myInches);
        System.out.printf("My Height is %.02f cm.%n", myHeight);

        myFeet = 13.0;
        myInches = 1.0;
        myHeight = calcFeetAndInches2Centimeters(myFeet, myInches);
        System.out.printf("I am %.00f\'%.00f\" tall.%n", myFeet, myInches);
        System.out.printf("My Height is %.02f cm.%n", myHeight);

    }

    public static int calculateScore(String playerName, int playerScore) {
        System.out.println("Player " + playerName + " scored " + playerScore + " points.");
        return playerScore * 1000;
    }

    public static int calculateScore(int playerScore) {
        System.out.println("Unnamed Player" + " scored " + playerScore + " points.");
        return playerScore * 1000;
    }

    public static int calculateScore() {
        System.out.println("No player name, no player score");
        return 0;
    }


    public static double calcFeetAndInches2Centimeters(double feet, double inches) {
        if (feet >= 0 && inches >= 0 && inches <= 12) {
            double feet2inches = calcFeetAndInches2Centimeters(feet);
            double centimeters = 2.54 * (feet2inches + inches);
            return centimeters;
        } else {
            System.out.println("Invalid feet or inches parameters.");
            return -1;
        }
    }

    public static double calcFeetAndInches2Centimeters(double feet) {

        if (feet >= 0) {
            double inches = feet * 12;
            return inches;
        } else {
            return -1;
        }

    }

}