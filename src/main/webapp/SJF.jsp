<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Priority.Priority" %>
<%@ page import="SJF.SJF" %>

<%
    Integer numberOfDevices = (Integer) request.getAttribute("numberOfDevices");
    numberOfDevices = 4; // You can change this as needed

    if (numberOfDevices != null) {
        ArrayList<SJF> sjfList = new ArrayList<>();

        for (int i = 1; i <= numberOfDevices; i++) {
            String deviceName = request.getParameter("deviceName" + i);
            int deviceArrival = Integer.parseInt(request.getParameter("deviceArrival" + i));
            int deviceBurst = Integer.parseInt(request.getParameter("deviceBurst" + i));

            SJF sjf = new SJF(deviceName, "color", deviceArrival, deviceBurst);
            sjfList.add(sjf);
        }

        ArrayList<SJF> executedSJFList = SJF.SJFschedule(sjfList, 0, 1000);
        double sumOfWaiting = 0;

        for (SJF sjf : executedSJFList) {
            System.out.println(sjf.name + " : " + sjf.executionTime);
            sumOfWaiting += sjf.timeWaiting;
        }

        double averageWaitingTime = SJF.Avg(executedSJFList, 2);

        // Set attributes to be used in the result JSP
        request.setAttribute("executedSJFList", executedSJFList);
        request.setAttribute("averageWaitingTime", averageWaitingTime);

        // Forward to the result JSP
        request.getRequestDispatcher("/SJFResults.jsp").forward(request, response);
    } else {
%>
<html></html>
<p>Process device error.</p>
<%
    }
%>
