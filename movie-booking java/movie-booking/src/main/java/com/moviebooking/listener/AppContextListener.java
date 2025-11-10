package com.moviebooking.listener;

import javax.servlet.*;
import com.moviebooking.utils.SeatXMLReader;

public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext context = event.getServletContext();
        String xmlPath = context.getRealPath("/WEB-INF/seats.xml");
        SeatXMLReader.loadXML(xmlPath);
        System.out.println("✅ Seat XML Loaded from: " + xmlPath);
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        System.out.println("🛑 Context Destroyed");
    }
}
