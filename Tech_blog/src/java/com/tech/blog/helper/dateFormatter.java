package com.tech.blog.helper;

import java.text.SimpleDateFormat;
import java.util.Date;

public class dateFormatter {

    public static String formatPostDate(Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat("MMMM dd, yyyy hh:mm:ss a"); // Format: Month Day, Year
        return formatter.format(date);
    }
}
