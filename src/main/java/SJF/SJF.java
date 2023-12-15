package SJF;

import java.util.ArrayList;

public class SJF {

    public String name;
    public String color;
    public int arrival;
    public int burst;
    public int turnaround;
    public int timeWaiting;
    public int executionTime; // Represents when the process will start after scheduling
    public int contextTime ;

    public void setTimeWaiting(int timeWaiting) {
        this.timeWaiting = timeWaiting;
    }

    public void setTurnaround(int turnaround) {
        this.turnaround = turnaround;
    }

    public void setExecutionTime(int executionTime) {
        this.executionTime = executionTime;
    }

    public void setname(String name) {
        this.name = name;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public void setBurst(int burst) {
        this.burst = burst;
    }

    public void setArrival(int arrival) {
        this.arrival = arrival;
    }

    public void setContextTime(int contextTime) {
        this.contextTime = contextTime;
    }

    public int getTurnaround() {
        return turnaround;
    }

    public int getTimeWaiting() {
        return timeWaiting;
    }

    public int getExecutionTime() {
        return executionTime;
    }

    public String getColor() {
        return color;
    }

    public int getArrival() {
        return arrival;
    }

    public int getBurst() {
        return burst;
    }

    public int getContextTime() {
        return contextTime;
    }


    public SJF(String p, String c, int a, int b) {
        name = p;
        color = c;
        arrival = a;
        burst = b;
        contextTime = 0 ;
    }

    //calculates average turn around and average waiting time
    public static int Avg(ArrayList<SJF> list, int choice) {
        int time = 0;
        int size = list.size();
        switch (choice) {
            // 1st case represents (Turn Around time)
            case 1: {
                for (SJF sjf : list) {
                    time += sjf.turnaround;
                }
            }
            break;

            // 2nd case: represents (Waiting time)
            case 2: {
                for (SJF sjf : list) {
                    time += sjf.timeWaiting;
                }
            }
            break;

            default:
                throw new IllegalStateException("Unexpected value: " + choice);
        }
        return time / size;
    }

    public static boolean search(SJF process, ArrayList<SJF> list) {
        return list.contains(process);
    }

    public static ArrayList<SJF> SJFschedule(ArrayList<SJF> P, int context, int timeInterval) {
        ArrayList<SJF> executedP = new ArrayList<>();
        int fulltime = 0, currenttime = 0, i = 0;

        for (i = 0; i < P.size(); i++) {
            if (i == P.size() - 1) {
                fulltime += P.get(i).burst;
            } else {
                fulltime += P.get(i).burst + context;
            }
        }

        int timer = 0;
        int x = 0;
        i = 0;

        while (timer < fulltime) {
            SJF processX = null;
            SJF minburst = P.get(0);

            // Find the process with the lowest burst time within the defined interval
            for (SJF sjf : P) {
                if (sjf.arrival <= currenttime && sjf.burst < minburst.burst && !search(sjf, executedP)) {
                    minburst = sjf;
                }
            }

            processX = minburst;
            int xtime = processX.burst;

            // Update currenttime based on the arrival time and previous execution
            if (processX.arrival > currenttime) {
                currenttime = processX.arrival;
            }

            // Simulate the execution of the process
            processX.turnaround = currenttime + xtime - processX.arrival;
            processX.timeWaiting = processX.turnaround - processX.burst;
            processX.executionTime = currenttime; // Store execution time
            currenttime += xtime + context;

            executedP.add(processX);
            x++;
            timer = currenttime;
            i++;
        }

        // Filter the executed processes within the defined time interval
        executedP.removeIf(process -> process.turnaround >= timeInterval);

        return executedP;
    }
}
