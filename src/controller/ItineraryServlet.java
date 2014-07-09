package controller;

import database.DataManager;
import database.Place;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ItineraryServlet", urlPatterns = { "/itinerary" })
public class ItineraryServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (request.getQueryString().contains("create_event=")) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.createNewEvents();
        } else if (lodgingSearchRequested(request)) {
            doLodgingSearchRequest(request, response);
        } else if (moreLodgingResultsRequested(request)) {
            doGetMoreLodgingResults(request, response);
        } else if (lodgingSelectionMade(request)) {
            new LodgingForm(request, response).saveLodgingSelection();
        } else if (detailedGoogleSearchRequested(request)) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.getDetailedInformationForPlace(true);
        } else if (eventSelectionMade(request)) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.saveSelection();
        } else if (deleteEventRequested(request)) {
            doEventDeleteRequest(request, response);
        } else if (sortEventsRequested(request)) {
            doSortEventsRequest(request, response);
        } else {
            response.sendRedirect("jsp/itinerary_overview.jsp");
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        if (newItineraryCreationRequested(request)) {
            new CreateItineraryForm(request);
            response.sendRedirect("jsp/itinerary_overview.jsp");
        } else if (itineraryDeleteRequested(request)) {
            doDeleteItineraryRequest(request);
            response.sendRedirect("jsp/itinerary_overview.jsp");
        } else if (userRequestedEventSearch(request)) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.getEventsAroundCentralLocation();
        } else if (textSearchRequested(request)) {
            doSearchRequest(request, response);
        } else if (removeTemporaryPlaceRequested(request)) {
            doRemovePlaceRequest(request, response);
        } else if (setLodgingTimeRequested(request)) {
            LodgingForm lodgingForm = new LodgingForm(request, response);
            lodgingForm.setLodgingTime();
        } else if (setEventTimeRequested(request)) {
            EventForm eventForm = new EventForm(request, response);
            eventForm.setEventTime();
        }
    }

    private boolean lodgingSearchRequested(HttpServletRequest request) {
        return request.getParameter("lodgingSubmitButton") != null;
    }

    private void doLodgingSearchRequest(HttpServletRequest request,
                                        HttpServletResponse response)
        throws IOException {
        new LodgingForm(request, response).getLodgingsAroundLocation();
        response.sendRedirect("jsp/index.jsp");
    }

    private boolean moreLodgingResultsRequested(HttpServletRequest request) {
        return request.getParameter("lodgingGetMoreResults") != null;
    }

    private void doGetMoreLodgingResults(HttpServletRequest request,
                                         HttpServletResponse response)
            throws IOException {
        new LodgingForm(request, response).getMoreLodgingResults();
        response.sendRedirect("jsp/index.jsp");
    }

    private boolean lodgingSelectionMade(HttpServletRequest request) {
        return request.getQueryString().contains("lodging_id=");
    }

    private boolean detailedGoogleSearchRequested(HttpServletRequest request) {
        return request.getQueryString() != null &&
                request.getQueryString().contains("detail_search");
    }

    private boolean newItineraryCreationRequested(HttpServletRequest request) {
        return request.getParameter("createItineraryButton") != null;
    }

    private boolean itineraryDeleteRequested(HttpServletRequest request) {
        return request.getParameter("deleteItinerary") != null;
    }

    private void doDeleteItineraryRequest(HttpServletRequest request) {
        try {
            String itineraryID = request.getParameter("deleteItinerary");
            DataManager.deleteItinerary(itineraryID);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private boolean removeTemporaryPlaceRequested(HttpServletRequest request) {
        return request.getQueryString() != null &&
                request.getQueryString().contains("remove_place_id");
    }

    private void doRemovePlaceRequest(HttpServletRequest request,
                                      HttpServletResponse response)
            throws IOException {
        final HttpSession session = request.getSession();
        List<Place> events = (List) session.getAttribute("events");
        final String queryString = request.getQueryString();
        final int beginIndex = queryString.lastIndexOf("=") + 1;
        final int eventID = Integer.parseInt(queryString.substring(beginIndex));
        events.remove(eventID);
        session.setAttribute("events", events);
        session.removeAttribute("businesses" + eventID);
        session.removeAttribute("apiSearchError" + eventID);
        response.sendRedirect("jsp/index.jsp");
    }

    private boolean userRequestedEventSearch(HttpServletRequest request) {
        return request.getParameter("getEventsWithGoogleButton") != null ||
                request.getParameter("getEventsWithYelpButton") != null;
    }

    private boolean eventSelectionMade(HttpServletRequest request) {
        return request.getQueryString() != null &&
                request.getQueryString().contains("select_business");
    }

    private boolean deleteEventRequested(final HttpServletRequest request) {
        return request.getQueryString() != null &&
                request.getQueryString().contains("delete_event");
    }

    private void doEventDeleteRequest(final HttpServletRequest request,
                                      final HttpServletResponse response)
        throws IOException {
        final EventForm eventForm = new EventForm(request, response);
        eventForm.deleteRequestedEvent();
    }

    private boolean sortEventsRequested(final HttpServletRequest request) {
        return request.getQueryString() != null &&
                request.getQueryString().contains("sort");
    }

    private void doSortEventsRequest(final HttpServletRequest request,
                                        final HttpServletResponse response)
        throws IOException {
        final EventSorter eventSorter = new EventSorter(request, response);
        eventSorter.sort();
    }

    private boolean setLodgingTimeRequested(final HttpServletRequest request) {
        return request.getParameter("lodgingDateTimeSubmit") != null;
    }

    private boolean setEventTimeRequested(final HttpServletRequest request) {
        return request.getParameter("eventDateTimeSubmit") != null;
    }

    private boolean textSearchRequested(HttpServletRequest request) {
        return request.getParameter("google-textsearch-submit") != null ||
                request.getParameter("collapse-textsearch-submit") != null;
    }

    private void doSearchRequest(HttpServletRequest request,
                                 HttpServletResponse response)
            throws IOException {
        String query;
        if (textSearchIssuedFromMainConsole(request)) {
            EventForm eventForm = new EventForm(request, response);
            final String eventID = eventForm.parseEventIDFromQueryString();
            query = request.getParameter("collapse-textsearch-query");
            List<Place> results = tryGoogleTextSearch(request, response, query);
            request.getSession().setAttribute("businesses" + eventID, results);
            request.getSession().setAttribute("eventQueryString" + eventID,
                    "Keyword = '" + query + "'.");
            request.getSession().removeAttribute("apiSearchError" + eventID);
            response.sendRedirect("jsp/index.jsp?event_no=" + eventID);
        } else {
            query = request.getParameter("google-textsearch-query");
            List<Place> results = tryGoogleTextSearch(request, response, query);
            request.getSession().setAttribute("textSearchResults", results);
            response.sendRedirect("jsp/index.jsp");
        }
    }

    private boolean textSearchIssuedFromMainConsole(HttpServletRequest request) {
        return request.getQueryString() != null &&
                request.getQueryString().contains("event_id");
    }

    private List<Place> tryGoogleTextSearch(HttpServletRequest request,
                                     HttpServletResponse response,
                                     final String query) {
        List<Place> results = new ArrayList<Place>();
        try {
            GooglePlaceAPI googleSearch = new GooglePlaceAPI();
            results = googleSearch.getByTextSearch(query);
        } catch (Exception ex) {
            BrowserErrorHandling.printErrorToBrowser(request, response, ex);
        } finally {
            return results;
        }
    }
}