package com.jetbrains;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class Main {

    public static Squad makeSquadFromFile(String filename) throws IOException {
        File fin = new File(filename);
        Scanner stdin = new Scanner(fin);
        Squad allSquads = new Squad();

        while (stdin.hasNext()) {
            String nextLine = stdin.nextLine();

            if (nextLine.isEmpty()) throw new IOException();

            System.out.println(nextLine);
        }

        return allSquads;
    }

    public static void main(String[] args) throws IOException {
        Main runners = new Main();

        Squad allSquads = runners.makeSquadFromFile(args[0]);



    }
}
