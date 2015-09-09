package com.analisa;

import java.io.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;


public class PlaceValidator {
	public List<String> kbbi = new ArrayList<String>();
	
	public PlaceValidator(String kbbf){
		try{
			
		    BufferedReader br = new BufferedReader(new FileReader(kbbf));
		    String strLine;
		    while ((strLine = br.readLine()) != null)   {
		    	kbbi.add(strLine.toLowerCase());
		    }
		    br.close();
	    }catch (Exception e){
	      System.err.println("Error: " + e.getMessage());
	    }
	}
	
	public static class Loc{
		public String name;
		public String loc;
	}
	

	public Loc ekstrak(String tweet){
		int i, j, k, l;
		boolean prev;
		String curVld;
		
		Loc lok = new Loc();
		
		Pattern p = Pattern.compile("(@?#?[A-Za-z0-9])\\w+");
        Matcher mat = p.matcher(tweet);
        String[] pat = new String [100];
        
        j = 0;
        while(mat.find()){
        	if (mat.group(0).substring(0, 1) != "@" || mat.group(0).substring(0, 1) != "#"){
        		if (mat.group(0).length() > 2) {
	        		pat[j] = mat.group(0);
	        		j++;
        		}
        	}
        }
        
        prev = false;
        StringBuilder as;
        
        curVld = "";
        boolean vld;
        
        for(i=0;i<j;i++) {
        	for(k=i; k<j; k++){
        		as = new StringBuilder();
        		for (l=i; l<=k; l++){
        			as.append(pat[l]);
        			as.append(" ");
        		}
        		vld = validate(as.toString().trim());
        		if ((!vld && prev) || (k==j-1 && prev)){
        			
        			if (vld){
        				lok.name = as.toString().trim();
        				lok.loc = "";//getLoc(as.toString().trim());
        				return lok;
        			}
        			else{
        				if (curVld.split(" ").length <= 2){
        					try{
        						
        			            if(!kbbi.contains(curVld.toLowerCase())){
        			            	lok.name = curVld;
        			            	lok.loc = "";//getLoc(curVld);
        			            	return lok;
        			            }
        			            	
        					}catch(Exception e){
        						
        					}
        				}else{
        					lok.name = curVld;
			            	lok.loc = "";//getLoc(curVld);
			            	return lok;
        				}
        			}
        		}else if(vld){
        			prev = true;
        			curVld = as.toString().trim();
        		}
        	}
        }
        
       
        lok.name = "";
        lok.loc = "";
		return lok;
	}
	
	public String getLoc(String placeName){
		try{
                        /*Properties systemProperties = System.getProperties();
                        systemProperties.put("proxySet", "true");
                        systemProperties.put("http.proxyHost", "127.0.0.1");
                        systemProperties.put("http.proxyPort", "808");*/
			URL url = new URL("https://maps.googleapis.com/maps/api/geocode/xml?address=\"" + placeName.replace(' ', '+') + ",Bandung\"&sensor=true");
				
			DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
			DocumentBuilder b = f.newDocumentBuilder();
			Document doc = b.parse(new InputSource(url.openStream()));
			  
			  if(doc.getElementsByTagName("formatted_address").item(0).getTextContent().toLowerCase().contains(placeName)){
				  return doc.getElementsByTagName("lat").item(0).getTextContent()+","+doc.getElementsByTagName("lng").item(0).getTextContent();
			  }else{
			  	return "";
			  }
		}catch(Exception x){
			return "";
		}
	}
	
	public boolean validate(String placeName){
		
		try
        {
			
            /*Properties systemProperties = System.getProperties();
            systemProperties.put("proxySet", "true");
            systemProperties.put("http.proxyHost", "127.0.0.1");
            systemProperties.put("http.proxyPort", "808");*/
            
			URL url = new URL("https://maps.googleapis.com/maps/api/geocode/xml?address=\"" + placeName.replace(' ', '+') + ",Bandung\"&sensor=true");
			
//			
//            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
//            DocumentBuilder b = f.newDocumentBuilder();
//            Document doc = b.parse(new InputSource(url.openStream()));
//            
//            if(doc.getElementsByTagName("formatted_address").item(0).getTextContent().toLowerCase().contains(placeName)){
//            	return doc.getElementsByTagName("lat").item(0).getTextContent()+","+doc.getElementsByTagName("lng").item(0).getTextContent();
//            }else{
//            	return "";
//            }
//            	
            //return doc.getElementsByTagName("status").item(0).getTextContent() ;
            
            StringBuilder sb = new StringBuilder();
            
            
            
            HttpURLConnection yc =(HttpURLConnection) url.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
            String inputLine;
            while ((inputLine = in.readLine()) != null) 
            	sb.append(inputLine);
            
            in.close();
            
            if(sb.toString().toLowerCase().contains(placeName.toLowerCase()))
            	return true;
            else
            	return false;
//            
//            if (doc.getElementsByTagName("status").item(0).getTextContent().trim().equals("OK"))
//            	return true;
//            else
//            	return false;

        }
        catch (Exception e)
        {
            e.printStackTrace();
            return false;
        }
		//return "";
		//return false;
	}
}
