package model;

import database.Place;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

public class EventSorter {
    private static int nameSortCount = 0;
    private static int creationDateSortCount = 0;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;

    public EventSorter(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
    }

    public void sort() throws IOException {
        final String sortType = determineSortType();
        List<Place> events = (List) session.getAttribute("events");
        if (nameSortRequested(sortType)) {
            sortByName(events);
        } else if (creationDateSortRequested(sortType)) {
            sortByCreationDate(events);
        }
        session.setAttribute("events", events);
        response.sendRedirect("jsp/index.jsp?sort=" + sortType);
    }

    private String determineSortType() {
        final String queryString = request.getQueryString();
        final int beginIndex = queryString.indexOf("=") + 1;
        final String sortType = queryString.substring(beginIndex);
        return sortType;
    }

    private boolean nameSortRequested(final String type) {
        return type.equalsIgnoreCase("name");
    }

    private void sortByName(List<Place> events) {
        if (nameSortRequestedOnce()) {
            Collections.sort(events, new EventNameComparator());
        } else {
            Collections.sort(events, Collections.reverseOrder(
                    new EventNameComparator()));
        }
        nameSortCount++;
        creationDateSortCount = 0;
    }

    private boolean nameSortRequestedOnce() {
        return nameSortCount % 2 == 0;
    }

    private boolean creationDateSortRequested(final String type) {
        return type.equalsIgnoreCase("creation_date");
    }

    private void sortByCreationDate(List<Place> events) {
        if (creationDateSortRequestedOnce()) {
            Collections.sort(events, new EventCreationDateComparator());
        } else  {
            Collections.sort(events, Collections.reverseOrder(
                    new EventCreationDateComparator()));
        }
        creationDateSortCount++;
        nameSortCount = 0;
    }

    private boolean creationDateSortRequestedOnce() {
        return creationDateSortCount % 2 == 0;
    }
}