<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_Template_Test_Elements, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>
<title>Lahore General Hospital Lahore</title>
<link href="../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

<script type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language ="javascript" type="text/javascript" >
function CheckMainGroup(a)
{
if (document.getElementById("TextBoxMGname").value =="")
    {
    alert("Please Enter the main Group Name");
    return false;
    }
    var Textbox=document.getElementById("TextBoxMGname").value;
    if (Textbox.length!=0)
        {
        var i;
         var space =" ";
        for(i=0;i<=Textbox.length;i++)
            {           
            if(Textbox==space)
                {
                alert("Spaces Are Not Allowed");
                return false;
                }
            space+=" "; 
            }
        
        }
}

</script>

</head>

<body onload="MM_preloadImages('../images1/img_bthover2.gif','../images1/img_btup2.gif')">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="../images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
      
   <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="180" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      
                </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">
                Test&gt;&gt; <span class="text_lables3">Template</span></td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="../images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="449" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="917" height="38" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="d-activecell"onactivate="this.className='activecell';" ondeactivate="this.className='d-activecell';">
                          <!--DWLayoutTable-->
                            <tr>
                                <td align="right" class="text_titles_01" height="37" valign="middle" width="179">
                                Template</td>
                                <td valign="middle" style="width: 165px">
                                    <asp:DropDownList ID="DropDownListTemplate" runat="server" DataSourceID="SqlDataSourceTemplates" DataTextField="Template_Name" DataValueField="Template_Id" Width="180px" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                                  <td align="right" class="text_titles_01" height="37" valign="middle" width="179">
                                      Main Group :
                                  </td>
                                <td valign="middle" width="250">
                                    &nbsp;<asp:DropDownList ID="DropDownListGroup" runat="server" DataSourceID="SqlDataSourceMainGroup" DataTextField="TGName" DataValueField="TGID" Width="157px" AppendDataBoundItems="True" AutoPostBack="True">
                                  </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="text_titles_01" height="37" valign="middle" width="179">
                                    Sub Group:</td>
                                <td style="width: 165px" valign="middle">
                                    <asp:DropDownList ID="DropDownListSubGroup" runat="server" DataSourceID="SqlDataSourceSubGroup" DataTextField="TSGName" DataValueField="TSGID" Width="157px" AutoPostBack="True">
                                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                                        SelectCommand="SELECT TSGID, TSGName FROM TestSubGroup WHERE (TGID = @TGID)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DropDownListGroup" Name="TGID" PropertyName="SelectedValue"
                                                Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td align="right" class="text_titles_01" height="37" valign="middle" width="179">
                                </td>
                                <td valign="middle" width="250">
                                </td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table><asp:SqlDataSource ID="SqlDataSourceTemplates" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" SelectCommand="SELECT Template_Id, Template_Name FROM Template_Name" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                    </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                                      SelectCommand="SELECT TGID, TGName FROM TestGroup" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>"></asp:SqlDataSource>
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <asp:Label ID="Label_message" runat="server" Width="730px"></asp:Label></td>
                      </tr>
                      <tr>
                        <td align="right" valign="top" style="height: 13px"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td valign="top" style="height: 24px"><asp:Label  Font-Bold="True" ID="LabelEmpName" runat="server" Width="182px"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  
                                &nbsp;<span style="text-align: center">
                                <asp:Label CssClass="text_lables2" ForeColor="Red" ID="Label1" runat="server" Width="394px"></asp:Label>
                                </span></td>
                      </tr>
                      <tr>
                        <td height="374" valign="top"><span style="text-align: center">
                          <asp:GridView ID="GridViewMGName" runat="server" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceForGrid" Width="917px" CssClass="Grid" DataKeyNames="TGID,TID">
                            <FooterStyle CssClass="GridPager" />                          
                            <Columns>
                                <asp:BoundField DataField="TGID" HeaderText="TGID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="TGID" />
                                <asp:BoundField DataField="TSGName" HeaderText="TSGName" SortExpression="TSGName" />
                                <asp:BoundField DataField="TID" HeaderText="TID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="TID" />
                                <asp:BoundField DataField="TestName" HeaderText="TestName" SortExpression="TestName" />
                                <asp:TemplateField HeaderText="Add to Template">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Add" />
                                        <asp:HiddenField ID="HiddenFieldroweid" runat="server" Value='<%# Eval("TID", "{0}") %>' />
                                        <br />
                                        <asp:HiddenField ID="HiddenField_MainGroupid" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Text">
                                    <ItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TestName", "{0}") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="GridItem"  />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                            &nbsp;</span> &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
<asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" DeleteCommand="DELETE FROM [admin_Phy_Exam_MainGroup] WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
                InsertCommand="INSERT INTO [admin_Phy_Exam_MainGroup] ([MG_Name], [Priority]) VALUES (@MG_Name, @Priority)"
                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT TestSubGroup.TGID, TestSubGroup.TSGID, TestSubGroup.TSGName, Test.TID, Test.TestName FROM TestSubGroup INNER JOIN Test ON TestSubGroup.TSGID = Test.TSGID WHERE (Test.TSGID = @MG_SubCode) AND (Test.TGID = @MG_Code)"
                UpdateCommand="UPDATE [admin_Phy_Exam_MainGroup] SET [MG_Name] = @MG_Name, [Priority] = @Priority WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
  <DeleteParameters>
    <asp:Parameter Name="original_MG_Code" Type="Int32" />
    <asp:Parameter Name="original_MG_Name" Type="String" />
    <asp:Parameter Name="original_Priority" Type="Int32" />
    </DeleteParameters>
  <UpdateParameters>
    <asp:Parameter Name="MG_Name" Type="String" />
    <asp:Parameter Name="Priority" Type="Int32" />
    <asp:Parameter Name="original_MG_Code" Type="Int32" />
    <asp:Parameter Name="original_MG_Name" Type="String" />
    <asp:Parameter Name="original_Priority" Type="Int32" />
    </UpdateParameters>
  <InsertParameters>
    <asp:Parameter Name="MG_Name" Type="String" />
    <asp:Parameter Name="Priority" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListGroup" Name="MG_Code" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListSubGroup" Name="MG_SubCode" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" DeleteCommand="DELETE FROM [admin_Phy_Exam_MainGroup] WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
                InsertCommand="[admin_insert_template_test_elements]"
                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT Template_Id, Template_Name FROM Admin_Template"
                UpdateCommand="UPDATE [admin_Phy_Exam_MainGroup] SET [MG_Name] = @MG_Name, [Priority] = @Priority WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
    <DeleteParameters>
        <asp:Parameter Name="original_MG_Code" Type="Int32" />
        <asp:Parameter Name="original_MG_Name" Type="String" />
        <asp:Parameter Name="original_Priority" Type="Int32" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="MG_Name" Type="String" />
        <asp:Parameter Name="Priority" Type="Int32" />
        <asp:Parameter Name="original_MG_Code" Type="Int32" />
        <asp:Parameter Name="original_MG_Name" Type="String" />
        <asp:Parameter Name="original_Priority" Type="Int32" />
    </UpdateParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="DropDownListTemplate" Name="Template_Id" PropertyName="SelectedValue"
            Type="Int32" />
        <asp:ControlParameter Name="Element_Id" Type="String" ControlID="HiddenField_id" PropertyName="Value" />
        <asp:ControlParameter Name="Element_Name" Type="String" ControlID="HiddenFieldename" PropertyName="Value" />
        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        <asp:ControlParameter ControlID="HiddenField_MainGroupid" Name="MainGroup_Id" PropertyName="Value"
            Type="Int32" />
        <asp:ControlParameter ControlID="DropDownListSubGroup" Name="SubGroup_id" PropertyName="SelectedValue"
            Type="Int32" />
    </InsertParameters>
</asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceDelete" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                DeleteCommand="DELETE FROM Admin_Template_test_Elements WHERE (Template_Id = @Template_Id) AND (Element_Id = @Element_Id)"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="DropDownListTemplate" Name="Template_Id" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="HiddenField_id" Name="Element_Id" PropertyName="Value" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                            <asp:Button ID="ButtonSave" runat="server" CssClass="bt1up" onmousedown="this.className='bt1down'"
                                onmouseout="this.className='bt1up'" onmouseover="this.className='bt1over'" Text="Save" />
                            <asp:Button ID="Button1" runat="server" CssClass="bt1up" onmousedown="this.className='bt1down'"
                                onmouseout="this.className='bt1up'" onmouseover="this.className='bt1over'" Text="Save All" />
                            <asp:HiddenField ID="HiddenFieldename" runat="server" />
                            <asp:HiddenField ID="HiddenField_id" runat="server" />
                            <asp:HiddenField ID="HiddenField_MainGroupid" runat="server" />
                            <asp:HiddenField ID="HiddenFieldvalues" runat="server" />
                        </td>
                      </tr>
                      

                      

                      
                      
                      
                      
                      
                      
                      

                      
                      
                      

                      
                      
                      
                      
                      
                      
                      
                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="../images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="../images1/flash_01.js"></script>
</form>
</body>
</html>

