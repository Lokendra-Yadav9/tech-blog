package com.tech.blog.helper;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserNameExtractor {

    public UserNameExtractor() {

    }

    public static String extractUserName(String link) {
        String userName = null;

        // GitHub username extraction
        if (link.contains("github.com")) {
            userName = extractGitHubUserName(link);
        } // LinkedIn username extraction
        else if (link.contains("linkedin.com")) {
            userName = extractLinkedInUserName(link);
        } // Facebook username extraction
        else if (link.contains("facebook.com")) {
            userName = extractFacebookUserName(link);
        } // Instagram username extraction
        else if (link.contains("instagram.com")) {
            userName = extractInstagramUserName(link);
        } else if (link.contains("twitter.com")) {
            userName = extractTwitterUserName(link);
        }

        return userName;
    }

    private static String extractGitHubUserName(String link) {
        if (link == null || link.isEmpty()) {
            return null; // Return null if link is null or empty
        }

        // Extract username from GitHub link (e.g., https://github.com/username)
        Pattern pattern = Pattern.compile("github\\.com/(\\w+)");
        Matcher matcher = pattern.matcher(link);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    private static String extractLinkedInUserName(String link) {
        if (link == null || link.isEmpty()) {
            return null; // Return null if link is null or empty
        }

        // Extract username from LinkedIn link (e.g., https://www.linkedin.com/in/username)
        Pattern pattern = Pattern.compile("linkedin\\.com/in/(\\w+)");
        Matcher matcher = pattern.matcher(link);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    private static String extractFacebookUserName(String link) {
        if (link == null || link.isEmpty()) {
            return null; // Return null if link is null or empty
        }
        // Extract username from Facebook link (e.g., https://www.facebook.com/username)
        Pattern pattern = Pattern.compile("facebook\\.com/(\\w+)");
        Matcher matcher = pattern.matcher(link);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    private static String extractInstagramUserName(String link) {
        if (link == null || link.isEmpty()) {
            return null; // Return null if link is null or empty
        }
        // Extract username from Instagram link (e.g., https://www.instagram.com/username)
        Pattern pattern = Pattern.compile("instagram\\.com/(\\w+)");
        Matcher matcher = pattern.matcher(link);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    private static String extractTwitterUserName(String link) {
        if (link == null || link.isEmpty()) {
            return null; // Return null if link is null or empty
        }
        // Extract username from Twitter link (e.g., https://twitter.com/username)
        Pattern pattern = Pattern.compile("twitter\\.com/(\\w+)");
        Matcher matcher = pattern.matcher(link);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }
}
