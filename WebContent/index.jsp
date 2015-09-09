<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="A layout example that shows off a responsive product landing page.">
    <title>Beranda &ndash; Tweetics</title>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.4.2/pure.css">
    <!--[if lte IE 8]>
        <link rel="stylesheet" href="css/main-grid-old-ie.css">
    <![endif]-->
    <!--[if gt IE 8]><!-->
        <link rel="stylesheet" href="css/main-grid.css">
    <!--<![endif]-->
    <!--[if lte IE 8]>
        <link rel="stylesheet" href="css/layouts/marketing-old-ie.css">
    <![endif]-->
    <!--[if gt IE 8]><!-->
        <link rel="stylesheet" href="css/layouts/marketing.css">
    <!--<![endif]-->
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">

</head>
<body>
<div class="header">
    <div class="home-menu pure-menu pure-menu-open pure-menu-horizontal pure-menu-fixed">
        <a class="pure-menu-heading" href=""><img src="logo.png" align="left"/>&nbsp; Tweetics</a>
		
        <ul style="margin-top:40px;">
            <li class="pure-menu-selected"><a href="#">Beranda</a></li>
            <li><a href="#about">Tentang</a></li>
        </ul>
    </div>
</div>

<div class="splash-container">
	<div style="background:url(bigpic.png); width:100%;height:100%; background-repeat:no-repeat;background-size:cover;">
	<div class="splash">
        <h1 class="splash-head">Twitter Analytics</h1>
        <p class="splash-subhead">
            Menganalisa berbagai hal dari tweet para pengguna twitter.
        </p>
        <p>
            <a href="analisa.jsp?cat=all" class="pure-button pure-button-primary">Mulai</a>
        </p>
    </div>
	</div>
</div>

<div class="content-wrapper">
    <div class="content">
        <h2 class="content-head is-center">Keuntungan menggunakan Tweetics</h2>

        <div class="pure-g">
            <div class="l-box pure-u-1 pure-u-med-1-2 pure-u-lrg-1-4">

                <h3 class="content-subhead">
                    <i class="fa fa-rocket"></i>
                    Secepat Kilat
                </h3>
                <p>
                    Menganalisa sebuah masalah dengan menggunakan Tweetics sangatlah cepat, secepat kilat...
                </p>
            </div>
            <div class="l-box pure-u-1 pure-u-med-1-2 pure-u-lrg-1-4">
                <h3 class="content-subhead">
                    <i class="fa fa-mobile"></i>
                    Teknologi Responsive
                </h3>
                <p>
                    Dirancang dengan teknologi Responsive. Anda dapat menganalisa melewati smartphone dimanapun dan kapanpun.
                </p>
            </div>
            <div class="l-box pure-u-1 pure-u-med-1-2 pure-u-lrg-1-4">
                <h3 class="content-subhead">
                    <i class="fa fa-th-large"></i>
                    Gratis
                </h3>
                <p>
                    Dengan dana sebesar seratus miliyar rupiah dari Prof.DrWeb. Reinaldo MH, Tweetics dapat digunakan secara bebas.
                </p>
            </div>
            <div class="l-box pure-u-1 pure-u-med-1-2 pure-u-lrg-1-4">
                <h3 class="content-subhead">
                    <i class="fa fa-check-square-o"></i>
                    Mudah diatur
                </h3>
                <p>
                    Anda dapat mengostumisasi opsi-opsi analisa anda. Proses kostumisasi sangat mudah dilakukan.
                </p>
            </div>
        </div>
    </div>

    <div class="ribbon l-box-lrg pure-g">
        <div class="l-box-lrg is-center pure-u-1 pure-u-med-1-2 pure-u-lrg-2-5">
            <img class="pure-img-responsive" alt="File Icons" width="300" src="img/common/file-icons.png">
        </div>
        <div class="pure-u-1 pure-u-med-1-2 pure-u-lrg-3-5">

            <h2 class="content-head content-head-ribbon">Dengan Teknologi KMP dan BM</h2>

            <p>
                Tweetics hadir dengan teknologi pencocokan string Knuth-Morris-Pratt (KMP) dan Boyer Moore (BM). Teknologi ini memungkinkan Tweetics untuk melakukan pencarian 
                dengan sangat cepat dan efisien. Selain itu Tweetics juga menggunakan teknologi pencocokan ekspresi regular (Reg Exp Matching) untuk menganalisa lokasi 
                sebuah tweet.
            </p>
        </div>
    </div>
<a id="about" name="about"></a>
    <div class="content">
        <h2 class="content-head is-center">Dibalik Tweetics: Tentang kami</h2>

        <div class="pure-g">
            <div class="l-box-lrg pure-u-1 pure-u-med-2-5">
            
                <img src="about.jpg" width="100%" height="100%">
            </div>

            <div class="l-box-lrg pure-u-1 pure-u-med-3-5">
                <h4>Andre Susanto - 13512028</h4>
                <p>
                    Andre (paling kiri) adalah seseorang yang bisa dibilang masih cupu. Dia sangat tertarik untuk menganalisa problema sehari hari melalui twitter. Untuk itu, ia bersama dua rekan lainnya mengembangkan tweetics.
                </p>
				<h4>M Reza Irvanda - 13512042</h4>
                <p>
                    Reza atau biasa disebut juga panda (tengah) adalah seseorang yang bisa dibilang sangat ambisius. Ia memiliki visi untuk menjadi presiden indonesia. Ia melihat bahwa berbagai masalah di indonesia dapat dianalisa melalui twitter. Untuk itu ia bersama dua rekan lainnya menciptakan tweetics.
                </p>
                <h4>Luthfi Hamid M - 13512100</h4>
                <p>
                    Luthfi atau akrab juga disapa <i>wono</i> (paling kanan) adalah seseorang yang bisa dibilang sangat dewa. Ia memiliki visi untuk menganalisa seua masalah hanya dengan bermodalkan laptopnya saja. Untuk mencapai visi itu, ia bersama dua rekan lainnya membuat tweetics.
                </p>
            </div>
        </div>

    </div>

    <div class="footer l-box is-center">
        Copyright &copy; 2014 by Andre Susanto, Luthfi Hamid M, M Reza Irvanda
    </div>

</div>

<script src="http://yui.yahooapis.com/3.14.1/build/yui/yui.js"></script>
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

