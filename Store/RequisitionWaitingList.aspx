<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RequisitionWaitingList.aspx.cs" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="RequisitionWaitingList" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 821px;
        }
        .style2
        {
            width: 65%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lbl_msg" runat="server" ForeColor="Red"></asp:Label>
    <br />
    <asp:Panel ID="Panel_Remarks" runat="server" Visible="False" Wrap="False">
        <br />
        &nbsp;<strong style="font-weight: bold; font-size: 13px;">Requisition No. : </strong>
        <asp:Label ID="Lbl_Requisition_No" runat="server" Style="color: #900; font-weight: bold;
            font-size: 13px; padding-bottom: 5px;"></asp:Label>
        <asp:TextBox ID="TextBox_Remarks" runat="server" Width="100%" Height="250px" TextMode="MultiLine"></asp:TextBox>
        <asp:SqlDataSource ID="Sql_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            SelectCommand="SELECT [Remarks] FROM [Store_Indent_Book_Main]" UpdateCommand="Reject_Requisition"
            UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" PropertyName="Text" />
                <asp:ControlParameter ControlID="HF_Re_ID" Name="IB_ID" PropertyName="Value" />
                <asp:SessionParameter Name="Approved_by" SessionField="emp_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <div align="center" style="margin-top: 10px; width: 100%;">
            <asp:Button ID="btn_Save" runat="server" OnClick="btn_Save_Click" Text="Save And Reject" />
            <asp:Button ID="btn_Cancel" runat="server" OnClick="btn_Cancel_Click" Text="Cancel" />
            <strong>
        </div>
        <br />
        <div align="center">
            <asp:Label ID="Label" runat="server" Style="color: #CC0000;"></asp:Label></strong></div>
        <br />
        <asp:HiddenField ID="HF_Re_ID" runat="server" />
    </asp:Panel>
    <table style="width: 95%;">
        <tr>
            <td style="width: 100%;">
                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right" width="150px" style="font-weight: bold;">
                            Date From :
                        </td>
                        <td style="width: 150px;">
                            <igsch:WebDateChooser ID="WebDateChooser_date_From" runat="server" Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                        <td align="right" style="width: 150px; font-weight: bold;">
                            Requisition No:
                        </td>
                        <td style="width: 200px;">
                            <asp:TextBox ID="txtIndentBookNo" runat="server"></asp:TextBox>
                        </td>
                        <td align="right" style="font-weight: bold;">
                            From Department
                        </td>
                        <td>
                            <asp:TextBox ID="txtFromDepartment" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="font-weight: bold;">
                            Date To :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="WebDateChooser_Date_To" runat="server" Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                        <td align="right" style="font-weight: bold;">
                            Requisition For:
                        </td>
                        <td>
                            <asp:TextBox ID="txtRequisitionFor" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="Button2" runat="server" CssClass="btn1" OnClick="Button2_Click" Text="Search" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="6">
                            <asp:Label ID="Label_Rec_found" runat="server" Font-Bold="True" ForeColor="red" Visible="False"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Width="100%"
        DataKeyNames="IB_ID" DataSourceID="SqlDataSource_List" OnPreRender="GridView2_PreRender"
        EmptyDataText="No Record Found" OnSelectedIndexChanged="GridView2_SelectedIndexChanged"
        EnableModelValidation="True" AllowPaging="True" PageSize="50">
        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <Columns>
            <asp:BoundField DataField="ShiftID" HeaderText="ShiftID" SortExpression="ShiftID"
                Visible="False" />
            <asp:TemplateField HeaderText="Indent Book No." SortExpression="IB_ID">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("IB_ID") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("IB_ID") %>' Visible="False"></asp:Label>
                    <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Bind("IB_ID") %>' OnClick="LinkButton1_Click"
                        CommandArgument='<%# Eval("IB_ID") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="By" HeaderText="Employee" ReadOnly="True" SortExpression="By" />
            <asp:BoundField DataField="By Department" HeaderText="From Department" SortExpression="By Department" />
            <asp:BoundField DataField="Requsition_For" HeaderText="Requsition For" SortExpression="Requsition_For" />
            <asp:BoundField DataField="Date Time" HeaderText="Date Time" ReadOnly="True" SortExpression="Date Time" />
            <asp:BoundField DataField="DemandedQty" HeaderText="Demanded Qty" SortExpression="DemandedQty" />
            <asp:BoundField DataField="IssueQTY" HeaderText="Issued Qty" ReadOnly="True" SortExpression="IssueQTY" />
            <asp:BoundField DataField="RemaningQty" HeaderText="Remaning Qty" ReadOnly="True" SortExpression="RemaningQty" />
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtnDetail" runat="server" Text="Detail" OnClick="lnkbtnDetail_Click" CommandArgument='<%# Eval("IB_ID") %>' ToolTip='<%# Eval("ShiftID") %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Reject" Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="lbn_Remarks" runat="server" CommandArgument='<%# Eval("IB_ID") %>'
                        OnClick="lbn_Remarks_Click">delete</asp:LinkButton>
                    
                    <asp:HiddenField ID="hfdremqty" runat="server" Value='<%# Eval("RemaningQty") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Completed">
                <ItemTemplate>
                    <asp:LinkButton ID="LBtn_Completed" runat="server" CommandArgument='<%# Eval("IB_ID") %>'
                        OnClick="LBtn_Completed_Click" ForeColor="#CC3399" OnClientClick="Alert">completed</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:LinkButton ID="btnGenerateReq" runat="server" CommandArgument='<%# Eval("IB_ID") %>'
                        ForeColor="#CC3399" Visible="False" OnClick="btnGenerateReq_Click" Text="Generate Requisition"></asp:LinkButton>
                    <asp:HiddenField ID="hdfCId" runat="server" Value='<%# Eval("Company_ID") %>' />
                    <asp:HiddenField ID="hdfOldIB_ID" runat="server" Value='<%# Eval("New_IB_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource_List" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Select_Item_Waiting_List"
        SelectCommandType="StoredProcedure" UpdateCommand="uspCompleteIPO" UpdateCommandType="StoredProcedure"
        OnSelected="SqlDataSource_List_Selected" OnSelecting="SqlDataSource_List_Selecting">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_dept_ID" Name="Dept_Id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_from_date" Name="DateFrom" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_to_Date" Name="DateTo" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_RequisitionNo" Name="IndentBookNo" PropertyName="Value"
                Type="string" />
            <asp:ControlParameter ControlID="HiddenFiled_RequisitionFor" Name="RequisitionFor"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_DepartmentFrom" Name="FromDepartment"
                PropertyName="Value" Type="String" />
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_Id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HF_Re_ID" Name="IB_ID" PropertyName="Value" />
            <asp:SessionParameter Name="EmpID" SessionField="emp_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_dept_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_from_date" runat="server" />
    <asp:HiddenField ID="HiddenField_to_Date" runat="server" />
    <asp:HiddenField ID="HiddenFiled_RequisitionFor" runat="server" />
    <asp:HiddenField ID="HiddenField_RequisitionNo" runat="server" />
    <asp:HiddenField ID="HiddenField_DepartmentFrom" runat="server" />
    <asp:HiddenField ID="HiddenField_YearlyCounter" runat="server" />
    <asp:HiddenField ID="HiddenField_counter" runat="server" />
    <asp:HiddenField ID="hdfComapnyId" runat="server" />
    <asp:HiddenField ID="hdfIBID" runat="server" />
    <asp:Panel ID="pnlGenReq" runat="server" Visible="false" CssClass="lightbox" Width="550px"
        Height="450px">
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right">
                    Send To Office :
                </td>
                <td>
                    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                    <asp:DropDownList ID="DropDownList_Department" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_Department" DataTextField="Dept_Name" DataValueField="Dept_ID"
                        OnSelectedIndexChanged="DropDownList_Department_SelectedIndexChanged" Width="190px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    For Store :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListStore" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceStore"
                        Width="190px" DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                    </asp:DropDownList>
                    <asp:Label ID="Labeb_Requisition_No" Style="color: red;" ToolTip="Requisition Number"
                        runat="server" CssClass="red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSave" runat="server" Text="Save & Submit" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:GridView ID="gvItems" runat="server" Width="100%" AutoGenerateColumns="False"
                        DataKeyNames="IB_ID" DataSourceID="sdsItems" onprerender="gvItems_PreRender" 
                         >
                        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                        <Columns>
                         <asp:TemplateField HeaderText="Sr. No.">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="50px"></ItemStyle>
                        </asp:TemplateField>
                        
                            <asp:TemplateField HeaderText="Item">
                                <ItemTemplate>
                                    <asp:Label ID="lblItemName" runat="server" Text='<%# Eval("Store_Items") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lblItemSpecifications" runat="server" 
                                        Text='<%# Eval("Item_Specification") %>'></asp:Label>
                                    <asp:HiddenField ID="hdfItemCode" runat="server" 
                                        Value='<%# Eval("Item_Code") %>' />
                                    <asp:HiddenField ID="hdfItemRate" runat="server" 
                                        Value='<%# Eval("Item_Rate") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQty" runat="server" Text='<%# Bind("Qty") %>' Width="50px"></asp:TextBox>
                                </ItemTemplate>
                                
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbItems" runat="server" Checked="true" Width="20px" Height="20px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsItems" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="Select_Store_Items_Order" SelectCommandType="StoredProcedure"
                        InsertCommand="usp_Insert_Indent_Book_Sub_By_IPO" InsertCommandType="StoredProcedure">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="Labeb_Requisition_No" Name="IB_ID" 
                                PropertyName="Text" Type="String" />
                            <asp:Parameter Name="Item_Code" Type="String" />
                            <asp:Parameter Name="Item_Qty" Type="Int32" />
                            <asp:Parameter Name="Item_Rate" Type="Decimal" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdfIBID" Name="IB_ID" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSourceStore" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id =@Dept_ID)  order by SubDept_Name ">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT Dept_ID, Dept_Name FROM Department  order by Dept_Name ">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Submit" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            InsertCommand="INSERT INTO Item_Request_Track(IB_ID, By_Emp_ID, By_Dept_ID, Date_Time, Request_Status) VALUES (@IB_ID, @By_Emp_ID, @By_Dept_ID, GETDATE(), 0)"
            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value" />
                <asp:SessionParameter Name="By_Emp_ID" SessionField="emp_id" />
                <asp:SessionParameter Name="By_Dept_ID" SessionField="SubDeptId" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceApprove" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            InsertCommand="medicine_order_approve" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
            InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_counter" DefaultValue="" Name="IB_ID"
                    PropertyName="Value" />
                <asp:Parameter DefaultValue="1" Name="Status" />
                <asp:SessionParameter DefaultValue="" Name="Emp_ID" SessionField="emp_id" />
                <asp:SessionParameter DefaultValue="" Name="By_Dept_ID" SessionField="dept_id" />
                <asp:ControlParameter ControlID="DropDownList_Department" Name="For_Dept_ID" PropertyName="SelectedValue"
                    Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsGenerateReq" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            InsertCommand="usp_Generate_Req_From_IPO" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:ControlParameter ControlID="hdfIBID" Name="IPO" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_counter" Name="IB_ID" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_YearlyCounter" Name="Yearly_Counter"
                    PropertyName="Value" Type="Int32" />
                <asp:SessionParameter Name="From_Dept_ID" SessionField="dept_id" Type="Int32" />
                <asp:SessionParameter Name="From_Sub_Dept_ID" SessionField="SubDeptId" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownListStore" Name="To_Sub_Dept_ID" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" Type="Int32" />
                <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" Type="Int32" />
                <asp:ControlParameter ControlID="hdfComapnyId" Name="Company_ID" PropertyName="Value"
                    Type="Decimal" />
            </InsertParameters>
        </asp:SqlDataSource>
    </asp:Panel>
</asp:Content>
