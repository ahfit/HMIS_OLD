<%@ Page Language="VB" AutoEventWireup="false" CodeFile="View_Room_Bed_Status_Doctor.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Patient_Billing_View_Room_Bed_Status_Doctor" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register src="~/Patient Billing/UserControlls/changeRoomRequest.ascx"   tagname="ChangeRoom" tagprefix="ChangeRoom" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <%--<script type="text/javascript">
          function confirmationRequest() {
              if (confirm('Are you sure you want to Forword the Clearance Request?')) {
                  return true;
              } else {
                  return false;
              }
          }
   </script>--%>
    <style type="text/css">
        .bxmain3 {
            background: honeydew !important;
        }

        @-webkit-keyframes blink {
            from {
                opacity: 1.0;
            }

            to {
                opacity: 0.0;
            }
        }

        .blink {
            -webkit-animation-name: blink;
            -webkit-animation-iteration-count: infinite;
            -webkit-animation-timing-function: cubic-bezier(1.0, 0, 0, 1.0);
            -webkit-animation-duration: 1s;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
     
    <div id="patient_info" runat="server" style="margin-top:5px; margin-bottom:5px;" >


<asp:FormView ID="FormView2" runat="server"  HorizontalAlign="Left" Width="100%"><EditItemTemplate>
                PayID:
                <asp:TextBox ID="PayIDTextBox" runat="server" Text='<%# Bind("PayID") %>'> </asp:TextBox>
                
                PatientName:
                <asp:TextBox ID="PatientNameTextBox" runat="server" Text='<%# Bind("PatientName") %>'> </asp:TextBox>
                
                Relation:
                <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                
                RelationName:
                <asp:TextBox ID="RelationNameTextBox" runat="server" Text='<%# Bind("RelationName") %>'> </asp:TextBox>
                
                Age:
                <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                
                PatientType:
                <asp:TextBox ID="PatientTypeTextBox" runat="server" Text='<%# Bind("PatientType") %>'> </asp:TextBox>
                
                BPHigh:
                <asp:TextBox ID="BPHighTextBox" runat="server" Text='<%# Bind("BPHigh") %>'> </asp:TextBox>
                
                BPLow:
                <asp:TextBox ID="BPLowTextBox" runat="server" Text='<%# Bind("BPLow") %>'> </asp:TextBox>
                
                Pulse:
                <asp:TextBox ID="PulseTextBox" runat="server" Text='<%# Bind("Pulse") %>'> </asp:TextBox>
                
                Temperature:
                <asp:TextBox ID="TemperatureTextBox" runat="server" Text='<%# Bind("Temperature") %>'> </asp:TextBox>
                
                RR:
                <asp:TextBox ID="RRTextBox" runat="server" Text='<%# Bind("RR") %>'> </asp:TextBox>
                
                StreetAddress:
                <asp:TextBox ID="StreetAddressTextBox" runat="server" Text='<%# Bind("StreetAddress") %>'> </asp:TextBox>
                
                HomePhone:
                <asp:TextBox ID="HomePhoneTextBox" runat="server" Text='<%# Bind("HomePhone") %>'> </asp:TextBox>
                
                MobilePhone:
                <asp:TextBox ID="MobilePhoneTextBox" runat="server" Text='<%# Bind("MobilePhone") %>'> </asp:TextBox>
                
                CNIC:
                <asp:TextBox ID="CNICTextBox" runat="server" Text='<%# Bind("CNIC") %>'> </asp:TextBox>
                
                Year:
                <asp:TextBox ID="YearTextBox" runat="server" Text='<%# Bind("Year") %>'> </asp:TextBox>
                
                AgeType:
                <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="Update"> </asp:LinkButton>
                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel"> </asp:LinkButton>
            
</EditItemTemplate>
<InsertItemTemplate>
                PayID:
                <asp:TextBox ID="PayIDTextBox" runat="server" Text='<%# Bind("PayID") %>'> </asp:TextBox>
                
                PatientName:
                <asp:TextBox ID="PatientNameTextBox" runat="server" Text='<%# Bind("PatientName") %>'> </asp:TextBox>
                
                Relation:
                <asp:TextBox ID="RelationTextBox" runat="server" Text='<%# Bind("Relation") %>'> </asp:TextBox>
                
                RelationName:
                <asp:TextBox ID="RelationNameTextBox" runat="server" Text='<%# Bind("RelationName") %>'> </asp:TextBox>
                
                Age:
                <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>'> </asp:TextBox>
                
                PatientType:
                <asp:TextBox ID="PatientTypeTextBox" runat="server" Text='<%# Bind("PatientType") %>'> </asp:TextBox>
                
                BPHigh:
                <asp:TextBox ID="BPHighTextBox" runat="server" Text='<%# Bind("BPHigh") %>'> </asp:TextBox>
                
                BPLow:
                <asp:TextBox ID="BPLowTextBox" runat="server" Text='<%# Bind("BPLow") %>'> </asp:TextBox>
                
                Pulse:
                <asp:TextBox ID="PulseTextBox" runat="server" Text='<%# Bind("Pulse") %>'> </asp:TextBox>
                
                Temperature:
                <asp:TextBox ID="TemperatureTextBox" runat="server" Text='<%# Bind("Temperature") %>'> </asp:TextBox>
                
                RR:
                <asp:TextBox ID="RRTextBox" runat="server" Text='<%# Bind("RR") %>'> </asp:TextBox>
                
                StreetAddress:
                <asp:TextBox ID="StreetAddressTextBox" runat="server" Text='<%# Bind("StreetAddress") %>'> </asp:TextBox>
                
                HomePhone:
                <asp:TextBox ID="HomePhoneTextBox" runat="server" Text='<%# Bind("HomePhone") %>'> </asp:TextBox>
                
                MobilePhone:
                <asp:TextBox ID="MobilePhoneTextBox" runat="server" Text='<%# Bind("MobilePhone") %>'> </asp:TextBox>
                
                CNIC:
                <asp:TextBox ID="CNICTextBox" runat="server" Text='<%# Bind("CNIC") %>'> </asp:TextBox>
                
                Year:
                <asp:TextBox ID="YearTextBox" runat="server" Text='<%# Bind("Year") %>'> </asp:TextBox>
                
                AgeType:
                <asp:TextBox ID="AgeTypeTextBox" runat="server" Text='<%# Bind("AgeType") %>'> </asp:TextBox>
                
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                    Text="Insert"> </asp:LinkButton>
                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="Cancel"> </asp:LinkButton>
            
</InsertItemTemplate>
<ItemTemplate>

<div id="p_info" class="patient-info">

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <%-- <td valign="top" style="width:70px;">
       <asp:Image ID="Image_Pic" runat="server" Height="80px" ImageUrl="~/images_hacims/picplace.jpg"
            Style="margin-left: 5px" Width="70px" /></td>--%>
    <td  valign="top" style="padding-left:10px;" align="left">
    
<ul>
<li>
<span class="name-p"> <asp:Label id="PatientNameLabel" runat="server"  Text='<%# Eval("prefix", "{0}") %>'></asp:Label></span>
<span class="relation">&nbsp;<asp:Label id="RelationLabel" runat="server" Text='<%# Bind("Relation", "{0}") %>'></asp:Label>&nbsp;</span>
<strong><asp:Label id="RelationNameLabel" runat="server"  Text='<%# Eval("RELATIONNAME", "{0}") %>'></asp:Label></strong>
<span class="age"><asp:Label id="AgeLabel" runat="server"  Text='<%# Bind("Age") %>' ></asp:Label> <span class="splt">|</span><asp:Label id="LabelDateofBirth" runat="server"  Text='<%# Eval("DateOfBirth") %>' ></asp:Label><span class="splt">|</span><asp:Label id="LabelGender" runat="server" Text='<%# Eval("Gender", "{0}") %>'></asp:Label></span>
<span class="add"> <asp:Label ID="Label_Address" runat="server" Text='<%# Bind("Address", "{0}") %>' ></asp:Label></span>
<span class="age">MR/OPD # &nbsp;&nbsp;<span class="reg"><asp:Label id="RegistrationNo" runat="server" Text='<%# Eval("RegNo") %>'></asp:Label></span><span class="splt">|</span>Patient Type &nbsp;<span class="visit"><asp:Label ID="Label_Patient_Type" runat="server" Text='<%# Eval("Patient_Type") %>'></asp:Label></span></span>
</li>
</ul> 
    
</td>
<td style="width:250px; padding-right:5px;" valign="top"> 
<div class="bxmain_1"> 
<table  border="0" cellspacing="0" cellpadding="0" class="tbl" width="96%">
  <tr >
    <td ><span title="Department"><asp:Label ID="Label_Department" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label></span>
<span class="splt">/<asp:Label ID="Label_SubDept" runat="server" Text='<%# Eval("SubDept_Name") %>'></asp:Label></span></td>  
  
  </tr>
  <tr>
    <td>
    <span class="docname" title="Doctor Name"> 
    <asp:Label ID="Label_DoctorName" runat="server" Text='<%# Bind("DoctorName", "{0}") %>'></asp:Label>
    </span>
    </td>
   
  </tr>
  <tr>
    <td >
    <strong>
        <asp:Label ID="Label1"    runat="server" Text='<%# Bind("BedNo", "{0}") %>'></asp:Label>
    </strong>
    </td>
    </tr>
   <tr>
    <td>
        <span class="age red" title="Diagnosis"><asp:Label ID="Label_Diagnosis" runat="server" Visible="false"  Text='<%# Bind("Diagonosis", "{0}") %>'></asp:Label></span>
    </td>
   
  </tr>
</table>

 </div>
</td>
      
  </tr>
  <tr style = "display :none;">
  <td>
      </span><span class="splt">|</span>Visit #&nbsp;<span class="visit"><asp:Label ID="Label_PayID" runat="server" Text='<%# Eval("PayID") %>'></asp:Label>
  </td>
  </tr>
</table>
  
  


<asp:HiddenField ID="HiddenField_Pfname" runat="server" Value='<%# Eval("pfname", "{0}") %>' />
    <asp:HiddenField ID="HiddenField_Pmname" runat="server" Value='<%# Eval("pmname", "{0}") %>' />
    <asp:HiddenField ID="HiddenField_Plname" runat="server" Value='<%# Eval("plname", "{0}") %>' />
    
   </div>  




</ItemTemplate>
</asp:FormView>



  <asp:SqlDataSource ID="patient_detail" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
            SelectCommand="pt_basic_info" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_regNo" Name="regno" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_Payis" Name="payid" PropertyName="Value"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_regNo" runat="server" />
        <asp:HiddenField ID="HiddenField_Payis" runat="server" />
  
                 <asp:ObjectDataSource ID="ObjectDataSource1" runat="server">
                 </asp:ObjectDataSource>
  
  
  
  
  
  </div> 
        
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span style="font-size: 10px;">IPD Patient List</span>

        </h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td width="70%" align="center">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr  style="display:none">
                            <td width="40%" align="right">
                                <strong>Department :</strong>&nbsp;
                            </td>
                            <td width="60%">
                                <asp:DropDownList ID="DDL_Department" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Department"
                                    DataTextField="Dept_Name" CssClass="dropbox" DataValueField="Dept_ID" Width="250px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="select 0 as Dept_ID,'--ALL--' as Dept_Name union select Dept_ID,Dept_Name from Department where Dept_ID in (76,77)"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr style="margin-left:30%">
                            <td width="40%" align="right">
                                <strong>Unit / Floor :</strong>&nbsp;
                            </td>
                            <td width="60%">
                                <asp:DropDownList ID="DropDownListFloor" runat="server" AutoPostBack="false" DataSourceID="SqlDataSourceFloor"
                                    DataTextField="Ward_Name" CssClass="dropbox" DataValueField="Ward_id" Width="250px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Button ID="btnViewData" runat="server" Text="Search" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnViewReport" runat="server" Text="View Report" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="right" width="30%">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <td align="center" width="100%">
                                    <asp:Label ID="lblDischargePati" Text="Dischargeable Patients :" Font-Bold="true"
                                        ForeColor="Black" runat="server" Font-Size="Medium"  Visible="false"/>
                                    <asp:Label ID="lblTotalDischargeable" ForeColor="blue" Font-Bold="true" Font-Size="Large"
                                        Text="" runat="server" Visible="false" />
                                </td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:DataList ID="dlFloors" runat="server" RepeatLayout="Table" RepeatColumns="7"
        RepeatDirection="Horizontal" Style="margin-left: 10px;" Visible="false">
        <ItemTemplate>
            <div class="bxmain3 inner_content" style="padding-left: 5px; padding-right: 5px; margin-right: 10px; margin-bottom: 5px;">
                <h2>
                    <asp:Label ID="lblFloorName" runat="server" Text='<%# Eval("Ward_Name") %>' Font-Size="Medium"
                        ForeColor="Black" Font-Bold="true"></asp:Label>
                    :
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Allocated") %>' ForeColor="lightseagreen"
                        Font-Size="X-Large" Font-Bold="true"></asp:Label>
                    <%--<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td valign="top">
                <strong style="color:darkgreen;">
                    Total Room :  </strong>
                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("Total") %>' Font-Bold="true"></asp:Label>
               
                </td>
            </tr>
            <tr>
                <td valign="top">
                <strong style="color: orangered;">
                    Allocated :  </strong>
                    <asp:Label ID="lblAllocated" runat="server" Text='<%# Eval("Allocated") %>' Font-Bold="true"></asp:Label>
               </td>
            </tr>
            <tr>
                <td valign="top">
                <strong style="color: indigo;">
                    Un Allocated :  </strong>
                    <asp:Label ID="lblUnAllocated" runat="server" Text='<%# Eval("UnAllocated") %>' Font-Bold="true"></asp:Label>
               
                 </td>
            </tr>
                </table>--%>
            </div>
        </ItemTemplate>
        <%-- <SelectedItemStyle BackColor="#666666" />--%>
    </asp:DataList>
    <%--  <asp:CheckBoxList runat="server" ID="CbList" DataTextField="Ward_Detail" DataValueField="Ward_Id"
        RepeatDirection="Horizontal" RepeatLayout="Table" Font-Bold="true" ForeColor="blue">
    </asp:CheckBoxList>--%>
    <asp:Panel ID="pnlGrid" runat="server" Visible="true">
       
        <div style="color: brown; font-weight: bold; font-size: 20px; padding: 10px">
            
                <asp:Label ID="lblmsg" runat="server" Text="Patient Is Not Discharge Due To Bill Not Paid"  Visible="false"></asp:Label>
         
        </div>
       
        <asp:GridView ID="GridViewTest" runat="server" AutoGenerateColumns="False" CssClass="Grid_2" 
            Font-Bold="true" Style="font-size: large !important" DataKeyNames="Bed_No,ward_Id"
            Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="0%">
                    <ItemTemplate>
                       
                        <asp:Label runat="server" ID="lblSerial"></asp:Label>
                        <asp:Label runat="server" ID="lblT" Text="Total :" Visible="false"></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblGT" Text="Grand Total : " runat="server"></asp:Label>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right"/>
                </asp:TemplateField>
                <asp:BoundField DataField="Yearly_No" HeaderText="File No." SortExpression="Indoor_No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Reg_No" HeaderText="Reg No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField HeaderText="Floor/Unit Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("Ward_Name") %>' ID="lblWardName" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Bed_No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderText="Bed/Room No." SortExpression="Bed_No" />
                <asp:TemplateField HeaderText="Patient Name">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_Patient" Text='<%# Bind("Patient_Name")%>' runat="server"
                            EnableTheming="False" ToolTip='<%# Eval("Yearly_No") %>' CommandArgument='<%# Eval("Reg_No") %>'
                            OnClick="LinkButton_Patient_Click"></asp:LinkButton><%--CommandName="Select"--%>
                        <asp:Label ID="Label2" runat="server" Text="Label" Visible="False"></asp:Label>
                        <asp:HiddenField ID="hf_regno" runat="server" Value='<%# Eval("Reg_No") %>' />
                        <asp:HiddenField ID="Hf_Yearly" runat="server" Value='<%# Eval("Yearly_No") %>' />
                        <asp:HiddenField ID="hf_WardID" runat="server" Value='<%# Eval("Ward_id") %>' />
                        <asp:HiddenField ID="hf_BedID" runat="server" Value='<%# Eval("Bed_id") %>' />
                        <asp:HiddenField ID="hf_FloorID" runat="server" Value='<%# Eval("FloorID")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Addmission_Date" HeaderText="Admission Date" SortExpression="Addmission_Date" />

                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Datedifference" HeaderText="Total Days" SortExpression="Datedifference" />
                <asp:BoundField DataField="Consultant_Name" HeaderText="Consultant Name" SortExpression="Consultant_Name" />

                <asp:TemplateField HeaderText="Bill" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Visible="false">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("Bill")%>' Width="50px" ForeColor="Blue" Font-Underline="true"
                            ID="glblBill" runat="server" />

                        <asp:Label ID="lblTotalBill" runat="server" Text="" Visible="false"></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="Bill" Text="" runat="server"></asp:Label>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" Font-Size="Larger"/>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Advance" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Visible="false">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("Advance")%>' Width="50px" ForeColor="Blue" Font-Underline="true"
                            ID="glblAdvance" runat="server" />
                        <asp:Label ID="lblTotalAdvance" runat="server" Text="" Visible="false"></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="Advance" runat="server" Visible="false"></asp:Label>
                    </FooterTemplate>
                    <FooterStyle HorizontalAlign="Right" Font-Size="Larger"/>
                </asp:TemplateField>
                <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="RemarkRoom/Bed Details" Visible="false" />
                
                <asp:TemplateField  HeaderText="Services" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnServicees" runat="server" OnClick="btnServicees_Click" CommandArgument='<%# Eval("Reg_No") %>'
                            ToolTip='<%# Eval("Yearly_No") %>'
                            Text="Services"></asp:LinkButton>
                    </ItemTemplate>

                </asp:TemplateField>
                <asp:TemplateField HeaderText="Services" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="Slnk_btn" runat="server" OnClick="lnk_btn_Click" Visible="false">Services</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Out-Standing Bill" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_PacKage" runat="server" CommandArgument='<%# Eval("Reg_No") %>'
                            ToolTip='<%# Eval("Yearly_No") %>'
                            Text="Out-Standing Bill" OnClick="lnk_PacKage_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Discharge" Visible="false" ControlStyle-Width="80px">
                    <ItemTemplate>
                        <asp:HiddenField ID="hfDischargeButton" runat="server"  Value='<%# Eval("DischargeVisibility") %>' />
                        <asp:LinkButton ID="lnkbtnDischarge"  ToolTip='<%#Bind("Is_Dischargeable") %>' Font-Bold="true"
                            ForeColor="Red" runat="server" Text="Discharge" OnClick="lnkbtnDischarge_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
              
                <asp:TemplateField HeaderText="Bed Transfer Request" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_PanelBill" runat="server" CommandArgument='<%# Eval("Reg_No") %>'
                         Text="Bed Transfer Request"   ToolTip='<%# Eval("Yearly_No") %>' OnClick="lnk_btn_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Forward" Visible="false">
                    <ItemTemplate>
                        
                        <asp:HiddenField ID="hfForwardButton" runat="server" Value='<%# Eval("ForwardVisibility") %>' />
                        <asp:LinkButton Width="140px"  ID="btnForward" runat="server" CommandArgument='<%# Eval("Reg_No") %>' ToolTip='<%# Eval("Yearly_No") %>' OnClick="btnForward_Click" OnClientClick="javascript: return confirm('Are you sure you want Forword the Clearance Request?')">Forward for Clearance </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="GridHeader2" />
        </asp:GridView>
    </asp:Panel>
    <div style="display:none">
    <div style="height: 30px; border-top: #CCC dotted 1px; width: 100%; display: block; line-height: 28px; font-weight: bold; color: #000000; font-size: 17px;" >
        <div align="right" style="float: right;">
            <strong>
                <asp:Label ID="LabelAdvance" runat="server" Text="Advance Grand Total :"></asp:Label></strong>
            <strong>
                <asp:Label ID="LabelAdvanceT" Text="" runat="server" CssClass="marks" style="font-size:17px !important"></asp:Label></strong> |
            <strong>
                <asp:Label ID="LabelGtotal" runat="server" Text="Bill Grand Total :"></asp:Label></strong>
            <strong>
                <asp:Label ID="LabelTotal" Text="" runat="server" CssClass="marks" style="font-size:17px !important"></asp:Label></strong>
        </div>
    </div>
        </div>
    <asp:Panel ID="pnlReport" runat="server" Visible="false">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </asp:Panel>
    <asp:Panel ID="Panel2" CssClass = "lightbox"  runat="server"  Visible="false" ><%--CssClass = "lightbox"--%>
         
  <asp:HiddenField ID="reg11" runat ="server" />
     <asp:HiddenField ID="yearlyNo" runat ="server" />
     <asp:HiddenField ID="wardID" runat ="server" />
     <asp:HiddenField ID="bedid" runat ="server" />
     <asp:HiddenField ID="hf_FloorID" runat ="server" />
         <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
             
            <tr>
                <td align="right">
                    Discharge Status :
                </td>
                <td>
                     <asp:DropDownList ID="DropDownList1" runat="server"  
                                     >
                             <asp:ListItem Value="Normal"  >Normal</asp:ListItem> 
                          <asp:ListItem Value="LAMA"  >LAMA</asp:ListItem> 
                          <asp:ListItem Value="DOR"  >DOR</asp:ListItem>
                         <asp:ListItem Value="Expired"  >Expired</asp:ListItem> 

                     </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">
                   Refer Doctor :
                </td>
                <td style="height: 18px">
                      <asp:DropDownList ID="DropDownList_Company" runat="server" DataSourceID="SqlDataSource_parties"
                                    DataTextField="Party_Name" DataValueField="Party_Id" >
                                </asp:DropDownList>
                     <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                    SelectCommand="Select EmpID Party_Id,isnull(Employee.EFName,'')+' '+isnull(Employee.EMName,'')+' '+isnull(Employee.ELName,'') Party_Name  from Employee where Is_Consultant=1">
                    <SelectParameters>
                        <asp:Parameter  Name="Party_Id" DefaultValue="0"
                             />
                    </SelectParameters>
                </asp:SqlDataSource>
                </td>
           
            <%--<tr>
                <td align="right">
                   Current Payment :
                </td>
                <td>
                       <asp:TextBox ID="TextBox2" runat="server" CssClass="input_txt" Width="64px" SkinID="intdata"
                                                    Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Panel Amount :
                </td>
                <td>
                      <asp:TextBox ID="TextBox_Panel" runat="server" AutoPostBack="True" Enabled="False">0</asp:TextBox>
                 
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">
                    Company :
                </td>
                <td style="height: 18px">
                      <asp:DropDownList ID="DropDownList_Company" runat="server" DataSourceID="SqlDataSource_parties"
                                    DataTextField="Party_Name" DataValueField="Party_Id" Enabled="False">
                                </asp:DropDownList>
                     <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                    SelectCommand="SELECT     Party_Id, Party_Name FROM  Parties where Party_Id=@Party_Id ">
                    <SelectParameters>
                        <asp:Parameter  Name="Party_Id" DefaultValue="0"
                             />
                    </SelectParameters>
                </asp:SqlDataSource>
                </td>--%>
            </tr>
            <tr>
                <td align="right">
                    Reason :
                </td>
                <td>
                     <asp:TextBox Height="150px" ID="txtRemarks" TextMode="MultiLine" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                            </td>
                <td>
                </td>
            </tr>
            <tr style="margin-left=20%">
                <td align="right">
                   
                </td>
                <td>
                   <asp:Button ID="Button_Report" runat="server" OnClick="Button_Report_Click" Text="Discharge" OnClientClick="javascript: return confirm('Are you sure you want to Discharge?')" />
                     <asp:Button ID="Button_Close" runat="server" Text="Close" OnClick="Button_Close_Click"/>
                    <asp:Label ID="LBL_Message" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    
   
          
    <asp:Panel ID="pnlChangeRequest" CssClass = "lightbox"  runat="server" Visible="false"><%--CssClass="lightbox"--%>
          <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">

                <h2><span>Change Ward / Floor</span></h2>
              
                <ChangeRoom:ChangeRoom runat="server" ID="ChangeRoom" />

             
             <%-- <asp:PlaceHolder ID="placeHolderForm" runat="server"></asp:PlaceHolder>--%>
              </div>
    </asp:Panel>
  
    <br />
    <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT  Ward_id,Ward_Name FROM  admin_Hospital_Wards WHERE (isDeleted = 0) ">
       <%-- <SelectParameters>
            <asp:SessionParameter Name="SubDeptId" SessionField="SubDeptId" />
        </SelectParameters>--%>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRoomBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status FROM admin_Hospital_Wards INNER JOIN SubDepartment ON admin_Hospital_Wards.SubDept_Id = SubDepartment.SubDept_Id INNER JOIN Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id WHERE (admin_Hospital_Wards.SubDept_Id = @SubDept_Id) AND (Ward_Beds.Bed_Status = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListFloor" Name="SubDept_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_EncrRegNo" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="insert_Patient_Assign_Bed" InsertCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldWard_Id" Name="Ward_id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldBedID" Name="Bed_id" PropertyName="Value" />
            <asp:SessionParameter Name="admission_By" SessionField="emp_id" />
            <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
            <asp:Parameter DefaultValue="false" Name="Pt_Status" />
            <asp:ControlParameter ControlID="DropDownListFloor" Name="FloorID" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Update" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Ward_Beds SET Bed_Status = 1 WHERE (ward_Id = @ward_Id) AND (Bed_id = @Bed_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldWard_Id" Name="ward_Id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldBedID" Name="Bed_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldBedID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Pt_View_AssignBed" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListFloor" Name="SubDept_Id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldWard_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
        UpdateCommand="Patient_Discharge_FinalBillTabba" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Reg_No" Type="String" DefaultValue="0" />
            <asp:Parameter Name="Yearly_No" Type="Int32" DefaultValue="0" />
             <asp:Parameter Name="referdoctor" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="DisStatus" Type="String" DefaultValue="0" />
             <asp:Parameter Name="Remarks" Type="String" DefaultValue="0" />
             
        </UpdateParameters>
    </asp:SqlDataSource>
    </span>
</asp:Content>
