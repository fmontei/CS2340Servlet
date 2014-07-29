package model;

import java.util.List;
import java.util.Random;

public class PasswordGenerator {

    public static String generatePassword(int strLength, List<Character> possibleCharacters) {
        if(strLength < 1){
            throw new IllegalArgumentException("strLength must a positive values.");
        }
        else if(possibleCharacters.size() < 1){
            throw new IllegalArgumentException("possibleCharacters must not be empty.");
        }
        else{
            Random rand = new Random();
            String pw = "";
            for(int i = 0; i < strLength; i++){
                int randomNum = rand.nextInt(possibleCharacters.size());
                pw = pw + possibleCharacters.get(randomNum);
            }
            return pw;
        }
    }
}
