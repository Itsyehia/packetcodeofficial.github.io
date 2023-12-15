<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 12/13/2023
  Time: 12:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AG.AG" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


<%
    // Retrieve parameters from the request
    double averageTurnAroundTime = (Double) request.getAttribute("averageTurnAroundTime");
    double averageWaitingTime = (Double) request.getAttribute("averageWaitingTime");
   ArrayList<String> excOrder = (ArrayList<String>) request.getAttribute("excOrder");
    ArrayList<Integer> trt = (ArrayList<Integer>) request.getAttribute("TRT");
    ArrayList<Integer> wt = (ArrayList<Integer>) request.getAttribute("waitTime");


%>

<html>
<head>
    <title>Title</title>



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
    <h1>AG Results</h1>

    <div class="flex-container">


        <%             double turnaround = 4 ;




           // for (int i = 0; i < 4; i++) {
              //  System.out.println("turn around time for p" + (i + 1) + ": " + averageTurnAroundTime);
              //  System.out.println("wait time for p" + (i + 1) + ": " +averageWaitingTime );
          //  }


           %>

        <% for (String process : excOrder) { %>
        <div class="results"><%= process %></div>
        <% } %>

    </div>


    <h2>waiting time </h2>
    <p>
    <% for (int i = 0; i < 4; i++) { %>
    <%= wt.get(i) %>
    <% } %>
    </p>


        <h2>TurnAround time </h2>
    <p>
    <% for (int i = 0; i < 4; i++) { %>
    <%=trt.get(i) %>
    <% } %>
    </p>

    <h2>Average waiting time: <%= averageWaitingTime %></h2>
    <h2>Average TurnAround time: <%= averageTurnAroundTime %></h2>

</div>

</body>
</html>
