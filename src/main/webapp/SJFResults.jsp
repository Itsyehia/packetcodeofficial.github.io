<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="SJF.SJF" %>
<%@ page import="java.util.List" %>

<%
    // Retrieve parameters from the request
    List<SJF> executedSJFList = (List<SJF>) request.getAttribute("executedSJFList");
    double averageWaitingTime = (Double) request.getAttribute("averageWaitingTime");
%>

<html>
<head>
    <title>SJF Results</title>


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
<div class="container">
<h1>SJF Results</h1>

    <div class="flex-container">


    <%             double turnaround = 0 ;

        for (SJF sjf : executedSJFList) { %>
        <div class="results">   <%= sjf.name %>  <p class="bottom-left"> <%= sjf.executionTime %>  </p>
            <p class="results"> <%= sjf.turnaround %>  </p>
            <p class="results"> <%= sjf.timeWaiting %>  </p>
        </div>
    <%  turnaround+= sjf.turnaround ; } turnaround= turnaround/4;  %>

    </div>

    <h2>Average waiting time: <%= averageWaitingTime %></h2>
    <h2>Average TurnAround time: <%= turnaround %></h2>

</div>

<%-- Display the console output on the page --%>

</body>
</html>
