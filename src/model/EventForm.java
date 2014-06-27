package model;

import database.Event;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class EventForm {
    private HttpServletRequest request;

    public EventForm(HttpServletRequest request) {
        this.request = request;
    }

    public void createNewEvents() {
        final HttpSession session = request.getSession();
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        final String numberOfEvents = queryString.substring(startIndex);
        List<Event> events = new ArrayList<Event>();
        if (session.getAttribute("events") != null) {
            events = (ArrayList<Event>) session.getAttribute("events");
        }
        for (int i = 0; i < Integer.parseInt(numberOfEvents); i++) {
            events.add(new Event());
        }
        session.setAttribute("events", events);
    }

    public int updateEvent() {
        final String queryString = request.getQueryString();
        final int startIndex = queryString.indexOf("=") + 1;
        String eventID = queryString.substring(startIndex);
        return Integer.parseInt(eventID);
    }
}
