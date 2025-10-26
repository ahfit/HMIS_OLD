<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="PanelComparisionReport.aspx.vb" Inherits="PanelComparisionReport" %>

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
    <div class="bxmain inner_content">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">

                 <tr>
                            <td align="right">
                                Company Name : 
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Company" runat="server" DataSourceID="SqlDataSourcePatientType"
                                    DataTextField="Party_Name" DataValueField="Party_id" AutoPostBack="True">
                                      <asp:ListItem Text=" ---  Select --- " Value="0"></asp:ListItem>
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="select 0 Party_Id,' All' Party_Name from Parties union select Party_Id,Party_Name from Parties">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                      
  
            <tr>
                <td align="right">
                    Service Category :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSource_Cat"
                        DataTextField="Asc_Name" DataValueField="Asc_id" AutoPostBack="True">
                        <asp:ListItem Text=" --- Select --- " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="btnReport" runat="server" Text="Show Report" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Save_Info" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Admin_Services" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
       
            <asp:ControlParameter ControlID="DropDownList2" DefaultValue="" Name="Company_ID"
                PropertyName="SelectedValue" Type="Int32" />
             <asp:ControlParameter ControlID="DropDownList_Company" DefaultValue="" Name="C_Name"
                PropertyName="SelectedValue" Type="Int32" />

           
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceHead" runat="server" 
        ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>" 
        
        SelectCommand="SELECT E_Code ESH_Code, E_Code+'-'+E_Name as E_Name FROM Expenditure WHERE left(ESH_Code,1) = 4 order by E_Code "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Cat" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Asc_id, Asc_Name FROM Admin_Service_Category order by Asc_Name">
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldSH_ID" runat="server" />
    <asp:Panel ID="pnlReport" runat="server">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </asp:Panel>
    <br />
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            
                                <ContentTemplate>
    --%>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department Order by Dept_Name">
    </asp:SqlDataSource>
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
          
          
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="S_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_SID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Asc_id, Asc_Name FROM Admin_Service_Category order by Asc_Name">
    </asp:SqlDataSource>
    <%--     </ContentTemplate>
                       
                            </asp:UpdatePanel>--%>
</asp:Content>
