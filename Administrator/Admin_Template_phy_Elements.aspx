<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Template_phy_Elements, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


 
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

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
                        
                            <tr>
                                <td align="right"  >
                                  Template : </td>
              <td  >
                                    <asp:DropDownList ID="DropDownListTemplate" runat="server" DataSourceID="SqlDataSourceTemplates" DataTextField="Template_Name" DataValueField="Template_Id" Width="222px" AutoPostBack="True">
                                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceTemplates" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" SelectCommand="SELECT Template_Id, Template_Name FROM Admin_Template" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                    </asp:SqlDataSource>
                              </td>
                                  <td align="right"  >
                                      Main Group : </td>
      <td  align="left">
                                    <asp:DropDownList ID="DropDownListGroup" runat="server" DataSourceID="SqlDataSource1" DataTextField="MG_Name" DataValueField="MG_Code" Width="218px" AppendDataBoundItems="True" AutoPostBack="True">
                                  </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                      SelectCommand="SELECT [MG_Code], [MG_Name] FROM [admin_Phy_Exam_MainGroup]&#13;&#10;order by MG_Name" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"></asp:SqlDataSource>
                              </td>
                            </tr>
                          
                          
                           
                          
                          
                          
                          
                          
                          
                        </table></div>
                        <br />
<asp:Label CssClass="err" Font-Bold="True" ID="LabelEmpName" runat="server" ></asp:Label>
                                  
<asp:Label CssClass="err" ID="Label1" runat="server" ></asp:Label>
<asp:Label CssClass="err" ID="Label_message" runat="server" ></asp:Label><br />

<asp:GridView ID="GridViewMGName" runat="server" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceForGrid" Width="100%"  DataKeyNames="MG_Code,e_Code">
                            <FooterStyle CssClass="GridPager" />                          
                            <Columns>
                                <asp:BoundField DataField="MG_Code" HeaderText="MG_Code" InsertVisible="False" ReadOnly="True"
                                    SortExpression="MG_Code" Visible="False" />
                                <asp:BoundField DataField="MG_Name" HeaderText="Group Name" SortExpression="MG_Name" />
                                <asp:BoundField DataField="e_Code" HeaderText="e_Code" InsertVisible="False" ReadOnly="True"
                                    SortExpression="e_Code" Visible="False" />
                                <asp:BoundField DataField="e_Name" HeaderText="Element" SortExpression="e_Name" />
                                <asp:TemplateField HeaderText="Add to Template">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Add" />
                                        <asp:HiddenField ID="HiddenFieldroweid" runat="server" Value='<%# Eval("e_Code", "{0}") %>' /><asp:HiddenField ID="HiddenField_MainGroupid" runat="server" Value='<%# Eval("MG_Code", "{0}") %>' />
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Text">
                                    <ItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("e_Name", "{0}") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Priority">
                                    <ItemTemplate>
                                        <asp:TextBox ID="TextBoxPriority" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="GridItem" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView><br />

 <div align="center">   <asp:Button ID="ButtonSave" runat="server"   Text="Save" />
                            <asp:Button ID="Button1" runat="server"   Text="Save All" />
                            <asp:Button ID="Button2" runat="server"  Text="Chech All" Visible="False" /></div>
                                
<asp:HiddenField ID="HiddenFieldename" runat="server" />
<asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" DeleteCommand="DELETE FROM [admin_Phy_Exam_MainGroup] WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
                InsertCommand="INSERT INTO [admin_Phy_Exam_MainGroup] ([MG_Name], [Priority]) VALUES (@MG_Name, @Priority)"
                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT Admin_Phy_Exam_Elememt_Assign_To_Group.MG_Code, admin_Phy_Exam_MainGroup.MG_Name, Admin_Phy_Exam_Elememt_Assign_To_Group.e_Code, admin_Phy_Exam_Elements.e_Name FROM admin_Phy_Exam_Elements INNER JOIN Admin_Phy_Exam_Elememt_Assign_To_Group ON admin_Phy_Exam_Elements.e_Code = Admin_Phy_Exam_Elememt_Assign_To_Group.e_Code INNER JOIN admin_Phy_Exam_MainGroup ON Admin_Phy_Exam_Elememt_Assign_To_Group.MG_Code = admin_Phy_Exam_MainGroup.MG_Code WHERE (admin_Phy_Exam_MainGroup.MG_Code = @MG_Code)"
                UpdateCommand="UPDATE [admin_Phy_Exam_MainGroup] SET [MG_Name] = @MG_Name, [Priority] = @Priority WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
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
    </SelectParameters>
</asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConflictDetection="CompareAllValues"
                ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" DeleteCommand="DELETE FROM [admin_Phy_Exam_MainGroup] WHERE [MG_Code] = @original_MG_Code AND [MG_Name] = @original_MG_Name AND [Priority] = @original_Priority"
                InsertCommand="[admin_insert_template_phy_elements]"
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
        <asp:ControlParameter Name="MainGroup_Id" Type="Int32" ControlID="HiddenField_MainGroupid" PropertyName="Value" />
        <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value"
            Type="Int32" />
    </InsertParameters>
</asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
                            <asp:HiddenField ID="HiddenField_id" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSourceDelete" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                DeleteCommand="DELETE FROM Admin_Template_phy_Elements WHERE (Template_Id = @Template_Id) AND (Element_Id = @Element_Id) AND (MainGroup_Id = @MainGroup_Id)"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="DropDownListTemplate" Name="Template_Id" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="HiddenField_id" Name="Element_Id" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="DropDownListGroup" Name="MainGroup_Id" PropertyName="SelectedValue" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_MainGroupid" runat="server" />
                            <asp:HiddenField ID="HiddenFieldvalues" runat="server" /><br /><br />
<br />

  </asp:Content>