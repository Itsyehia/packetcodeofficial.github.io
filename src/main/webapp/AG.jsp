<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 12/15/2023
  Time: 4:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Priority.Priority" %>
<%@ page import="AG.AG" %>
<%@ page import="java.util.Random" %>



<%




            AG ag = new AG();

            Integer numberOfDevices = (Integer) request.getAttribute("numberOfDevices");
            numberOfDevices =4;
            ag.numberOfProcess =numberOfDevices;

    for(
            int i = 1;
            i <=numberOfDevices;i++)

            {
                String deviceName = request.getParameter("deviceName" + i);
                int deviceArrival = Integer.parseInt(request.getParameter("deviceArrival" + i));
                int deviceBurst = Integer.parseInt(request.getParameter("deviceBurst" + i));
                int devicePriority = Integer.parseInt(request.getParameter("devicePriority" + i));
                int deviceQuantum = Integer.parseInt(request.getParameter("deviceQuantum" + i));

                Random random = new Random();
                int deviceRandomNumber = random.nextInt(21);

                AG.processes.add(deviceName);
                AG.burstTime.add(deviceBurst);
                AG.arrivalTime.add(deviceArrival);
                AG.priority.add(devicePriority);
                AG.quantum.add(deviceQuantum);
                AG.randomNumber.add(deviceRandomNumber);

            }
            ag.AGSchedule();
            ag.calculateAverageTurnAroundTime();
            ag.calculateAverageWaitingTime();
            // ag.calculateAverageTurnAroundTime();
            //   ag.calculateAverageWaitingTime();
//    for (int index = 0; index < AG.excOrder.size() - 1; index++) {
            //  System.out.print(AG.excOrder.get(index) + " ");
            //}


            // for (int i = 0; i < numberOfDevices; i++) {
            //   System.out.println("turn around time for p" + (i + 1) + ": " + ag.getTurnAroundTime().get(i));
            // System.out.println("wait time for p" + (i + 1) + ": " + ag.waitTime.get(i));
            // }
            // System.out.println("average turn around time: " + ag.getAverageTurnaroundTime());
            // System.out.println("average waiting time: " + ag.getAverageWaitingTime());
    request.setAttribute("waitTime",ag.turnAroundTime);
    request.setAttribute("TRT",ag.waitTime);

    request.setAttribute("averageTurnAroundTime",ag.averageTurnaroundTime);
    request.setAttribute("averageWaitingTime",ag.averageWaitingTime);
    request.setAttribute("excOrder",AG.excOrder);

    request.getRequestDispatcher("/AGResutls.jsp").

            forward(request, response);

%>

<html>
<head>
    <title>AG Schedule</title>
</head>
<body>







</body>
</html>
