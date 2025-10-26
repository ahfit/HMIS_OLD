<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_Template, App_Web_zvadaqir" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>
<title>Lahore General Hospital Lahore</title>
<link href="../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />


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

<body >

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
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      
                </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">History  &gt;&gt; <span class="text_lables3">Main Group </span></td>
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
                  <td valign="top" style="height: 439px"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="917" height="38" valign="top" style="text-align: center"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="179" height="37" align="right" valign="middle" ><strong>Template Name  :&nbsp; </strong></td>
                              <td width="736" valign="middle"><span style="height: 25px">
                                <asp:TextBox ID="TextBoxname" runat="server"  Width="146px"  ></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:Button ID="ButtonSave" runat="server" CssClass="bt1up" Text="Save"     />                                
                              </span></td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table>
                            <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                      </tr>
                      <tr>
                        <td height="13" align="right" valign="top"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="24" valign="top"><asp:Label  Font-Bold="True" ID="LabelEmpName" runat="server" Width="182px"></asp:Label>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  
                                &nbsp;<span style="text-align: center">
                                <asp:Label  ForeColor="Red" ID="Label1" runat="server" Width="394px"></asp:Label>
                                </span></td>
                      </tr>
                      <tr>
                        <td height="374" valign="top"><span style="text-align: center">
                          <asp:GridView ID="GridViewMGName" runat="server" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSource_Template" Width="100%"  AllowPaging="True" DataKeyNames="Template_Id" PageSize="25">
                            <FooterStyle CssClass="GridPager" />                          
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                <asp:BoundField DataField="Template_Id" HeaderText="Template_Id" InsertVisible="False"
                                    ReadOnly="True" SortExpression="Template_Id" />
                                <asp:BoundField DataField="Template_Name" HeaderText="Template_Name" SortExpression="Template_Name" />
                            </Columns>
                            <RowStyle CssClass="GridItem"  />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                            &nbsp;&nbsp;</span> &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <asp:SqlDataSource ID="SqlDataSource_Template" runat="server" ConflictDetection="CompareAllValues"
                                ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" DeleteCommand="DELETE FROM [Admin_Template] WHERE [Template_Id] = @original_Template_Id AND [Template_Name] = @original_Template_Name"
                                InsertCommand="INSERT INTO [Admin_Template] ([Template_Name]) VALUES (@Template_Name)"
                                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Admin_Template]"
                                UpdateCommand="UPDATE [Admin_Template] SET [Template_Name] = @Template_Name WHERE [Template_Id] = @original_Template_Id AND [Template_Name] = @original_Template_Name">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_Template_Id" Type="Int32" />
                                    <asp:Parameter Name="original_Template_Name" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Template_Name" Type="String" />
                                    <asp:Parameter Name="original_Template_Id" Type="Int32" />
                                    <asp:Parameter Name="original_Template_Name" Type="String" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBoxname" Name="Template_Name" PropertyName="Text"
                                        Type="String" />
                                </InsertParameters>
                            </asp:SqlDataSource>
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

