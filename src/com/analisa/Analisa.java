package com.analisa;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.DriverManager; 


/**
 * Servlet implementation class Analisa
 */
@WebServlet("/Analisa")
public class Analisa extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
    public Analisa() {
        super();
        
        
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

//        	PlaceValidator as = new PlaceValidator(this.getServletContext().getRealPath("kbbi.txt"));
//			
	        response.setContentType("text/html");
	        PrintWriter out = response.getWriter();

	        try {
		    	Class.forName("com.mysql.jdbc.Driver");
		    	out.println("Loaded driver");
		    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/tweetics", "root", "");
		    	out.println("Connected to MySQL");
		    	con.close();
	    	}
	    	catch (Exception ex) {
	    		out.println(ex.getLocalizedMessage());
	    		//ex.printStackTrace();
	    	} 
	        
	        out.println("TES ");
	        out.println("<form action='' method='post'><input name='yow' type='text'></form>");
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        PlaceValidator as = new PlaceValidator(this.getServletContext().getRealPath("kbbi.txt"));
       // out.println(as.validate(request.getParameter("yow")));
        
        out.println(as.ekstrak(request.getParameter("yow")).name);
//        
//        TweetAnalytics abs = new TweetAnalytics("#lalinbdg");
//        abs.AddCategory("Macet", "macet;padat");
//        
//        try{
//        	List<Category> cat = abs.GetResult("KMP", 10);
//        	
//        	for(Category aa : cat){
//        		out.println(aa.name);
//        		
//        		for(Tweet ab : aa.tweets){
//	        		out.println("<b>Username : </b>" + ab.getUser() + "<br>");
//	        		out.println("<b>Stat : </b>" + ab.getStatus() + "<br>");
//	        		out.println("<b>Lokasi : </b>" + ab.getLocation() + "<br>");
//	        		
//	        	}
//        	}
//        	
//        	
//        	
//        }catch(Exception x){
//        	
//        }
        
//        if (as.validate(request.getParameter("yow"))) {
//        	 out.println("Tempat " + request.getParameter("yow") + " Bagus!");
//        }else{
//        	out.println("Tempat " + request.getParameter("yow") + " Gak ADA!");
//        }
       
		
	}

}
