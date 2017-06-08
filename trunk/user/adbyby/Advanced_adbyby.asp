<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - <#menu5_13_2#></title>
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
	init_itoggle('ad_enable', change_ad_enable);
	init_itoggle('adbyby_cpu');
	init_itoggle('koolproxy_https');
if($j("#ad_change_adbyby").is(":checked")==true){
$j("#row_adbyby_whost").show();
if($j("#ad_dir_2").is(":checked")==true){
$j("#row_adbybym_u").show();
}else{
$j("#row_adbybyt_u").show();
}
}
if($j("#ad_change_koolproxy").is(":checked")==true){
if($j("#ad_dir_2").is(":checked")==true){
$j("#row_koolproxym_u").show();
}else{
$j("#row_koolproxyt_u").show();
}
 $j("#row_koolproxy_https").show();
  }
	$j("#ad_change_adbyby").click(function(){
    $j("#row_adbyby_whost").show();
    $j("#row_koolproxy_https").hide();
	if($j("#ad_dir_2").is(":checked")==true){
	$j("#row_adbybym_u").show();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").hide();
	$j("#row_koolproxyt_u").hide();
	}else{
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").show();
	$j("#row_koolproxym_u").hide();
	$j("#row_koolproxyt_u").hide();
	}
  });
  $j("#ad_change_koolproxy").click(function(){
  $j("#row_koolproxy_https").show();
  $j("#row_adbyby_whost").hide();
  if($j("#ad_dir_2").is(":checked")==true){
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").show();
	$j("#row_koolproxyt_u").hide();
	}else{
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").hide();
	$j("#row_koolproxyt_u").show();
	}
  });
   $j("#ad_dir_1").click(function(){
  if($j("#ad_dir_2").is(":checked")==true){
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").show();
	$j("#row_koolproxyt_u").hide();
	}else{
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").hide();
	$j("#row_koolproxyt_u").show();
	}
  });
  $j("#ad_dir_1").click(function(){
if($j("#ad_change_adbyby").is(":checked")==true){
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").show();
	$j("#row_koolproxym_u").hide();
	$j("#row_koolproxyt_u").hide();
}
if($j("#ad_change_koolproxy").is(":checked")==true){
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").hide();
	$j("#row_koolproxyt_u").show();
  }
  });
    $j("#ad_dir_2").click(function(){
if($j("#ad_change_adbyby").is(":checked")==true){
	$j("#row_adbybym_u").show();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").hide();
	$j("#row_koolproxyt_u").hide();
}
if($j("#ad_change_koolproxy").is(":checked")==true){
	$j("#row_adbybym_u").hide();
	$j("#row_adbybyt_u").hide();
	$j("#row_koolproxym_u").show();
	$j("#row_koolproxyt_u").hide();
  }
  });
 
});

</script>
<script>

function initial(){
	show_banner(1);
	show_menu(5,11,2);
	show_footer();
//load_body();
	if(found_app_adbyby()){
		$("tbl_adbyby").style.display = "";
		change_ad_enable();
	}
	


}



function textarea_scripts_enabled(v){
	inputCtrl(document.form['adbybyt.user.txt'], v);
	inputCtrl(document.form['koolpyt.user.txt'], v);
	inputCtrl(document.form['adbybym.user.txt'], v);
	inputCtrl(document.form['koolpym.user.txt'], v);
}

function change_ad_enable(){
	var v = document.form.ad_enable[0].checked; 
	showhide_div('row_ad_change', v);
	showhide_div('row_ad_dir', v);
	showhide_div('row_adbyby_cpu', v);
	if (v==false){
	showhide_div('row_adbyby_whost', v);
	showhide_div('row_koolproxy_https', v);
	showhide_div('row_adbybyt_u', v);
	showhide_div('row_adbybym_u', v);
	showhide_div('row_koolproxyt_u', v);
	showhide_div('row_koolproxym_u', v);
	}
	if (v==true){
	var ad = document.form.ad_change[0].checked;
	if (ad==true){
	showhide_div('row_adbyby_whost', v);
	if($j("#ad_dir_2").is(":checked")==true){
showhide_div('row_adbybym_u', v);
}else{
showhide_div('row_adbybyt_u', v);
}
	}
	if (ad==false){
	showhide_div('row_koolproxy_https', v);
	if($j("#ad_dir_2").is(":checked")==true){
showhide_div('row_koolproxym_u', v);
}else{
showhide_div('row_koolproxyt_u', v);
}
	}
	}
	
}

//function change_adbyby_enable(){
//	var v = document.form.adbyby_enable[0].checked;
//	showhide_div('row_adbyby_cpu', v);
//	showhide_div('row_koolproxy_https', v);
//}

function applyRule(){
	showLoading();
		
	document.form.action_mode.value = " Apply ";
	document.form.current_page.value = "/Advanced_adbyby.asp";
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

    <input type="hidden" name="current_page" value="Advanced_adbyby.asp">
    <input type="hidden" name="next_page" value="">
    <input type="hidden" name="next_host" value="">
    <input type="hidden" name="sid_list" value="Storage;General;">
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
                            <h2 class="box_head round_top"><#menu5_13#> - <#menu5_13_2#></h2>
                            <div class="round_bottom">
                                <div class="row-fluid">
                                    <div id="tabMenu" class="submenuBlock"></div>
                                    <div class="alert alert-info" style="margin: 10px;"><#adabout#></div>

                                    <table id="tbl_adbyby" width="100%" cellpadding="4" cellspacing="0" class="table" style="display:none;">
                                        <tr>
                                            <th colspan="2" style="background-color: #E3E3E3;"><#adbb#></th>
                                        </tr>
										<tr>
                                            <th width="50%">
                                                <#adenable#>
                                            </th>
                                            <td>
                                                <div class="main_itoggle">
                                                    <div id="ad_enable_on_of">
                                                        <input type="checkbox" id="ad_enable_fake" <% nvram_match_x("", "ad_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ad_enable", "0", "value=0"); %>>
                                                    </div>
                                                </div>

                                                <div style="position: absolute; margin-left: -10000px;">
                                                    <input type="radio" name="ad_enable" id="ad_enable_1" value="1" onclick="change_ad_enable();" <% nvram_match_x("", "ad_enable", "1", "checked"); %>/><#checkbox_Yes#>
                                                    <input type="radio" name="ad_enable" id="ad_enable_0" value="0" onclick="change_ad_enable();" <% nvram_match_x("", "ad_enable", "0", "checked"); %>/><#checkbox_No#>
                                                </div>
                                            </td>
                                        </tr>
																				<tr id="row_adbyby_cpu" >
                                            <th width="50%">
                                                <#adbybycpu#>
                                            </th>
                                            <td>
                                                <div class="main_itoggle">
                                                    <div id="adbyby_cpu_on_of">
                                                        <input type="checkbox" id="adbyby_cpu_fake" <% nvram_match_x("", "adbyby_cpu", "1", "value=1 checked"); %><% nvram_match_x("", "adbyby_cpu", "0", "value=0"); %>>
                                                    </div>
                                                </div>

                                                <div style="position: absolute; margin-left: -10000px;">
                                                    <input type="radio" name="adbyby_cpu" id="adbyby_cpu_1" class="input" value="1" <% nvram_match_x("", "adbyby_cpu", "1", "checked"); %>/><#checkbox_Yes#>
                                                    <input type="radio" name="adbyby_cpu" id="adbyby_cpu_0" class="input" value="0" <% nvram_match_x("", "adbyby_cpu", "0", "checked"); %>/><#checkbox_No#>
                                                </div>
                                            </td>
                                        </tr>
										<tr id="row_ad_dir" >
                                            <th width="50%">
                                                <#addir#>
                                            </th>
                                            <td>
											<label class="radio inline">
                                                    <input type="radio" name="ad_dir" id="ad_dir_1" value="1" <% nvram_match_x("", "ad_dir", "1", "checked"); %>/><#adtmp#>
													</label>
                                         <label class="radio inline">
                                                    <input type="radio" name="ad_dir" id="ad_dir_2" value="2" <% nvram_match_x("", "ad_dir", "2", "checked"); %>/><#adsmmt#>
													</label>
                                            </td>
                                        </tr>
										<tr id="row_ad_change" >
                                            <th width="50%">
                                                <#adchange#>
                                            </th>
                                            <td>
											<label class="radio inline">
                                                    <input type="radio" name="ad_change" id="ad_change_adbyby" onclick="change_adbyby_enable();" value="1" <% nvram_match_x("", "ad_change", "1", "checked"); %>/><#changeadbyby#>
													</label>
                                         <label class="radio inline">
                                                    <input type="radio" name="ad_change" id="ad_change_koolproxy" onclick="change_koolproxy_enable();" value="2" <% nvram_match_x("", "ad_change", "2", "checked"); %>/><#changekoolproxy#>
													</label>
                                            </td>
                                        </tr>
										<tr id="row_koolproxy_https" style="display:none;">
                                            <th width="50%">
                                                <#koolproxyhttps#>
                                            </th>
                                            <td>
                                                <div class="main_itoggle">
                                                    <div id="koolproxy_https_on_of">
                                                        <input type="checkbox" id="koolproxy_https_fake" <% nvram_match_x("", "koolproxy_https", "1", "value=1 checked"); %><% nvram_match_x("", "koolproxy_https", "0", "value=0"); %>>
                                                    </div>
                                                </div>

                                                <div style="position: absolute; margin-left: -10000px;">
                                                    <input type="radio" name="koolproxy_https" id="koolproxy_https_1" value="1" class="input" <% nvram_match_x("", "koolproxy_https", "1", "checked"); %>/><#checkbox_Yes#>
                                                    <input type="radio" name="koolproxy_https" id="koolproxy_https_0" value="0" class="input" <% nvram_match_x("", "koolproxy_https", "0", "checked"); %>/><#checkbox_No#>
                                                </div>
                                            </td>
                                        </tr>
										 <tr id="row_adbyby_whost" style="display:none;">
										    <th>
                                             <#adbybywhost#>
                                            </th>
                                            <td>
                                                <input type="text" name="adbyby_whost" class="input" maxlength="32" size="32" value="<% nvram_get_x("", "adbyby_whost"); %>"/>
                                            </td>
                                        </tr>
										<tr id="row_adbybyt_u" style="display:none;" >
                                            <td colspan="2">
                                                <a href="javascript:spoiler_toggle('script0')"><span><#adbybytu#></span></a>
                                                <div id="script0" style="display:none;">
                                                    <textarea rows="24" wrap="off" spellcheck="false" maxlength="8192" class="span12" name="adbybyt.user.txt" style="font-family:'Courier New'; font-size:12px; width=100%"><% nvram_dump("adbybyt.user.txt",""); %></textarea>
                                                </div>
                                            </td>
                                        </tr>
										<tr id="row_adbybym_u" style="display:none;" >
                                            <td colspan="2">
                                                <a href="javascript:spoiler_toggle('script1')"><span><#adbybymu#></span></a>
                                                <div id="script1" style="display:none;">
                                                    <textarea rows="24" wrap="off" spellcheck="false" maxlength="8192" class="span12" name="adbybym.user.txt" style="font-family:'Courier New'; font-size:12px; width=100%"><% nvram_dump("adbybym.user.txt",""); %></textarea>
                                                </div>
                                            </td>
                                        </tr>
										<tr id="row_koolproxyt_u" style="display:none;" >
                                            <td colspan="2">
                                                <a href="javascript:spoiler_toggle('script2')"><span><#koolproxytu#></span></a>
                                                <div id="script2" style="display:none;">
                                                    <textarea rows="24" wrap="off" spellcheck="false" maxlength="8192" class="span12" name="koolpyt.user.txt" style="font-family:'Courier New'; font-size:12px; width=100%"><% nvram_dump("koolpyt.user.txt",""); %></textarea>
                                                </div>
                                            </td>
                                        </tr>
										<tr id="row_koolproxym_u" style="display:none;" >
                                            <td colspan="2">
                                                <a href="javascript:spoiler_toggle('script3')"><span><#koolproxymu#></span></a>
                                                <div id="script3" style="display:none;">
                                                    <textarea rows="24" wrap="off" spellcheck="false" maxlength="8192" class="span12" name="koolpym.user.txt" style="font-family:'Courier New'; font-size:12px; width=100%"><% nvram_dump("koolpym.user.txt",""); %></textarea>
                                                </div>
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
