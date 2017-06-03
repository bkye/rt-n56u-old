<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - <#menu5_4_6#></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/itoggle.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script>
var $j = jQuery.noConflict();
var xunleidir = "<% nvram_get_x("", "xunlei_dir"); %>"

$j(document).ready(function() {
	init_itoggle('xunlei_enable', change_xunlei_enabled);
	var code = "";
	for(var i = 0; i < usb_share_list.length; i++){
		if(xunleidir == usb_share_list[i][1]){
			code += '<option value="'+usb_share_list[i][1]+'" selected>'+usb_share_list[i][1]+'</option>';
		}else{
			code += '<option value="'+usb_share_list[i][1]+'" >'+usb_share_list[i][1]+'</option>';
		}
	}
	$j("#st_xunlei_dir").append(code);
});

</script>
<script>

var lan_ipaddr = '<% nvram_get_x("", "lan_ipaddr_t"); %>';
var http_proto = '<% nvram_get_x("", "http_proto"); %>';
var http_port = '<% nvram_get_x("", "http_lanport"); %>';
var https_port = '<% nvram_get_x("", "https_lport"); %>';
var ddns_enable = '<% nvram_get_x("", "ddns_enable_x"); %>';
var ddns_server = '<% nvram_get_x("", "ddns_server_x"); %>';
var ddns_hostname = '<% nvram_get_x("", "ddns_hostname_x"); %>';

var usb_share_list = [<% get_usb_share_list(); %>];

function initial(){
	show_banner(1);
	show_menu(5,11,1);
	show_footer();

	if(found_app_xunlei()){
		$("tbl_xunlei").style.display = "";
		change_xunlei_enabled();
	}
	


}

function change_xunlei_enabled(){
	var v = document.form.xunlei_enable[0].checked;
	showhide_div('row_xunlei_dir', v);
	showhide_div('row_xunlei_sn', v);
	showhide_div('row_xunlei_admin', v);
}

function getsn(){
	location.href = "Advanced_xunlei.asp";
}

function applyRule(){
	showLoading();
		
	document.form.action_mode.value = " Apply ";
	document.form.current_page.value = "/Advanced_xunlei.asp";
	document.form.next_page.value = "";
	document.form.submit();
}

</script>
<style>
.nav-tabs > li > a {
	padding-right: 6px;
	padding-left: 6px;
}
</style>
</head>

<body onload="initial();" onunLoad="return unload_body();">

<div class="wrapper">
    <div class="container-fluid" style="padding-right: 0px">
        <div class="row-fluid">
            <div class="span3"><center><div id="logo"></div></center></div>
            <div class="span9" >
                <div id="TopBanner"></div>
            </div>
        </div>
    </div>

    <div id="Loading" class="popup_bg"></div>

    <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

    <form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">

    <input type="hidden" name="current_page" value="Advanced_xunlei.asp">
    <input type="hidden" name="next_page" value="">
    <input type="hidden" name="next_host" value="">
    <input type="hidden" name="sid_list" value="Storage;">
    <input type="hidden" name="group_id" value="">
    <input type="hidden" name="action_mode" value="">
    <input type="hidden" name="action_script" value="">

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span3">
                <!--Sidebar content-->
                <!--=====Beginning of Main Menu=====-->
                <div class="well sidebar-nav side_nav" style="padding: 0px;">
                    <ul id="mainMenu" class="clearfix"></ul>
                    <ul class="clearfix">
                        <li>
                            <div id="subMenu" class="accordion"></div>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="span9">
                <!--Body content-->
                <div class="row-fluid">
                    <div class="span12">
                        <div class="box well grad_colour_dark_blue">
                            <h2 class="box_head round_top"><#menu5_13#> - <#menu5_4_6#></h2>
                            <div class="round_bottom">
                                <div class="row-fluid">
                                    <div id="tabMenu" class="submenuBlock"></div>
                                    <div class="alert alert-info" style="margin: 10px;"><#USB_Application_xunlei#></div>

                                    <table id="tbl_xunlei" width="100%" cellpadding="4" cellspacing="0" class="table" style="display:none;">
                                        <tr>
                                            <th colspan="2" style="background-color: #E3E3E3;"><#Storagexunlei#></th>
                                        </tr>
										<tr>
                                            <th width="50%">
                                                <#Storagexunleienable#>
                                            </th>
                                            <td>
                                                <div class="main_itoggle">
                                                    <div id="xunlei_enable_on_of">
                                                        <input type="checkbox" id="xunlei_enable_fake" <% nvram_match_x("", "xunlei_enable", "1", "value=1 checked"); %><% nvram_match_x("", "xunlei_enable", "0", "value=0"); %>>
                                                    </div>
                                                </div>

                                                <div style="position: absolute; margin-left: -10000px;">
                                                    <input type="radio" name="xunlei_enable" id="xunlei_enable_1" value="1" onclick="change_xunlei_enabled();" <% nvram_match_x("", "xunlei_enable", "1", "checked"); %>/><#checkbox_Yes#>
                                                    <input type="radio" name="xunlei_enable" id="xunlei_enable_0" value="0" onclick="change_xunlei_enabled();" <% nvram_match_x("", "xunlei_enable", "0", "checked"); %>/><#checkbox_No#>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="row_xunlei_dir">
                                            <th>
                                                <#Storagexunleidir#>
                                            </th>
                                            <td>
                                                <select id= "st_xunlei_dir" name="xunlei_dir" class="input">
												
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="row_xunlei_sn">
                                            <th>
                                                <#Storagexunleisn#>
                                            </th>
                                            <td>
                                                <input type="text" name="xunlei_sn" class="input" maxlength="32" size="32" value="<% nvram_get_x("", "xunlei_sn"); %>"/>&nbsp;
												<input type="button" onClick="getsn();" value="<#CTL_refresh#>" class="btn btn-success">
                                            </td>
                                        </tr>
                                        <tr id="row_xunlei_admin">
                                            <th>
                                                <#Storagexunleiadmin#>
                                            </th>
                                            <td>
                                                <a href="http://yuancheng.xunlei.com/" target="_blank">http://yuancheng.xunlei.com/</a>
                                            </td>
                                        </tr>
                                    </table>


                                    <table width="100%" cellpadding="4" cellspacing="0" class="table">
                                        <tr>
                                            <td style="border-top: 0 none;">
                                                <center><input class="btn btn-primary" style="width: 219px" onclick="applyRule();" type="button" value="<#CTL_apply#>" /></center>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </form>

    <div id="footer"></div>
</div>
</body>
</html>
