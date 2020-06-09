/**
 * This class represents a proper name for a person.
 * It extends Name class and includes first name, last name, 
 * middle initial and title 
 *
 * Assume valid title is one of the follwing : Mr. Ms. Mrs.
 *
 * Throw PersonException if a name is invalid
 *
 * Implement methods with "add statements"
 */

package Person;

public class ProperName extends Name
{
    private char   middleInitial;
    private String nameTitle;

    public ProperName() 
    {
        super();
    }

    public ProperName(String title, String first, char middle, String last) 
    {
        super (first, last);
        middleInitial = middle;
        nameTitle = title;

        if (title == null)
            throw new PersonException("Title or first or last is null.");
        if (title != "Mr." && (title != "Ms.") && (title != "Mrs."))
            throw new PersonException("Title is invalid.");

        // throw PersonException if title or first or last is "null"
        // throw PersonException if title is invalid
        //
        // Add statements
    }

    public void setMiddleInitial(char middle) 
    {
        middleInitial = middle;
    }

    public char getMiddleInitial() 
    {
        return middleInitial;
    }

    public void setTitle(String title) 
    {
        nameTitle = title;
        if(title != "Mrs." &&  title != "Ms." && title != "Mr.")
        {
        throw new PersonException("Title is invalid");
        // throw PersonException if title is invalid

        // Add statements
    }
    }
    public String getTitle() 
    {
        // Add statements
        return nameTitle; // change it
    }

    public String toString() 
    {
        // Add statements
        return super.toString() + "," + nameTitle + "," + middleInitial; // change it
    }


    public boolean equals(Object other)
    {
        boolean result;

        // Add statements

        if((other == null || (getClass () != other.getClass())))
            result = false;
        else {
            ProperName otherProperName = (ProperName) other;
            result = (getFirst().equals(otherProperName.getFirst()) &&
                    getLast().equals(otherProperName.getLast()) &&
                    nameTitle.equals(otherProperName.nameTitle) &&
                    middleInitial == (otherProperName.middleInitial)); // change it
               }
    return result;
    } // end equals


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
