<%@page import="com.analisa.PlaceValidator"%>
<%@ page import="java.sql.*" %><% 

String user = "";
if (session.getAttribute("tweetics") == null){
	response.sendRedirect("twitter");
	
}else{
	user = session.getAttribute("tweetics").toString();
}
String connectionURL = "jdbc:mysql://localhost/tweetics";
   Connection connection = null; 
   Class.forName("com.mysql.jdbc.Driver").newInstance(); 
   connection = DriverManager.getConnection(connectionURL, "andre", "susanto");
  
Statement statement = connection.createStatement();
PreparedStatement preparedStatement;

if (request.getParameter("action") != null){
	
	if (request.getParameter("action").equals("clean")) {
		statement.executeUpdate("DELETE FROM tweets WHERE username='" + user + "'");
		response.sendRedirect("analisa.jsp?cat=all");
		
	}
	
	if (request.getParameter("action").equals("logout")) {
		session.setAttribute("tweetics", null);
		response.sendRedirect("index.jsp");
		
	}
}

%><!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="A layout example that shows off a responsive email layout.">
    <title>Analisa &ndash; Tweetics</title>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.4.2/pure.css">
  
    <!--[if lte IE 8]>
        <link rel="stylesheet" href="css/layouts/email-old-ie.css">
    <![endif]-->
    <!--[if gt IE 8]><!-->
        <link rel="stylesheet" href="css/layouts/email.css">
    <!--<![endif]-->
    
    <% 
    boolean mapScript = false;
    String mapLocation = "";
    String mapTitle = "";
    ResultSet resTweet = null;
    PreparedStatement ps;
    int twActive = 1;
    
    if (request.getParameter("cat") != null){
    	if (request.getParameter("cat").equals("all")) {
    		resTweet = statement.executeQuery("SELECT * FROM `tweets` WHERE `username`='"+user+"'");
    	}else{
    		ps = connection.prepareStatement("SELECT * FROM `tweets` WHERE `username`='"+user+"' AND category=?");
    		ps.setString(1, request.getParameter("cat"));
    		resTweet = ps.executeQuery();
    	}
    	
    	if (request.getParameter("id") != null){
    		twActive = Integer.parseInt(request.getParameter("id"));
    	}
    	
    	if (resTweet.absolute(twActive)){
			/*if (!resTweet.getString(6).equals("")){
				mapScript = true;
				mapLocation = resTweet.getString(6);
				mapTitle = resTweet.getString(5);
				
			}else
                        {*/
                                PlaceValidator Place = new PlaceValidator("D:\\Upix\\ITB\\Kuliah\\Semester 4\\IF2211 Strategi Algoritma\\Tugas Besar 3\\Tweetics\\web\\kbbi.txt");
				mapTitle = resTweet.getString(5);
                                //mapLocation = Place.getLoc("Juanda Dago");
                        //}
    	}
    	
    
    	
    }
    %>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
var map;
function initialize() {

  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': '<%= mapTitle %>,Bandung'}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            var mapOptions = {
                zoom: 15,
                center: results[0].geometry.location

              };
              map = new google.maps.Map(document.getElementById('map-canvas'),
                  mapOptions);
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location,
                draggable: true,
            });

        } else {
            
        }
    });

}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
</head>
<body>

	
<div id="layout" class="content pure-g">
    <div id="nav" class="pure-u">
        <a href="#" class="nav-menu-button">Menu</a>

        <div class="nav-inner">
			<img src="logo_small.png" /><br/>
            <button class="primary-button pure-button" onclick="location.href='analisa.jsp?action=new'">Buat Baru</button>

            <div class="pure-menu pure-menu-open">
                
                <%  ResultSet resultSet;
                	resultSet = statement.executeQuery("SELECT COUNT(*) FROM tweets WHERE `username`='"+user+"' ");
            		resultSet.first();
	  				out.println("<ul><li><a href=\"analisa.jsp?cat=all\">Semua <span class=\"email-count\">(" + resultSet.getInt(1) + ")</span></a></li>");
                	resultSet = statement.executeQuery("SELECT category.*,COUNT(category.category) FROM `category` JOIN tweets ON category.username=tweets.username AND category.category=tweets.category WHERE category.username='" + user + "' GROUP BY category.category ");
		  			boolean hasil;
				    int i = 0;
				    
		  			hasil = resultSet.first();
				      
		  			while (hasil){
		  				out.println("<li><a href=\"analisa.jsp?cat="+resultSet.getString(2).replace(' ', '+')+"\">" + resultSet.getString(2) + " <span class=\"email-count\">(" + resultSet.getString(4) + ")</span></a></li>");
		  				hasil = resultSet.next();
		  			}
		  			%>
                    <li><a href="analisa.jsp?action=clean">Bersihkan Semua</a></li>
                    <li class="pure-menu-heading">Pengaturan</li>
                    <li><a href="analisa.jsp?action=kustomisasi"><span class="email-label-personal"></span>Kustomisasi</a></li>
                    <li><a href="analisa.jsp?action=profil"><span class="email-label-work"></span>Profil</a></li>
                    <li><a href="analisa.jsp?action=logout"><span class="email-label-travel"></span>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    
<% 
if (request.getParameter("cat") != null){
	if (request.getParameter("cat").equals("all")) {
		resTweet = statement.executeQuery("SELECT * FROM `tweets` WHERE `username`='"+user+"'");
	}else{
		ps = connection.prepareStatement("SELECT * FROM `tweets` WHERE `username`='"+user+"' AND category=?");
		ps.setString(1, request.getParameter("cat"));
		resTweet = ps.executeQuery();
	}
	%>
	<div id="list" class="pure-u-1">
		<% boolean bTweet = resTweet.first();
		int iT = 1;
		while (bTweet) { %>
        <div class="email-item <% if (iT == twActive) out.print("email-item-selected "); %>pure-g" onclick="location.href='analisa.jsp?cat=<%= request.getParameter("cat") %>&id=<%= iT %>'">
            <div class="pure-u">
                <img class="email-avatar" alt="<%= resTweet.getString(7) %>&#x27;s avatar" height="64" width="64" src="<%= resTweet.getString(8) %>">
            </div>

            <div class="pure-u-3-4">
                <h4 class="email-subject"><%= resTweet.getString(7) %></h4>
                <p class="email-desc">
                    <% if (resTweet.getString(4).length() > 90)
                    		out.print(resTweet.getString(4).substring(0, 90) + "...");
                    	else
                    		out.print(resTweet.getString(4)); %>
                </p>
                <h5 class="email-name"><%= resTweet.getString(5) %></h5>
            </div>
        </div>
        <% bTweet = resTweet.next(); iT++; } 
        boolean ada = resTweet.absolute(twActive);
        %>
	</div>
	<% if (ada) { %>
	<div id="main" class="pure-u-1">
        <div class="email-content">
            <div class="email-content-header pure-g">
                <div class="pure-u-1-2">
                    <h1 class="email-content-title"><% if (ada) out.print(resTweet.getString(7)); else out.print("..."); %></h1>
                    <p class="email-content-subtitle">
                        Tweet <a><% if (ada) out.print(resTweet.getString(7)); else out.print("..."); %></a> pada <span><% if (ada) out.print(resTweet.getString(7)); else out.print("..."); %></span>
                    </p>
                </div>

                <div class="email-content-controls pure-u-1-2">
                    <button class="secondary-button pure-button">Hapus</button>
                    <button class="secondary-button pure-button">Bersihkan</button>
                    <button class="secondary-button pure-button">Pindahkan</button>
                </div>
            </div>

            <div class="email-content-body" width="100%">
				<p><b>TWEET:</b></p>
                <p><i>
                <% if (ada) out.print(resTweet.getString(4).replaceAll("@([a-zA-Z0-9]+)", "<a>@$1</a>").replaceAll("#([a-zA-Z0-9]+)", "<a>#$1</a>"));  else out.print("..."); %>
                    
                </i></p>
				<p><b>ANALISIS:</b></p>
                <table class="pure-table" width="100%">
					<thead>
						<tr>
							<th width="20px">#</th>
							<th width="30%">Nama Kategori</th>
							<th>Keyword Matching</th>
						</tr>
					</thead>

					<tbody>
						
						<tr>
							<td>1</td>
							<td>Lokasi</td>
							<td><% if (ada) out.print(resTweet.getString(5)); else out.print("..."); %></td>
						</tr>

						<tr>
							<td>2</td>
							<td>Keyword</td>
							<td><% if (ada) out.print(resTweet.getString(10)); else out.print("..."); %></td>
						</tr>

					</tbody>
				</table>
				<p><b>LOCATION:</b></p>
				<div id="map-canvas"></div>
				
            </div>
        </div>
    </div>
<%} }else if(request.getParameter("action") != null){
	if (request.getParameter("action").equals("kustomisasi")) {
		%>
		<div id="full" class="pure-u-1">
        <div class="email-content">
            <div class="email-content-header pure-g">
                <div class="pure-u-1-2">
                    <h1 class="email-content-title">Kustomisasi</h1>
                    <p class="email-content-subtitle">
                        Kustomisasi analisis <span><i>Tweetics</i></span>
                    </p>
                </div>
            </div>

            <div class="email-content-body" width="100%">
            	<% if (request.getParameter("algoritma")!=null) {
            		if (request.getParameter("algoritma").equals("Boyer-Moore")){
            			statement.executeUpdate("UPDATE user SET algoritma='0' WHERE username='" + user + "'");
            			
            			out.println("<p><b><font color='green'>Algoritma berhasil diganti ke Boyer-Moore</font></b></p>");
            		}else{
            			statement.executeUpdate("UPDATE user SET algoritma='1' WHERE username='" + user + "'");
            			out.println("<p><b><font color='green'>Algoritma berhasil diganti ke Knuth Morris-Pratt</font></b></p>");
            		}
            		}
            	if (request.getParameter("count")!=null) {
            			statement.executeUpdate("UPDATE user SET count=" + request.getParameter("count") + " WHERE username='" + user + "'");
            			
            			out.println("<p><b><font color='green'>Jumlah count berhasil diganti</font></b></p>");
            		
            		}
            		if (request.getParameter("name")!=null) {
            			preparedStatement = connection.prepareStatement("INSERT INTO `category` (`username`, `category`, `keyword`) VALUES (?, ?, ?)");
            			preparedStatement.setString(1, user);
						String name = request.getParameter("name");
						String keyword = request.getParameter("keyword");
						
						name.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");
						keyword.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");
						
            			preparedStatement.setString(2, name);
            			preparedStatement.setString(3, keyword);
            			      
            			preparedStatement.executeUpdate();
            			out.println("<p><b><font color='green'>Kategori berhasil ditambah</font></b></p>");
            		
            		}
            		
            		if (request.getParameter("d")!=null) {
            			preparedStatement = connection.prepareStatement("DELETE FROM `category` WHERE username=? AND category=?");
            			String cat = request.getParameter("d");
						
            			preparedStatement.setString(1, user);
            			
						
						cat.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");
						
            			preparedStatement.setString(2, cat);
            			      
            			preparedStatement.executeUpdate();
            			out.println("<p><b><font color='green'>Kategori berhasil dihapus</font></b></p>");
            		}
            		%>
            	
            	
            	<p><b>Algoritma:</b></p>
            	<form class="pure-form" action="analisa.jsp?action=kustomisasi" method="POST">
		        <select id="algoritma" name="algoritma" class="pure-input-1-3">
		        <% resultSet = statement.executeQuery("select algoritma from user WHERE username='" + user + "'");
		        	resultSet.first();
		        	%>
		            <option<% if(resultSet.getInt(1) == 0) out.println(" selected");%>>Boyer-Moore</option>
		            <option<% if(resultSet.getInt(1) == 1) out.println(" selected");%>>Knuth Morris-Pratt</option>
		        </select>&nbsp;
		        <select id="count" name="count" class="pure-input-1-6">
		        <% resultSet = statement.executeQuery("select `count` from user WHERE username='" + user + "'");
		        	resultSet.first();
		        	%>
		            <option<% if(resultSet.getInt(1) == 5) out.println(" selected");%>>5</option>
		            <option<% if(resultSet.getInt(1) == 10) out.println(" selected");%>>10</option>
		            <option<% if(resultSet.getInt(1) == 25) out.println(" selected");%>>25</option>
		            <option<% if(resultSet.getInt(1) == 50) out.println(" selected");%>>50</option>
		            <option<% if(resultSet.getInt(1) == 100) out.println(" selected");%>>100</option>
		            
		            
		        </select>&nbsp;
		        <button type="submit" class="pure-button pure-button-primary">Simpan</button>
		        </form>
            	<p><b>Kategori:</b></p>
				<p>Daftar kategori analisa Tweetics:</p>
				<table class="pure-table" width="100%">
					<thead>
						<tr>
							<th width="20px">#</th>
							<th width="30%">Nama</th>
							<th>Keyword</th>
							<th width="30px">Opt</th>
						</tr>
					</thead>

					<tbody>
					<%
				      // resultSet gets the result of the SQL query
				    resultSet = statement.executeQuery("select * from category WHERE username='" + user + "'");
		  			i = 0;
				    
		  			hasil = resultSet.first();
				      
		  			while (hasil){
		  				if (!resultSet.getString(2).equals("Unknown")){
			  				out.println("<tr>");
			  				out.println("<td>" + ++i + "</td>");
			  				out.println("<td>" + resultSet.getString(2) + "</td>");
			  				out.println("<td>" + resultSet.getString(3) + "</td>");
			  				out.println("<td align=\"center\"><a href=\"analisa.jsp?action=kustomisasi&d="+resultSet.getString(2).replace(' ', '+')+"\"><img src=\"img/close.png\"></a></td>");
			  				out.println("</tr>");
		  				}
		  				hasil = resultSet.next();
		  			}
		  			out.println("<tr>");
	  				out.println("<td>" + ++i + "</td>");
	  				out.println("<td>Unknown</td>");
	  				out.println("<td>Keyword lainnya ...</td>");
	  				out.println("<td align=\"center\"></td>");
	  				out.println("</tr>");
				      %>
					</tbody>
				</table>
				<p><b>Tambah Kategori:</b></p>
				<form class="pure-form pure-form-aligned" action="analisa.jsp?action=kustomisasi" method="post">
    <fieldset>
        <div class="pure-control-group ">
            <label for="name">Nama</label>
            <input id="name" name="name" type="text" class="pure-input-1-3" placeholder="Nama Kategori">
        </div>

        <div class="pure-control-group">
            <label for="key">Keyword</label>
            <input id="key" name="keyword" class="pure-input-1-3" type="text" placeholder="keyword1;keyword2;keyword3">
        </div>

        <div class="pure-controls">
            <button type="submit" class="pure-button pure-button-primary">Submit</button>
        </div>
    </fieldset>
</form>
            </div>
        </div>
    </div>
		<%
	}
	if (request.getParameter("action").equals("new")) { %>

    <div id="full" class="pure-u-1">
        <div class="email-content">
            <div class="email-content-header pure-g">
                <div class="pure-u-1-2">
                    <h1 class="email-content-title">Buat Analisa Baru</h1>
                    <p class="email-content-subtitle">
                        Kustomisasi dapat dilakukan di <span><i>menu Kostumisasi</i></span>
                    </p>
                </div>
            </div>

            <div class="email-content-body" width="100%">
            	<p><b>Opsi Analisa:</b></p>
            	<form class="pure-form pure-g" action="New" method="post">
				    
				    <div class="pure-u-3-4">
				        <input name="key" class="pure-input-1" type="text" placeholder="Masukkan #hashtag atau @username">
				    </div>
				    <div class="pure-u-1-4">
				     &nbsp; <button type="submit" class="pure-button pure-u-1-4 pure-button-primary">Search</button>
				    </div>
				    
				</form>
				<p><b>Keterangan:</b></p>
				<p>Tweetics akan menganalisa kategori-kategori berikut ini:</p>
				<table class="pure-table" width="100%">
					<thead>
						<tr>
							<th width="20px">#</th>
							<th width="30%">Nama</th>
							<th>Keyword</th>
						</tr>
					</thead>

					<tbody>
					<%
				      // resultSet gets the result of the SQL query
				    resultSet = statement.executeQuery("select * from category WHERE username='" + user + "'");
		  			i = 0;
				    
		  			hasil = resultSet.first();
				      
		  			while (hasil){
		  				out.println("<tr>");
		  				out.println("<td>" + ++i + "</td>");
		  				out.println("<td>" + resultSet.getString(2) + "</td>");
		  				out.println("<td>" + resultSet.getString(3) + "</td>");
		  				out.println("</tr>");
		  				hasil = resultSet.next();
		  			}
				      %>
					</tbody>
				</table>
            </div>
        </div>
    </div>
    </div>
<% } } %>

</div>

<script src="http://yui.yahooapis.com/3.14.1/build/yui/yui.js"></script>
<script>
    YUI().use('node-base', 'node-event-delegate', function (Y) {

        var menuButton = Y.one('.nav-menu-button'),
            nav        = Y.one('#nav');

        // Setting the active class name expands the menu vertically on small screens.
        menuButton.on('click', function (e) {
            nav.toggleClass('active');
        });

        // Your application code goes here...

    });
</script>

<script>
YUI().use('node-base', 'node-event-delegate', function (Y) {
    // This just makes sure that the href="#" attached to the <a> elements
    // don't scroll you back up the page.
    Y.one('body').delegate('click', function (e) {
        e.preventDefault();
    }, 'a[href="#"]');
});
</script>





</body>
</html>
