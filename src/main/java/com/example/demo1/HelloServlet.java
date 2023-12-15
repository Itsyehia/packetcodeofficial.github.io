package com.example.demo1;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        // Forward the request to register.jsp
        getServletContext().getRequestDispatcher("/register.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numberOfDevicesStr = request.getParameter("numberOfDevices");

        if (numberOfDevicesStr != null && !numberOfDevicesStr.isEmpty()) {
            try {
                int numberOfDevices = Integer.parseInt(numberOfDevicesStr);

                request.setAttribute("numberOfDevices", numberOfDevices);

                getServletContext().getRequestDispatcher("/register.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid number of devices.");
            }
        } else {
            response.getWriter().println("Please provide the number of devices error from hello .");
        }
    }

    public void destroy() {}

}
