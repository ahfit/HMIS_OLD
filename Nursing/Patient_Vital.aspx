<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="Patient_Vital.aspx.cs" Inherits="Nursing_Patient_Vital" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


<script type="text/javascript">
function picture()
{
window.open("mlc_mainpic.aspx?reg={0}&yno={1}");
}
</script>
 <script src="../css_hacims/ck.js" type="text/javascript"></script>

 <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>


    <script type="text/javascript">
       

        function calculateBMI() {
            // Convert the values from a string to a float
            var weight = parseFloat(document.getElementById('<%= txtweight.ClientID %>').value);
            var height = parseFloat(document.getElementById('<%= txtheight.ClientID %>').value);
            // Make sure both values are valid numbers
            if (!isNaN(height) && !isNaN(weight)) {
                // Show the calculated value in the C box
                document.getElementById('<%= txtBMI.ClientID %>').value = Math.floor((weight / (height * height)) * 10000,2);
                
            }
            else {
                // Can't do any calculations, just show a blank value
                document.getElementById('<%= txtBMI.ClientID %>').value = "";
            }
           
        }
        </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div align="right" style="margin-top:-10px; margin-right:5px; display:none;">
     <a href="#" title="Blood Bank"><img src="../images_hacims/bloodbankb.png" width="32" height="32" /></a>
     <a href="#" title="CT Scan"><img src="../images_hacims/ct.png" width="32" height="32" /></a>
      <a href="#" title="ECG"><img src="../images_hacims/ecg1.png" width="32" height="32" /></a>
      
   <a href="#" title="Medical"><img src="../images_hacims/medical.png" width="32" height="32" /></a>
    <a href="#" title="Medical"><img src="../images_hacims/medicalb.png" width="32" height="32" /></a>
     <a href="#" title="Medicine"><img src="../images_hacims/medicine.png" width="32" height="32" /></a>
      <a href="#" title="Red"><img src="../images_hacims/redc.png" width="32" height="32" /></a>
       <a href="#" title="Wheel Chair"><img src="../images_hacims/wheelchairb.png" width="32" height="32" /></a>
        <a href="#" title="X Ray"><img src="../images_hacims/xraya.png" width="32" height="32" /></a>
   
  
  </div>
    
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
 
</td>
<td  style="width:auto;" valign="top" > 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="75%" style="height: 302px">

<div class="bxmain" style="margin-left:10px; width:98%;">
     <div class="sub-title">
        <h3 style="text-align: left">Patient Vital Detail :</h3>
        <table style="width: 90%; margin: 0 auto;">
            <tr>
               
                <td class="text-right" style="width: 20%;">Weight (kg) 
                </td>
                <td style="width: 35%;">
                    <asp:TextBox ID="txtweight" Width="150px"    Text=""  runat="server"  onkeyup="javascript:calculateBMI();" ></asp:TextBox>
                    
             <%--   <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate ="txtweight" MinimumValue ="1" MaximumValue="200" ForeColor ="Red"  ErrorMessage="Invalid Weight"></asp:RangeValidator>--%>
                </td>

                <td class="text-right" style="width: 20%;">Height (cm) 
                </td>
                <td>
                    <asp:TextBox ID="txtheight" Width="150px"  Text="" MaxLength="11"  runat="server" onkeyup="javascript:calculateBMI();"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="text-right">BP High </td>
                <td>
                    <asp:TextBox ID="txtbpH" Width="150px"  Text=""  runat="server"></asp:TextBox>
                </td>
                <td class="text-right">BP Low </td>
                <td>
                    <asp:TextBox ID="txtbpL" Width="150px" Text=""  runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="text-right">Pulse Rate</td>
                <td>
                    <asp:TextBox ID="txtpulse" Width="150px"  Text="" runat="server"></asp:TextBox>
                </td>
                <td class="text-right">Respiration Rate </td>
                <td>
                    <asp:TextBox ID="txtRespiration" Width="150px" Text="" runat="server"></asp:TextBox>
                </td>
                 
            </tr>
            <tr>
                <td   class="text-right">Blood Sugar 
                </td>
                <td>
                    <asp:TextBox ID="txtblood" Width="150px" Text="" runat="server"></asp:TextBox>
                </td>
                <td class="text-right">Temperature  </td>
                <td>
                    <asp:TextBox ID="txttemp" Width="150px" Text="" runat="server" ></asp:TextBox>
                </td>
                
            </tr>
            <tr>
                <td class="text-right">BMI </td>
                <td colspan="">
                    <asp:TextBox ID="txtBMI" Width="150px" Text="" runat="server"></asp:TextBox>
                </td>
                 <td class="text-right"> SPO2  </td>
                <td>
                    <asp:TextBox ID="txtboxO2" Width="150px" Text="" runat="server" ></asp:TextBox>
                </td>
               </tr>
            
            <tr>
                 <td class="text-right" >Shift</td>

                     <td>
                           <asp:DropDownList ID="DropDownList2" Enabled="True" Width="150px" runat="server">
                                                        <asp:ListItem Value="1">
                                                            Evening
                                                        </asp:ListItem>
                                                          <asp:ListItem Value="2">
                                                              Night
                                                        </asp:ListItem>
                                                                  <asp:ListItem Value="3">
                                                              Morning
                                                        </asp:ListItem>
                                                            </asp:DropDownList>
                       </td>
                 <td class="text-right"> FHR</td>
                <td>
                    <asp:TextBox ID="txtboxRAO2" Width="150px" Text="" runat="server" ></asp:TextBox>
                </td>
                   
            </tr>
             <tr>
                 <td class="text-right" >Notes </td>

                     <td colspan="4">
                         <asp:TextBox ID="txtboxRmarks" runat="server" Width="100%" Height="40px"></asp:TextBox>
                         </td>
          
        </table>
    </div>
      <div style="text-align: center; margin-top: 1%">
           <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Style="height: 5%"  />
          <asp:Button ID="Reportbtn" runat="server" Text="Show Report" OnClick="Reportbtn_Click"  Style="height: 5%"  />

           <asp:Label ID="lblMsg" Text="" runat="server"></asp:Label>
           </div>
    </div>
        <div style="width: 754px; overflow: scroll;margin-left: 10px;">
                <asp:GridView  ID="GridView1" AutoGenerateColumns="false" runat="server"  Width="98%">
              <Columns>
                  
                   
                <asp:TemplateField HeaderText="Date">
                      <ItemTemplate>
                          <asp:Label ID="lblVitalDate" runat="server" Text='<%#Bind("VitalDate") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField> 
                  <asp:TemplateField HeaderText="Time">
                      <ItemTemplate>
                          <asp:Label ID="lblVitalTime" runat="server" Text='<%#Bind("VitalTime") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>     
                  <asp:TemplateField HeaderText="Shift">
                      <ItemTemplate>
                          <asp:Label ID="lblShift" runat="server" Text='<%#Bind("Shift") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="Weight KG">
                      <ItemTemplate>
                          <asp:Label ID="lblWeight_KG" runat="server" Text='<%#Bind("Weight_KG") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                    <asp:TemplateField HeaderText="Height CM">
                      <ItemTemplate>
                          <asp:Label ID="lblHeight_CM" runat="server" Text='<%#Bind("Height_CM") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Temperature F">
                      <ItemTemplate>
                          <asp:Label ID="lblTemperatureF" runat="server" Text='<%#Bind("TemperatureF") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="BPHigh">
                      <ItemTemplate>
                          <asp:Label ID="lblBPHigh" runat="server" Text='<%#Bind("BPHigh") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="BPLow">
                      <ItemTemplate>
                          <asp:Label ID="lblBPLow" runat="server" Text='<%#Bind("BPLow") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                   <asp:TemplateField HeaderText="PulseRate">
                      <ItemTemplate>
                          <asp:Label ID="lblPulseRate" runat="server" Text='<%#Bind("PulseRate") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                    <asp:TemplateField HeaderText="RespirationRate">
                      <ItemTemplate>
                          <asp:Label ID="lblRespirationRate" runat="server" Text='<%#Bind("RespirationRate") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  
                   <asp:TemplateField HeaderText="BloodSugar">
                      <ItemTemplate>
                          <asp:Label ID="lblBloodSugar" runat="server" Text='<%#Bind("BloodSugar") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="BMI">
                      <ItemTemplate>
                          <asp:Label ID="lblBMI" runat="server" Text='<%#Bind("BMI") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="PSO2">
                      <ItemTemplate>
                          <asp:Label ID="lblBMI" runat="server" Text='<%#Bind("O2") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="FHR">
                      <ItemTemplate>
                          <asp:Label ID="lblBMI" runat="server" Text='<%#Bind("RAO2") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes">
                      <ItemTemplate>
                          <asp:Label ID="SugarRemarks" runat="server" Text='<%#Bind("SugarRemarks") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  
                  <asp:TemplateField HeaderText="Nurse">
                      <ItemTemplate>
                          <asp:Label ID="SeenBy" runat="server" Text='<%#Bind("Nurse") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  
                  
                  
              </Columns>
                      </asp:GridView>
                    
        </div>
        <br />

                    <h2></h2>
             <div style="float:left;margin-left:50px">   <div class="data_scroll" style="height: 225px; text-align: center;">
                        <asp:Chart ID="Chart2" runat="server" Height="225px" Width="450px" RightToLeft="Yes">
                            <Series>
                                <asp:Series ChartType="Spline" CustomProperties="BarLabelStyle=Center, PieLabelStyle=Outside"
                                    Font="Microsoft Sans Serif, 8.25pt, style=Bold" IsValueShownAsLabel="True" XValueMember="VitalTime" 
                                    YValueMembers="TemperatureF" IsXValueIndexed="True" Name="Temperature-F" Palette="BrightPastel"
                                    PostBackValue="#INDEX" Legend="Legend1">
                                </asp:Series>
                                
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    
                                    <AxisY Minimum="32" Maximum="212" Interval="Auto"></AxisY>
                                    <Area3DStyle Enable3D="false" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    </div></div>
              
                  <div class="data_scroll" style="height: 225px; text-align: center;">
                        <asp:Chart ID="Chart3" runat="server" Height="225px" Width="450px" RightToLeft="Yes">
                            <Series>
                                <asp:Series ChartType="Spline" CustomProperties="BarLabelStyle=Center, PieLabelStyle=Outside"
                                    Font="Microsoft Sans Serif, 8.25pt, style=Bold" IsValueShownAsLabel="True" XValueMember="VitalTime" 
                                    YValueMembers="PulseRate" IsXValueIndexed="True" Name="PR -BPM" Palette="BrightPastel"
                                    PostBackValue="#INDEX" Legend="Legend1">
                                </asp:Series>
                                
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    
                                    <AxisY Minimum="30" Maximum="120" Interval="Auto"></AxisY>
                                    <Area3DStyle Enable3D="false" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    </div>
             <div style="float:left; margin-left:50px"> 
                   <div class="data_scroll" style="height: 225px; text-align: center;">
                        <asp:Chart ID="Chart4" runat="server" Height="225px" Width="450px" RightToLeft="Yes">
                            <Series>
                                <asp:Series ChartType="Spline" CustomProperties="BarLabelStyle=Center, PieLabelStyle=Outside"
                                    Font="Microsoft Sans Serif, 8.25pt, style=Bold" IsValueShownAsLabel="True" XValueMember="VitalTime" 
                                    YValueMembers="BPHigh" IsXValueIndexed="True" Name="BP High" Palette="BrightPastel"
                                    PostBackValue="#INDEX" Legend="Legend1">
                                </asp:Series>
                                
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    
                                    <AxisY Minimum="70" Maximum="190" Interval="Auto"></AxisY>
                                    <Area3DStyle Enable3D="false" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    </div></div>
             
                    <div class="data_scroll" style="height: 225px; text-align: center;">
                        <asp:Chart ID="Chart1" runat="server" Height="225px" Width="450px">
                            <Series>
                                <asp:Series  ChartType="Spline" CustomProperties="BarLabelStyle=Center, PieLabelStyle=Outside"
                                    Font="Microsoft Sans Serif, 8.25pt, style=Bold" IsValueShownAsLabel="True" XValueMember="VitalTime" 
                                    YValueMembers="BPLow" IsXValueIndexed="True" Name="BP Low" Palette="BrightPastel"
                                    PostBackValue="#INDEX" Legend="Legend1">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    
                                    <AxisY Minimum="70" Maximum="190" Interval="Auto"></AxisY>
                                    <Area3DStyle Enable3D="false" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    </div>
  </td>
  </tr>
  <tr>
    <td valign="top" width="75%" style="height: 302px">

        &nbsp;</td>
  </tr>
  <tr>
    <td valign="top" width="75%" style="height: 302px">

        &nbsp;</td>
  </tr>
</table>  

  <br />
        <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:NurseConnectionString %>"
        ProviderName="<%$ ConnectionStrings:NurseConnectionString.ProviderName %>" SelectCommand="SELECT     Nurse_Record.Date_Time AS Date, Nurse_Record.Clinical_Observation, Nurse_Record.Treatment, &#13;&#10;                      Employee.Prefix + ' ' + Employee.EFName + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS Nurse, Nurse_Record.Type, &#13;&#10;                      Nurse_Record.Nurse_Record_ID, Nurse_Record.Critical_Reading, CASE when Nurse_Record.Critical_Reading=1 THEN ('(Critical)') ELSE '' END AS Critical  &#13;&#10;FROM         Nurse_Record INNER JOIN&#13;&#10;                      Employee ON Nurse_Record.Emp_Id = Employee.EmpID&#13;&#10;WHERE     (Nurse_Record.YearlyNo = @YearlyNo) AND (Nurse_Record.RegNo = @RegNo)&#13;&#10;ORDER BY Date DESC">
        <SelectParameters>
            <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
            <asp:SessionParameter Name="RegNo" SessionField="registrationNo" />
        </SelectParameters>
    </asp:SqlDataSource>

</td>
</tr>
</table>
    
<asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
 </asp:Content>

