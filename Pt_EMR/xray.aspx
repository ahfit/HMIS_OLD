 <%@ page language="VB" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="xray, App_Web_p0fljamz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
  <script src="../css_hacims/ck.js" type="text/javascript"></script>

<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
 
</td>
<td  style="width:auto;" valign="top" >
     
     


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="248">
    
    <map name="Map" id="Map">
              <area shape="circle" coords="123,40,27" href="radiology_xraydescription.aspx?bodypart=skull" target="holder" />
              <area shape="rect" coords="114,68,133,92" href="radiology_xraydescription.aspx?bodypart=neck" target="holder" />
              <area shape="rect" coords="66,93,116,99" href="radiology_xraydescription.aspx?bodypart=shoulder" target="holder" />
              <area shape="rect" coords="131,94,184,100" href="radiology_xraydescription.aspx?bodypart=shoulder" target="holder" />
              <area shape="poly" coords="47,260,23,279,18,246,22,233,31,222,45,229" href="radiology_xraydescription.aspx?bodypart=3" target="holder" />
              <area shape="poly" coords="99,253,89,242,80,246,77,269,81,358,102,360" href="radiology_xraydescription.aspx?bodypart=lower Limb" target="holder" />
              <area shape="poly" coords="86,425,101,426,102,364,85,361" href="radiology_xraydescription.aspx?bodypart=Lower Limb" target="holder" />
              <area shape="poly" coords="104,472,77,468,81,440,87,428,101,426" href="radiology_xraydescription.aspx?bodypart=foot" target="holder" />
              <area shape="poly" coords="138,368,160,369,162,484,144,485" href="radiology_xraydescription.aspx?bodypart=Lower Limb" target="holder" />
              <area shape="poly" coords="181,510,157,518,146,502,146,486,160,485" href="radiology_xraydescription.aspx?bodypart=foot" target="holder" />
              <area shape="poly" coords="141,246,146,238,154,244,160,247,161,343,160,357,156,365,144,365,139,355" href="radiology_xraydescription.aspx?bodypart=Lower Limb" target="holder" />
              <area shape="poly" coords="109,209,88,201,84,211,86,221,91,229,94,241,95,247,101,260,105,263,112,264,119,259,122,257,127,263,137,261,139,255,145,241,149,233,153,217,156,208,154,204" href="radiology_xraydescription.aspx?bodypart=pelvis" target="holder" />
              <area shape="poly" coords="109,205,133,204,130,183,127,164,126,145,126,126,124,110,127,97,119,95" href="radiology_xraydescription.aspx?bodypart=ABDOMEN AND PELVIC CAVITY" target="holder" />
              <area shape="poly" coords="110,176,99,180,88,178,83,161,80,147,80,136,80,126,79,115,81,106,90,104,98,102,107,100,114,100" href="radiology_xraydescription.aspx?bodypart=lungs" target="holder" />
              <area shape="poly" coords="129,171,139,178,154,180,162,175,164,158,165,146,166,133,166,122,166,115,165,108,164,103,156,102,148,99,140,99,133,99,129,102" href="radiology_xraydescription.aspx?bodypart=lungs" target="holder" />
              <area shape="poly" coords="201,259,210,271,219,276,227,273,228,259,223,247,219,240,217,229,215,229,206,234" href="radiology_xraydescription.aspx?bodypart=3" target="holder" />
              <area shape="poly" coords="203,230,213,224,188,166,185,105,173,105,173,164" href="radiology_xraydescription.aspx?bodypart=forearm" target="holder" />
              <area shape="poly" coords="33,216,46,223,73,165,72,106,60,102,58,152" href="radiology_xraydescription.aspx?bodypart=forearm" target="holder" />
            </map>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">

                  <tr>
                    <td width="248" height="530" valign="top"><img src="../images_hacims/skeleton_002.jpg" width="235" height="518" border="0" usemap="#MapMap" target="holder" href="radiology_xraydescription.aspx?bodypart=pelvis" /></td>
                      </tr>
                </table>  <map name="MapMap" id="MapMap">
                  <area shape="circle" coords="123,40,27" href="radiology_xraydescription.aspx?bodypart=skull" target="holder" />
                  <area shape="rect" coords="114,68,133,92" href="radiology_xraydescription.aspx?bodypart=neck" target="holder" />
                  <area shape="rect" coords="66,93,116,99" href="radiology_xraydescription.aspx?bodypart=shoulder" target="holder" />
                  <area shape="rect" coords="131,94,184,100" href="radiology_xraydescription.aspx?bodypart=shoulder" target="holder" />
                  <area shape="poly" coords="47,260,23,279,18,246,22,233,31,222,45,229" href="radiology_xraydescription.aspx?bodypart=hand" target="holder" />
                  <area shape="poly" coords="99,253,89,242,80,246,77,269,81,358,102,360" href="radiology_xraydescription.aspx?bodypart=lower Limb" target="holder" />
                  <area shape="poly" coords="86,425,101,426,102,364,85,361" href="radiology_xraydescription.aspx?bodypart=lower limb" target="holder" />
                  <area shape="poly" coords="104,472,77,468,81,440,87,428,101,426" href="radiology_xraydescription.aspx?bodypart=foot" target="holder" />
                  <area shape="poly" coords="138,368,160,369,162,484,144,485" href="radiology_xraydescription.aspx?bodypart=lower limb" target="holder" />
                  <area shape="poly" coords="181,510,157,518,146,502,146,486,160,485" href="radiology_xraydescription.aspx?bodypart=foot" target="holder" />
                  <area shape="poly" coords="141,246,146,238,154,244,160,247,161,343,160,357,156,365,144,365,139,355" href="radiology_xraydescription.aspx?bodypart=Lower Limb" target="holder" />
                  <area shape="poly" coords="109,209,88,201,84,211,86,221,91,229,94,241,95,247,101,260,105,263,112,264,119,259,122,257,127,263,137,261,139,255,145,241,149,233,153,217,156,208,154,204" href="radiology_xraydescription.aspx?bodypart=pelvis" target="holder" />
                  <area shape="poly" coords="109,205,133,204,130,183,127,164,126,145,126,126,124,110,127,97,119,95" href="radiology_xraydescription.aspx?bodypart=abdomen and pelvic cavity" target="holder" />
                  <area shape="poly" coords="110,176,99,180,88,178,83,161,80,147,80,136,80,126,79,115,81,106,90,104,98,102,107,100,114,100" href="radiology_xraydescription.aspx?bodypart=lungs" target="holder" />
                  <area shape="poly" coords="129,171,139,178,154,180,162,175,164,158,165,146,166,133,166,122,166,115,165,108,164,103,156,102,148,99,140,99,133,99,129,102" href="radiology_xraydescription.aspx?bodypart=lungs" target="holder" />
                  <area shape="poly" coords="201,259,210,271,219,276,227,273,228,259,223,247,219,240,217,229,215,229,206,234" href="radiology_xraydescription.aspx?bodypart=hand" target="holder" />
                  <area shape="poly" coords="202,229,212,223,187,165,184,104,172,104,172,163" href="radiology_xraydescription.aspx?bodypart=forearm" target="holder" />
                  <area shape="poly" coords="33,216,46,223,73,165,72,106,60,102,58,152" href="radiology_xraydescription.aspx?bodypart=forearm" target="holder" />
                  </map> </td>
    <td style="padding-left:5px;"><iframe 
      src="radiology_xraydescription.aspx" name="holder" width="100%" marginwidth="0" height="530" marginheight="0" 
      scrolling="auto" frameborder="0" id="holder"></iframe></td>
  </tr>
</table>
     
</td>
</tr>
</table>

  <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label>

   </asp:Content>