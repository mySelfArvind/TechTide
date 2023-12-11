package com.techtide.helpers;

import java.sql.*;

public class PostContentLength {

    public static String getThreeHundradLettterInContent(String content) {
        String totalContent;
        if (content.length() >= 300) {
            totalContent = content.substring(0, 300);
        } else {
            totalContent = content;
        }

        return totalContent + "...";
    }

    public static String getModifiedDate(Timestamp ts) {
        String s;

//        s = ts.toString().substring(0, 11);
        s = ts.toLocalDateTime().toString();

        return s;
    }
}
