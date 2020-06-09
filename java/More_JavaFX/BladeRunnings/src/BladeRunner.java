
public class BladeRunner {

    private String name;
    private String squad;
    private Double experience;
    private boolean isCaptain;

    public BladeRunner() {
        this.name = null;
        this.squad = null;
        this.experience = null;
        this.isCaptain = false;
    }

    public BladeRunner(String n) {
        this.name = n;
        this.experience = null;
        this.squad = null;
        this.isCaptain = false;
    }

    public BladeRunner(String n, String sqd, Double exp, boolean c) {
        this.name = n;
        this.squad = sqd;
        this.experience = exp;
        this.isCaptain = c;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String n) {
        this.name = n;
    }

    public String getSquad() {
        return this.squad;
    }

    public void setSquad(String s) {
        this.squad = s;
    }
    public Double getExperience() {
        return this.experience;
    }

    public void setExperience(Double exp) {
        this.experience = exp;
    }

    public void setCaptaincy(boolean c) {
        this.isCaptain = c;
    }

    public boolean getCaptaincy () {
        return this.isCaptain;
    }

    public void printInfo() {
        String captaincy;
        String longLine = "\n----------------------------------";
        if (isCaptain) {
            captaincy = "C";
        }
        else {
            captaincy = "m";
        }

        System.out.printf("BladeRunner Information:%s %n" +
                          "Name: %s (%s) %n" +
                          "Squad: %s %n" +
                          "Experience (years): %.02f %n%n",
                           longLine, name, captaincy, squad, experience);
    }

}