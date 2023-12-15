<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>CPU Schedule</title>
    <style>

        body {
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .button {
            background-color: #04AA6D; /* Green */
            border: none;
            color: white;
            padding: 16px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            transition-duration: 0.4s;
            cursor: pointer;
            align-self: center; /* Center the button */
            width: 100%;

        }
        .button2 {
            background-color: white;
            color: black;
            border: 2px solid #008CBA;
        }
        .button2:hover {
            background-color: #008CBA;
            color: white;
        }
        h1 {
            color: #008CBA;
            margin-bottom: 50px;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #f2f2f2;
            padding: 100px;
            border-radius: 20px;
        }
        input[type=number], select {
            width: 100%;
            padding: 12px 20px;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 50px;
        }

    </style>

</head>
<body>
<br/>


<div class="container">
    <h1>CPU Scheduler</h1>

<form method="post" action="hello-servlet">
    <label for="numberOfDevices">Number of Devices</label>
    <input type="number" id="numberOfDevices" name="numberOfDevices" placeholder="Enter number of devices"  min="1">
    <button class="button button2" type="submit">Confirm</button>
</form>
</div>



</body>
</html>
