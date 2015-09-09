/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.analisa;

import java.util.LinkedList;
import java.util.List;
import twitter4j.*;
import twitter4j.conf.*;

/**
 *
 * @author lenovo
 */
public class TweetAnalytics{ 
    private String hashtag;
    private List<Category> category;
    private Category Unknown;
    public TweetAnalytics(String h)
    {
        hashtag = h;
        category = new LinkedList();
        Unknown = new Category("Unknown","");
    }
    public void AddCategory(Category C)
    {
        category.add(C);
    }
    public void AddCategory(String Name,String Key)
    {
        category.add(new Category(Name,Key));
    }
    public void SearchTweets(String Algo,int count) throws Exception
    {
        this.ResetContent();
        ConfigurationBuilder cb = new ConfigurationBuilder();
        cb.setDebugEnabled(true)
              .setOAuthConsumerKey("ui7gNA93UOQ59OTgKWhxaqwJu")
              .setOAuthConsumerSecret("rt7tdGxZwQjBj9vJxY6UdRNKMwe2TpP8R70ceVIeu5pDlJzeuH")
              .setOAuthAccessToken("94801551-i3u2j3wBa9ZipUrH3HQavzzohTJo23UFRK6QdwPGc")
              .setOAuthAccessTokenSecret("TFeNhIA9zzE5AuKtMKjsOrayDIEV84fI7NZExzqlPSOaC");
        TwitterFactory tf = new TwitterFactory(cb.build());
        Twitter twitter = tf.getInstance();
        try {
            Query query = new Query(hashtag);
            query.setCount(count);
            QueryResult result;
            result = twitter.search(query);
            List<Status> tweets = result.getTweets();
            for (Status tweet : tweets) {
                boolean found = false;
                for (Category cat : category)
                {
                    for (String Key : cat.keyword)
                    {
                        if (Algo.equalsIgnoreCase("KMP"))
                        {
                            KMP Matcher = new KMP(Key);
                            if (Matcher.match(tweet.getText()))
                            {
                                cat.tweets.add(new Tweet(tweet,Key));
                                found = true;
                                break;
                            }
                        }
                        else if (Algo.equalsIgnoreCase("BoyerMoore"))
                        {
                            BoyerMoore Matcher = new BoyerMoore(Key);
                            if (Matcher.match(tweet.getText()))
                            {
                                cat.tweets.add(new Tweet(tweet,Key));
                                found = true;
                                break;
                            }
                        }
                    }
                    if (found)
                    {
                        break;
                    }
                }
                if (!found)
                {
                    Unknown.tweets.add(new Tweet(tweet,""));
                }
            }
        } catch (TwitterException te) {
            throw new Exception(te.toString());
        }
    }
    public List<Category> GetResult(String Algo,int count) throws Exception
    {
        this.SearchTweets(Algo, count);
        List<Category> Result = new LinkedList(category);
        Result.add(Unknown);
        return Result;
    }
    private void ResetContent()
    {
        for (Category Cat : category)
        {
            Cat.tweets = new LinkedList();
        }
    }
}
