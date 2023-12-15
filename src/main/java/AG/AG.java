package AG;

import java.util.ArrayList;

public class AG {
    public   static ArrayList<String> processes = new ArrayList<>();
    public   static ArrayList<Integer> burstTime = new ArrayList<>();

  public   static ArrayList<Integer> randomNumber = new ArrayList<>();
    public   static ArrayList<String> excOrder = new ArrayList<>();
    public   ArrayList<Integer> remainingBurstTime = new ArrayList<>();
    public   ArrayList<Integer> waitTime = new ArrayList<>();
    public ArrayList<Integer> turnAroundTime = new ArrayList<>();

  public   int numberOfProcess;
    public  double averageTurnaroundTime = 0;
    public  double averageWaitingTime = 0;

    public void checkArrival(int time) {
        for (int i = 0; i < numberOfProcess; i++) {
            if (arrivalTime.get(i) == time && !readyQ.contains(processes.get(i))) {
                readyQ.add(processes.get(i));
            }
        }
    }

    ArrayList<Integer> leaveTime = new ArrayList<>();
    ArrayList<String> readyQ = new ArrayList<>();
    ArrayList<String> color = new ArrayList<>();

    public  int calculateQuantum(int quantum) {
        int res = 0;
        res = (int) Math.ceil((double) quantum / 2);
        return res;
    }


    public  static ArrayList<Integer> arrivalTime = new ArrayList<>();
    public static ArrayList<Integer> priority = new ArrayList<>();
    public static ArrayList<Integer> quantum = new ArrayList<>();


    public int calculateAGFactor(int priority, int arrival, int rem, int randomNumber, int burst) {
        int ag;
        if (randomNumber == 10) {
            ag = priority + arrival + burst;
        } else if (randomNumber > 10) {
            ag = 10 + arrival + burst;
        } else {
            ag = randomNumber + arrival + burst;
        }
        return ag;
    }

     public void AGSchedule() {
        int indx = 0;
        int minIndx;
        int halfQuantum;
        int time = 0;
        int countProcessDone = 0;

        for (int i = 0; i < numberOfProcess; i++) {
            leaveTime.add(0);
            remainingBurstTime.add(burstTime.get(i));
        }

        while (true) {

            if (remainingBurstTime.get(indx) > 0) {

                //start of none preemptive
                excOrder.add(processes.get(indx));
                halfQuantum = calculateQuantum(quantum.get(indx));

                //    System.out.print("quantum: ");
                //  System.out.println(quantum);

                //  System.out.println("half quantum "+halfQuantum);
                if (remainingBurstTime.get(indx) >= halfQuantum) {
                    int takenQ = 0;

                    //check the arrival at every sec of the ceil 50%.
                    for (int i = time; i < time + halfQuantum; i++) checkArrival(i);
                    takenQ += halfQuantum;
                    time += halfQuantum;

                    minIndx = calculateMinimumAGFactor(-1, time);
                    remainingBurstTime.set(indx, remainingBurstTime.get(indx) - takenQ);

                    if (indx == minIndx) {
                        int remQ = quantum.get(indx) - takenQ;
                        int remQAftLoop = 0;
                        for (int i = 0; i < remQ; i++) {

                            // preemptive
                            checkArrival(time);
                            time++;
                            takenQ++;
                            remQAftLoop = quantum.get(indx) - takenQ;
                            remainingBurstTime.set(indx, remainingBurstTime.get(indx) - 1);
                            minIndx = calculateMinimumAGFactor(-1, time);
                            if (indx != minIndx) {
                                break;
                            }
                            if (remainingBurstTime.get(indx) == 0) {
                                // the remaining burst time  = zero
                                readyQ.remove(0);
                                quantum.set(indx, 0);
                                leaveTime.set(indx, time);
                                countProcessDone++;
                                break;
                            }
                        }
                        if (quantum.get(indx) > 0) {
                            if (remQAftLoop == 0) {

                                //case 1
                                // used all the quantum
                                double mean = 0;

                                for (Integer integer : quantum) {
                                    mean += integer;
                                }
                                //  System.out.println("size : "+ quantum.size());
                                mean = mean / quantum.size();
                                mean = Math.ceil(mean * 0.1);


                                // System.out.println("mean = " + mean);
                                mean += quantum.get(indx);

                                quantum.set(indx, (int) mean);
                                // System.out.println( "new quantum = " + quantum.get(indx));

                                readyQ.add(readyQ.get(0));
                                readyQ.remove(readyQ.get(0));
                                indx = processes.indexOf(readyQ.get(0));
                                continue;

                            } else {
                                // not used all the quantum and if was removed
                                //   System.out.println("remaining queue " + remQAftLoop);
                                quantum.set(indx, (quantum.get(indx) + remQAftLoop));
                                readyQ.add(readyQ.get(0));
                                readyQ.remove(readyQ.get(0));

                            }
                            if (remainingBurstTime.get(indx) == 0) // take all remaining Quantum and finish
                            {
                                readyQ.remove(0);
                                quantum.set(indx, 0);
                                leaveTime.set(indx, time);
                                indx = processes.indexOf(readyQ.get(0));
                                countProcessDone++;
                                continue;
                            }
                        } else {
                            if (readyQ.size() != 0) {
                                indx = processes.indexOf(readyQ.get(0));
                                continue;
                            }
                        }

                    } else {
                        readyQ.add(readyQ.get(0));
                        readyQ.remove(readyQ.get(0));
                        quantum.set(indx, quantum.get(indx) + takenQ);

                    }
                }

                //if its preemptive and value of burst < halfQuantum
                //So it will finish immediately
                else {
                    time = time + remainingBurstTime.get(indx);
                    remainingBurstTime.set(indx, 0);
                    quantum.set(indx, 0);
                    readyQ.remove(0);
                    leaveTime.set(indx, time);
                    countProcessDone++;
                }
                minIndx = calculateMinimumAGFactor(indx, time);
                readyQ.remove(processes.get(minIndx));
                readyQ.add(0, processes.get(minIndx));
                indx = minIndx;
            }
            if (countProcessDone == numberOfProcess) {
                break;
            }
        }
    }


    public  int calculateMinimumAGFactor(int index, int currentTime) {
        double minFactor = 9999999;
        int minimumIndex = 0;
        for (int j = 0; j < numberOfProcess; j++) {
            if (currentTime >= arrivalTime.get(j) && quantum.get(j) > 0) {
                if (minFactor > calculateAGFactor(priority.get(j), arrivalTime.get(j), remainingBurstTime.get(j), randomNumber.get(j), burstTime.get(j))
                        && index != j) {
                    minFactor = calculateAGFactor(priority.get(j), arrivalTime.get(j), remainingBurstTime.get(j), randomNumber.get(j), burstTime.get(j));
                    minimumIndex = j;
                }
            }
        }
        return minimumIndex;
    }


    public  void calculateAverageTurnAroundTime() {
        for (int i = 0; i < numberOfProcess; i++) {
            turnAroundTime.add(leaveTime.get(i) - arrivalTime.get(i));
            averageTurnaroundTime += turnAroundTime.get(i);
        }
        averageTurnaroundTime /= numberOfProcess;
    }

    public   void calculateAverageWaitingTime() {
        for (int i = 0; i < numberOfProcess; i++) {
            waitTime.add(turnAroundTime.get(i) - burstTime.get(i));
            averageWaitingTime += waitTime.get(i);
        }
        averageWaitingTime /= numberOfProcess;
    }


}

