package com.tech.blog.entity;

import java.util.List;

public class userInfo {

    private int id;
    private long mobile;
    private String address;
    private String occupation;
    private String higherStudy;
    private String twitter;
    private String insta;
    private String facebook;

    private String github;
    private String other_site;
    private String Linkedin;

    // Fields for technical skill levels
    private List<Integer> techSkillLevels;

    // Fields for soft skill levels
    private List<Integer> softSkillLevels;

    // Fields for technical skills
    private List<TechnicalSkill> techSkills;

    // Fields for soft skills
    private List<SoftSkill> softSkills;

    public userInfo(int mobile, String address, String occupation, String twitter, String insta, String facebook, String github, String other_site, String Linkedin) {
        this.mobile = mobile;
        this.address = address;
        this.twitter = twitter;
        this.insta = insta;
        this.facebook = facebook;
        this.github = github;
        this.other_site = other_site;
        this.Linkedin = Linkedin;

    }

    public userInfo(int id, int mobile, String address, String occupation, String twitter, String insta, String facebook, String github, String other_site, String Linkedin) {
        this.id = id;
        this.mobile = mobile;
        this.address = address;
        this.occupation = occupation;
        this.twitter = twitter;
        this.insta = insta;
        this.facebook = facebook;
        this.github = github;
        this.other_site = other_site;
        this.Linkedin = Linkedin;

    }

    public userInfo(int id, int mobile, String address, String occupation, String twitter, String insta, String facebook, String github, String other_site, String Linkedin, List<Integer> techSkillLevels, List<Integer> softSkillLevels, List<TechnicalSkill> techSkills, List<SoftSkill> softSkills) {
        this.id = id;
        this.mobile = mobile;
        this.address = address;
        this.occupation = occupation;
        this.twitter = twitter;
        this.insta = insta;
        this.facebook = facebook;
        this.github = github;
        this.other_site = other_site;
        this.Linkedin = Linkedin;
        this.techSkillLevels = techSkillLevels;
        this.softSkillLevels = softSkillLevels;
        this.techSkills = techSkills;
        this.softSkills = softSkills;
    }

    public userInfo(int id, long mobile, String address, String occupation, String higherStudy, String twitter, String insta, String facebook, String github, String other_site, String Linkedin, List<Integer> techSkillLevels, List<Integer> softSkillLevels, List<TechnicalSkill> techSkills, List<SoftSkill> softSkills) {
        this.id = id;
        this.mobile = mobile;
        this.address = address;
        this.occupation = occupation;
        this.higherStudy = higherStudy;
        this.twitter = twitter;
        this.insta = insta;
        this.facebook = facebook;
        this.github = github;
        this.other_site = other_site;
        this.Linkedin = Linkedin;
        this.techSkillLevels = techSkillLevels;
        this.softSkillLevels = softSkillLevels;
        this.techSkills = techSkills;
        this.softSkills = softSkills;
    }

    public String getHigherStudy() {
        return higherStudy;
    }

    public void setHigherStudy(String higherStudy) {
        this.higherStudy = higherStudy;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public userInfo() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Setter method for mobile number
    public void setMobile(long mobile) {
        this.mobile = mobile;
    }

    // Getter method for mobile number
    public long getMobile() {
        return mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTwitter() {
        return twitter;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    public String getInsta() {
        return insta;
    }

    public void setInsta(String insta) {
        this.insta = insta;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getGithub() {
        return github;
    }

    public void setGithub(String github) {
        this.github = github;
    }

    public String getOther_site() {
        return other_site;
    }

    public void setOther_site(String other_site) {
        this.other_site = other_site;
    }

    public String getLinkedin() {
        return Linkedin;
    }

    public void setLinkedin(String Linkedin) {
        this.Linkedin = Linkedin;
    }

//    skill`s getter and setter
    public List<TechnicalSkill> getTechSkills() {
        return techSkills;
    }

    public void setTechSkills(List<TechnicalSkill> techSkills) {
        this.techSkills = techSkills;
    }

    // Getter and setter methods for soft skills
    public List<SoftSkill> getSoftSkills() {
        return softSkills;
    }

    public void setSoftSkills(List<SoftSkill> softSkills) {
        this.softSkills = softSkills;
    }

    public List<Integer> getTechSkillLevels() {
        return techSkillLevels;
    }

    public void setTechSkillLevels(List<Integer> techSkillLevels) {
        this.techSkillLevels = techSkillLevels;
    }

    // Getter and setter methods for soft skill levels
    public List<Integer> getSoftSkillLevels() {
        return softSkillLevels;
    }

    public void setSoftSkillLevels(List<Integer> softSkillLevels) {
        this.softSkillLevels = softSkillLevels;
    }

}
