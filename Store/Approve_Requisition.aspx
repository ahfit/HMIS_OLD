<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" 
    CodeFile="Approve_Requisition.aspx.cs" Inherits="Store_Approve_Requisition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">
    .Form_View tr
    {
        height:25px;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <asp:FormView ID="FormView1" DataSourceID="SqlDataSource1" Width="100%" runat="server">
        <ItemTemplate>
            <table class="Form_View" width="100%">
                <tr>
                    <td>
                        Requistions ID :</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("IB_ID") %>'></asp:Label>
                    </td>
                    <td>
                        Date Time :</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Date_Time", "{0:d}") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Delivery Address :</td>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Delivery_Address") %>'></asp:Label>
                    </td>
                    <td>
                        Contact Person :</td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("Contact_Person") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Phone # :</td>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Phone_No") %>'></asp:Label>
                    </td>
                    <td>
                       Remarks : </td>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        To Sub Department :</td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("To_Sub_Dept") %>'></asp:Label>
                    </td>
                    <td>
                        Department : </td>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        From Sub Department :    
                    </td>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("From_Sub_Dept") %>'></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT     Store_Indent_Book_Main.IB_ID, Store_Indent_Book_Main.Date_Time, Store_Indent_Book_Main.Reg_No, Store_Indent_Book_Main.Yearly_NO, 
Store_Indent_Book_Main.Description, Store_Indent_Book_Main.Is_Approved, Store_Indent_Book_Main.SO_ID, Store_Indent_Book_Main.Delivery_Site, 
Store_Indent_Book_Main.Delivery_Address, Store_Indent_Book_Main.Contact_Person, Store_Indent_Book_Main.Phone_No, Store_Indent_Book_Main.Remarks, 
SubDepartment.SubDept_Name To_Sub_Dept, SubDepartment_1.SubDept_Name From_Sub_Dept, Department.Dept_Name
FROM         Store_Indent_Book_Main INNER JOIN
Department ON Store_Indent_Book_Main.From_Dept_ID = Department.Dept_ID INNER JOIN
SubDepartment AS SubDepartment_1 ON Store_Indent_Book_Main.From_Sub_Dept_ID = SubDepartment_1.SubDept_Id INNER JOIN
SubDepartment ON Store_Indent_Book_Main.To_Sub_Dept_ID = SubDepartment.SubDept_Id
Where Store_Indent_Book_Main.IB_ID = @IB_ID">
        <SelectParameters>
            <asp:QueryStringParameter Name="IB_ID" QueryStringField="RQ_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="gvRequistionDetail" runat="server" Width="100%"
        AutoGenerateColumns="False" DataKeyNames="IB_ID,Item_Code" 
        DataSourceID="sqlDs_RequistionDetail" 
        onprerender="gvRequistionDetail_PreRender" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="IB_ID" HeaderText="Requisition ID" ReadOnly="True" 
                SortExpression="IB_ID" />
            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" ReadOnly="True" 
                SortExpression="Item_Code" />
            <asp:BoundField DataField="Item_Name" HeaderText="Item Name" 
                SortExpression="Item_Name" />
               <asp:TemplateField HeaderText="Qty">
                <ItemTemplate>
                    <asp:HiddenField ID="hfld_IB_ID" runat="server" Value='<%#Eval("IB_ID") %>' />
                    <asp:HiddenField ID="hfld_Item_Code" runat="server" Value='<%#Eval("Item_Code") %>' />
                    <asp:TextBox ID="txtNewQty" runat="server" Text='<%#Eval("Item_Qty")%>' Enabled="false"></asp:TextBox>
                </ItemTemplate>
                
            </asp:TemplateField>
                <asp:TemplateField HeaderText="Rate">
                    <ItemTemplate>
                        <asp:Label ID="lblRate" runat="server" Text='<%#Eval("Item_Rate","{0:0,00}")%>'></asp:Label>
                    </ItemTemplate>
                   <FooterTemplate>
                    <asp:Label ID="lblTotal" runat="server" Text="Total Amount : " Font-Bold="true"></asp:Label>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
            <asp:TemplateField HeaderText="Total">
                    <ItemTemplate>
                        <asp:Label ID="lblTotalAmount" runat="server" Text='<%#Eval("TotalAmount","{0:0,00}")%>'></asp:Label>
                    </ItemTemplate>
                   <FooterTemplate>
                    <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="true"></asp:Label>
                </FooterTemplate>
                </asp:TemplateField>
        </Columns>
        
    </asp:GridView>


    <asp:SqlDataSource ID="sqlDs_RequistionDetail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT     Store_Indent_Book_Sub.IB_ID, Store_Indent_Book_Sub.Item_Code, Store_Indent_Book_Sub.Item_Qty, Store_Indent_Book_Sub.Item_Specification, 
Store_Indent_Book_Sub.Item_Rate, Store_Items.Item_Name,Store_Indent_Book_Sub.Item_Rate*Store_Indent_Book_Sub.Item_Qty TotalAmount
FROM         Store_Indent_Book_Sub INNER JOIN
Store_Items ON Store_Indent_Book_Sub.Item_Code = Store_Items.Item_Code
Where IB_ID = @IB_ID order by IB_ID_Sub" InsertCommand="uspCreateApprovalRequest" InsertCommandType="StoredProcedure"
        UpdateCommand="Update Store_Indent_Book_Sub Set Item_Qty = @Qty Where IB_ID = @IB_ID And Item_Code = @Item_Code">
        <InsertParameters>
            <asp:Parameter Name="Requisition_ID" />
            <asp:Parameter Name="Send_By" />
            <asp:Parameter Name="Send_By_Sub_Dept_Id" />
            <asp:Parameter Name="Send_To" />
            <asp:Parameter Name="Send_To_Sub_Dept_Id" />
            <asp:Parameter Name="SendDate" />
            <asp:Parameter Name="Requisition_Remarks" />
            <asp:Parameter Name="Parent_Approval_Request_Id" />
            <asp:Parameter Name="Approved_Status" />
            <asp:Parameter Name="Approved_Date" />
            <asp:Parameter Name="Request_Level" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="IB_ID" QueryStringField="RQ_ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="IB_ID" />
            <asp:Parameter Name="Item_Code" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <br />

    <table width="100%">
        <tr>
            <td>
                &nbsp;</td>
            <td style="text-align:right;">
                <asp:Button ID="Btn_Return" runat="server" Text="Return" 
                    onclick="Btn_Return_Click" />
                <asp:Button ID="btnSaveQuantity" runat="server" Text="Save Quantity" 
                    onclick="btnSaveQuantity_Click" Visible="false" />
            </td>
        </tr>
        <tr>
            <td>
                Remarks :
            </td>
            <td>
                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Rows="7" Height="50px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Send To :
            </td>
            <td>
                <asp:DropDownList ID="ddlSendTo" runat="server" DataSourceID="SqlDataSource2" 
                    DataTextField="Employee_Name" DataValueField="EmpID">
                    
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT     Employee.EmpID,IsNull(Employee.Prefix,'') + ' ' + IsNull(Employee.EFName,'') + ' ' 
+ IsNull(Employee.ELName,'')  + ' ( ' + Cast(Approval_Authority.Auth_Level as varchar) + ' )' Employee_Name
FROM         Approval_Authority INNER JOIN
Employee ON Approval_Authority.EmployeeId = Employee.EmpID
Where Approval_Authority.SubDeptId= @SubDeptId
Order By Auth_Level,Employee.EFName">
                    <SelectParameters>
                        <asp:SessionParameter Name="SubDeptId" SessionField="SubDeptID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btnSave" runat="server" Text="Forward For Approval" 
                    onclick="btnSave_Click" />
                <asp:Label ID="lbl_msg" runat="server"></asp:Label>
            </td>
        </tr>
    </table>



</asp:Content>

