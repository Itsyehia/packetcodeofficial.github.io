<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Priority.Priority" %>

<%
    Integer numberOfDevices = (Integer) request.getAttribute("numberOfDevices");
    numberOfDevices= 5 ;
    if (numberOfDevices != null) {
        ArrayList<Priority> priorities = new ArrayList<>();

        for (int i = 1; i <= numberOfDevices; i++) {
            String deviceName = request.getParameter("deviceName" + i);
            int devicePriority = Integer.parseInt(request.getParameter("devicePriority" + i));
            int deviceBurst = Integer.parseInt(request.getParameter("deviceBurst" + i));

            Priority p = new Priority(deviceName, devicePriority, 0, deviceBurst, numberOfDevices);
            priorities.add(p);
        }

        ArrayList<Priority> prioritizedList = Priority.prioritize(priorities);
        double sumOfWaiting = 0;
        double sumOfTurnAround = 0;

        for (Priority p : prioritizedList) {
            System.out.println(p.name + " : " + p.startTime );
            sumOfWaiting += p.timeWaiting;
            sumOfTurnAround += p.turnaround;
        }

        double averageWaitingTime = sumOfWaiting / numberOfDevices;
        double averageTurnAroundTime = sumOfTurnAround / numberOfDevices;

        // Set attributes to be used in the result JSP
        request.setAttribute("prioritizedList", prioritizedList);
        request.setAttribute("averageWaitingTime", averageWaitingTime);
        request.setAttribute("averageTurnAroundTime", averageTurnAroundTime);

        // Forward to the result JSP
        request.getRequestDispatcher("/priorityResults.jsp").forward(request, response);
    } else {
%>
<html></html>
<p>Process device error.</p>
<%
    }
%>
