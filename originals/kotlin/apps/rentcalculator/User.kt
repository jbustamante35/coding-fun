// Class to set up individual Users
/*

Object should keep track of month and dates

Data should contain the following:
   String Name     [constructor]
   Int RentDays	   [entered at month-date]
   Int ParkingDays [entered at month-date]
   Int MGEDays     [entered at month-date]

Methods should calculate:
   Float RentRatio
   Float ParkingRatio
   Float MGERatio
   Float RentTotal
   Float ParkingTotal
   Float MGETotal
   Float MiscTotal
   Float UserTotal

 */

fun main (args: Array<String>) {
    var user1 = User("akire")
    var user2 = User("julian")
    var user3 = User("samara")

    println("Current Users: ${user1.name} | ${user2.name} | ${user3.name}")
    var rat = user1.calculateRatio(9.0, 31.0, "MGE")
    println("MGERatio = $rat")

    var tot = user2.calculateTotal(rat, 835.00, 2, "Rent")
    println("RentTotal = $tot")
}

class User (_name: String) {
    val name = _name.capitalize()
    init {
    	println("Created user...$name")
    }

    fun calculateRatio(days: Double, total: Double, param: String): Double {
        // Calculate the percentage of total days user will pay for param
        println("Percentage $param | $days / $total")
        return days / total
    }

    fun calculateTotal(ratio: Double, cost: Double, users: Int, param: String): Double {
        // Calculate total user cost for param
        println("User Share $param | ($ratio * $cost) / $users")
        return (ratio * cost) / users
    }

}

