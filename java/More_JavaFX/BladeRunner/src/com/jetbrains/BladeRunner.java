package com.jetbrains;

public class BladeRunner {

    private String name;
    private Double experience;
    private String squad;
    private boolean isCaptain;

    public BladeRunner() {
        this.name = null;
        this.experience = null;
        this.squad = null;
        this.isCaptain = false;
    }

    public BladeRunner(String n, Double exp, String sqd, boolean c) {
        this.name = n;
        this.experience = exp;
        this.squad = sqd;
        this.isCaptain = c;
    }




}