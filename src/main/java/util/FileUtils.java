package util;

import java.awt.font.TextHitInfo;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Arrays;

public class FileUtils {

    private String fullPathOfFile;
    private ArrayList<ArrayList<String>> fileContent = new ArrayList<>();

    public FileUtils(String fullPathOfFile) {
        this.fullPathOfFile = fullPathOfFile;
    }

    public String getCaminhoDir() {
        return fullPathOfFile;
    }

    public void addFileContent(ArrayList<String> fileContent) {
        this.fileContent.add(fileContent);
    }

    public ArrayList<ArrayList<String>> getFileContent(String delimitator) {
        readFile(delimitator);
        return fileContent;
    }

    private void readFile(String delimitator) {

        File f = new File(getCaminhoDir());
        FileReader reader;
        try {
            reader = new FileReader(f);
            BufferedReader bf = new BufferedReader(reader);
            String row = "";
            while ((row = bf.readLine()) != null) {
                addFileContent(new ArrayList<>(Arrays.asList(row.split(delimitator))));
            }
            reader.close();
            bf.close();
        } catch (Exception ex) {
            System.out.println("Não foi possível ler no arquivo.");
            System.out.println(ex.getMessage());
            ex.fillInStackTrace();
            System.out.println(getCaminhoDir());
        }
    }

    public void writeFile(String text, Boolean append) {
        try {
            File f = new File(fullPathOfFile);
            FileWriter imp = new FileWriter(f, append);
            imp.write(text + "\n");
            imp.close();

        } catch (Exception e) {
            System.out.println("Nao poi possível escrever o arquivo.");
        }
    }

}