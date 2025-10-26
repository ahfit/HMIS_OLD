<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Approve_Requisition_Request"
     CodeFile="Approve_Requisition_Request.aspx.cs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .Form_View tr
        {
            height: 25px;
        }
        
        .labelColor
        {
            width: 50px;
            height: 18px;
            text-align: center;
            color: White;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
            <td style="width: 800px;">
                <asp:FormView ID="FormView1" DataSourceID="SqlDataSource1" Width="100%" runat="server">
                    <ItemTemplate>
                        <table class="Form_View" width="100%">
                            <tr>
                                <td>
                                    Request Type :
                                </td>
                                <td>
                                    <asp:Label ID="LabelRequestType" runat="server" Text='<%# Eval("RequestType") %>'></asp:Label>
                                    
                                </td>
                                
                            </tr>
                            <tr>
                                <td>
                                    Requistions ID :
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("IB_ID") %>'></asp:Label>
                                    <asp:HiddenField ID="hdfApprovalStatus" runat="server" Value='<%# Eval("Is_Approved") %>' />
                                </td>
                                <td>
                                    Date Time :
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Date_Time", "{0:d}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td>
                                    Delivery Address :
                                </td>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Delivery_Address") %>'></asp:Label>
                                </td>
                                <td>
                                    Contact Person :
                                </td>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Contact_Person") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td>
                                    Phone # :
                                </td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("Phone_No") %>'></asp:Label>
                                </td>
                                <td>
                                    Remarks :
                                </td>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    To Department :
                                </td>
                                <td>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("To_Sub_Dept") %>'></asp:Label>
                                </td>
                                <td>
                                    From Department :
                                </td>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("From_Sub_Dept") %>'></asp:Label>
                                    
                                </td>
                            </tr>
                            <tr>
                                 <td>
                                   Remarks :
                                </td>
                                 <td>
                                    <asp:Label ID="Label76" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td>
                                    From Sub Department :
                                </td>
                                <td>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
            </td>
            <td>
                <asp:GridView ID="gvRequisitionApprovalLevels" ShowHeader="false" Width="100%" runat="server"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource4" OnRowDataBound="gvRequisitionApprovalLevels_RowDataBound" >
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="55px">
                            <ItemTemplate>
                                <asp:Label ID="lblColor" CssClass="labelColor" runat="server" Width="25" Text='<%# Eval("Auth_Level") %>'></asp:Label>
                                <asp:HiddenField ID="hfldColor" runat="server" Value='<%# Eval("Color") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                    SelectCommand="GetRequisitionApprovalLevels" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="IB_ID" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT   isnull(Store_Indent_Book_Main.Type,'Demand') as RequestType,    Store_Indent_Book_Main.IB_ID, Store_Indent_Book_Main.Date_Time, Store_Indent_Book_Main.Reg_No, Store_Indent_Book_Main.Yearly_NO, 
Store_Indent_Book_Main.Description, Store_Indent_Book_Main.Is_Approved, Store_Indent_Book_Main.SO_ID, Store_Indent_Book_Main.Delivery_Site, 
Store_Indent_Book_Main.Delivery_Address, Store_Indent_Book_Main.Contact_Person, Store_Indent_Book_Main.Phone_No, Store_Indent_Book_Main.Remarks, 
SubDepartment.SubDept_Name To_Sub_Dept, SubDepartment_1.SubDept_Name From_Sub_Dept, Department.Dept_Name
FROM         Store_Indent_Book_Main INNER JOIN
Department ON Store_Indent_Book_Main.From_Dept_ID = Department.Dept_ID INNER JOIN
SubDepartment AS SubDepartment_1 ON Store_Indent_Book_Main.From_Sub_Dept_ID = SubDepartment_1.SubDept_Id INNER JOIN
SubDepartment ON Store_Indent_Book_Main.To_Sub_Dept_ID = SubDepartment.SubDept_Id
Where Store_Indent_Book_Main.IB_ID = @IB_ID">
        <SelectParameters>
            <asp:QueryStringParameter Name="IB_ID" QueryStringField="IB_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvRequistionDetail" runat="server" Width="100%" AutoGenerateColumns="False"
        DataKeyNames="IB_ID,Item_Code" DataSourceID="sqlDs_RequistionDetail" 
        onprerender="gvRequistionDetail_PreRender" ShowFooter="True" OnLoad="gvRequistionDetail_Load1">
        <Columns>
            <asp:TemplateField HeaderText="Sr #">
                <ItemTemplate>
                    <%# Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="IB_ID" HeaderText="Requisition" ReadOnly="True" 
                SortExpression="IB_ID" Visible="false" />
            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" ReadOnly="True" SortExpression="Item_Code" />
            <asp:BoundField DataField="Item_Name" HeaderText="Item Name" 
                SortExpression="Item_Name" />
             <asp:BoundField DataField="Stock" HeaderText="Stock" ReadOnly="True" SortExpression="Stock" />
              <asp:BoundField DataField="Description" HeaderText="Remarks" ReadOnly="True" SortExpression="Description" />
            <asp:TemplateField HeaderText="Qty" ItemStyle-Width="100px">
                <ItemTemplate>
                    <asp:HiddenField ID="hfld_IB_ID" runat="server" Value='<%#Eval("IB_ID") %>' />
                    <asp:HiddenField ID="hfld_Item_Code" runat="server" Value='<%#Eval("Item_Code") %>' />
                    
                    <asp:TextBox ID="txtNewQty" runat="server"  Text='<%#Eval("Item_Qty")%>'></asp:TextBox>
                </ItemTemplate>

            </asp:TemplateField>
               <asp:BoundField DataField="01Months" HeaderText="01 Mon" ItemStyle-Width="35px" />
              <asp:BoundField DataField="03Months" HeaderText="03 Mon" ItemStyle-Width="35px" />
              <asp:BoundField DataField="06Months" HeaderText="06 Mon" ItemStyle-Width="35px"/>
              <asp:BoundField DataField="09Months" HeaderText="09 Mon" ItemStyle-Width="35px" />
              <asp:BoundField DataField="12Months" HeaderText="12 Mon" ItemStyle-Width="35px"/>
            <asp:TemplateField HeaderText="Rate" Visible="false"> 
                    <ItemTemplate>
                        <asp:Label ID="lblRate" runat="server" Text='<%#Eval("Item_Rate","{0:0,00}")%>'></asp:Label>
                    </ItemTemplate>
                   <FooterTemplate>
                    <asp:Label ID="lblTotal" runat="server" Text="Total Amount : " Font-Bold="true"></asp:Label>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>
            <asp:TemplateField HeaderText="Total" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblTotalAmount" runat="server" Text='<%#Eval("TotalAmount","{0:0,00}")%>'></asp:Label>
                    </ItemTemplate>
                   <FooterTemplate>
                    <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="true"></asp:Label>
                </FooterTemplate>
                </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="updtQty" runat="server" OnClick="updtQty_Click" Text="Update" CommandArgument='<%# Bind("Item_Code") %>' />
                    <asp:Button ID="btndelete" runat="server" Visible="false" Text="Delete" OnClick="btndelete_Click" OnClientClick="retrun confirm(Are you sure you want to delete this item?)" />
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlDs_RequistionDetail" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_GetRequisitionForApproval" SelectCommandType="StoredProcedure" InsertCommand="uspCreateApprovalRequest" InsertCommandType="StoredProcedure"
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
            <asp:QueryStringParameter Name="IB_ID" QueryStringField="IB_ID" />
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
                &nbsp;
            </td>
            <td style="text-align: right;" colspan="5">
                <asp:Button ID="btnrETURN" runat="server" Text="Return" 
                    OnClick="btnrETURN_Click" />
                <asp:Button ID="btnSaveQuantity" runat="server" Text="Save Quantity" OnClick="btnSaveQuantity_Click" Visible="false" />
                 <asp:Button ID="btnconsumption" runat="server" Text="Previous Consumption" OnClick="btnconsumption_Click" />
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td style="display:none;">
                <table>
                    <tr>
                        <td>
                            Remarks :
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Rows="7" Height="50px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Send To :
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSendTo" runat="server" DataSourceID="SqlDataSource2" DataTextField="Employee_Name"
                                DataValueField="EmpID">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="SELECT     Employee.EmpID,IsNull(Employee.Prefix,'') + ' ' + IsNull(Employee.EFName,'') + ' ' 
+ IsNull(Employee.ELName,'')  + ' ( ' + Cast(Approval_Authority.Auth_Level as varchar) + ' )' Employee_Name
FROM         Approval_Authority INNER JOIN
Employee ON Approval_Authority.EmployeeId = Employee.EmpID
Where Approval_Authority.SubDeptId = 
(Select top 1 Send_By_Sub_Dept_Id From Approval_Request WHere Requisition_ID = @Requistion_Id )--And Parent_Approval_Request_Id Is Null)
--And Employee.EmpID Not In ( Select Distinct Send_To From Approval_Request WHere Requisition_ID = @Requistion_Id )
Order By Auth_Level,Employee.EFName">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="Requistion_Id" QueryStringField="IB_ID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btnSave" runat="server" Text="Forward For Approval" OnClick="btnSave_Click" />
                       <asp:Label ID="Lbl_F_approval" runat="server" ForeColor = "Red"></asp:Label> 
                       </td>
                        
                    </tr>
                </table>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            Approval Remarks :
                        </td>
                        <td>
                            <asp:TextBox ID="txtApprovalRemarks" TextMode="MultiLine" Rows="7" Height="50px"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="btnApprove_Click" />
                            <asp:Label ID="Lbl_approve" runat="server" ForeColor="Red"></asp:Label>
                            <asp:SqlDataSource ID="sqlDs_Approve" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="Select Top 1 * From Approval_Request" UpdateCommand="UpdateApprovalRequest"
                                UpdateCommandType="StoredProcedure">
                                <UpdateParameters>
                                    <asp:Parameter Name="Approval_Remarks" />
                                    <asp:Parameter Name="Approved_Date" />
                                    <asp:Parameter Name="Approval_Request_Id" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            Rejection Remarks :
                        </td>
                        <td>
                            <asp:TextBox ID="txtRejectedReason" TextMode="MultiLine" Rows="7" Height="50px" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="btnReject" runat="server" Text="Reject" OnClick="btnReject_Click" />
                            <asp:Label ID="lbl_Reject" runat="server" ForeColor="Red"></asp:Label>
                            <asp:SqlDataSource ID="sqlDs_Reject" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="Select Top 1 * From Approval_Request" UpdateCommand="UpdateRejectStatus"
                                UpdateCommandType="StoredProcedure">
                                <UpdateParameters>
                                    <asp:Parameter Name="Remarks" />
                                    <asp:Parameter Name="IB_ID" />
                                    <asp:Parameter Name="Parent_Request_Id" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
             <td style="display:none;">
                <table>
                    <tr>
                        <td>Hold Remarks :
                        </td>
                        <td>
                            <asp:TextBox ID="txtHoldRemarks" TextMode="MultiLine" Rows="7" Height="50px" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnhold" runat="server" Text="Hold" OnClick="btnhold_Click" />
                            <asp:Label ID="lbl_Hold" runat="server" ForeColor="Red"></asp:Label>
                            <asp:SqlDataSource ID="sqlDs_Hold" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                UpdateCommand="UpdateHoldStatus"
                                UpdateCommandType="StoredProcedure">
                                <UpdateParameters>
                                    <asp:Parameter Name="Remarks" />
                                    <asp:Parameter Name="IB_ID" />
                                    <asp:Parameter Name="Parent_Request_Id" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>




            <td>
                <div class="bx_infos_patients">
                    <h2>
                        <span><a style="text-decoration: none">Requisition Remarks</a></span></h2>
                    <div style="height: auto" class="bxinfo_margin">
                        <asp:DataList ID="DataList_Requisition_Remarks" runat="server" DataSourceID="SqlDataSource3"
                            Width="100%">
                            <ItemTemplate>
                                <div class="bx_pathology">
                                    <ul id="CollapsiblePanelp_<%# Eval("Send_By_Employee") %>">
                                        <li><span style="font-weight: bold;">
                                            <asp:Label ID="Label10" runat="server" ToolTip="Send Date" Text='<%# Eval("Send_By_Employee") %>'></asp:Label>
                                        </span>( <span>
                                            <asp:Label ID="PrefixLabel" runat="server" ToolTip="Send Date" Text='<%# Eval("SendDate") %>'></asp:Label>
                                        </span>) ( <span>
                                            <asp:Label ID="Label15" runat="server" ToolTip="Send Date" Text='<%# Eval("Approved_Status") %>'></asp:Label>
                                        </span>) </li>

                                        <li><span style="padding-left: 20px; padding-right: 20px;">
                                            <asp:Label ID="Label45" runat="server" ToolTip="Send Date" Text='<%# Eval("Description") %>'></asp:Label>
                                        </span></li>


                                        <li><span style="padding-left: 20px; padding-right: 20px;">
                                            <asp:Label ID="Label11" runat="server" ToolTip="Send Date" Text='<%# Eval("Requisition_Remarks") %>'></asp:Label>
                                        </span></li>
                                        <li><span style="font-weight: bold;">
                                            <asp:Label ID="Label12" runat="server" ToolTip="Send Date" Text='<%# Eval("Send_To_Employee") %>'></asp:Label>
                                        </span>( <span>
                                            <asp:Label ID="Label13" runat="server" ToolTip="Send Date" Text='<%# Eval("Approved_Date") %>'></asp:Label>
                                        </span>) </li>
                                        <li><span style="padding-left: 20px; padding-right: 20px;">
                                            <asp:Label ID="Label14" runat="server" ToolTip="Send Date" Text='<%# Eval("Approval_Remarks") %>'></asp:Label>
                                        </span></li>
                                    </ul>
                                    <script type='text/javascript'>var CollapsiblePanelp_<%# Eval("Send_By_Employee") %> = 
                                    new Spry.Widget.CollapsiblePanel('CollapsiblePanelp_<%# Eval("Send_By_Employee") %>',{contentIsOpen:false});</script>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT     Approval_Request.SendDate, Approval_Request.Requisition_Remarks, Approval_Request.Approved_Status, 
Approval_Request.Approved_Date, Approval_Request.Approval_Remarks, IsNull(Employee_1.Prefix,'') + ' ' + IsNull(Employee_1.EFName,'') 
+ ' ' + IsNull(Employee_1.ELName,'') AS Send_To_Employee, 
IsNull(Employee.Prefix,'') + ' ' + IsNull(Employee.EFName,'') + ' ' + IsNull(Employee.ELName,'')
AS Send_By_Employee, Store_Indent_Book_Main.Description
FROM         Approval_Request INNER JOIN
Employee ON Approval_Request.Send_By = Employee.EmpID INNER JOIN
Employee AS Employee_1 ON Approval_Request.Send_To = Employee_1.EmpID inner join Store_Indent_Book_Main on Store_Indent_Book_Main.IB_ID=Approval_Request.Requisition_ID
 
WHERE     (Approval_Request.Requisition_ID = @Requisition_ID)
Order By SendDate">
        <SelectParameters>
            <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="IB_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
