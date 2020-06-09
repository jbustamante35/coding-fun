import Person.*;

class QuickTest
{
	public static void main(String[] args) 
	{
		ProperName pname;
		System.out.println("\n\nTest cases.....\n\n");
		System.out.println("construct invalid name: Mr. NULL Y Wong");
		try {
	       		pname = new ProperName("Mr.", null, 'Y', "Wong");
		} catch (PersonException e) {
			System.out.println("PersonException! : " + e);
		}
		System.out.println("============================");

		System.out.println("construct invalid name: Prof. Jimmy Y Sander");
		try {
	       		pname = new ProperName("Prof.", "Jimmy", 'Y', "Sander");
		} catch (PersonException e) {
			System.out.println("PersonException! : " + e);
		}
		System.out.println("============================");

		System.out.println("construct valid name: Mr. Jimmy Y Sander");
	       	pname = new ProperName("Mr.", "Jimmy", 'Y', "Sander");
		System.out.println("Name : " + pname);
		System.out.println("============================");

		ProperName properName1 = new ProperName();
		properName1.setTitle("Mr.");
		properName1.setFirst("Joe");
		properName1.setMiddleInitial('Q');
		properName1.setLast("Student");

		System.out.println("Name #1 : " + properName1);
		ProperName properName2 = new ProperName();
		properName2.setTitle("Mr.");
		properName2.setFirst("Joe");
		properName2.setMiddleInitial('Q');
		properName2.setLast("Student");
		System.out.println("Name #2 : " + properName2);
		System.out.println("Equals : "+properName1.equals(properName2));
		System.out.println("============================");
		properName2.setMiddleInitial('Y');
		System.out.println("Name #1 : " + properName1);
		System.out.println("Name #2 - change initial : Y");
		System.out.println("Name #2 : " + properName2);
		System.out.println("Equals : "+properName1.equals(properName2));
		System.out.println("============================");
		System.out.println("Name #2 - Set title : Mrs.");
		properName2.setTitle("Mrs.");
		System.out.println("Name #2 : " + properName2);
		System.out.println("============================");
		System.out.println("Name #2 - Set title : Dr.");
		try {
			properName2.setTitle("Dr.");
			System.out.println("Name #2 : " + properName2);
		} catch (PersonException e) {
			System.out.println("PersonException! : " + e);
		}
		System.out.println("============================");

	}
}
