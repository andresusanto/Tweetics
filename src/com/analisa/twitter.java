package com.analisa;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.*;
import twitter4j.auth.RequestToken;

/**
 * Servlet implementation class twitter
 */
@WebServlet("/twitter")
public class twitter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public twitter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Twitter twitter = new TwitterFactory().getInstance();
		twitter.setOAuthConsumer("ui7gNA93UOQ59OTgKWhxaqwJu", "rt7tdGxZwQjBj9vJxY6UdRNKMwe2TpP8R70ceVIeu5pDlJzeuH");
        request.getSession().setAttribute("twitter", twitter);
        try {

            RequestToken requestToken = twitter.getOAuthRequestToken("http://sg.andresusanto.com:8080/Tweetics/call");
            request.getSession().setAttribute("requestToken", requestToken);
            response.sendRedirect(requestToken.getAuthenticationURL());

        } catch (TwitterException e) {
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
