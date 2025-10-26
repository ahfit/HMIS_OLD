<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_History_MainGroup, App_Web_0xn5azrs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



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
 <asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label> 
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
               
                          <tr>
                            <td align="right"  ><strong>Main Group Name  :&nbsp; </strong></td>
                              <td >
                                <asp:TextBox ID="TextBoxMGname" runat="server"   Width="146px" ></asp:TextBox>

                                  <asp:Button ID="ButtonSearch" runat="server"  Text="Search" />
                                <asp:Button ID="ButtonSave" runat="server"  Text="Save"  /> <asp:Label CssClass="err" ID="LabelEmpName" runat="server"></asp:Label></td>
                            </tr>
                          
                           
                          
                        </table></div>

<br />

<asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label> 

 
<asp:GridView ID="GridViewMGName" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                 DataKeyNames="MG_Code" Width="100%">
                                <Columns>
                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                    <asp:BoundField DataField="MG_Code" HeaderText="Main Group Code" InsertVisible="False"
                                        ReadOnly="True" SortExpression="MG_Code" />
                                    <asp:BoundField DataField="MG_Name" HeaderText="Main Group Name" SortExpression="MG_Name" />
                                    <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
                                </Columns>
                              <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

                            </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                InsertCommand="INSERT INTO admin_History_MainGroup(MG_Name) VALUES (@MG_Name)"
                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                            <InsertParameters>
                              <asp:ControlParameter ControlID="TextBoxMGname" Name="MG_Name" PropertyName="Text" />
                            </InsertParameters>
                                                  </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                DeleteCommand="DELETE FROM admin_History_MainGroup WHERE (MG_Code = @MG_Code)"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"
                                SelectCommand="SELECT MG_Code, MG_Name, Priority FROM admin_History_MainGroup&#13;&#10;Order by Priority,MG_Name "
                                UpdateCommand="UPDATE admin_History_MainGroup SET MG_Name =@MG_Name, Priority =@Priority&#13;&#10;WHERE (MG_Code = @MG_Code)">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="GridViewMGName" Name="MG_Code" PropertyName="SelectedValue" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="HiddenFieldMainGroup" Name="MG_Name" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="GridViewMGName" Name="MG_Code" PropertyName="SelectedValue" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                    SelectCommand="SELECT MG_Code, MG_Name, Priority FROM admin_History_MainGroup WHERE (MG_Name LIKE @MG_Name + '%')" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" DeleteCommand="DELETE FROM admin_History_MainGroup WHERE (MG_Code = @MG_Code)" UpdateCommand="UPDATE admin_History_MainGroup SET MG_Name =@MG_Name, Priority =@Priority&#13;&#10;WHERE (MG_Code = @MG_Code)">
    <SelectParameters>
        <asp:ControlParameter ControlID="TextBoxMGname" Name="MG_Name" PropertyName="Text" />
    </SelectParameters>
    <DeleteParameters>
        <asp:ControlParameter ControlID="GridViewMGName" Name="MG_Code" PropertyName="SelectedValue" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:ControlParameter ControlID="HiddenFieldMainGroup" Name="MG_Name" PropertyName="Value" />
        <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value" />
        <asp:ControlParameter ControlID="GridViewMGName" Name="MG_Code" PropertyName="SelectedValue" />
    </UpdateParameters>
</asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldMainGroup" runat="server" />
                            <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
<br /><br />


  </asp:Content>