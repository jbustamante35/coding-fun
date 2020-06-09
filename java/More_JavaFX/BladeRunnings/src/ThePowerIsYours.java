
import java.io.File;
import java.io.IOException;
import java.util.*;

public class ThePowerIsYours {

    private Squad[] squads = null;
    private static int numTeams = 0;

    @SuppressWarnings("unchecked")
    public ThePowerIsYours() {
        this.squads = new Squad[10];
    }

    public static Squad loadRunners(String filename, boolean showOutput) throws IOException {
        File fin = new File(filename);
        Scanner stdin = new Scanner(fin);
        Squad allParticipants = new Squad();
        allParticipants.setName("All Participants");

        while (stdin.hasNext()) {

            String nextLine = stdin.nextLine().trim();
            if (nextLine.isEmpty()) throw new IOException();

            String[] splitLine = nextLine.split("\t");

            // Set BladeRunner experience (years)
            Double exp = 0.0;
            exp = exp.valueOf(splitLine[2]);

            // Set BladeRunner captaincy status
            boolean capt = false;
            if (splitLine[3].equals("Y")) capt = true;

            BladeRunner tmp = new BladeRunner(splitLine[0], splitLine[1], exp, capt);
            allParticipants.addMember(tmp);

            // Print out BladeRunner info if showOutput set to true
            if (showOutput) tmp.printInfo();

        }

        System.out.printf("Members Initialized. Total BladeRunners: %d %n%n", allParticipants.numMembers());
        return allParticipants;
    }


    private Squad[] sortSquads(Squad participants, boolean showOutput) {
        // Iterate through all participants and check squad name
        // If Squad with name exists, add member to squad
        // If Squad with name doesn't exist, create new ArrayList<Squad>
        // Set captain as head of the squad

        // Initialize Squad array
        for (int i = 0; i < squads.length; i++) {
            squads[i] = new Squad();
        }

        // Iterate through all Participants and add them to respective Squad
        for (int i = 0; i < participants.numMembers(); i++) {
            // Search through all Squads
            for (int ii = 0; ii < squads.length; ii++) {

                if (participants.getRunner(i).getSquad() == null) { continue; }

                // If current Squad is empty
                if (squads[ii].numMembers() == 0) {

                    numTeams++;
                    squads[ii].addMember(participants.getRunner(i));
                    squads[ii].setName(participants.getRunner(i).getSquad());

                    if (showOutput) {
                        System.out.printf("Size of %s: %d ", squads[ii].getName(), squads[ii].numMembers());
                        System.out.printf(" | Added %s %n", participants.getRunner(i).getName());
                    }

                    break;
                }

                // If BladeRunner Squad name matches current Squad
                else if (squads[ii].getName().trim().equalsIgnoreCase(participants.getRunner(i).getSquad().trim())) {

                    squads[ii].addMember(participants.getRunner(i));

                    if (showOutput) {
                        System.out.printf("Size of %s: %d ", squads[ii].getName(), squads[ii].numMembers());
                        System.out.printf(" | Added %s %n", participants.getRunner(i).getName());
                    }

                    break;
                }

            }
        }

        for (int i = 0; i < numTeams; i++) {
            squads[i] = sortCaptain(squads[i]);
            Double getChem = calcChemistry(squads[i]);
            squads[i].setChemistry(getChem);
        }

        System.out.printf("%n%d Participants sorted into %d Squads %n", participants.numMembers(), numTeams);

        if (showOutput) {
            for (int i = 0; i < numTeams; i++) {
                squads[i].printMembers();
            }
        }

        return squads;
    }

    private Squad sortCaptain(Squad sqd) {

            for (int i = 0; i < sqd.numMembers(); i++) {
                if (sqd.getRunner(i).getCaptaincy()) {
                    sqd.setCaptain(sqd.getRunner(i));
                }

            }

            return sqd;
        }

    private Double calcChemistry(Squad sqd) {
        Double totalExp = 0.0;

        for (int i = 0; i < sqd.numMembers(); i++) {
            totalExp += sqd.getRunner(i).getExperience();
        }

        return (totalExp / sqd.numMembers()) * (0.25 * sqd.getCaptain().getExperience());
    }

    public static void main(String[] args) throws IOException {
        ThePowerIsYours runners = new ThePowerIsYours();
        boolean visualize = false;

        Squad participants = runners.loadRunners(args[0], visualize);
        Squad[] Teams = runners.sortSquads(participants, visualize);

        for (int i = 0; i < numTeams ; i++) {
            Teams[i].printTeamInfo();
        }


    }


}
