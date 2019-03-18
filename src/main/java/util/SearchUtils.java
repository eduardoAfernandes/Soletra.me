package util;

public class SearchUtils {

    public static void main(String[] args) {
//        int[] teste = new int[6];
//        teste[0] = 6;
//        teste[1] = 5;
//        teste[2] = 4;
//        teste[3] = 3;
//        teste[4] = 2;
//        teste[5] = 1;
//
//        System.out.println(binarySearch(teste, 1, false));
//
//
//        int[] teste2 = new int[6];
//        teste2[0] = 1;
//        teste2[1] = 2;
//        teste2[2] = 3;
//        teste2[3] = 4;
//        teste2[4] = 5;
//        teste2[5] = 6;
//
//        System.out.println(binarySearch(teste2, 1));
//
//        String[] teste3 = new String[6];
//        teste3[0] = "a";
//        teste3[1] = "b";
//        teste3[2] = "c";
//        teste3[3] = "d";
//        teste3[4] = "e";
//        teste3[5] = "f";
//
//        System.out.println(binarySearch(teste3, "a"));
//
//        String[] teste4 = new String[6];
//        teste4[0] = "f";
//        teste4[1] = "e";
//        teste4[2] = "d";
//        teste4[3] = "c";
//        teste4[4] = "b";
//        teste4[5] = "a";
//
//        System.out.println(binarySearch(teste4, "a", false));
    }

    //Binary Search Desc Feita por Sotero com Recursividade.
    private static int binarySearch(int vet[], int key, int start, int end, boolean asc) {

        int mid;
        int response = -1;

        if (start <= end) {
            mid = (start+end) / 2;
            if (vet[mid] == key) {
                return mid;
            }

            if (vet[mid] > key && asc) {
                end = mid - 1;
            } else if (vet[mid] < key && !asc) {
                end = mid - 1;
            } else {
                start = mid + 1;
            }

            response = binarySearch(vet, key, start, end, asc);

        }

        return response;

    }

    private static int binarySearch(String vet[], String key, int start, int end, boolean asc) {

        int mid;
        int response = -1;

        if (start <= end) {
            mid = (start+end) / 2;
            if (vet[mid].equals(key)) {
                return mid;
            }

            if (vet[mid].compareTo(key) > 0 && asc) {
                end = mid - 1;
            } else if (vet[mid].compareTo(key) < 0 && !asc) {
                end = mid - 1;
            } else {
                start = mid + 1;
            }

            response = binarySearch(vet, key, start, end, asc);

        }
        //System.out.println(response);
        return response;

    }

    public static int binarySearch(int vet[], int key) {
        return binarySearch(vet, key, 0, vet.length - 1, true);
    }

    public static int binarySearch(int vet[], int key, boolean asc) {
        return binarySearch(vet, key, 0, vet.length - 1, asc);
    }

    public static int binarySearch(String vet[], String key) {
        return binarySearch(vet, key, 0, vet.length - 1, true);
    }

    public static int binarySearch(String vet[], String key, boolean asc) {
        return binarySearch(vet, key, 0, vet.length - 1, asc);
    }


}
