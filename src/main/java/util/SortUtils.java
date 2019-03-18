package util;

import java.util.ArrayList;

public class SortUtils {

    public static void selectionSort(int array[]) {
        int i, j, greaterPosition;
        for (i = 0; i < array.length; i++) {
            greaterPosition = 0;
            for (j = 0; j < array.length - i; j++) {
                if (array[greaterPosition] < array[j]) {
                    greaterPosition = j;
                }
            }
            int temp = array[array.length - i - 1];
            array[array.length - i - 1] = array[greaterPosition];
            array[greaterPosition] = temp;
        }
    }

    public static void selectionSort(ArrayList<ArrayList<String>> array) {
        int i, j, greaterPosition;
        for (i = 0; i < array.size(); i++) {
            greaterPosition = 0;
            for (j = 0; j < array.size() - i; j++) {
                if (array.get(greaterPosition).get(1).compareTo(array.get(j).get(1)) < 0) {
                    greaterPosition = j;
                }
            }
            ArrayList<String> temp = array.get(array.size() - i - 1);
            array.set(array.size() - i - 1, array.get(greaterPosition));
            array.set(greaterPosition, temp);
        }
    }


}