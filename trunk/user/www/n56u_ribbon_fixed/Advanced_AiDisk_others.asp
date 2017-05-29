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

var lan_ipaddr = '<% nvram_get_x("", "lan_ipaddr_t"); %>';
var http_proto = '<% nvram_get_x("", "http_proto"); %>';
var http_port = '<% nvram_get_x("", "http_lanport"); %>';
var https_port = '<% nvram_get_x("", "https_lport"); %>';
var ddns_enable = '<% nvram_get_x("", "ddns_enable_x"); %>';
var ddns_server = '<% nvram_get_x("", "ddns_server_x"); %>';
var ddns_hostname = '<% nvram_get_x("", "ddns_hostname_x"); %>';

function initial(){
	show_banner(1);
	show_menu(5,6,1);
	show_footer();

	if(!found_utl_hdparm()){
		$("row_spd").style.display = "none";
		$("row_apm").style.display = "none";
	}

	if(support_usb3()){
		$("row_usb3_disable").style.display = "";
	}

}

function applyRule(){
	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_AiDisk_others.asp";
		document.form.next_page.value = "";
		document.form.submit();
	}
}

function validForm(){
	if(!validate_range(document.form.st_max_user, 1, 50)){
		return false;
	}
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

    <input type="hidden" name="current_page" value="Advanced_AiDisk_others.asp">
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
                                    <div class="alert alert-info" style="margin: 10px;"><#USB_Application_disk_miscellaneous_desc#></div>

                                    <table width="100%" cellpadding="4" cellspacing="0" class="table">
                                        <tr id="row_usb3_disable" style="display:none;">
                                            <th width="50%"><#StorageU3Off#></th>
                                            <td>
                                                <select name="usb3_disable" class="input">
                                                    <option value="0" <% nvram_match_x("", "usb3_disable", "0", "selected"); %>><#checkbox_No#> (*)</option>
                                                    <option value="1" <% nvram_match_x("", "usb3_disable", "1", "selected"); %>><#checkbox_Yes#> (<#StorageU3Desc#>)</option>
                                                </select>
                                                &nbsp;<span style="color:#888">* need reboot</span>
                                            </td>
                                        </tr>
                                        <tr id="row_spd">
                                            <th width="50%"><#StorageSpindown#></th>
                                            <td>
                                                <select name="hdd_spindt" class="input">
                                                    <option value="0" <% nvram_match_x("", "hdd_spindt", "0", "selected"); %>><#ItemNever#></option>
                                                    <option value="1" <% nvram_match_x("", "hdd_spindt", "1", "selected"); %>>0h:15m</option>
                                                    <option value="2" <% nvram_match_x("", "hdd_spindt", "2", "selected"); %>>0h:30m</option>
                                                    <option value="3" <% nvram_match_x("", "hdd_spindt", "3", "selected"); %>>1h:00m</option>
                                                    <option value="4" <% nvram_match_x("", "hdd_spindt", "4", "selected"); %>>1h:30m</option>
                                                    <option value="5" <% nvram_match_x("", "hdd_spindt", "5", "selected"); %>>2h:00m</option>
                                                    <option value="6" <% nvram_match_x("", "hdd_spindt", "6", "selected"); %>>2h:30m</option>
                                                    <option value="7" <% nvram_match_x("", "hdd_spindt", "7", "selected"); %>>3h:00m</option>
                                                    <option value="8" <% nvram_match_x("", "hdd_spindt", "8", "selected"); %>>3h:30m</option>
                                                    <option value="9" <% nvram_match_x("", "hdd_spindt", "9", "selected"); %>>4h:00m</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="row_apm">
                                            <th><#StorageApmOff#></th>
                                            <td>
                                                <select name="hdd_apmoff" class="input">
                                                    <option value="0" <% nvram_match_x("", "hdd_apmoff", "0", "selected"); %>><#checkbox_No#></option>
                                                    <option value="1" <% nvram_match_x("", "hdd_apmoff", "1", "selected"); %>><#checkbox_Yes#></option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th width="50%"><#StorageAutoChkDsk#></th>
                                            <td>
                                                <select name="achk_enable" class="input">
                                                    <option value="0" <% nvram_match_x("", "achk_enable", "0", "selected"); %>><#checkbox_No#> (*)</option>
                                                    <option value="1" <% nvram_match_x("", "achk_enable", "1", "selected"); %>><#checkbox_Yes#></option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><#StorageCacheReclaim#></th>
                                            <td>
                                                <select name="pcache_reclaim" class="input">
                                                    <option value="0" <% nvram_match_x("", "pcache_reclaim", "0", "selected"); %>><#checkbox_No#></option>
                                                    <option value="1" <% nvram_match_x("", "pcache_reclaim", "1", "selected"); %>>70% RAM</option>
                                                    <option value="2" <% nvram_match_x("", "pcache_reclaim", "2", "selected"); %>>50% RAM</option>
                                                    <option value="3" <% nvram_match_x("", "pcache_reclaim", "3", "selected"); %>>30% RAM</option>
                                                    <option value="4" <% nvram_match_x("", "pcache_reclaim", "4", "selected"); %>>15% RAM</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><#StorageAllowOptw#></th>
                                            <td>
                                                <select name="optw_enable" class="input">
                                                    <option value="0" <% nvram_match_x("", "optw_enable", "0", "selected"); %>><#checkbox_No#></option>
                                                    <option value="1" <% nvram_match_x("", "optw_enable", "1", "selected"); %>>Optware (legacy)</option>
                                                    <option value="2" <% nvram_match_x("", "optw_enable", "2", "selected"); %>>Entware</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr id="row_max_user">
                                            <th>
                                                <a class="help_tooltip" href="javascript:void(0);" onmouseover="openTooltip(this,17,1);"><#ShareNode_MaximumLoginUser_itemname#></a>
                                            </th>
                                            <td>
                                                <input type="text" name="st_max_user" class="input" maxlength="2" size="5" value="<% nvram_get_x("", "st_max_user"); %>"/>
                                                &nbsp;<span style="color:#888;">[1..50]</span>
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
