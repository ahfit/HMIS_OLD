<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Requisition_Multi_Department, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain inner_content" style="width:100%;">
<h2><span>Requisition Multi departmental Authentication : </span></h2>
    <table width="100%">
        <tr>
            
            <td align="right" width="50%">
                <b>Select Requisition Type :</b></td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="true">
                    <asp:ListItem Selected="True">Internal</asp:ListItem>
                    <asp:ListItem>Demand</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            
        </tr>
        
        <tr>
            
            <td align="right" width="50%">
                <b>Select Approval Department :</b></td>
            <td>
                <asp:DropDownList ID="DDL_Subdepartment_from" runat="server" DataSourceID="Sds_Department" DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="Sds_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment ORDER BY SubDept_Name"></asp:SqlDataSource>
            </td>
            
        </tr>
        
        <tr>
            
            <td align="right" width="50%">
                <b>Select Department :</b></td>
            <td>
                <asp:DropDownList ID="DDL_Subdepartment_Sub" runat="server" DataSourceID="Sds_Department" DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                </asp:DropDownList>
            </td>
            
        </tr>
        
        <tr>
            
            <td colspan="2" align="center">
               
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                <asp:Label ID="lblText" runat="server"></asp:Label>
            </td>
           
        </tr>
    </table>
    </div>
    <div>
     <asp:GridView ID="GVD_Record" runat="server" AllowPaging="True" Width="100%"
        PageSize="20" AutoGenerateColumns="False"   DataSourceID="SDS_Record" DataKeyNames="ID">
        <Columns>
            <asp:BoundField DataField="Requisition_Type" HeaderText="Requisition Type" SortExpression="Requisition_Type" />
            <asp:BoundField DataField="M_SubDept_Name" HeaderText="Authorised Department" SortExpression="M_SubDept_Name" />
            <asp:BoundField DataField="S_SubDept_Name" HeaderText="Department" SortExpression="S_SubDept_Name" />
            <asp:BoundField DataField="Entry_Date" HeaderText="Add Date" SortExpression="Entry_Date" />
            <asp:BoundField DataField="Name" HeaderText="Add by" SortExpression="Name" />
            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/images/deletebtn.png" ShowDeleteButton="True" />
            
            
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SDS_Record" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT requisition_department_filter.ID, requisition_department_filter.Requisition_Type, requisition_department_filter.Entry_Date, Employee.Name, M_S.SubDept_Name AS M_SubDept_Name, S_S.SubDept_Name AS S_SubDept_Name FROM requisition_department_filter INNER JOIN SubDepartment AS M_S ON requisition_department_filter.Main_Subdept_ID = M_S.SubDept_Id INNER JOIN SubDepartment AS S_S ON requisition_department_filter.sub_Subdept_ID = S_S.SubDept_Id INNER JOIN Employee ON requisition_department_filter.Entry_By = Employee.EmpID WHERE (requisition_department_filter.Is_deleted = 0) AND (requisition_department_filter.Requisition_Type = @Requisition_Type)" DeleteCommand="DELETE FROM requisition_department_filter WHERE (ID = @ID)" InsertCommand="INSERT INTO requisition_department_filter(Main_Subdept_ID, sub_Subdept_ID, Requisition_Type, Entry_By) VALUES (@Main_Subdept_ID, @sub_Subdept_ID, @Requisition_Type, @Entry_By)">
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="DDL_Subdepartment_from" Name="Main_Subdept_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDL_Subdepartment_Sub" Name="sub_Subdept_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RadioButtonList1" Name="Requisition_Type" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Entry_By" SessionField="emp_id" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="RadioButtonList1" Name="Requisition_Type" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
</asp:Content>

