/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.analisa;

import twitter4j.*;

/**
 *
 * @author lenovo
 */
public class Tweet {
    private Status Stat;
    private String Location="";
    private String Kor="";
    private String Keyword;
    public Tweet(Status T,String Key)
    {
        Stat = T;
        PlaceValidator Place = new PlaceValidator("/root/kbbi.txt");
        
        PlaceValidator.Loc lok = Place.ekstrak(T.getText());
        
        Location = lok.name;
        Kor = lok.loc;
        Keyword = Key;
    }
    public String getUser()
    {
        return Stat.getUser().getScreenName();
    }
    public String getStatus()
    {
        return Stat.getText();
    }
    public String getImage()
    {
        return Stat.getUser().getProfileImageURL();
    }
    public String getLocation()
    {
        return Location;
    }
    public String getKor()
    {
        return Kor;
    }
    public String getKeyword()
    {
        return Keyword;
    }
}
