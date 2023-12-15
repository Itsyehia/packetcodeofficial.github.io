<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Priority.Priority" %>
<%@ page import="SRTF.SRTF" %>
<%@ page import="java.util.List" %>

<%
    Integer numberOfDevices = (Integer) request.getAttribute("numberOfDevices");
    numberOfDevices = 4; // You can change this as needed

    if (numberOfDevices != null) {
        List<SRTF> processes = new ArrayList<>();

        for (int i = 1; i <= numberOfDevices; i++) {
            String deviceName = request.getParameter("deviceName" + i);
            int deviceArrival = Integer.parseInt(request.getParameter("deviceArrival" + i));
            int deviceBurst = Integer.parseInt(request.getParameter("deviceBurst" + i));

            SRTF s = new SRTF(deviceName, "color", deviceArrival, deviceBurst);
            processes.add(s);
        }

        List<SRTF> schedule = new ArrayList<>(SRTF.SRTFschedule(processes,0));
        double sumOfWaiting = 0;

        for (SRTF srtf : schedule) {
            System.out.println(srtf.name + " : " + srtf.executionTime);
            sumOfWaiting += srtf.timeWaiting;
        }
        SRTF.printProcessInfo(schedule);

        double averageWaitingTime = SRTF.Avg(schedule, 2);
        double averageTurnAroundTime = SRTF.Avg(schedule, 1);

        System.out.println("The average turnaround time is: " + SRTF.Avg(schedule, 1));
        System.out.println("The average waiting time is: " + SRTF.Avg(schedule, 2));


        // Set attributes to be used in the result JSP
        request.setAttribute("executedSJFList", schedule);
        request.setAttribute("averageWaitingTime", averageWaitingTime);
        request.setAttribute("averageTurnAroundTime", averageTurnAroundTime);

        // Forward to the result JSP
        request.getRequestDispatcher("/SRTFResults.jsp").forward(request, response);
    } else {
%>

<html></html>
<p>Process device error.</p>
<%
    }
%>