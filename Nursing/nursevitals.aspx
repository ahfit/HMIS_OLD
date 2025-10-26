<%@ page language="VB" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="Nursing_nursevitals1, App_Web_iao5qmh5" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../css_hacims/ck.js" type="text/javascript"></script>

    <script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>
    
    <style type="text/css">
        .bxmain
        {
            width:100%;
         }
    
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
                <asp:Panel ID="Panel1" runat="server" Visible="False">
                </asp:Panel>
            </td>
            <td style="width: auto;" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" style="height: 427px; width: 40%;">
                            <div class="bxmain">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                    <tr>
                                        <td align="right" width="20%">
                                            Date :</td>
                                        <td width="80%">
                                            <igsch:WebDateChooser ID="WebDateChooser1" runat="server" CssClass="drop_date" Width="143px">
                                                <CalendarLayout Culture="English (United Kingdom)">
                                                </CalendarLayout>
                                            </igsch:WebDateChooser>
                                            <igtxt:WebDateTimeEdit ID="WebDateTimeEdit1" runat="server" DisplayModeFormat="t"
                                                EditModeFormat="t" Width="62px">
                                            </igtxt:WebDateTimeEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            &nbsp;
                                        </td>
                                        <td>
                                            <asp:RadioButtonList ID="RadioButtonListCategory" runat="server" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" Visible="False">
                                                <asp:ListItem>Ward</asp:ListItem>
                                                <asp:ListItem>ICU</asp:ListItem>
                                                <asp:ListItem>OT</asp:ListItem>
                                            </asp:RadioButtonList></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Pulse :</td>
                                        <td>
                                            <asp:TextBox ID="TextBox_Pulse" runat="server" CssClass="input_txt" Width="55px"
                                                MaxLength="3"></asp:TextBox>
                                            <asp:RangeValidator ControlToValidate="TextBox_Pulse" ID="RangeValidatorPulse" MaximumValue="200"
                                                MinimumValue="0" runat="server" Type="Double" CssClass="small_f" ErrorMessage="Enter Pulse b/w 0 & 200"></asp:RangeValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            B.P. :</td>
                                        <td>
                                            <asp:TextBox ID="TextBox_Bphigh" runat="server" CssClass="input_txt" Width="55px"
                                                MaxLength="3"></asp:TextBox>
                                            <span class="small_f">/</span>
                                            <asp:TextBox ID="TextBox_Bplow" runat="server" CssClass="input_txt" Width="55px"
                                                MaxLength="3"></asp:TextBox>
                                            &nbsp;&nbsp;<asp:Label ID="Label2" runat="server" Text="Higher BP / Lower BP"></asp:Label>
                                            <asp:RangeValidator ControlToValidate="TextBox_Bphigh" ErrorMessage="Enter High B.P below than 300"
                                                ID="RangeValidatorBPHigh" MaximumValue="300" MinimumValue="0" runat="server"
                                                Type="Double" CssClass="small_f"></asp:RangeValidator>
                                            <asp:RangeValidator ControlToValidate="TextBox_Bplow" ErrorMessage="Enter High B.P below 400"
                                                ID="RangeValidatorBPLow" MaximumValue="400" CssClass="small_f" MinimumValue="0"
                                                runat="server" Type="Double"></asp:RangeValidator></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            R.R. :</td>
                                        <td>
                                            <asp:TextBox ID="TextBox_Resp_beats" runat="server" CssClass="input_txt" Width="55px"
                                                MaxLength="2"></asp:TextBox>
                                            &nbsp; <span id="Label3" class="small_f">per min.</span><span></span> &nbsp;
                                            <asp:RangeValidator ControlToValidate="TextBox_Resp_beats" ErrorMessage="Enter R.R b/w 14 and 40"
                                                CssClass="small_f" ID="RangeValidatorResp" MaximumValue="40" MinimumValue="14"
                                                runat="server" Type="Double"></asp:RangeValidator></td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="height: 20px">
                                            Temp:
                                         </td>
                                        <td style="height: 20px">
                                            <asp:TextBox ID="TextBox_Temp_F" runat="server" CssClass="input_txt" Width="55px" MaxLength="4"></asp:TextBox>
                                            &nbsp;&nbsp;<span class="small_f">F</span> <span class="small_f">&nbsp;<asp:RangeValidator
                                                ControlToValidate="TextBox_Temp_F" CssClass="small_f" ErrorMessage="Enter Temp B/w 0 and 107"
                                                ID="RangeValidatorTemp" MaximumValue="107" MinimumValue="0" runat="server" Type="Double"></asp:RangeValidator>
                                                <asp:DropDownList ID="DropDownList_Oxygenation_SAO2" runat="server" Visible="false">
                                                    <asp:ListItem></asp:ListItem>
                                                    <asp:ListItem>75</asp:ListItem>
                                                    <asp:ListItem>100</asp:ListItem>
                                                    <asp:ListItem>125</asp:ListItem>
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            CVP</td>
                                        <td>
                                            <asp:TextBox ID="txtCVP" runat="server" Width="55px" MaxLength="2"></asp:TextBox>
                                         
                                            <asp:RangeValidator ID="RangeValidatorCVP" runat="server" ControlToValidate="txtCVP"
                                                ErrorMessage="Enter From 0 and 15" MaximumValue="15" MinimumValue="0" 
                                                SetFocusOnError="false"></asp:RangeValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Remarks :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRemarks" runat="server" Width="306px" TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="ButtonSave" runat="server" CssClass="btn1" Text="Save" Width="80px" />
                                            <asp:Button ID="ButtonBPreport" runat="server" Text="BPReport" CssClass="btn2" Visible="False" />
                                            <asp:Button ID="ButtonPulse" runat="server" Text="Pulse Report" CssClass="btn2" Visible="False" />
                                            <asp:Button ID="ButtonTemperature" runat="server" Text="Temperature Report" CssClass="btn2"
                                                Visible="False" />
                                            <asp:LinkButton ID="LinkButton_Chart" runat="server" Visible="False">Chart</asp:LinkButton>
                                            <asp:Label ID="Label_Message" runat="server"></asp:Label>
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Nursing/PatientVitalSign_Rpt.aspx"
                                                CssClass="report">Detail Report</asp:HyperLink></td>
                                    </tr>
                                </table>
                                <asp:SqlDataSource ID="SqlDataSourcevitals_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                    InsertCommand="Insert_Patient_Vital_Remarks" InsertCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="txtRemarks" Name="Vital_Remarks" PropertyName="Text"
                                            Type="String" />
                                        <asp:SessionParameter Name="Emp_ID" SessionField="emp_Id" Type="Int32" />
                                        <asp:Parameter Direction="Output" Name="Identity" Type="Int32" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="hf_Remarks_Identity" runat="server" />
                            </div>
                        </td>
                        <td width="60%" valign="top">
                            <div style="margin-left: 1%; width:98%;">
                                <asp:GridView ID="GridViewVitals" runat="server"  CssClass="Grid_1" AutoGenerateColumns="False">
                                    <RowStyle CssClass="GridItem" />
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="Date" />
                                        <asp:BoundField DataField="Time" HeaderText="Time" />
                                        <asp:BoundField DataField="Temp_F" HeaderText="Temp(F)" />
                                        <asp:BoundField DataField="Pluse" HeaderText="Pulse" />
                                        <asp:BoundField DataField="RR" HeaderText="RR" />
                                        <asp:TemplateField HeaderText="B.P">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("[B.P]") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("BPHigh") %>'></asp:Label><asp:Label
                                                    ID="lblSlash" runat="server" Text="/"></asp:Label>
                                                <asp:Label ID="lblBPLow" runat="server" Text='<%# Bind("BPLow") %>'>></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CVP" HeaderText="CVP" /> 
                                        <asp:BoundField DataField="Vital_Remarks" HeaderText="Remarks" />
                                    </Columns>
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                    <FooterStyle HorizontalAlign="Right" />
                                </asp:GridView>
                            </div>                            
                            
                        </td>
                    </tr>
                    
                    
               
                    <tr>
                        <td style="height: 427px" valign="top" colspan="2">
                        <%--ehsan --%>
                        
                        <%--<div class=main_chart>
                            <div class=title_chart>
                                <div class=in_itle_Lchart> Temperature 
                                
                                </div><!--title_chart-->
                                <div class=in_title_rchart>Pulse</div><!--end in_title_rchart-->
                            
                            </div><!--main_chart-->
                            <div class=in_main>
                                <div class=uleft>--%>
                                
                                <%--<asp:Chart id="Chart1" runat="server" 
                                        ImageStorageMode="UseImageLocation" Width="458px" Height="310px">
                                <series>
                                <asp:Series Name="Series1" XValueMember="Time" YValueMembers="Pluse" ChartType="Line" ChartArea="ChartArea1"></asp:Series>
                                    </series>
                                <chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas>
                            </asp:Chart>--%>
</div>
                                <div class =uright>
                                
                                <%--<asp:Chart id="Chart2" runat="server" 
                                        ImageStorageMode="UseImageLocation" Width="458px" Height="310px"><series>
<asp:Series Name="Series1" XValueMember="Time" YValueMembers="Temp(f)" ChartType="Line" ChartArea="ChartArea1"></asp:Series>
</series><chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas></asp:Chart>--%>
                                </div>
                            <%--</div>
                            
                            <div class=title_chart>
                                <div class=in_itle_Lchart>BP-High
                                
                                </div><!--title_chart-->
                                <div class=in_title_rchart>BP-Low
                                </div><!--end in_title_rchart-->
                            
                            </div><!--main_chart-->
                            <div class=din_main>
                                <div class=dleft>--%>
                                <%--<asp:Chart id="Chart3" runat="server" ImageStorageMode="UseImageLocation" 
                                        Width="458px" Height="310px">
                                    <series>
<asp:Series Name="Series1" XValueMember="Time" YValueMembers="RR" ChartType="Line" ChartArea="ChartArea1"></asp:Series>
</series>
                                    <chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas>
                                </asp:Chart>--%>
                                
                                
                                </div><!--end left_in_main chart3-->
                                    
                                    
                                <div class =dright>
                                <%--<asp:chart id="chart4" runat="server" imagestoragemode="useimagelocation" 
                                        width="458px" Height="310px">
                                    <series>
<asp:Series Name="series1" XValueMember="time" YValueMembers="cvp" ChartType="Line" ChartArea="chartarea1"></asp:Series>
</series>
                                    <chartareas>
<asp:chartarea name="chartarea1"></asp:chartarea>
</chartareas>
                                </asp:chart>--%>
                                
                                
                                </div><!--end right_in_main chart4-->
                            </div><!--end in_main-->
                                
                        
                        
                        
                        </div><%--end main_chart--%>
                        
                        
                        <%--ehsan--%>
                        <div>
                            <%--<asp:Chart id="Chart2" runat="server" ImageStorageMode="UseImageLocation" Width="450px"><series>
<asp:Series Name="Series1" XValueMember="Time" YValueMembers="Temp(f)" ChartType="Spline" ChartArea="ChartArea1"></asp:Series>
</series><chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas></asp:Chart>--%>
                            <%--<asp:Chart id="Chart1" runat="server" ImageStorageMode="UseImageLocation" Width="450px">
                                <series>
<asp:Series Name="Series1" XValueMember="Time" YValueMembers="Pluse" ChartType="Spline" ChartArea="ChartArea1"></asp:Series>
</series>
                                <chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas>
                            </asp:Chart>--%>
                            <div>
                                <%--<asp:Chart id="Chart3" runat="server" ImageStorageMode="UseImageLocation" Width="450px">
                                    <series>
<asp:Series Name="Series1" XValueMember="Time" YValueMembers="RR" ChartType="Spline" ChartArea="ChartArea1"></asp:Series>
</series>
                                    <chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas>
                                </asp:Chart>--%>
                                <%--<asp:Chart id="Chart4" runat="server" ImageStorageMode="UseImageLocation" Width="450px">
                                    <series>
<asp:Series Name="Series1" XValueMember="Time" YValueMembers="cvp" ChartType="Spline" ChartArea="ChartArea1"></asp:Series>
</series>
                                    <chartareas>
<asp:ChartArea Name="ChartArea1"></asp:ChartArea>
</chartareas>
                                </asp:Chart>--%></div>
                        </td>
                    </tr>
                </table>
                <div style="display: none;">
                    <div id="inline_example1">
                        <object id="FlashID_comp" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="800px"
                            height="450"><param name="movie" value="../allcharts/Linem.swf" /><param name="quality" value="high" /><param name="wmode" value="transparent" /><param name="swfversion" value="8.0.35.0" />
                            <param name="expressinstall" value="../Scripts/expressInstall.swf" /><param name="flashvars" value="&amp;dataURL=vitals_comp.xml" />
                            <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
                            <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
                            <!--[if !IE]>-->
                        </object>
                        <object type="application/x-shockwave-flash" data="../allcharts/Linem.swf" width="800px"
                            height="450">
                            <!--<![endif]-->
                            <param name="quality" value="high" />
                            <param name="wmode" value="transparent" />
                            <param name="swfversion" value="8.0.35.0" />
                            <param name="expressinstall" value="../Scripts/expressInstall.swf" />
                            <param name="flashvars" value="&amp;dataURL=vitals_comp.xml" />
                            <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
                            <div>
                                <h4>
                                    Content on this page requires a newer version of Adobe Flash Player.</h4>
                                <p>
                                    <a href="http://www.adobe.com/go/getflashplayer">
                                        <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif"
                                            alt="Get Adobe Flash player" width="112" height="33" /></a></p>
                            </div>
                            <!--[if !IE]>-->
                        </object>
                        <!--<![endif]-->
                    </div>
                </div>
                <asp:SqlDataSource ID="SqlDataSourcevitals" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                    InsertCommand="Insert_Patient_Vital_Nurse" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
                    DeleteCommand="DELETE FROM Pt_Stages_Vitals WHERE (vitalsid = @vitalsID)" UpdateCommand="UPDATE Pt_Stages_Vitals SET TemperatureF = @TempF, TemperatureC = @TempC, Pulsebeats = @Pulse, Respirationbeats = @RR, BPHigh = @BPHigh, BPLow = @BPlow, datetime = @DateTime WHERE (vitalsid = @VitalsID)">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenFieldVitalID" Name="VitalID" PropertyName="Value"
                            Type="Int32" />
                        <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                        <asp:SessionParameter Name="SubDeptID" SessionField="SubDeptID" Type="Int32" />
                        <asp:ControlParameter ControlID="RadioButtonListCategory" Name="Category" PropertyName="SelectedValue"
                            Type="String" />
                        <asp:SessionParameter Name="EmpID" SessionField="emp_Id" Type="Int32" />
                        <asp:SessionParameter Name="RegNo" SessionField="registrationNo" Type="String" />
                        <asp:ControlParameter ControlID="HiddenFieldVital_Value" Name="Result" PropertyName="Value"
                            Type="Double" />
                        <asp:ControlParameter ControlID="HiddenFieldVitalTakeDate" Name="DateTime" PropertyName="Value"
                            Type="DateTime" />
                        <asp:Parameter DefaultValue="0" Name="Transfusion_Id" Type="Int32" />
                        <asp:Parameter DefaultValue=" " Name="val" Type="String" />
                        <asp:ControlParameter ControlID="hf_Remarks_Identity" Name="Vital_Remark_ID" PropertyName="Value"
                            Type="Int32" />
                    </InsertParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridViewVitals" Name="vitalsID" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenFieldTemp" Name="TempF" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldTempC" Name="TempC" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldPulse" Name="Pulse" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldRR" Name="RR" PropertyName="Value" />
                        <asp:ControlParameter ControlID="RangeValidatorBPHigh" Name="BPHigh" PropertyName="Text" />
                        <asp:ControlParameter ControlID="RangeValidatorBPLow" Name="BPlow" PropertyName="Text" />
                        <asp:ControlParameter ControlID="HiddenFieldDateTime" Name="DateTime" PropertyName="Value" />
                        <asp:ControlParameter ControlID="GridViewVitals" Name="VitalsID" PropertyName="SelectedValue" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="patient_detail" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="pt_basic_info" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="regno" SessionField="registrationNo" Type="String" />
                        <asp:SessionParameter Name="payid" SessionField="YearlyNo" Type="Int32" />
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldVital_Value" runat="server" />
                <asp:HiddenField ID="HiddenFieldVitalTakeDate" runat="server" />
                <asp:HiddenField ID="HiddenFieldDateTime" runat="server" />
                <asp:HiddenField ID="HiddenFieldTemp" runat="server" />
                <asp:HiddenField ID="HiddenFieldTempC" runat="server" />
                <asp:HiddenField ID="HiddenFieldPulse" runat="server" />
                <asp:HiddenField ID="HiddenFieldRR" runat="server" />
                <asp:HiddenField ID="HiddenFieldBPHigh" runat="server" />
                <asp:HiddenField ID="HiddenFieldBPLow" runat="server" />
                <asp:HiddenField ID="HiddenFieldVitalID" runat="server" />
                <asp:HiddenField ID="hfCVPID" runat="server" />
                <br />
                <br />
            </td>
        </tr>
    </table>

    <script type="text/javascript">
<!--

swfobject.registerObject("FlashID1");
swfobject.registerObject("FlashID2");
swfobject.registerObject("FlashID3");
swfobject.registerObject("FlashID4");
swfobject.registerObject("FlashID_comp");
//-->
    </script>

    <asp:Label ID="LabelFooter" runat="server" Text=""></asp:Label></asp:Content>
