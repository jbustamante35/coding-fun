/* Name class, take from text book
 * Do not modify this class!
*/

package Person;

public class Name
{
	private String first; // first name
	private String last;  // last name

	public Name()
	{
		first = "";
		last = "";
	} // end default constructor

	public Name(String firstName, String lastName)
	{
		first = firstName;
		last = lastName;
	} // end constructor

	public void setName(String firstName, String lastName)
	{
		setFirst(firstName);
		setLast(lastName);
	} // end setName

	public String getName()
	{
		return toString();
	} // end getName

	public void setFirst(String firstName)
	{
		first = firstName; 
	} // end setFirst

	public String getFirst()
	{
		return first;
	} // end getFirst

	public void setLast(String lastName)
	{
		last = lastName;
	} // end setLast

	public String getLast()
	{
		return last;
	} // end getLast

	public void giveLastNameTo(Name aName)
	{
		aName.setLast(last);
	} // end giveLastNameTo

	public String toString()
	{
		return first + " " + last;
	} // end toString

	public boolean equals(Object other)
	{
	  boolean result;
	  
	  if ((other == null) || (getClass() != other.getClass()))
	    result = false;
	  else
	  {
	    Name otherName = (Name)other;
	    result = first.equals(otherName.first) && 
	             last.equals(otherName.last);
	  } // end if
	  
	  return result;
	} // end equals
} // end Name
