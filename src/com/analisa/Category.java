/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.analisa;

import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author lenovo
 */
public class Category {
    public String name;
    public List<String> keyword;
    public List<Tweet> tweets;
    public Category(String name)
    {
        this.name = name;
        keyword = new LinkedList();
        tweets = new LinkedList();
    }
    public Category(String Name,String Key)
    {
        this.name = Name;
        keyword = new LinkedList();
        tweets = new LinkedList();
        String K[] = Key.split(";");
        for (int i=0;i<K.length;i++)
        {
            keyword.add(K[i]);
        }
    }
}
