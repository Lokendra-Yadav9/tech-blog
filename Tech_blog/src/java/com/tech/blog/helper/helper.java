package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class helper {

    public static boolean delete_profile(String path) {
        boolean f = false;
        try {
            File file = new File(path);
            f = file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public static boolean Save_newImage(InputStream is, String path) {
        boolean f = false;
        try {

            if (is.available() > 0) {
                byte[] b = new byte[is.available()];
                is.read(b);

                FileOutputStream fos = new FileOutputStream(path);
                fos.write(b);
                fos.flush();
                fos.close();
                f = true;
            } else {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
