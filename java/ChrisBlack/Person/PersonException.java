/************************************************************************************
 * Do not modify this file.
 * PersonException class. 
 *************************************************************************************/

package Person;

public class PersonException extends RuntimeException
{
    public PersonException()
    {
	this("");
    }

    public PersonException(String errorMsg) 
    {
	super(errorMsg);
    }

}
