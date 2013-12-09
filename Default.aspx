<%@ Page Title="PeaShake House: Real Time... Real People!" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head id="Head1" runat="server">
    <title>PeaShake House: Real Time... Real People!</title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function start() {
            var screenWidth = movieWidth();
            var screenHeight = movieHeight();
            var movie = document.getElementById("IntroBlackBackdrop");
            var movieLeft = (screenWidth - 1280) / 2
            if (movieLeft < 0)
                movieLeft = 0;
            var movieTop = (screenHeight - 720) / 2;
            if (movieTop < 0)
                movieTop = 0;
            movie.style.left = movieLeft;
            movie.style.top = movieTop;
        }

        function movieWidth() {
            var myWidth = 0;
            if (typeof (window.innerWidth) == 'number') {
                //Non-IE
                myWidth = window.innerWidth;
            } else if (document.documentElement && document.documentElement.clientWidth) {
                //IE 6+ in 'standards compliant mode'
                myWidth = document.documentElement.clientWidth;
            } else if (document.body && document.body.clientWidth) {
                //IE 4 compatible
                myWidth = document.body.clientWidth;
            }

            return myWidth;
        }

        function movieHeight() {
            var myHeight = 0;
            if (typeof (window.innerHeight) == 'number') {
                //Non-IE
                myHeight = window.innerHeight;
            } else if (document.documentElement && document.documentElement.clientHeight) {
                //IE 6+ in 'standards compliant mode'
                myHeight = document.documentElement.clientHeight;
            } else if (document.body && document.body.clientHeight) {
                //IE 4 compatible
                myHeight = document.body.clientHeight;
            }

            return myHeight;
        }    
    </script>
</head>
<body onload="start()" style="width:100%;height:100%;margin:0;padding:0;background:#000;overflow:hidden;">
    <form id="Form1" runat="server">
        <div id="IntroBlackBackdrop">
			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="1280" height="720" id="intro" align="middle">
				<param name="movie" value="swf/intro.swf" />
				        <param name="quality" value="best" />
				        <param name="allowscriptaccess" value="always" />
				        <param name="play" value="true" />
				        <param name="loop" value="true" />
				        <param name="wmode" value="transparent" />
				        <param name="allowFullScreen" value="true" />
				<!--[if !IE]>-->
				<object type="application/x-shockwave-flash" data="swf/intro.swf" width="1280" height="720">
					<param name="movie" value="swf/intro.swf" />
				        <param name="quality" value="best" />
				        <param name="allowscriptaccess" value="always" />
				        <param name="play" value="true" />
				        <param name="loop" value="true" />
				        <param name="wmode" value="transparent" />
				        <param name="allowFullScreen" value="true" />
				<!--<![endif]-->
					<a href="http://www.adobe.com/go/getflash">
						<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
					</a>
				<!--[if !IE]>-->
				</object>
				<!--<![endif]-->
			</object>
        </div>
        <div>
            <a id="skipIntro" href="Login.aspx">Skip Intro</a>
        </div>    
    </form>
</body>
</html>
