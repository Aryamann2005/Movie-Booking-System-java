package com.moviebooking.utils;

import java.io.File;
import java.util.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.*;

public class SeatXMLReader {

    private static Map<String, Map<String, Map<String, Map<String, String>>>> seatData = new HashMap<>();

    public static void loadXML(String filePath) {
        try {
            File xmlFile = new File(filePath);

            if (!xmlFile.exists()) {
                System.out.println("❌ seats.xml not found at: " + xmlFile.getAbsolutePath());
                return;
            }

            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlFile);
            doc.getDocumentElement().normalize();

            NodeList movieList = doc.getElementsByTagName("movie");

            for (int i = 0; i < movieList.getLength(); i++) {
                Element movieElement = (Element) movieList.item(i);
                String movieName = movieElement.getAttribute("name");

                Map<String, Map<String, Map<String, String>>> showsMap = new LinkedHashMap<>();

                NodeList showList = movieElement.getElementsByTagName("showtime");

                for (int j = 0; j < showList.getLength(); j++) {
                    Element showElement = (Element) showList.item(j);
                    String showTime = showElement.getAttribute("time");

                    Map<String, Map<String, String>> seatTypes = new LinkedHashMap<>();

                    String seatsText = showElement.getElementsByTagName("seats").item(0).getTextContent().trim();
                    String[] sections = seatsText.split(",");

                    for (String section : sections) {
                        section = section.trim();
                        if (section.isEmpty()) continue;

                        String[] parts = section.split(":");
                        String type = parts[0].trim();
                        String[] seats = Arrays.copyOfRange(parts, 1, parts.length);

                        Map<String, String> seatMap = new LinkedHashMap<>();

                        for (String seat : seats) {
                            String seatId = seat.trim();
                            if (!seatId.isEmpty()) {
                                seatMap.put(seatId, "available");
                            }
                        }

                        seatTypes.put(type, seatMap);
                    }

                    showsMap.put(showTime, seatTypes);
                }

                seatData.put(movieName, showsMap);
            }

            System.out.println("✅ Seat data loaded successfully for movies: " + seatData.keySet());

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("⚠️ Error loading seats.xml: " + e.getMessage());
        }
    }

    public static Map<String, Map<String, Map<String, Map<String, String>>>> getSeatData() {
        return seatData;
    }
}
