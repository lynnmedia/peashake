<%@ Control Language="C#" AutoEventWireup="true" CodeFile="luma.ascx.cs" Inherits="Controls_luma" %>

<div id="dayRoomWall">
    <img id="dayRoomWallImageA" src="../Images/Bkgs/2a.jpg" />
    <img id="dayRoomWallImageB" src="../Images/Bkgs/2b.jpg" />
    <img id="dayRoomWallImageC" src="../Images/Bkgs/2c.jpg" />
    <div id="TVDRHolder">
        <div id="TVDR01Holder">
            <div id="TVDR01">
			    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="384" height="200" id="monitorL1" align="middle">
				    <param name="movie" value="../swf/monitorL1.swf" />
				        <param name="quality" value="best" />
				        <param name="allowscriptaccess" value="always" />
				        <param name="play" value="true" />
				        <param name="loop" value="true" />
				        <param name="wmode" value="transparent" />
				        <param name="allowFullScreen" value="true" />
				    <!--[if !IE]>-->
				    <object type="application/x-shockwave-flash" data="../swf/monitorL1.swf" width="384" height="200">
					    <param name="movie" value="../swf/monitorL1.swf" />
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
        </div>
        <div id="TVDR02Holder">
            <div id="TVDR02">
                <img id="imageAd1" style="width:420px; height:101px;" src="../Images/logos/vanyaLogo.jpg" />
            </div>
        </div>
        <div id="TVDR03Holder">
            <div id="TVDR03">
                <img id="imageAd2" style="width:283px; height:290px;" src="../Images/logos/vanyaCity.jpg" />
            </div>
        </div>
    </div>
</div>
