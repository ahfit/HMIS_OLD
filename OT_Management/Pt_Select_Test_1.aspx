<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Select_Test_1.aspx.vb" Inherits="Pt_Select_Test_1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebHtmlEditor.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebHtmlEditor" TagPrefix="ighedit" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <link href="../css_hacims/class_reset.css"   rel="stylesheet"   type="text/css" media="screen, projection" />
<link href="../css_hacims/class_forms.css" rel="stylesheet"   type="text/css" media="screen, projection" />
<!--[if IE]><link rel="stylesheet" href="../css_hacims/class_ie_form.css" type="text/css" media="screen, projection"/><![endif]-->

<script language="javascript" type="text/javascript">
function getdata(a)
{

var val=a;
alert(document.getElementById("ListBox_Radiology_templates").Value);
}
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

 <script src="../css_hacims/js/hlight-all.js" type="text/javascript"></script>

 
</head>

<body><form id="form1" runat = "server">

<div id="forms_items"  >

<asp:Label ID="Label_message" runat="server"  CssClass="err"></asp:Label> 

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
        </asp:SqlDataSource> 

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
                                      Text='<%# Eval("TGName") %>'></asp:LinkButton> 
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
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="33%" valign="top">
    
    
    
     <table cellpadding="0" cellspacing="0" width="100%" border="0" class="tbl_form">
                <tr>
                    <td  >
                        <asp:TextBox ID="TextBox_Radiology_templates1" runat="server" Width="90px"></asp:TextBox>
                        <asp:Button ID="Button_Radiology_templates" runat="server" Text="Search" Width="45px" /></td>
                </tr>
                <tr>
                    <td  >
                        <asp:ListBox ID="ListBox_Radiology_templates" runat="server"
                            DataSourceID="SqlDataSource_Radiology_templates" DataTextField="Templates_Name"
                            DataValueField="Templates_Description" Height="178px" Width="139px" AutoPostBack="True" ></asp:ListBox>
                        <asp:SqlDataSource ID="SqlDataSource_Radiology_templates" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                            SelectCommand="SELECT Radiology_templates_ID, Templates_Name, Templates_Description, TGID FROM Radiology_templates WHERE (Templates_Name LIKE @Templates_Name + '%') AND (TGID = @RSGID)">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="TextBox_Radiology_templates1" DefaultValue="%" Name="Templates_Name"
                                    PropertyName="Text" />
                            <asp:SessionParameter Name="RSGID" SessionField="RSGID" />
                          </SelectParameters>
                        </asp:SqlDataSource></td>
            </tr>
            </table>
            
            </td>
    <td width="33%" valign="top"> <asp:Panel ID="Panel2" runat="server" Width="100%"   Wrap="False"></asp:Panel><asp:Panel ID="Panel1" runat="server" Width="100%"></asp:Panel></td>
    <td width="33%" valign="top">
    
  <asp:Panel ID="Panel3" runat="server" Visible="False" Width="100%">
        <ighedit:WebHtmlEditor ID="WebHtmlEditor1" runat="server" BackgroundImageName=""
            FontFormattingList="Heading 1=<h1>&Heading 2=<h2>&Heading 3=<h3>&Heading 4=<h4>&Heading 5=<h5>&Normal=<p>"
            FontNameList="Arial,Verdana,Tahoma,Courier New,Georgia" FontSizeList="1,2,3,4,5,6,7"
            FontStyleList="Blue Underline=color:blue;text-decoration:underline;&Red Bold=color:red;font-weight:bold;&ALL CAPS=text-transform:uppercase;&all lowercase=text-transform:lowercase;&Reset="
            Height="300px" SpecialCharacterList="Ω,Σ,Δ,Φ,Γ,Ψ,Π,Θ,Ξ,Λ,ξ,μ,η,φ,ω,ε,θ,δ,ζ,ψ,β,π,σ,ß,þ,Þ,ƒ,Б,Ж,Д,Ц,Ш,Ю,Я,б,ж,ф,ш,ю,я,お,あ,絵,所,Æ,Å,Ç,Ð,Ñ,Ö,æ,å,ã,ä,ç,ê,ð,ë,ñ,¢,£,¤,¥,№,™,©,®,—,@,•,¡,&#14;,&#18;,&#24;,&#26;,&#27;,¦,§,¨,ª,¬,¯,¶,°,±,«,»,·,¸,º,¹,²,³,¼,½,¾,¿,×,÷"
            Width="300px">
            <DownlevelLabel Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <DropDownStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <ProgressBar Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <DownlevelTextArea Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <RightClickMenu Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False">
                <ighedit:HtmlBoxMenuItem runat="server" Act="Cut" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem runat="server" Act="Copy" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem runat="server" Act="Paste" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem runat="server" Act="PasteHtml" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem runat="server" Act="CellProperties" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                    <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" InternalDialogType="CellProperties" />
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem runat="server" Act="TableProperties" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                    <Dialog Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" InternalDialogType="ModifyTable" />
                </ighedit:HtmlBoxMenuItem>
                <ighedit:HtmlBoxMenuItem runat="server" Act="InsertImage" Font-Bold="False" Font-Italic="False"
                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False">
                </ighedit:HtmlBoxMenuItem>
            </RightClickMenu>
            <TextWindow Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
            <Toolbar Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False">
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="Bold" />
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="Italic" />
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="Underline" />
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="Strikethrough" />
                <ighedit:ToolbarImage runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="Separator" />
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="JustifyLeft" />
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="JustifyCenter" />
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="JustifyRight" />
                <ighedit:ToolbarButton runat="server" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                    Font-Strikeout="False" Font-Underline="False" Type="JustifyFull" />
            </Toolbar>
            <DialogStyle BackColor="#ECE9D8" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                Font-Names="sans-serif" Font-Size="8pt" ForeColor="Black" />
            <TabStrip Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" />
        </ighedit:WebHtmlEditor>
<div align="center" style="margin-top:5px;"><asp:Button ID="Button_close" runat="server" Text="Close" /></div>
</asp:Panel>
    
    
    </td>
  </tr>
</table>

   
 

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
            RepeatColumns="4"  Width="100%" Visible="False">
            <ItemTemplate>
                 
                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="login_link"
                    Text='<%# Eval("TGName", "{0}") %>' Width="208px"></asp:LinkButton><br />
                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                <asp:HiddenField ID="HiddenField5" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                <asp:HiddenField ID="HiddenFieldTBID" runat="server" Value='<%# Eval("TB_ID", "{0}") %>' />
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
  
  
    
   
      
    <br />
    

                  <table cellpadding="0" cellspacing="0" border="0" width="96%" class="tbl_form">
                      <tr>
                          <td align="left" >
                              &nbsp;</td></tr><tr>
                          <td >
                              </td>
                      </tr>
                  </table>
<br />

<div align="center"><asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />&nbsp;
                  <asp:Button ID="ButtonFinal" runat="server" CssClass="btn1" Text="Final" /></div> <asp:Label ID="Label_Description" runat="server" CssClass="err" Text="Description" Visible="False"
                                  ></asp:Label>
                              <asp:TextBox ID="TextBox_Description" runat="server" Rows="5" TextMode="MultiLine"
                                  Visible="False" Width="98%" ></asp:TextBox><br />
    <asp:HiddenField ID="HiddenField_new_TGID" runat="server" />
 


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
                  </asp:SqlDataSource>   <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
    <br />
<br />

</div>

</form>
</body>
</html>