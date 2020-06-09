package com.jetbrains;
import java.util.LinkedList;

public class Squad extends LinkedList<BladeRunner> {
    private String name;
    private LinkedList<BladeRunner> members;
    private Integer chemistry;
    private BladeRunner captain;

    public Squad() {
        this.name = null;
        this.members = null;
        this.chemistry = null;
    }

    public Squad(String n, LinkedList<BladeRunner> m) {
        this.name = n;
        this.members = m;
        this.chemistry = calcChemistry(m);
    }

    public void addMember(BladeRunner newMember) {
        members.add(newMember);
    }

    private Integer calcChemistry(LinkedList<BladeRunner> m) {
        Integer totalChem = null;



        return totalChem;
    }


}