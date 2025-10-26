<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Select_Test_old.aspx.vb" Inherits="Pt_Select_Test_old" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HACIMS - +</title>
<link href="../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images/sheet_form.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">

function CheckRequiredField(Element_ID,TB_ID)
{
   
    //Bilirubin="TextBoxT0134"
    //Indirect="TextBoxT0136"
    //Direct="TextBoxT01649"
    //Total Proteins="TextBoxT0142"
    //Albumin="TextBoxT0143"
    //Globulin="TextBoxT0144"
    //A/G Ratio="TextBoxT0145"
    
    //Total Lipids="TextBoxT0151"
    //Trigiycerides="TextBoxT0152"
    //Cholesterol="TextBoxT0153"
    //H.D.L.="TextBoxT0154"
    //L.D.L.="TextBoxT0155"
    //V.L.D.L.="TextBoxT0156"
    //Chylomicrons.="TextBoxT0157"
    
    //24 Hr Urine Protein="TextBoxT0216"
    //Serum Creatinine ="TextBoxT0131"
    //Creatinine Clearance ="TextBoxT0132"
    //Blood Urea ="TextBoxT0130"
    
    //alert(Element_ID);
    if(TB_ID==369||TB_ID==94||TB_ID==93||TB_ID==95)
    {
        var Bilirubin = document.getElementById("TextBoxT0134").value;
        var InDirect = document.getElementById("TextBoxT0136").value;
        document.getElementById("TextBoxT01649").value=Bilirubin-InDirect;
        if(document.getElementById("TextBoxT0142").value!="")
        {
            var Globulin=document.getElementById("TextBoxT0142").value - document.getElementById("TextBoxT0143").value;
            document.getElementById("TextBoxT0144").value = Globulin;
            var AGRatio=document.getElementById("TextBoxT0143").value/document.getElementById("TextBoxT0144").value;
            document.getElementById("TextBoxT0145").value=AGRatio;
        }
    }
    else if(TB_ID==378)
    {
        if (document.getElementById("TextBoxT0152").value<450)
        {
            if(document.getElementById("TextBoxT0154").value!="" && document.getElementById("TextBoxT0153").value!="")
            {
                var LDL=document.getElementById("TextBoxT0153").value-document.getElementById("TextBoxT0154").value-(document.getElementById("TextBoxT0152").value/5);
                document.getElementById("TextBoxT0155").value=LDL;
                var VLDL=document.getElementById("TextBoxT0153").value-(document.getElementById("TextBoxT0154").value+LDL);
                document.getElementById("TextBoxT0156").value=VLDL;
            }
        }
    }
    else if(TB_ID==370)
    {
        if(document.getElementById("TextBoxT0131").value.length!=0 && document.getElementById("TextBoxT0216").value.length!=0)
        {
            var a=document.getElementById("TextBoxT0130").value*document.getElementById("TextBoxT0216").value;    
            var b=document.getElementById("TextBoxT0131").value*1440;
            document.getElementById("TextBoxT0132").value=Math.round(a/b);
        }
    }
    return;
}
</script>
<script language ="jscript" type ="text/javascript" >
function Image_NEw(YearlyNo,RegNo,TableID) 
{ 
//alert("dsfsd");
var regno;
var yearlyno;
var query = window.location.search.substring(1); 
var vars = query.split("&"); 
    for (var i=0;i<vars.length;i++) 
    { 
   var  pair = vars[i].split("="); 
        if (pair[0] == RegNo) 
        { 
        regno = pair[1]
        } 
    } 
     var querys = window.location.search.substring(1); 
var varss = querys.split("&"); 
    for (var i=0;i<varss.length;i++) 
    { 
     var pairs = varss[i].split("="); 
        if (pairs[0] == YearlyNo) 
        { 
        yearlyno = pairs[1]
        } 
    } 
    window.open("ptxrayview.aspx?Xray_ID=" + TableID + "&payId=" + YearlyNo + "&rig_no=" + RegNo,"Mywindow","")
return false;
}


</script>

<script src="../images/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
*{margin:0 0 0 0;}
</style>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">

<iframe src="../PatientBasicInfo_Iframe.aspx" width="100%" name="holder1" scrolling="no" frameborder="0" 
            style="height: 50px; " id="holder1" ></iframe><br />
<asp:Label ID="Label_message" runat="server"  CssClass="err"></asp:Label><br />

<asp:DataList ID="DataListtemplate" runat="server" DataKeyField="Template_id" DataSourceID="SqlDataSourceTemplate"
            RepeatColumns="5" RepeatDirection="Horizontal"  Width="100%" Visible="False">
            <ItemTemplate>
                <asp:LinkButton ID="SelectButton" runat="server" CommandName="Select" CssClass="login_link"
                    ForeColor="Blue" Text='<%# Eval("Template_Name", "{0}") %>'></asp:LinkButton>
            </ItemTemplate>
            <SeparatorStyle BorderWidth="1px" CssClass="griditem" />
        </asp:DataList><asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="SELECT Admin_Assign_Template.Template_Id, Admin_Template.Template_Name FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id WHERE (Admin_Assign_Template.subdept_id = @subdeptid)&#13;&#10;and (Admin_Assign_Template.dept_id = @deptid)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:SessionParameter Name="subdeptid" SessionField="SubDeptID" />
                <asp:SessionParameter Name="deptid" SessionField="dept_id" />
            </SelectParameters>
        </asp:SqlDataSource><br />

                  <asp:GridView ID="GridView_Test_Status" runat="server" AutoGenerateColumns="False"
                      CssClass="Grid_1" DataSourceID="SqlDataSource_Status" Width="100%" DataKeyNames="TGID">
                      <Columns>
                          <asp:BoundField DataField="TB_Name" HeaderText="Test" ReadOnly="True" SortExpression="TB_Name" />
                          <asp:TemplateField HeaderText="Status" SortExpression="Status">
                              <EditItemTemplate>
                                  <asp:DropDownList ID="DropDownList_Status" runat="server" DataSourceID="SqlDataSource_Status_Edit"
                                      DataTextField="Status" DataValueField="Status_ID" Width="167px">
                                  </asp:DropDownList><br />
                                  <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Status_ID = 3) OR (Status_ID = 5) OR (Status_ID = 9)">
                                  </asp:SqlDataSource>
                                  <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                              </EditItemTemplate>
                              <ItemTemplate>
                                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                              </ItemTemplate>
                          </asp:TemplateField>
                          <asp:TemplateField>
                              <EditItemTemplate>
                                  <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                      ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                              </EditItemTemplate>
                              <ItemTemplate>
                                  <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                      OnClientClick="return confirmation_edit(this)" />
                              </ItemTemplate>
                          </asp:TemplateField>
                          <asp:BoundField DataField="Date_Time" HeaderText="Date Time" SortExpression="Date_Time" />
                          <asp:TemplateField ShowHeader="False" HeaderText="Test Group Name">
                              <ItemTemplate>
                                  <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                      Text='<%# Eval("TGName") %>'></asp:LinkButton><br />
                                  <asp:HiddenField ID="HiddenField6" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                                  <asp:HiddenField ID="HiddenField7" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                                  <asp:HiddenField ID="HiddenField8" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                                  <asp:HiddenField ID="HiddenFieldTBID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                              </ItemTemplate>
                          </asp:TemplateField>
                          <asp:BoundField DataField="TGName" HeaderText="Test Group Name" SortExpression="TGName" Visible="False" />
                          <asp:BoundField DataField="Sample No." HeaderText="Sample No." SortExpression="Sample No." ReadOnly="True" />
                          <asp:HyperLinkField DataNavigateUrlFields="TGID,Reg_no,Yearly_No" DataNavigateUrlFormatString="PatientXRay.aspx?TGID={0}&amp;RegNo={1}&amp;YearlyNo={2}"
                              Target="_blank" Text="Attach Image" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />
                      <AlternatingRowStyle CssClass="GridAltItem" />
                  </asp:GridView>
    <asp:Panel ID="Panel2" runat="server" Height="50px" Width="125px" Wrap="False">
    </asp:Panel>
    <br />

                  <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="pt_select_status"
                      UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (ID = @ID)" SelectCommandType="StoredProcedure">
                      <UpdateParameters>
                          <asp:ControlParameter ControlID="HiddenField_Edit_Status" Name="Status" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenField_Edit_ID" Name="ID" PropertyName="Value" />
                      </UpdateParameters>
                      <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                          <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenField_Edit_Status" runat="server" />
                  <asp:HiddenField ID="HiddenField_Edit_ID" runat="server" />
        <asp:DataList ID="DataListMainGroup" runat="server" DataKeyField="MS_TGID" DataSourceID="SqlDataSourceMainGroup"
            RepeatColumns="4" Style="position: static" Width="100%" Visible="False">
            <ItemTemplate>
                &nbsp;
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="login_link"
                    Text='<%# Eval("TGName", "{0}") %>' Width="208px"></asp:LinkButton><br />
                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                <asp:HiddenField ID="HiddenField5" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
            SelectCommand="pt_main_group" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="payid" SessionField="YearlyNo" />
                <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
            </SelectParameters>
        </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenFieldCategory" runat="server" />
                  <asp:HiddenField ID="HiddenFieldMainID" runat="server" />
    <asp:HiddenField ID="HiddenField_TBID" runat="server" />
    <br />

                <asp:Panel ID="Panel1" runat="server" Width="100%"> </asp:Panel><br />

                  <table>
                      <tr>
                          <td align="right" >
                              <asp:Label ID="Label_Description" runat="server" CssClass="err" Text="Description :&nbsp;" Visible="False"
                                  ></asp:Label>
                                                        </td>
                          <td >
                              <asp:TextBox ID="TextBox_Description" runat="server" Rows="5" TextMode="MultiLine"
                                  Visible="False" Width="736px" ></asp:TextBox></td>
                      </tr>
                  </table>

<div align="center"><asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />&nbsp;
                  <asp:Button ID="ButtonFinal" runat="server" CssClass="btn1" Text="Final" /></div><br />
    <asp:HiddenField ID="HiddenField_new_TGID" runat="server" />
<br />


<asp:Label ID="Label1" runat="server" Text="Label" Visible="False" CssClass="err"></asp:Label><br />

                <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                  <asp:SqlDataSource ID="SqlDataSource_UpdateStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept SET status = @status WHERE (Reg_No = @Reg_No) AND (yearly_no = @yearly_no) AND (to_sub_Dept = @to_sub_Dept)">
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="1" Name="status" />
                          <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="registrationNo" />
                          <asp:SessionParameter Name="yearly_no" SessionField="YearlyNo" />
                          <asp:Parameter DefaultValue="13" Name="to_sub_Dept" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField3" runat="server" Value="0" /><asp:HiddenField ID="HiddenField_MS_TGID" runat="server" Value="0" /><asp:HiddenField ID="HiddenField_TSGID" runat="server" Value="0" />
                  <asp:HiddenField ID="HiddenField_TGID" runat="server" />
                  <asp:HiddenField ID="HiddenField_TG_ID" runat="server" />
                  <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                      <UpdateParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:Parameter DefaultValue="6" Name="Status" />
                          <asp:SessionParameter DefaultValue="" Name="PayID" SessionField="YearlyNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSource_Update_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" UpdateCommand="Update_Patient_Test_Status" UpdateCommandType="StoredProcedure">
                      <UpdateParameters>
                          <asp:Parameter DefaultValue="6" Name="Status" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" />
                          <asp:SessionParameter Name="RegNo" SessionField="RegistrationNo" />
                          <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value"
                              Type="Int32" />
                          <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceUpdateTreatment" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" UpdateCommand="UPDATE PatientsLabTest SET Status = @Status WHERE (RegNo = @RegNo) AND (PayID = @PayID)">
                      <UpdateParameters>
                          <asp:QueryStringParameter Name="RegNo" QueryStringField="RegNo" />
                          <asp:Parameter DefaultValue="6" Name="Status" />
                          <asp:QueryStringParameter DefaultValue="" Name="PayID" QueryStringField="YearlyNo" />
                      </UpdateParameters>
                  </asp:SqlDataSource>   <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" /><br />
<br />

            
            
            
</div>

</form>
</body>
</html>