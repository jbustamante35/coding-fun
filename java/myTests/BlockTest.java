// Try out a bunch of simple java code

class BlockTest {
	public static void main (String args[]) {
		int numA, numB;
		numA = 10;
		numB = 30;

		for (int i = 1; i < numB; i++) {
			numA += i;
			System.out.println("numA + i = " + numA);
			System.out.println("numB is still " + numB);
			System.out.println("Iteration #" + i + "\n");
		}		
	}
}