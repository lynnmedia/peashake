<%@ Control Language="C#" AutoEventWireup="true" CodeFile="peashake.ascx.cs" Inherits="Controls_peashake" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<div id="djmusic">
    <object width="0" height="0">
        <param name="movie" value="http://fpdownload.adobe.com/strobe/FlashMediaPlayback.swf"></param>
        <param name="flashvars" value="src=rtmp%3A%2F%2Fec2-50-16-154-255.compute-1.amazonaws.com%2Fvod%2Fmp4%3AHOT_PEASHAKE_VIDEO_MIX_01.mp4&controlBarMode=none&playButtonOverlay=false&autoPlay=true&loop=true"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowscriptaccess" value="always"></param>
        <embed src="http://fpdownload.adobe.com/strobe/FlashMediaPlayback.swf" 
            type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="0" height="0" 
            flashvars="src=rtmp%3A%2F%2Fec2-50-16-154-255.compute-1.amazonaws.com%2Fvod%2Fmp4%3AHOT_PEASHAKE_VIDEO_MIX_01.mp4&controlBarMode=none&playButtonOverlay=false&autoPlay=true&loop=true">
        </embed>
    </object>
</div>
<div id="nightClubWall">
    <asp:Image ID="nightClubWallImage" runat="server" ImageUrl="~/Images/Bkgs/3.jpg" />
    <div id="TVMWHolder">
        <div id="TVMW01Holder">
            <div id="TVMW01">
			    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="384" height="200" id="monitorP1" align="middle">
				    <param name="movie" value="../swf/monitorP1.swf" />
				        <param name="quality" value="best" />
				        <param name="allowscriptaccess" value="always" />
				        <param name="play" value="true" />
				        <param name="loop" value="true" />
				        <param name="wmode" value="transparent" />
				        <param name="allowFullScreen" value="true" />
				    <!--[if !IE]>-->
				    <object type="application/x-shockwave-flash" data="../swf/monitorP1.swf" width="384" height="200">
					    <param name="movie" value="../swf/monitorP1.swf" />
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
        <div id="TVMW02Holder">
            <div id="TVMW02">
			    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="384" height="200" id="monitorP2" align="middle">
				    <param name="movie" value="../swf/monitorP2.swf" />
				        <param name="quality" value="best" />
				        <param name="allowscriptaccess" value="always" />
				        <param name="play" value="true" />
				        <param name="loop" value="true" />
				        <param name="wmode" value="transparent" />
				        <param name="allowFullScreen" value="true" />
				    <!--[if !IE]>-->
				    <object type="application/x-shockwave-flash" data="../swf/monitorP2.swf" width="384" height="200">
					    <param name="movie" value="../swf/monitorP2.swf" />
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
        <div id="TVMW03Holder">
            <div id="TVMW03">
			    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="384" height="200" id="monitorP3" align="middle">
				    <param name="movie" value="../swf/monitorP3.swf" />
				        <param name="quality" value="best" />
				        <param name="allowscriptaccess" value="always" />
				        <param name="play" value="true" />
				        <param name="loop" value="true" />
				        <param name="wmode" value="transparent" />
				        <param name="allowFullScreen" value="true" />
				    <!--[if !IE]>-->
				    <object type="application/x-shockwave-flash" data="../swf/monitorP3.swf" width="384" height="200">
					    <param name="movie" value="../swf/monitorP3.swf" />
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
        <div id="TVMW04Holder">
            <div id="TVMW04">
			    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="384" height="200" id="monitorP4" align="middle">
				    <param name="movie" value="../swf/monitorP4.swf" />
				        <param name="quality" value="best" />
				        <param name="allowscriptaccess" value="always" />
				        <param name="play" value="true" />
				        <param name="loop" value="true" />
				        <param name="wmode" value="transparent" />
				        <param name="allowFullScreen" value="true" />
				    <!--[if !IE]>-->
				    <object type="application/x-shockwave-flash" data="../swf/monitorP4.swf" width="384" height="200">
					    <param name="movie" value="../swf/monitorP4.swf" />
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
    </div>
</div>
<asp:AnimationExtender ID="AccordionAnimationExtender0" runat="server" TargetControlID="nightClubWallImage">
<Animations>
    <OnLoad>
        <Sequence iterations="0">
            <Move Horizontal="-2680" AnimationTarget="nightClubWall" Duration="600" Fps="30" />
            <Move Horizontal="2680" AnimationTarget="nightClubWall" Duration="600" Fps="30" />
        </Sequence>
    </OnLoad>
</Animations>           
</asp:AnimationExtender>
