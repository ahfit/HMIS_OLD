<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Approve_Demand_Requisition.aspx.cs" Inherits="Store_Approve_Demand_Requisition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .Form_View tr {
            height: 25px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Approve Demand Requisition</span></h2>
        <asp:formview id="FormView1" datasourceid="SqlDataSource1" width="100%" runat="server">
        <ItemTemplate>
            <table class="Form_View" width="100%">
                <tr>
                    <td>
                        Demand # :</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Demand_RQ_ID") %>'></asp:Label>
                    </td>
                    <td>
                        Date Time :</td>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Date_Time") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                   
                    <td>
                        From Department :    
                        </td>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("From_Sub_Dept") %>'></asp:Label>
                    </td>
                    <td>
                        To Department :
                      </td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("To_Sub_Dept") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    
                     <td>
                         Remarks : 
                    </td>
                    <td colspan="3">
                         <asp:Label ID="Label6" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                    </td>
                    <td style="display:none;">
                        Department : 
                     </td>
                    <td style="display:none;">
                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                    </td>
                    
                </tr>
                
            </table>
        </ItemTemplate>
    </asp:formview>
    </div>
    <br />
    <asp:sqldatasource id="SqlDataSource1" runat="server"
        connectionstring="<%$ ConnectionStrings:STOREConnectionString %>" selectcommand="SELECT
	Demand_Requisition_Main.Demand_RQ_ID,
	Demand_Requisition_Main.Date_Time,
	Demand_Requisition_Main.Reg_No,
	Demand_Requisition_Main.Yearly_NO,
	Demand_Requisition_Main.Description,
	Demand_Requisition_Main.Is_Approved,
	Demand_Requisition_Main.SO_ID,
	Demand_Requisition_Main.Remarks,
	SubDepartment.SubDept_Name AS To_Sub_Dept,
	SubDepartment_1.SubDept_Name AS From_Sub_Dept,
	Department.Dept_Name
FROM Demand_Requisition_Main
INNER JOIN SubDepartment
	ON Demand_Requisition_Main.From_Sub_Dept_ID = SubDepartment.SubDept_Id
INNER JOIN SubDepartment AS SubDepartment_1
	ON Demand_Requisition_Main.To_Sub_Dept_ID = SubDepartment_1.SubDept_Id
INNER JOIN Department
	ON Demand_Requisition_Main.From_Dept_ID = Department.Dept_ID
WHERE Demand_Requisition_Main.Demand_RQ_ID=@Demand_RQ_ID">
        <SelectParameters>
            <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" />
        </SelectParameters>
    </asp:sqldatasource>

    <asp:gridview id="gvRequistionDetail" runat="server" width="100%"
        autogeneratecolumns="False" datakeynames="Demand_RQ_ID,Item_Code"
        datasourceid="sqlDs_RequistionDetail">
        <Columns>
            <asp:BoundField DataField="Demand_RQ_ID" HeaderText="Demand Requisition" ReadOnly="True" 
                SortExpression="Demand_RQ_ID" />
            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" ReadOnly="True" 
                SortExpression="Item_Code" />
            <%--<asp:BoundField DataField="Units" HeaderText="Units" SortExpression="Units" />
            <asp:BoundField DataField="Qty_Per_Unit" HeaderText="Qty Per Unit" 
                SortExpression="Qty_Per_Unit" />--%>
            <asp:BoundField DataField="Item_Name" HeaderText="Item Name" 
                SortExpression="Item_Name" />
            <asp:BoundField DataField="Item_Qty" HeaderText="Qty" 
                SortExpression="Item_Qty" />
                
            <asp:TemplateField HeaderText="New Demand Qty" Visible="false">
                <ItemTemplate>
                    
                    <asp:TextBox ID="txtNewQty" runat="server" Text='<%#Eval("Item_Qty")%>' 
                        Width="50px" AutoPostBack="True" ontextchanged="txtNewQty_TextChanged"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Unit Price">
                <ItemTemplate>
                    <asp:HiddenField ID="hfld_RQ_ID" runat="server" Value='<%#Eval("Demand_RQ_ID") %>' />
                    <asp:HiddenField ID="hfld_Item_Code" runat="server" Value='<%#Eval("Item_Code") %>' />
                    <asp:TextBox ID="txtRate" runat="server" Text='<%#Eval("Item_Rate","{0:N2}")%>' 
                        Width="50px" ontextchanged="txtRate_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount" Visible="false">
                <ItemTemplate>
                    
                    <asp:TextBox ID="txtDiscount" runat="server" Text='<%#Eval("Discount")%>' 
                        Width="50px" ontextchanged="txtDiscount_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Amount">
                <ItemTemplate>
                    
                    <asp:TextBox ID="txtTotalAmount" runat="server" 
                        Text='<%#Eval("Total_Amount","{0:N2}")%>' Width="50px" Enabled="False"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        
    </asp:gridview>


    <asp:sqldatasource id="sqlDs_RequistionDetail" runat="server"
        connectionstring="<%$ ConnectionStrings:STOREConnectionString %>" Selectcommand="uspGetDemandItems" SelectCommandType="StoredProcedure"
        insertcommand="uspCreateDemandApprovalRequest" insertcommandtype="StoredProcedure"
        updatecommand="UPDATE Demand_Requisition_Sub SET Item_Qty = @Qty,Item_Rate=@Rate,Discount=@Discount,Total_Amount=@Amount WHERE Demand_RQ_ID = @Demand_RQ_ID AND Item_Code = @Item_Code">
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
            <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="Demand_RQ_ID" />
            <asp:Parameter Name="Item_Code" />
            <asp:Parameter Name="Rate" />
            <asp:Parameter Name="Discount" />
            <asp:Parameter Name="Amount" />
        </UpdateParameters>
    </asp:sqldatasource>


    <br />

    <table width="100%">
        <tr>
            <td>&nbsp;</td>
            <td style="text-align: right;">
                <asp:button id="Btn_Return" runat="server"
                    text="Return" onclick="Btn_Return_Click" />
                <asp:button id="btnSaveQuantity" runat="server" text="Save Quantity"
                    onclick="btnSaveQuantity_Click" Visible="false" />
            </td>
        </tr>
        <tr>
            <td>Remarks :
            </td>
            <td>
                <asp:textbox id="txtRemarks" runat="server" textmode="MultiLine" rows="7" height="50px"></asp:textbox>
            </td>
        </tr>
        <tr>
            <td>Send To :
            </td>
            <td>
                <asp:dropdownlist id="ddlSendTo" runat="server" datasourceid="SqlDataSource2"
                    datatextfield="Employee_Name" datavaluefield="EmpID">
                    
                </asp:dropdownlist>
                <asp:sqldatasource id="SqlDataSource2" runat="server"
                    connectionstring="<%$ ConnectionStrings:STOREConnectionString %>" selectcommand="SELECT
	Employee.EmpID,
	ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' '
	+ ISNULL(Employee.ELName, '') + ' ( ' + CAST(Approval_Authority_For_Demand.Auth_Level AS varchar) + ' )' Employee_Name
FROM Approval_Authority_For_Demand
INNER JOIN Employee
	ON Approval_Authority_For_Demand.EmployeeId = Employee.EmpID
WHERE Approval_Authority_For_Demand.SubDeptId = @SubDeptId
ORDER BY Auth_Level, Employee.EFName">
                    <SelectParameters>
                        <asp:SessionParameter Name="SubDeptId" SessionField="SubDeptID" />
                    </SelectParameters>
                </asp:sqldatasource>
            </td>sqlDs_RequistionDetail
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:button id="btnSave" runat="server" text="Forward For Approval"
                    onclick="btnSave_Click" />
                <asp:label id="lbl_message" runat="server" forecolor="Red"></asp:label>
            </td>
        </tr>
    </table>



</asp:Content>

