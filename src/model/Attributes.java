package model;

import java.util.HashMap;
import java.util.Map;

public class Attributes {
    public static final String CURRENT_USER = "currentUser";
    private static Map<String, String> map = new HashMap<String, String>();

    public static String getAttribute(String attribute) {
        String value = map.get(attribute);
        return value;
    }

    public static void putAttribute(String attribute, String value) {
        map.put(attribute, value);
    }
}
