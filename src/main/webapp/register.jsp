<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Priority.Priority" %>


<style>

    body {
        margin: 0;
        height: auto;
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
        padding: 40px;
        width: 500px;
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
    input[type=text], select {
        width: 100%;
        padding: 12px 20px;
        display: inline-block;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        margin-bottom: 50px;
    }

</style>

<script>
    function generateForm(action, inputFields) {
        document.getElementById('formsContainer').innerHTML = '';

        // Generate new form
        var form = document.createElement('form');
        form.method = 'post';
        form.action = action;

        for (var i = 1; i <= inputFields; i++) {
            var label = document.createElement('label');
            label.htmlFor = 'deviceName' + i;
            label.appendChild(document.createTextNode('Device ' + i + ' Name:'));
            form.appendChild(label);

            var inputName = document.createElement('input');
            inputName.type = 'text';
            inputName.id = 'deviceName' + i;
            inputName.name = 'deviceName' + i;
            inputName.required = true;
            form.appendChild(inputName);

            var labelBurst = document.createElement('label');
            labelBurst.htmlFor = 'deviceBurst' + i;
            labelBurst.appendChild(document.createTextNode('Device ' + i + ' Burst:'));
            form.appendChild(labelBurst);

            var inputBurst = document.createElement('input');
            inputBurst.type = 'number';
            inputBurst.id = 'deviceBurst' + i;
            inputBurst.name = 'deviceBurst' + i;
            inputBurst.required = true;
            form.appendChild(inputBurst);

            // Add additional fields based on the scenario (e.g., Priority, Arrival Time)
            if (action === 'process-device.jsp') {
                var labelPriority = document.createElement('label');
                labelPriority.htmlFor = 'devicePriority' + i;
                labelPriority.appendChild(document.createTextNode('Device ' + i + ' Priority:'));
                form.appendChild(labelPriority);

                var inputPriority = document.createElement('input');
                inputPriority.type = 'number';
                inputPriority.id = 'devicePriority' + i;
                inputPriority.name = 'devicePriority' + i;
                inputPriority.required = true;
                form.appendChild(inputPriority);
            }
            else if (action === 'SRTF.jsp') {
                var labelArrival = document.createElement('label');
                labelArrival.htmlFor = 'deviceArrival' + i;
                labelArrival.appendChild(document.createTextNode('Device ' + i + ' Arrival:'));
                form.appendChild(labelArrival);

                var inputArrival = document.createElement('input');
                inputArrival.type = 'number';
                inputArrival.id = 'deviceArrival' + i;
                inputArrival.name = 'deviceArrival' + i;
                inputArrival.required = true;
                form.appendChild(inputArrival);
            }

            else if (action === 'SJF.jsp') {
                var labelArrival = document.createElement('label');
                labelArrival.htmlFor = 'deviceArrival' + i;
                labelArrival.appendChild(document.createTextNode('Device ' + i + ' Arrival:'));
                form.appendChild(labelArrival);

                var inputArrival = document.createElement('input');
                inputArrival.type = 'number';
                inputArrival.id = 'deviceArrival' + i;
                inputArrival.name = 'deviceArrival' + i;
                inputArrival.required = true;
                form.appendChild(inputArrival);
            }
            else if (action === 'AG.jsp') {

                var labelArrival = document.createElement('label');
                labelArrival.htmlFor = 'deviceArrival' + i;
                labelArrival.appendChild(document.createTextNode('Device ' + i + ' Arrival:'));
                form.appendChild(labelArrival);

                var inputArrival = document.createElement('input');
                inputArrival.type = 'number';
                inputArrival.id = 'deviceArrival' + i;
                inputArrival.name = 'deviceArrival' + i;
                inputArrival.required = true;
                form.appendChild(inputArrival);


                var labelPriority = document.createElement('label');
                labelPriority.htmlFor = 'devicePriority' + i;
                labelPriority.appendChild(document.createTextNode('Device ' + i + ' Priority:'));
                form.appendChild(labelPriority);

                var inputPriority = document.createElement('input');
                inputPriority.type = 'number';
                inputPriority.id = 'devicePriority' + i;
                inputPriority.name = 'devicePriority' + i;
                inputPriority.required = true;
                form.appendChild(inputPriority);


                var labelQuantum = document.createElement('label');
                labelQuantum.htmlFor = 'deviceQuantum' + i;
                labelQuantum.appendChild(document.createTextNode('Device ' + i + ' Quantum:'));
                form.appendChild(labelQuantum);

                var inputQuantum= document.createElement('input');
                inputQuantum.type = 'number';
                inputQuantum.id = 'deviceQuantum' + i;
                inputQuantum.name = 'deviceQuantum' + i;
                inputQuantum.required = true;
                form.appendChild(inputQuantum);

            }

            var breakElement = document.createElement('br');
            form.appendChild(breakElement);
        }

        var submitButton = document.createElement('button');
        submitButton.type = 'submit';
        submitButton.name = 'scheduleType';
        submitButton.value = 'Submit';
        submitButton.className = 'button button2';
        submitButton.appendChild(document.createTextNode('Submit'));
        form.appendChild(submitButton);

        // Append the form to the container
        document.getElementById('formsContainer').appendChild(form);
    }
</script>


<body>
<div class="container">

<div id="formsContainer"></div>



<form id="scheduleForm" method="post" action="">

    <% // Retrieve the number of devices from the request attribute
        Integer numberOfDevices = (Integer) request.getAttribute("numberOfDevices");

        if (numberOfDevices != null) {
            for (int i = 1; i <= numberOfDevices; i++) {
    %>


    <%
        }
    %>

    <div class="btn-group">

    <button type="button" onclick="generateForm('process-device.jsp', <%= numberOfDevices %>);" name="scheduleType" value="priority" class="button button2" >Priority</button>

    <button type="button" onclick="generateForm('SJF.jsp', <%= numberOfDevices %>);" name="scheduleType" value="SJF" class="button button2" >SJF</button>

    <button type="button" onclick="generateForm('SRTF.jsp', <%= numberOfDevices %>);" name="scheduleType" value="SRTF" class="button button2" >SRTF</button>

    <button type="button" onclick="generateForm('AG.jsp', <%= numberOfDevices %>);" name="scheduleType" value="AG" class="button button2" >AG</button>

    </div>

</form>

</div>


<%
} else {
%>
<p>Please provide the number of devices to create labels.</p>
<%
    }
%>
</body>