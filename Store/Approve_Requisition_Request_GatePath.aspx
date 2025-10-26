<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Approve_Requisition_Request_GatePath, App_Web_cgfanjlz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
                                    Gate Pass No :
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("G_PassNO") %>'></asp:Label>
                                </td>
                                <td>
                                    Date Time :
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Gate_PassDate", "{0:d}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td>
                                   Transport :
                                </td>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Transporter") %>'></asp:Label>
                                </td>
                                <td>
                                   Vehicle No :
                                </td>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Vehicle_No") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td>
                                    Reference # :
                                </td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("ReferenceNo") %>'></asp:Label>
                                </td>
                              
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
            </td>
            <td>
                <asp:GridView ID="gvRequisitionApprovalLevels" ShowHeader="false" Width="100%" runat="server"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource4" OnRowDataBound="gvRequisitionApprovalLevels_RowDataBound">
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
                    SelectCommand="GetRequisitionApprovalLevelsGatePass" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="G_PassNO" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT    G_PassNO, Gate_PassDate, Transporter, Vehicle_No, ReferenceNo
FROM         Store_Gate_Pass_Main
where G_PassNO = @G_PassNO">
        <SelectParameters>
            <asp:QueryStringParameter Name="G_PassNO" QueryStringField="G_PassNO" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="gvRequistionDetail" runat="server" Width="100%" AutoGenerateColumns="False"
        DataKeyNames="G_PassNO,ItemCode" DataSourceID="sqlDs_RequistionDetail" 
        onprerender="gvRequistionDetail_PreRender" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="G_PassNO" HeaderText="Gate Pass #" ReadOnly="True" 
                SortExpression="G_PassNO" />
            <asp:BoundField DataField="ItemCode" HeaderText="Item Code" ReadOnly="True" SortExpression="Item_Code" />
            <asp:BoundField DataField="Description" HeaderText="Item Name" 
                SortExpression="Description" />
            <asp:TemplateField HeaderText="Qty">
                <ItemTemplate>
                    <asp:HiddenField ID="hfld_IB_ID" runat="server" Value='<%#Eval("Gate_Pass_Sub_ID") %>' />
                    <asp:HiddenField ID="hfld_Item_Code" runat="server" Value='<%#Eval("ItemCode") %>' />
                    <asp:TextBox ID="txtNewQty" runat="server" Text='<%#Eval("Qty")%>' Enabled="false"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
<%--            <asp:TemplateField HeaderText="Rate" Visible="false"> 
                    <ItemTemplate>
                        <asp:Label ID="lblRate" runat="server" Text='<%#Eval("Item_Rate","{0:0,00}")%>'></asp:Label>
                    </ItemTemplate>
                   <FooterTemplate>
                    <asp:Label ID="lblTotal" runat="server" Text="Total Amount : " Font-Bold="true"></asp:Label>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
                </asp:TemplateField>--%>
            <asp:TemplateField HeaderText="Total" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblTotalAmount" runat="server" Text='<%#Eval("Qty","{0:0,00}")%>'></asp:Label>
                    </ItemTemplate>
                   <FooterTemplate>
                    <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="true"></asp:Label>
                </FooterTemplate>
                </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlDs_RequistionDetail" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="Select M.G_PassNO,S.Description, s.Qty,s.UOM,s.ItemCode,s.Gate_Pass_Sub_ID
From Store_Gate_Pass_Main M Inner Join
	 Store_Gate_Pass_Sub S On M.ID=S.Gate_Pass_Main_ID
	 where m.G_PassNO=@G_PassNO" InsertCommand="uspCreateApprovalRequestForGatePath" InsertCommandType="StoredProcedure"
        UpdateCommand="Update Store_Gate_Pass_Sub Set Qty = @Qty Where Gate_Pass_Sub_ID = @Gate_Pass_Sub_ID">
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
             <asp:Parameter Name="G_PassNo" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="G_PassNO" QueryStringField="G_PassNO" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="Gate_Pass_Sub_ID" />
            <asp:Parameter Name="ItemCode" />
             <asp:Parameter Name="G_PassNo" />
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
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td>
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
+ IsNull(Employee.ELName,'')  + ' ( ' + Cast(Approval_AuthorityForGatePass.Auth_Level as varchar) + ' )' Employee_Name
FROM         Approval_AuthorityForGatePass INNER JOIN
Employee ON Approval_AuthorityForGatePass.EmployeeId = Employee.EmpID
Where Approval_AuthorityForGatePass.SubDeptId = 
(Select top 1 Send_By_Sub_Dept_Id From Approval_Request_GatePass WHere Requisition_ID = @Requistion_Id )--And Parent_Approval_Request_Id Is Null)
--And Employee.EmpID Not In ( Select Distinct Send_To From Approval_Request_GatePass WHere Requisition_ID = @Requistion_Id )
Order By Auth_Level,Employee.EFName">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="Requistion_Id" QueryStringField="G_PassNO" />
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
                                SelectCommand="Select Top 1 * From Approval_Request_GatePass" UpdateCommand="UpdateApprovalRequestGatePass"
                                UpdateCommandType="StoredProcedure">
                                <UpdateParameters>
                                    <asp:Parameter Name="Approval_Remarks" />
                                    <asp:Parameter Name="Approved_Date" />
                                    <asp:Parameter Name="Approval_Request_Id" />
                                      <asp:Parameter Name="G_PassNo" />
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
                             <asp:HiddenField ID="hfRID" runat="server" Value='<%#Eval("Approval_Request_Id") %>' />
                            <asp:Label ID="lbl_Reject" runat="server" ForeColor="Red"></asp:Label>
                            <asp:SqlDataSource ID="sqlDs_Reject" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="Select Top 1 * From Approval_Request_GatePass" UpdateCommand="UpdateRejectStatus_GatePath"
                                UpdateCommandType="StoredProcedure">
                                <UpdateParameters>
                                    <asp:Parameter Name="Remarks" />
                                  
                                    <asp:Parameter Name="Parent_Request_Id" />
                                      <asp:Parameter Name="G_PassNo" />
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
        SelectCommand="SELECT     Approval_Request_GatePass.SendDate, Approval_Request_GatePass.Requisition_Remarks, Approval_Request_GatePass.Approved_Status, 
Approval_Request_GatePass.Approved_Date, Approval_Request_GatePass.Approval_Remarks, IsNull(Employee_1.Prefix,'') + ' ' + IsNull(Employee_1.EFName,'') 
+ ' ' + IsNull(Employee_1.ELName,'') AS Send_To_Employee, 
IsNull(Employee.Prefix,'') + ' ' + IsNull(Employee.EFName,'') + ' ' + IsNull(Employee.ELName,'')
AS Send_By_Employee
FROM         Approval_Request_GatePass INNER JOIN
Employee ON Approval_Request_GatePass.Send_By = Employee.EmpID INNER JOIN
Employee AS Employee_1 ON Approval_Request_GatePass.Send_To = Employee_1.EmpID
WHERE     (Approval_Request_GatePass.Requisition_ID = @Requisition_ID)
Order By SendDate">
        <SelectParameters>
            <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="G_PassNO" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
