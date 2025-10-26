<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage.master"
    CodeFile="Pt_Blood_Sugar_Chart.aspx.vb" Inherits="Nursing_Pt_Blood_Sugar_Chart" ValidateRequest = "false" EnableEventValidation ="false" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
function CheckRequirment()
{
    if(document.getElementById("TextBoxsugar").value.length==0)
    {   
        alert("Enter Sugar Value");
        document.getElementById("TextBoxsugar").focus();
        return false;
    }
}
    </script>

    <script src="../css_hacims/ck.js" type="text/javascript"></script>
     <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

    <script>
		$(document).ready(function(){
			$(".sugchart").colorbox({inline:true, width:"53%", height:"83%", href:"#FlashID2"});
			 
				
		});
    </script>

    <%--    --%>
    <!-- 1. Add these JavaScript inclusions in the head of your page -->

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>

    <script type="text/javascript" src="../css_hacims/js_c/highcharts.js"></script>

    <!-- 1a) Optional: add a theme file -->
    <!--
			<script type="text/javascript" src="../js/themes/gray.js"></script>
		-->
    <!-- 1b) Optional: the exporting module -->

    <script type="text/javascript" src="../css_hacims/js_c/modules/exporting.js"></script>

    <!-- 2. Add the JavaScript to initialize the chart on document ready -->

    <script type="text/javascript">
		
			/**
			 * Visualize an HTML table using Highcharts. The top (horizontal) header 
			 * is used for series names, and the left (vertical) header is used 
			 * for category names. This function is based on jQuery.
			 * @param {Object} table The reference to the HTML table to visualize
			 * @param {Object} options Highcharts options
			 */
			Highcharts.visualize = function(table, options) {
				// the categories
				options.xAxis.categories = [];
				$('tbody th', table).each( function(i) {
					options.xAxis.categories.push(this.innerHTML);
				});
				
				// the data series
				options.series = [];
				$('tr', table).each( function(i) {
					var tr = this;
					$('th, td', tr).each( function(j) {
						if (j > 0) { // skip first column
							if (i == 0) { // get the name and init the series
								options.series[j - 1] = { 
									name: this.innerHTML,
									data: []
								};
							} else { // add values
								options.series[j - 1].data.push(parseFloat(this.innerHTML));
							}
						}
					});
				});
				
				var chart = new Highcharts.Chart(options);
			}
				
			// On document ready, call visualize on the datatable.
			$(document).ready(function() {			
				var table = document.getElementById('datatable'),
				options = {
					   chart: {
					      renderTo: 'container1',
						  
					      defaultSeriesType: 'column'
					   },
					   title: {
					      text: 'Blood Sugar Chart'
					   },
					   xAxis: {
					   },
					   yAxis: {
					      title: {
					         text: 'Values'
					      }
					   },
					 
					   dataLabels: {
							enabled: true,
							rotation: 90,
							color: '#333333',
							align: 'right',
							x: -3,
							y: 10,
							formatter: function() {
								return this.y;
							},
							style: {
								font: 'normal 13px Verdana, sans-serif'
							}
					   },
					   tooltip: {
					      formatter: function() {
					         return '<b>'+ this.series.name +'</b><br/>'+
					            this.y +' '+ this.x.toLowerCase();
					      }
					   }
					};
				
			      					
				Highcharts.visualize(table, options);
			});
				
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
            </td>
            <td style="width: auto;" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" width="50%">
                            <div class="bxmain">
                                <table cellpadding="0" cellspacing="0" border="0" class="tbl_form">
                                    <tr>
                                        <td align="right">
                                            Date :
                                        </td>
                                        <td>
                                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                                            </asp:ScriptManager>
                                            
                                            <igsch:WebDateChooser ID="WebDateChooserDateTime" runat="server" Format="Long" CssClass="drop_date"
                                                Width="202px">
                                                <CalendarLayout Culture="English (United Kingdom)">
                                                </CalendarLayout>
                                            </igsch:WebDateChooser>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Sugar :</td>
                                        <td>
                                            <asp:TextBox ID="TextBoxsugar" runat="server" AutoPostBack="True" CssClass="input_txt"></asp:TextBox>&nbsp;
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxsugar"
                                                Display="None" ErrorMessage="Enter Sugar Value"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Injection :
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DropDownListInjection" runat="server" Width="147px">
                                                <asp:ListItem Value="R17863">Humulim Regular</asp:ListItem>
                                                <asp:ListItem Value="R17864">NPH</asp:ListItem>
                                                <asp:ListItem Value="R17865">70/30</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:TextBox ID="TextBoxQty" runat="server" CssClass="input_txt" Width="50px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Route :
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DropDownListRoute" runat="server" Width="147px">
                                                <asp:ListItem>SC</asp:ListItem>
                                                <asp:ListItem>I/V</asp:ListItem>
                                                <asp:ListItem>Other</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Type :
                                        </td>
                                        <td align="left">
                                            <asp:RadioButtonList ID="RadioButtonListType" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem>Fasting</asp:ListItem>
                                                <asp:ListItem>Random</asp:ListItem>
                                            </asp:RadioButtonList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            &nbsp;</td>
                                        <td align="left">
                                            <asp:Button ID="ButtonSave" CssClass="btn1" runat="server" Text="Save" /></td>
                                    </tr>
                                </table>
                            </div>
                            <table id="datatable" style="display: none;">
                                <thead>
                                    <tr>
                                        <th>
                                        </th>
                                        <th>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>
                                            Sep 09, 2011</th>
                                        <td>
                                            40</td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Sep 10, 2011</th>
                                        <td>
                                            60</td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Sep 11, 2011</th>
                                        <td>
                                            70</td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Sep 12, 2011</th>
                                        <td>
                                            100</td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Sep 13, 2011</th>
                                        <td>
                                            140</td>
                                    </tr>
                                </tbody>
                            </table>
                            <div id="container1" style="width: 500px; height: 123px; margin: 0 auto;">
                            </div>
                        </td>
                        <td valign="top" width="50%">
                            <div style="margin-left: -134px;"  class="sugchart" title="Blood Sugar Chart" >
                                <%--<object id="FlashID1" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="420"
                                    height="300">
                                    <param name="movie" value="../allcharts/Column2D.swf" />
                                    <param name="quality" value="high" />
                                    <param name="wmode" value="transparent" />
                                    <param name="swfversion" value="8.0.35.0" />
                                    <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
                                    <param name="expressinstall" value="../Scripts/expressInstall.swf" />
                                    <param name="flashvars" value="&amp;dataURL=sugarchart.xml&chartWidth=420&chartHeight=300" />
                                    <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
                                    <!--[if !IE]>-->
                                    application/x-shockwave-flash<object type="application/x-shockwave-flash" data="../allcharts/Column2D.swf" width="420"
                                        height="300">
                                        <!--<![endif]-->
                                        <param name="quality" value="high" />
                                        <param name="wmode" value="transparent" />
                                        <param name="swfversion" value="8.0.35.0" />
                                        <param name="expressinstall" value="../Scripts/expressInstall.swf" />
                                        <param name="flashvars" value="&amp;dataURL=sugarchart.xml&chartWidth=420&chartHeight=300" />
                                        <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
                                        <div>
                                            <h4>
                                                Content on this page requires a newer version of Adobe Flash Player.</h4>
                                            <p>
                                                <a href="http://www.adobe.com/go/getflashplayer">
                                                    <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"
                                                        alt="Get Adobe Flash player" width="112" height="33" /></a>
                                            </p>
                                        </div>
                                        <!--[if !IE]>-->
                                    </object>
                                    <!--<![endif]-->
                                </object>--%>
                                <%--<asp:Chart id="Chart1" runat="server" DataSourceID="SqlDataSource1" ImageStorageMode="UseImageLocation" Width="418px">
                                    <series>
<asp:Series Name="Series1" XValueMember="Time" YValueMembers="Sugar" ChartType="Line" ChartArea="ChartArea1"></asp:Series>
</series>
                                    <chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas>
                                </asp:Chart>--%>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT Pt_Blood_Sugar_Chart.Item_Qty, Pt_Blood_Sugar_Chart.Route, Pt_Blood_Sugar_Chart.Sugar, CONVERT (varchar, Pt_Blood_Sugar_Chart.Date_Time, 107) AS Date, CONVERT (varchar, Pt_Blood_Sugar_Chart.Date_Time, 108) AS Time, Store_Items.Item_Name FROM Pt_Blood_Sugar_Chart LEFT OUTER JOIN Store_Items ON Pt_Blood_Sugar_Chart.Item_Code = Store_Items.Item_Code WHERE (Pt_Blood_Sugar_Chart.RegNo = @RegNo) AND (Pt_Blood_Sugar_Chart.YearlyNo = @YearlyNo)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            <div style="display: none;">
                                <object id="FlashID2" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="650"
                                    height="450">
                                    <param name="movie" value="../allcharts/Line.swf" />
                                    <param name="quality" value="high" />
                                    <param name="wmode" value="transparent" />
                                    <param name="swfversion" value="8.0.35.0" />
                                    <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
                                    <param name="expressinstall" value="../Scripts/expressInstall.swf" />
                                    <param name="flashvars" value="&amp;dataURL=sugarchart.xml&chartWidth=650&chartHeight=450" />
                                    <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
                                    <!--[if !IE]>-->
                                    <object type="application/x-shockwave-flash" data="../allcharts/Column2D.swf" width="650"
                                        height="450">
                                        <!--<![endif]-->
                                        <param name="quality" value="high" />
                                        <param name="wmode" value="transparent" />
                                        <param name="swfversion" value="8.0.35.0" />
                                        <param name="expressinstall" value="../Scripts/expressInstall.swf" />
                                        <param name="flashvars" value="&amp;dataURL=sugarchart.xml&chartWidth=650&chartHeight=450" />
                                        <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
                                        <div>
                                            <h4>
                                                Content on this page requires a newer version of Adobe Flash Player.</h4>
                                            <p>
                                                <a href="http://www.adobe.com/go/getflashplayer">
                                                    <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"
                                                        alt="Get Adobe Flash player" width="112" height="33" /></a>
                                            </p>
                                        </div>
                                        <!--[if !IE]>-->
                                    </object>
                                    <!--<![endif]-->
                                </object>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="HiddenFieldDateTime" runat="server" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceInsert" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                        <asp:BoundField DataField="Time" HeaderText="Time" ReadOnly="True" SortExpression="Time" />
                        <asp:BoundField DataField="Sugar" HeaderText="Sugar" SortExpression="Sugar" />
                        <asp:BoundField DataField="Item_Name" HeaderText="Injection" SortExpression="Item_Name" />
                        <asp:BoundField DataField="Item_Qty" HeaderText="Qty" SortExpression="Item_Qty" />
                        <asp:BoundField DataField="Route" HeaderText="Route" SortExpression="Route" />
                    </Columns>
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SqlDataSourceInsert" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
                    InsertCommand="INSERT INTO Pt_Blood_Sugar_Chart(RegNo, YearlyNo, Sugar, Item_Code, Item_Qty, Route, Type, Date_Time) VALUES (@RegNo, @YearlyNo, @Sugar, @Item_Code, @Item_Qty, @Route, @Type, @Date_Time)"
                    ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT Pt_Blood_Sugar_Chart.Item_Qty, Pt_Blood_Sugar_Chart.Route, Pt_Blood_Sugar_Chart.Sugar, CONVERT (varchar, Pt_Blood_Sugar_Chart.Date_Time, 107) AS Date, CONVERT (varchar, Pt_Blood_Sugar_Chart.Date_Time, 108) AS Time, Store_Items.Item_Name FROM Pt_Blood_Sugar_Chart LEFT OUTER JOIN Store_Items ON Pt_Blood_Sugar_Chart.Item_Code = Store_Items.Item_Code WHERE (Pt_Blood_Sugar_Chart.RegNo = @RegNo) AND (Pt_Blood_Sugar_Chart.YearlyNo = @YearlyNo)">
                    <SelectParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                        <asp:ControlParameter ControlID="TextBoxsugar" Name="Sugar" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownListInjection" Name="Item_Code" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="TextBoxQty" Name="Item_Qty" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownListRoute" Name="Route" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RadioButtonListType" Name="Type" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldDateTime" Name="Date_Time" PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                </td>
        </tr>
    </table>

    <script type="text/javascript">
<!--

swfobject.registerObject("FlashID1");
swfobject.registerObject("FlashID2"); 
//-->
    </script>

    <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
</asp:Content>
