package model;

import database.Place;

import java.util.Comparator;

public class EventCreationDateComparator implements Comparator<Place> {
    @Override
    public int compare(Place p, Place q) {
        if (p.getCreationDate().before(q.getCreationDate())) {
            return -1;
        } else if (p.getCreationDate().after(q.getCreationDate())) {
            return 1;
        } else {
            return 0;
        }
    }
}
