public class BMICalculator {

	public static void main(String[] args) {
		System.out.println("Hwllo Worhled");
	}

	private double weight, height, BMI;

	public BMICalculator( double weight, double height )
	{
		this.weight = weight;
		this.height = height;
	}

	public void calculate()
	{
		BMI = weight / (height*height);
	}

	public boolean isOverweight()
	{
		return (BMI > 25);
	}	
}