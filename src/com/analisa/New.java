package com.analisa;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class New
 */
@WebServlet("/New")
public class New extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public New() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		   
		String user = "";
		if (session.getAttribute("tweetics") == null){
			response.sendRedirect("twitter");
		}else{
			user = session.getAttribute("tweetics").toString();
		}
		
		TweetAnalytics abs = new TweetAnalytics(request.getParameter("key"));
		String connectionURL = "jdbc:mysql://localhost/tweetics";
	   Connection connection = null; 
	   

       response.setContentType("text/html");
       PrintWriter out = response.getWriter();
	   
	   try {
		   Class.forName("com.mysql.jdbc.Driver").newInstance();
		   connection = DriverManager.getConnection(connectionURL, "andre", "susanto");

		   Statement statement = connection.createStatement();
		   
		   ResultSet algo = statement.executeQuery("SELECT algoritma,`count` FROM `user` WHERE `username`='"+user+"'");
		   algo.first();
		   String pilAlgo = algo.getString(1);
		   int count = algo.getInt(2);
		   
		   if (pilAlgo.equals("1")){
			   pilAlgo = "KMP";
		   }else{
			   pilAlgo = "BoyerMoore";
		   }
		   
		   //out.println(pilAlgo);
		   
		   ResultSet cats = statement.executeQuery("SELECT * FROM `category` WHERE `username`='"+user+"'");
		   boolean n = cats.first();
		   
		   while (n){
			   if (!cats.getString(2).equals("Unknown")){
				   abs.AddCategory(cats.getString(2),cats.getString(3));
			   }
			   //out.println(cats.getString(2)+" "+cats.getString(3));
			   n = cats.next();
		   }
		   //out.println("SU");
		   PreparedStatement preparedStatement;
		  // preparedStatement = connection.prepareStatement("INSERT INTO `tweets` (`id_tweet`, `username`, `category`, `tweet_content`, `location_name`, `location_pos`, `tweet_user`, `tweet_pic`, `tweet_time`, `keyword_match`) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		   
		  

		   List<Category> cat = abs.GetResult(pilAlgo, count);
		   
	       	for(Category aa : cat){
		   		for(Tweet ab : aa.tweets){
		   			//out.println("");
		   			preparedStatement = connection.prepareStatement("INSERT INTO `tweets` (`id_tweet`, `username`, `category`, `tweet_content`, `location_name`, `location_pos`, `tweet_user`, `tweet_pic`, `tweet_time`, `keyword_match`) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		   			
//		   			out.println(aa.name);
//		   			out.println( ab.getStatus());
//		   			out.println( ab.getLocation());
//		   			out.println( ab.getKor());
//		   			out.println( ab.getUser());
//		   			out.println( ab.getImage());
//		   			out.println( getCurrentTimeStamp());
//		   			out.println( ab.getKeyword());
//		   			
		   			preparedStatement.setString(1, user);
		   			preparedStatement.setString(2, aa.name);
		   			preparedStatement.setString(3, ab.getStatus());
		   			preparedStatement.setString(4, ab.getLocation());
		   			preparedStatement.setString(5, ab.getKor());
		   			preparedStatement.setString(6, ab.getUser());
		   			preparedStatement.setString(7, ab.getImage());
		   			preparedStatement.setString(8, getCurrentTimeStamp());
		   			preparedStatement.setString(9, ab.getKeyword());
		       		preparedStatement.executeUpdate();
		       	}
		   	}
		   
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	   
	  response.sendRedirect("analisa.jsp?cat=all");

		
	}
	
	public static String getCurrentTimeStamp() {
	    SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//dd/MM/yyyy
	    Date now = new Date(0);
	    String strDate = sdfDate.format(now);
	    return strDate;
	}

}
