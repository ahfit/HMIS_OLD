<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_Assingtemplate, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
      src="../tabs.aspx" name="holder" width="957" marginwidth="0" height="180" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
                </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">
                Assign Template</td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top" style="text-align: center">
                      <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="449" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="917" valign="top" style="height: 38px"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                            <tr>
                                <td align="right"  height="37" valign="middle" width="179">
                                Template</td>
                                <td valign="middle" style="width: 165px">
                                    <asp:DropDownList ID="DropDownListTemplate" runat="server" DataSourceID="SqlDataSourceTemplates" DataTextField="Template_Name" DataValueField="Template_Id" Width="180px">
                                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceTemplates" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="SELECT Template_Id, Template_Name FROM Admin_Template">
                                    </asp:SqlDataSource>
                                </td>
                                  <td align="right"  height="37" valign="middle" width="179">
                                      Hospital</td>
                                <td valign="middle" width="250">
                                    <asp:DropDownList ID="DropDownListHospital" runat="server" DataSourceID="SqlDataSourceHospital" DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="158px" AutoPostBack="True">
                                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                        SelectCommand="SELECT Hospital_ID, Hospital_Name FROM Hospital"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"  valign="middle" width="179" style="height: 65px">
                                    Department</td>
                                <td valign="middle" style="width: 165px; height: 65px;">
                                    <asp:DropDownList ID="DropDownListDepartment" runat="server" DataSourceID="SqlDataSourceDepartment" DataTextField="Dept_Name" DataValueField="Dept_ID" Width="179px" AppendDataBoundItems="True" AutoPostBack="True">
                                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="SELECT Dept_ID, Dept_Name FROM Department where Hospital_Id= @Hospital_Id">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DropDownListHospital" Name="Hospital_Id" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                  <td align="right"  valign="middle" width="179" style="height: 65px">
                                      Sub Department</td>
                                <td valign="middle" width="250" style="height: 65px">
                                    <asp:DropDownList ID="DropDownListsubDepartment" runat="server" Width="157px" AutoPostBack="True" DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                                    </asp:DropDownList><br />
                                    <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                        SelectCommand=" SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = @dept_id)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DropDownListDepartment" Name="dept_id" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td align="right" valign="top" style="height: 13px"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td valign="top" style="height: 24px"><asp:Label  Font-Bold="True" ID="LabelEmpName" runat="server" Width="182px"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  
                                &nbsp;<span style="text-align: center">
                                <asp:Label  ForeColor="Red" ID="Label1" runat="server" Width="394px"></asp:Label>
                                </span></td>
                      </tr>
                      <tr>
                        <td height="374" valign="top"><span style="text-align: center">
                          <asp:GridView ID="GridViewMGName" runat="server" AutoGenerateColumns="False" Width="100%"  DataSourceID="SqlDataSourceForGrid" DataKeyNames="id">
                            <FooterStyle CssClass="GridPager" />                          
                            <RowStyle CssClass="GridItem"  />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                              <Columns>
                                  <asp:CommandField ShowDeleteButton="True" />
                                  <asp:BoundField DataField="Template_Name" HeaderText="Template Name" SortExpression="Template_Name" />
                                  <asp:BoundField DataField="SubDepartment" HeaderText="SubDepartment" SortExpression="SubDepartment" />
                                  <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                                  <asp:BoundField DataField="Hospital" HeaderText="Hospital" SortExpression="Hospital" />
                                  <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True"
                                      SortExpression="id" Visible="False" />
                              </Columns>
                          </asp:GridView>
                            &nbsp;</span> &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
<asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" DeleteCommand="DELETE FROM Admin_Assign_Template WHERE (id = @Id)"
                InsertCommand="INSERT INTO [admin_Phy_Exam_MainGroup] ([MG_Name], [Priority]) VALUES (@MG_Name, @Priority)" SelectCommand="SELECT Admin_Template.Template_Name, SubDepartment.SubDept_Name AS SubDepartment, Department.Dept_Name AS Department, Hospital.Hospital_Name AS Hospital, Admin_Assign_Template.id FROM Admin_Assign_Template INNER JOIN Admin_Template ON Admin_Assign_Template.Template_Id = Admin_Template.Template_Id INNER JOIN SubDepartment ON Admin_Assign_Template.subdept_id = SubDepartment.SubDept_Id INNER JOIN Department ON SubDepartment.Dept_Id = Department.Dept_ID INNER JOIN Hospital ON Department.Hospital_ID = Hospital.Hospital_ID"
                UpdateCommand="UPDATE [admin_Phy_Exam_MainGroup] SET [MG_Name] = @MG_Name, [Priority] = @Priority WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority">
  <DeleteParameters>
      <asp:ControlParameter ControlID="GridViewMGName" Name="Id" PropertyName="SelectedValue" />
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
</asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" DeleteCommand="DELETE FROM [admin_Phy_Exam_MainGroup] WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
                InsertCommand="&#13;&#10;insert into Admin_Assign_Template(hospital_id,dept_id,subdept_id,template_id)&#13;&#10;values(@hospital_id,@dept_id,@subdept_id,@template_id)"
                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT Template_Id, Template_Name FROM Admin_Template"
                UpdateCommand="UPDATE [admin_Phy_Exam_MainGroup] SET [MG_Name] = @MG_Name, [Priority] = @Priority WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority">
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
        <asp:ControlParameter ControlID="DropDownListHospital" Name="hospital_id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListDepartment" Name="dept_id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListsubDepartment" Name="subdept_id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListTemplate" Name="template_id" PropertyName="SelectedValue" />
    </InsertParameters>
</asp:SqlDataSource>
                            <asp:Button ID="ButtonSave" runat="server" CssClass="bt1up" 
                                  Text="Save" />&nbsp;
                            <asp:HiddenField ID="HiddenFieldename" runat="server" />
                            <asp:HiddenField ID="HiddenField_id" runat="server" />
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


