<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Priority.Priority" %>
<%@ page import="java.util.List" %>

<%
    // Retrieve parameters from the request
    List<Priority> prioritizedList = (List<Priority>) request.getAttribute("prioritizedList");
    double averageWaitingTime = (Double) request.getAttribute("averageWaitingTime");
    double averageTurnAroundTime = (Double) request.getAttribute("averageTurnAroundTime");

%>

<html>
<head>
    <title>Priority Results</title>

    <style>
        .flex-container {
            display: flex;
            background-color: #008CBA;
        }
        .flex-container > div {
            background-color: #f1f1f1;
            margin: 10px;
            padding: 20px;
            font-size: 40px;
        }
        .container{
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #f2f2f2;
            padding: 30px;
            border-radius: 20px;
        }

        body {
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

    /*add the results in a box */
    .results{

            position: relative;
            border: 1px solid black; /* Optional: Add a border for visibility */

    }

        /*add the start time of each process*/
        .bottom-left {
            font-weight: bold;
            font-size: 10px;
            position: absolute;
            bottom: 0;
            left: 0;
            margin: 5px; /* Optional: Add some margin for spacing */
        }
    </style>

</head>
<body>

<%-- Display the results --%>
<div class="container">
    <h1>Priority Results</h1>

    <div class="flex-container">

<% for (Priority p : prioritizedList) { %>

    <div class="results"><%= p.name %>
        <p class="bottom-left"> <%= p.startTime %>  </p>
        <p class="results"> <%= p.timeWaiting %>  </p>
        <p class="results"> <%= p.turnaround %>  </p>


    </div>
    <% } %>


</div>
    <h2>Average waiting time: <%= averageWaitingTime %></h2>
    <h2>Average Turn Around time: <%= averageTurnAroundTime %></h2>

</div>


<%-- Display the console output on the page --%>

</body>
</html>
