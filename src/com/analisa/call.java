package com.analisa;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import twitter4j.*;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;

/**
 * Servlet implementation class call
 */
@WebServlet("/call")
public class call extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public call() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String connectionURL = "jdbc:mysql://localhost/tweetics";
		   Connection connection = null; 
		   
		// TODO Auto-generated method stub
		Twitter twitter = (Twitter) request.getSession().getAttribute("twitter");
        RequestToken requestToken = (RequestToken) request.getSession().getAttribute("requestToken");
        String verifier = request.getParameter("oauth_verifier");
        AccessToken accesToken = null;
        try {
        	accesToken = twitter.getOAuthAccessToken(requestToken, verifier);
            request.getSession().removeAttribute("requestToken");
//            out.println("AccessToken : "+accesToken.getToken()+"<br>");
//            out.println("AccessTokenSecret : "+accesToken.getTokenSecret()+"<br>");
//            out.println("Username : "+twitter.getScreenName()+"<br>");
//            
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
		   connection = DriverManager.getConnection(connectionURL, "root", "");

		   Statement statement = connection.createStatement();
		   
		   ResultSet algo = statement.executeQuery("SELECT username FROM `user` WHERE `username`='"+twitter.getScreenName()+"'");
		   HttpSession session = request.getSession(true);
		   session.setAttribute("tweetics", twitter.getScreenName());
		   
            if (!algo.first()){
            	
            	statement.executeUpdate("INSERT INTO `user` (`username`, `auth`, `algoritma`, `count`) VALUES ('"+twitter.getScreenName()+"', '"+accesToken.getTokenSecret()+"', '0', '5');");
            	statement.executeUpdate("INSERT INTO `category` (`username`, `category`, `keyword`) VALUES ('"+twitter.getScreenName()+"', 'Unknown', '');");
            	
            }
            
            response.sendRedirect("analisa.jsp?cat=all");
            
        } catch (Exception e) {
            throw new ServletException(e);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
