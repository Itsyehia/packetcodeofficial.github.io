package SRTF;
import java.time.temporal.Temporal;
import java.util.*;
public class SRTF {
    public String name;
    public String color;
    public int arrival;
    public int burst;
    public int RemainingProcessTime;
    public int turnaround;
    public int timeWaiting;
    public int executionTime;
    public int finishtime;
    public int contextTime ;

    public void setArrival(int arrival) {
        this.arrival = arrival;
    }

    public void setBurst(int burst) {
        this.burst = burst;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public void setExecutionTime(int executionTime) {
        this.executionTime = executionTime;
    }

    public void setFinishtime(int finishtime) {
        this.finishtime = finishtime;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setRemainingProcessTime(int remainingProcessTime) {
        RemainingProcessTime = remainingProcessTime;
    }

    public void setTimeWaiting(int timeWaiting) {
        this.timeWaiting = timeWaiting;
    }

    public void setTurnaround(int turnaround) {
        this.turnaround = turnaround;
    }

    public int getBurst() {
        return burst;
    }

    public int getArrival() {
        return arrival;
    }

    public int getExecutionTime() {
        return executionTime;
    }

    public int getFinishtime() {
        return finishtime;
    }

    public int getRemainingProcessTime() {
        return RemainingProcessTime;
    }

    public int getTimeWaiting() {
        return timeWaiting;
    }

    public int getTurnaround() {
        return turnaround;
    }

    public String getColor() {
        return color;
    }

    public String getname() {
        return name;
    }



    public SRTF(String n, String c, int a, int b){
        name = n;
        color = c;
        arrival = a;
        burst = b;
        RemainingProcessTime = b;
        contextTime = 0 ;
    }
    public static void printProcessInfo(List<SRTF> SRTF) {
        Set<String> processedNames = new HashSet<>();
        for (SRTF process : SRTF) {
            if (processedNames.add(process.name)) {
                System.out.println("Process Name: " + process.name);
                System.out.println("Waiting Time: " + process.timeWaiting);
                System.out.println("Turnaround Time: " + process.turnaround);
                System.out.println();
            }
        }
    }
    public static double Avg(List<SRTF> SRTF, int choice) {
        double time = 0;
        double size = SRTF.size();
        Set<String> processedNames = new HashSet<>();
        for (SRTF process : SRTF) {
            if (processedNames.add(process.name)) {
                switch (choice) {
                    case 1:
                        time += process.turnaround;
                        break;
                    case 2:
                        time += process.timeWaiting;
                        break;
                    default:
                        throw new IllegalStateException("Unexpected value: " + choice);
                }
            }
        }
        return time / processedNames.size();
    }
    public static SRTF FindMin(List<SRTF> temp, int currentTime) {
        SRTF minProcess = null;
        for (SRTF process : temp) {
            if (process.arrival <= currentTime && (minProcess == null || process.RemainingProcessTime < minProcess.RemainingProcessTime)) {
                minProcess = process;
            } else if (process.arrival <= currentTime && minProcess != null && process.RemainingProcessTime == minProcess.RemainingProcessTime
                    && process.timeWaiting > minProcess.timeWaiting) {
                // Aging: If two processes have the same remaining time, prioritize the one with higher waiting time
                minProcess = process;
            }
        }
        return minProcess;
    }

    public static boolean appearsTwice(SRTF targetProcess, List<SRTF> temp) {
        int count = 0;
        for (SRTF process : temp) {
            if (process.name.equals(targetProcess.name)) {
                count++;
                if (count > 1) {
                    return true;
                }
            }
        }
        return false;
    }
    public static void CalculateWaitingTime(List<SRTF> SRTF_schedule,int Ftime){
        for(int i=0;i<SRTF_schedule.size();i++){
            if(!appearsTwice(SRTF_schedule.get(i),SRTF_schedule) && i!= SRTF_schedule.size()-1 ) {
                SRTF_schedule.get(i).timeWaiting = SRTF_schedule.get(i+1).executionTime -(SRTF_schedule.get(i).arrival+SRTF_schedule.get(i).burst);
            }else if(i == SRTF_schedule.size()-1){
                SRTF_schedule.get(i).timeWaiting = Ftime -(SRTF_schedule.get(i).arrival+SRTF_schedule.get(i).burst);
            }else{
                SRTF_schedule.get(i).timeWaiting = SRTF_schedule.get(i).finishtime -(SRTF_schedule.get(i).arrival+SRTF_schedule.get(i).burst);
            }
        }
    }
    public static void CalculateTurnaroundTime(List<SRTF> SRTF_schedule,int finaltime){
        for(int i=0;i<SRTF_schedule.size();i++){
            if( i!= SRTF_schedule.size()-1){
                SRTF_schedule.get(i).turnaround = SRTF_schedule.get(i).finishtime - SRTF_schedule.get(i).arrival;
            }else {
                SRTF_schedule.get(i).turnaround = finaltime - SRTF_schedule.get(i).arrival;
            }

        }
    }
    public static void removeIfZero(List<SRTF> temp) {
        Iterator<SRTF> iterator = temp.iterator();
        while (iterator.hasNext()) {
            SRTF process = iterator.next();
            if (process.RemainingProcessTime == 0) {
                iterator.remove();
            }
        }
    }

   public static List<SRTF> SRTFschedule(List<SRTF> P,int context){
       int size = P.size();
       List<SRTF> temp = new ArrayList<>(P);
       int size1 = temp.size();
       List<SRTF> SRTF_Schedule = new ArrayList<>();
       int ii=0;
       int fulltime=0;
       List<Integer> gui = new ArrayList<>();
       // get full time of all processes
       while (ii < P.size()) {
           if (ii == P.size() - 1) {
               fulltime += P.get(ii).burst;
           } else {
               fulltime += P.get(ii).burst + context;
           }
           ii++;
       }
       int timer = 0;
       Collections.sort(temp, (a1,a2)-> Integer.compare(a1.arrival, a2.arrival));
       // add first process
       int currentTime = 0;
       SRTF curr = temp.get(0);
       SRTF_Schedule.add(curr);
       SRTF_Schedule.get(0).executionTime = currentTime;
       gui.add(currentTime);
       int i =0;
       while(timer < fulltime){
           SRTF_Schedule.get(i).RemainingProcessTime--;
           currentTime++;
           if(SRTF_Schedule.get(i).RemainingProcessTime ==0){
               removeIfZero(temp);
           }
           SRTF MIN;
           MIN = FindMin(temp,currentTime);

           if(MIN != null && MIN.arrival <= currentTime){
               if(SRTF_Schedule.get(i).RemainingProcessTime == 0){
                   gui.add(currentTime);
                   SRTF_Schedule.get(i).finishtime = currentTime;
                   curr = MIN;
                   SRTF_Schedule.add(curr);
                   i++;
                   SRTF_Schedule.get(i).executionTime = currentTime;
               }
               if(SRTF_Schedule.get(i).RemainingProcessTime > MIN.RemainingProcessTime){
                   gui.add(currentTime);
                   SRTF_Schedule.get(i).finishtime = currentTime;
                   curr = MIN;
                   SRTF_Schedule.add(curr);
                   i++;
                   SRTF_Schedule.get(i).executionTime = currentTime;
               }
           }

           timer++;
       }
       CalculateWaitingTime(SRTF_Schedule,currentTime);
       CalculateTurnaroundTime(SRTF_Schedule,currentTime);
       gui.add(currentTime);
       return SRTF_Schedule;
   }
}