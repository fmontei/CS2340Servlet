package model;

import java.util.HashMap;
import java.util.Map;

public class Attributes {
    public static final String CURRENT_USER = "currentUser";
    private static Map<String, String> map = new HashMap<String, String>();

    public static String getAttribute(String attribute) {
        String found = map.get(attribute);
        return found;
    }

    public static void storeAttribute(String attribute, String value) {
        map.put(attribute, value);
    }

    public static void removeAttribute(String attribute) {
        map.remove(attribute);
    }
}
