package com.techtide.helpers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import javax.servlet.http.Part;

public class Image {

//    Deletion of old profile pic
    public static boolean deleteOldImage(String path) {
        boolean f = false;
        try {
            
            
            if ("D:\\GitHubProjects\\TechTide\\TechTide\\build\\web\\profile\\default.png".equals(path)) {
                f = true;
            } else {
                System.out.println(path);
                File file = new File(path);
                f = file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

//    Saving new profile pic
    public static boolean saveNewImage(String path, Part part) {
        boolean f = false;
        try {
            InputStream is = part.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            FileOutputStream fos = new FileOutputStream(path);
            fos.write(data);

            is.close();
            fos.close();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

}
