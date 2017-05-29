<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - <#menu5_4_3#></title>
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

$j(document).ready(function() {
	init_itoggle('enable_samba', change_smb_enabled);
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

function initial(){
	show_banner(1);
	show_menu(5,6,2);
	show_footer();

	if(found_app_smbd()){
		$("tbl_smbd").style.display = "";
		change_smb_enabled();
	}

}

function change_smb_enabled(){
	var v = document.form.enable_samba[0].checked;
	showhide_div('row_smb_wgrp', v);
	showhide_div('row_smb_mode', v);
	showhide_div('row_smb_lmb', v);
	showhide_div('row_smb_fp', v);
}

function applyRule(){
	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_AiDisk_samba.asp";
		document.form.next_page.value = "";
		document.form.submit();
	}
}

function validForm(){


	String.prototype.Trim = function(){return this.replace(/(^\s*)|(\s*$)/g,"");}
	document.form.st_samba_workgroup.value = document.form.st_samba_workgroup.value.Trim();


	return true;
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

    <input type="hidden" name="current_page" value="Advanced_AiDisk_sabma.asp">
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
                            <h2 class="box_head round_top"><#menu5_4#> - <#menu5_4_3#></h2>
                            <div class="round_bottom">
                                <div class="row-fluid">
                                    <div id="tabMenu" class="submenuBlock"></div>
                                    <div class="alert alert-info" style="margin: 10px;"><#USB_Application_samba#></div>

                                    <table id="tbl_smbd" width="100%" cellpadding="4" cellspacing="0" class="table" style="display:none;">
                                        <tr>
                                            <th colspan="2" style="background-color: #E3E3E3;"><#StorageSMBD#></th>
                                        </tr>
                                        <tr>
                                            <th width="50%">
                                                <#enableCIFS#>
                                            </th>
                                            <td>
                                                <div class="main_itoggle">
                                                    <div id="enable_samba_on_of">
                                                        <input type="checkbox" id="enable_samba_fake" <% nvram_match_x("", "enable_samba", "1", "value=1 checked"); %><% nvram_match_x("", "enable_samba", "0", "value=0"); %>>
                                                    </div>
                                                </div>

                                                <div style="position: absolute; margin-left: -10000px;">
                                                    <input type="radio" name="enable_samba" id="enable_samba_1" value="1" onclick="change_smb_enabled();" <% nvram_match_x("", "enable_samba", "1", "checked"); %>/><#checkbox_Yes#>
                                                    <input type="radio" name="enable_samba" id="enable_samba_0" value="0" onclick="change_smb_enabled();" <% nvram_match_x("", "enable_samba", "0", "checked"); %>/><#checkbox_No#>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="row_smb_wgrp">
                                            <th>
                                                <a class="help_tooltip" href="javascript:void(0);" onmouseover="openTooltip(this,17, 3);"><#ShareNode_WorkGroup_itemname#></a>
                                            </th>
                                            <td>
                                                <input type="text" name="st_samba_workgroup" class="input" maxlength="32" size="32" value="<% nvram_get_x("", "st_samba_workgroup"); %>"/>
                                            </td>
                                        </tr>
                                        <tr id="row_smb_mode">
                                            <th>
                                                <#StorageShare#>
                                            </th>
                                            <td>
                                                <select name="st_samba_mode" class="input" style="width: 300px;">
                                                    <option value="1" <% nvram_match_x("", "st_samba_mode", "1", "selected"); %>><#StorageShare1#></option>
                                                    <option value="3" <% nvram_match_x("", "st_samba_mode", "3", "selected"); %>><#StorageShare5#></option>
                                                    <option value="4" <% nvram_match_x("", "st_samba_mode", "4", "selected"); %>><#StorageShare2#></option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="row_smb_lmb">
                                            <th>
                                                <#StorageLMB#>
                                            </th>
                                            <td>
                                                <select name="st_samba_lmb" class="input">
                                                    <option value="0" <% nvram_match_x("", "st_samba_lmb", "0", "selected"); %>><#checkbox_No#></option>
                                                    <option value="1" <% nvram_match_x("", "st_samba_lmb", "1", "selected"); %>>Local Master Browser (*)</option>
                                                    <option value="2" <% nvram_match_x("", "st_samba_lmb", "2", "selected"); %>>Local & Domain Master Browser</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="row_smb_fp">
                                            <th>
                                                <#StorageSMBFP#>
                                            </th>
                                            <td>
                                                <select name="st_samba_fp" class="input">
                                                    <option value="0" <% nvram_match_x("", "st_samba_fp", "0", "selected"); %>><#checkbox_No#></option>
                                                    <option value="1" <% nvram_match_x("", "st_samba_fp", "1", "selected"); %>>TCP ports 445, 139 (*)</option>
                                                </select>
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
