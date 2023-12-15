package Priority;

import java.util.ArrayList;

public class Priority {
    public String name;
    public int priority;
    public int arrival;
    public int burst;
    public int turnaround;
    public int timeWaiting;
    public int startTime;
    public static  int numberOfProcess;
    int contextTime ;
    String color ;

    public int getContextTime() {
        return contextTime;
    }

    public int getTimeWaiting() {
        return timeWaiting;
    }

    public int getArrival() {
        return arrival;
    }

    public int getTurnaround() {
        return turnaround;
    }

    public String getColor() {
        return color;
    }

    public int getBurst() {
        return burst;
    }

    public static int getNumberOfProcess() {
        return numberOfProcess;
    }

    public int getPriority() {
        return priority;
    }

    public int getStartTime() {
        return startTime;
    }

    public void setContextTime(int contextTime) {
        this.contextTime = contextTime;
    }

    public void setArrival(int arrival) {
        this.arrival = arrival;
    }

    public void setTurnaround(int turnaround) {
        this.turnaround = turnaround;
    }

    public void setBurst(int burst) {
        this.burst = burst;
    }

    public void setTimeWaiting(int timeWaiting) {
        this.timeWaiting = timeWaiting;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public void setname(String name) {
        this.name = name;
    }

    public static void setNumberOfProcess(int numberOfProcess) {
        Priority.numberOfProcess = numberOfProcess;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public void setStartTime(int startTime) {
        this.startTime = startTime;
    }

    public Priority(String name, int priority, int arrival, int burst , int numberOfProcess) {
        this.name = name;
        this.priority = priority;
        this.burst = burst;
        this.arrival = arrival;
        this.numberOfProcess= numberOfProcess;
        color = null ;
        contextTime = 0 ;
    }


    public static boolean comparePriority(Priority A, Priority B) {
        //A has higher priority
        return A.priority <= B.priority;
    }

    public static ArrayList<Priority> prioritize(ArrayList<Priority> P) {
        ArrayList<Priority> priorityQueue = new ArrayList<>();
        int fullTime = 0, currentTime = 0, i = 0;

        // Variable to store the end time of the previous process
        int previousProcessEndTime = 0;

        // Calculate fullTime
        while (i < P.size()) {
            if (i == P.size() - 1) {
                fullTime += P.get(i).burst;
            } else {
                fullTime += P.get(i).burst;
            }
            i++;
        }

        int timer = 0;

        while (timer < fullTime && !P.isEmpty()) {
            Priority processX = null;
            Priority highest = P.get(0);

            // Find the process with the highest priority within the arrived process interval
            for (Priority pr : P) {
                if (pr.arrival <= currentTime && comparePriority(pr, highest)) {
                    highest = pr;
                }
            }

            processX = highest;
            int xTime = processX.burst;

            // Update current time based on the arrival time and previous execution
            if (processX.arrival > currentTime) {
                currentTime = processX.arrival;
            }

            // Simulate the execution of the process
            processX.turnaround = currentTime + xTime - processX.arrival;
            processX.timeWaiting = processX.turnaround - processX.burst;

            // Calculate and update the start time
            processX.startTime = previousProcessEndTime;

            currentTime += xTime;
            previousProcessEndTime = currentTime;  // Update the end time of the current process

            priorityQueue.add(processX);
            P.remove(processX);
            timer = currentTime;  // Update timer outside the loop

        }

        return priorityQueue;
    }

}