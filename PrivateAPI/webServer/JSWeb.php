<body>
<h2>chenJS</h2>
<head></head>

<script>

function sendCommand(cmd,param)
{
	var url=cmd+"::"+param;
	document.location = url;
}
function clickLink()
{
	// sendCommand("install","192.168.1.153/cqh/InstallAppPlist.plist");
	sendCommand("install","itms-services:///?action=download-manifest&url=http://192.168.1.153/cqh/InstallAppPlist.plist");
}
</script>

<script>
function getItunesStoreLink()
{
    var url="itunesapp::425349261";
    // var url="itunesapp://itunes.apple.com/cn/app/wang-yi-xin-wen/id425349261?mt=8";
    document.location = url;
}
</script>

<script>
function openAppLink()
{
    var url="openapp::chenapp";
    document.location = url;
}
</script>

<script type="text/javascript">
	function try_to_open_app()
	{
		window.location = "chenapp:open";
		setTimeout( 
			function()
			{ 
				window.location="itms-apps://itunes.apple.com/cn/app/wang-yi-xin-wen/id425349261?mt=8";
			} , 100);
	}
</script>

	<!--自己的plist，无效证书，此部分需要有效的证书-->
<a href="javascript:clickLink();">Install App by Safari</>
	<br/>
	<br/>
	<!--跳转APP Store-->
<a href="javascript:getItunesStoreLink();">Install by ItunesStore</>
	<br/>
	<br/>
	<!--打开已安装的app-->
<a href="javascript:openAppLink();">Open App</>
	<br>
	<br>
	<!--自己的plist，无效证书，此部分需要有效的证书-->
<a href="itms-services:///?action=download-manifest&url=http://192.168.1.153/cqh/InstallAppPlist.plist">test App by Safari</>
	<br>
	<br>
	<!--在网页上直接跳转APP Store-->
<a href="itms-apps://itunes.apple.com/cn/app/wang-yi-xin-wen/id425349261?mt=8">direct open ItunesStore</>
	<br>
	<br>
	<!--在网页直接打开安装（越狱版PP助手）-->
<a href="itms-services://?action=download-manifest&amp;url=https://sslapi.25pp.com/version/PPHelperNS_g.plist">PP</a>
	<br>
	<br>
	<!--在网页直接打开，打不开就跳转到appstore-->
<a href="javascript:try_to_open_app();">open app, if fail, to appstore</a>


</body>