<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Approve_RequisitionForGatePass, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">
    .Form_View tr
    {
        height:25px;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <asp:FormView ID="FormView" DataSourceID="SqlDataSource1" Width="100%" runat="server">
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

       <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT    G_PassNO, Gate_PassDate, Transporter, Vehicle_No, ReferenceNo
FROM         Store_Gate_Pass_Main
where G_PassNO = @G_PassNO">
        <SelectParameters>
            <asp:QueryStringParameter Name="G_PassNO" QueryStringField="G_PassNO" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:GridView ID="gvRequistionDetail" runat="server" Width="100%"
        AutoGenerateColumns="False"  DataKeyNames="G_PassNO,ItemCode" 
        DataSourceID="sqlDs_RequistionDetail" 
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
+ IsNull(Employee.ELName,'')  + ' ( ' + Cast(Approval_AuthorityForGatePass.Auth_Level as varchar) + ' )' Employee_Name
FROM         Approval_AuthorityForGatePass INNER JOIN
Employee ON Approval_AuthorityForGatePass.EmployeeId = Employee.EmpID
Where Approval_AuthorityForGatePass.SubDeptId= @SubDeptId
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

