<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Admin_Services.aspx.vb" Inherits="Administrator_Admin_Services" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function CheckRequirement(a) {
            if (document.getElementById("TextBox_Name").value.length == 0) {
                alert("Enter Service Name");
                document.getElementById("TextBox_Name").focus();
                return false;
            }
            if (document.getElementById("TextBox_Charges").value.length == 0) {
                alert("Enter Service Charges");
                document.getElementById("TextBox_Charges").focus();
                return false;
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td align="right" style="height: 18px">Service Name :
                </td>
                <td style="height: 18px">
                    <asp:TextBox ID="TextBox_Name" runat="server"></asp:TextBox>
                    <asp:Button ID="Button_Search" runat="server" Text="Search" />
                </td>
            </tr>
            <tr>
                <td align="right">Service Category :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSource_Cat"
                        DataTextField="Asc_Name" DataValueField="Asc_id" AutoPostBack="True">
                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Service Charges :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Charges" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Service Charges Before :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Charges_Before" runat="server">
                        <asp:ListItem>True</asp:ListItem>
                        <asp:ListItem>False</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Service Edit Price :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Edit_Price" runat="server">
                        <asp:ListItem>False</asp:ListItem>
                        <asp:ListItem>True</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Service Head :</td>
                <td>
                    <asp:DropDownList ID="DDL_S_HEAD" runat="server"
                        DataSourceID="SqlDataSourceHead" DataTextField="E_Name" DataValueField="ESH_Code">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>&nbsp;
                </td>
                <td>
                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnViewGridData" runat="server" Text="View Data" Visible="false" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnReport" runat="server" Text="Show Report" Visible="false" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Save_Info" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Admin_Services" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Name" Name="S_Name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList2" DefaultValue="" Name="S_Category"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Charges" DefaultValue="" Name="S_Amount"
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Charges_Before" Name="S_PaymentBefore"
                PropertyName="SelectedValue" Type="Boolean" />
            <asp:ControlParameter ControlID="DropDownList_Edit_Price" Name="Edit_Status" PropertyName="SelectedValue"
                Type="Boolean" />
            <asp:ControlParameter ControlID="HiddenFieldSH_ID" Name="SH_ID" PropertyName="Value"
                Type="Int32" />
            <asp:SessionParameter Name="emp_ID" SessionField="emp_id" Type="Int32" />
            <asp:ControlParameter ControlID="DDL_S_HEAD" Name="Account_Head_ID"
                PropertyName="SelectedValue" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceHead" runat="server"
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>"
        SelectCommand="SELECT E_Code ESH_Code, E_Name FROM Expenditure WHERE ESH_Code = 4101"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Cat" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Asc_id, Asc_Name FROM Admin_Service_Category where isnull(Active,0)=1 order by Asc_Name "></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldSH_ID" runat="server" />
    <asp:Panel ID="pnlReport" runat="server" Visible="false">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </asp:Panel>
    <asp:Panel ID="pnlGrid" runat="server">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="S_ID" DataSourceID="SqlDataSourceGrid" Width="100%" PageSize="50">
            <Columns>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"
                            ToolTip="Update" /><asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel"
                                ImageUrl="~/images_hacims/icon_err.gif" ToolTip="Cancel" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"
                            OnClientClick="return confirmation_edit(this)" ToolTip="Edit" />
                        <%--<asp:ImageButton
                                ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                                OnClientClick="return confirmation(this)" ToolTip="Delete" />                        --%>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                
                <asp:BoundField DataField="S_ID" HeaderText="S_ID" InsertVisible="False" SortExpression="S_ID"
                    Visible="False" />
                <asp:TemplateField HeaderText="Service Name" SortExpression="S_Name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("S_Name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("S_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sevice Category " SortExpression="Asc_Name">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSourceCategory"
                            DataTextField="Asc_Name" DataValueField="Asc_id" SelectedValue='<%# Eval("Asc_id", "{0}") %>'
                            Width="157px">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Asc_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Service Amount" SortExpression="S_Amount">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("S_Amount") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("S_Amount") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                   <asp:TemplateField HeaderText="Edit Status" SortExpression="S_Amount">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlchange" runat="server">
                            <asp:ListItem Value="0">False</asp:ListItem>
                            <asp:ListItem Value="1">True</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LblEditStatus" runat="server" Text='<%# Bind("Edit_Status") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Asc_id" HeaderText="Asc_id" InsertVisible="False" ReadOnly="True"
                    SortExpression="Asc_id" Visible="False" />
                <asp:CheckBoxField DataField="Active" HeaderText="Active Status" SortExpression="Active" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="8%"/>
                 <asp:TemplateField HeaderText="Change Status" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>                    
                    <asp:LinkButton ID="lnkbtn" Text="Change Status" runat="server" CommandName='<%# Bind("ActiveStatus")%>' CommandArgument='<%# Eval("s_id") %>' 
                        OnClick="lnkbtn_Click" ToolTip='<%# Eval("Active") %>'></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="12%" />
            </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="GridItem" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <PagerStyle CssClass="GridPager" />
        </asp:GridView>
    </asp:Panel>
    <br />
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            
                                <ContentTemplate>
    --%>
    <div class="bxmain" style="display: none">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td align="right" width="40%">Department Name :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_Department"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:Label ID="LabelSave" runat="server" Visible="False" CssClass="err"></asp:Label>
                    <asp:HiddenField ID="HiddenField_SNAME" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">Service Category :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListCategory" runat="server" DataSourceID="SqlDataSourceCategory"
                        DataTextField="Asc_Name" DataValueField="Asc_id" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Service Name :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_ServiceName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="left" valign="top">
                    <div style="overflow: auto; scroll-x: hidden; height: 200px;">
                        <asp:CheckBoxList ID="CheckBoxList_Services" runat="server" DataSourceID="SqlDataSource_Services"
                            DataTextField="S_Name" DataValueField="S_ID" RepeatColumns="4" RepeatDirection="Horizontal">
                        </asp:CheckBoxList>
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True"
                            DataKeyNames="S_ID" DataSourceID="SqlDataSource_Delete_Admin_Services">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" />
                            </Columns>
                        </asp:GridView>
                        <br />
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right"></td>
                <td>
                    <asp:Button ID="Button_Save_Dept" runat="server" Text="Save" />
                    <asp:Button ID="ButtonAll" runat="server" Text="Check All" OnClick="ButtonAll_Click" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department Order by Dept_Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT S_Name, S_ID FROM Admin_Services WHERE (S_Category = @S_Category)  and (S_Name like @S_Name) order by S_Name asc"
        InsertCommand="Insert_Admin_Dept_Services" InsertCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Admin_Dept_Services WHERE (S_ID = @S_ID) AND (Dept_ID = @Dept_ID)">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Dept_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_SID" Name="S_ID" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_SID" Name="S_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Dept_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListCategory" Name="S_Category" PropertyName="SelectedValue"
                DefaultValue="" />
            <asp:ControlParameter ControlID="HiddenField_SNAME" DefaultValue="%" Name="S_Name"
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Delete_Admin_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT S_Name, S_ID FROM Admin_Services WHERE (S_Category = @S_Category)  and (S_Name like @S_Name) order by S_Name asc"
        InsertCommand="Insert_Admin_Dept_Services" InsertCommandType="StoredProcedure"
        DeleteCommand="DELETE FROM Admin_Dept_Services WHERE (S_ID = @S_ID) AND (Dept_ID = @Dept_ID)"
        UpdateCommand="UPDATE Admin_Services SET S_Name =, S_Amount =, Priority =, Display_Rate = WHERE (S_ID = @S_ID)">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Dept_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_SID" Name="S_ID" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_SID" Name="S_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Dept_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListCategory" Name="S_Category" PropertyName="SelectedValue"
                DefaultValue="" />
            <asp:ControlParameter ControlID="HiddenField_SNAME" DefaultValue="%" Name="S_Name"
                PropertyName="Value" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="S_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_SID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Asc_id, Asc_Name FROM Admin_Service_Category order by Asc_Name"></asp:SqlDataSource>
    <%--     </ContentTemplate>
                       
                            </asp:UpdatePanel>--%>
    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        DeleteCommand="DELETE FROM Admin_Services WHERE (S_ID = @S_ID)" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select_Admin_Services" UpdateCommand="UPDATE Admin_Services SET S_Name = @S_Name, S_Category = @S_Category,Edit_Status=@EditStatus, S_Amount = @S_Amount WHERE (S_ID = @S_ID)"
        SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="S_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList2" Name="Service_Category" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Service" Name="Service_Name" PropertyName="Value"
                Type="String" DefaultValue="%" />
        </SelectParameters>
        <UpdateParameters>

            <asp:ControlParameter ControlID="HiddenFieldName" Name="S_Name" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldCategory" Name="S_Category" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldAmount" Name="S_Amount" PropertyName="Value" />
            <asp:ControlParameter ControlID="GridView1" Name="S_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenFieldEditStatus" Name="EditStatus" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldCategory" runat="server" />
     <asp:HiddenField ID="HiddenFieldEditStatus" runat="server" />
    <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
    <asp:HiddenField ID="HiddenFieldName" runat="server" />
    <asp:HiddenField ID="HiddenField_Service" runat="server" />
</asp:Content>
