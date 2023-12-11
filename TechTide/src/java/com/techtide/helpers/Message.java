package com.techtide.helpers;

public class Message {

    private String content;
    private String cssClass;
    private String type;

    public Message(String content, String cssClass, String type) {
        this.content = content;
        this.cssClass = cssClass;
        this.type = type;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}
