
import java.util.ArrayList;
import java.util.LinkedList;

public class Squad extends ArrayList<BladeRunner> {
    private String name;
    private ArrayList<BladeRunner> members;
    private Double chemistry;
    private BladeRunner captain;

    public Squad() {
        this.name = null;
        this.members = new ArrayList<BladeRunner>();
        this.chemistry = null;
    }

    public Squad(String n, ArrayList<BladeRunner> m) {
        this.name = n;
        this.members = m;
        this.chemistry = null;
    }

    public BladeRunner getRunner(int pos) {
        BladeRunner getRunner = new BladeRunner();

        for (int i = 0; i <= pos; i++) {
            getRunner = members.get(pos);
        }

        return getRunner;
    }

    public String getName() { return this.name; }
    public void setName(String n) {
        if (n == null) throw new IllegalArgumentException();

        this.name = n;
    }

    public Double getChemistry() { return this.chemistry; }
    public void setChemistry(Double chem) {
        if (chem == null || chem < 0) throw new IllegalArgumentException();

        this.chemistry = chem;
    }

    public BladeRunner getCaptain() { return this.captain; }
    public void setCaptain(BladeRunner capt) {
        if (capt == null) throw new IllegalArgumentException();

        this.captain = capt;
    }


    public void addMember(String newMember) throws NullPointerException {
        if (newMember == null) throw new NullPointerException();

        BladeRunner newbie = new BladeRunner(newMember);
        members.add(newbie);
    }

    public void addMember(BladeRunner newbie) throws NullPointerException {
        if (newbie == null) { throw new NullPointerException(); }

        int currSize = members.size();
        this.members.add(currSize, newbie);
    }

    public BladeRunner removeMember(String target) {
        for (int i = 0; i < members.size(); i++) {
            if (members.get(i).getName().equals(target)) {
                return members.remove(i);
            }
        }

        return null;
    }

    public int numMembers() {
        return members.size();
    }

    public void printMembers() {
        for (int i = 0; i < members.size(); i++) {
            System.out.printf("%s Team %n", name);
            members.get(i).printInfo();
        }
    }

    public void printTeamInfo() {

        String longLine = "\n----------------------------------";


        System.out.printf("%s Team Information:%s %n" +
                        "Captain: %s %n" +
                        "Number of Members: %d %n" +
                        "Team Chemistry: %.02f %n%n",
                name, longLine, captain.getName(), members.size(), chemistry);
    }




}