<%@ page title="" language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Store_Delivery_To_Customer"
      CodeFile="Delivery_To_Customer.aspx.vb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
      <table class="style1">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div style="width: 100%;">
                    <table style="width: 90%; margin: auto;">
                        <tr>
                            <td style="font-weight: bold;">
                                Company
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <asp:DropDownList ID="DDL_Company" runat="server" DataSourceID="SDS_Company" DataTextField="Financial_Company_Name"
                                    DataValueField="Financial_Company_Id" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Company" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @emp_id)))">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <td style="font-weight: bold;">
                                Branch
                            </td>
                            <td>
                                <strong>:</strong>
                            </td>
                            <td>
                                <asp:DropDownList ID="DDL_Branch" runat="server" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                                    DataValueField="SubDept_Id" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Branch" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="SELECT        SubDepartment.SubDept_Id, SubDepartment.SubDept_Name
FROM            SubDepartment INNER JOIN
                         Group_Financial_Companies ON SubDepartment.Financial_Company_Id = Group_Financial_Companies.Financial_Company_Id
Where         SubDepartment.Financial_Company_Id=@Financial_Company_Id">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_Company" Name="Financial_Company_Id" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <td style="font-weight: bold;">
                                Item Category
                            <td>
                               <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="DDL_item_cat" runat="server" AutoPostBack="True" datasourceid="SDS_Item_cat" DataTextField="Item_Category" DataValueField="Item_Category_ID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Item_cat" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT  0 Item_Category_ID, ' All ' Item_Category Union 
Select T.Item_Type_Id Item_Category_ID, T.Item_Type Item_Category from StoreItems_Consumption_Detail Cd Inner join StoreItem_Consumption_Main Cm on Cm.Consumption_Id = CD.Consumption_Id inner join  Store_items I on I.Item_Code = Cd.Item_code Inner join Store_Item_Types T
on I.Item_Type_Id = T.Item_Type_Id
where CM.SubDept_Id = @Subdept_id ;">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_Company" Name="Financial_Company_Id" PropertyName="SelectedValue" />
                                         <asp:ControlParameter ControlID="DDL_Branch" Name="Subdept_id" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                Issue Date From
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <igsch:WebDateChooser ID="WebDateChooser_date_From" runat="server" Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                            <td style="font-weight: bold;">
                                Requisition No
                            </td>
                            <td>
                                <strong>:</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRequistionNo" runat="server"></asp:TextBox>
                            </td>
                            <td style="font-weight: bold;">
                                Item</td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="DDL_item" runat="server" datasourceid="SDS_Item" DataTextField="Item_Name" DataValueField="Item_Code">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Item" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT    '0'    Item_Code,' All ' Item_Name union Select I.Item_Code ,I.Item_Name from StoreItems_Consumption_Detail Cd Inner join StoreItem_Consumption_Main Cm on Cm.Consumption_Id = CD.Consumption_Id inner join  Store_items I on I.Item_Code = Cd.Item_code
where CM.SubDept_Id = @Subdept_id and (@cat =0 or I.Item_Type_Id =@cat) order by Item_Name;">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_item_cat" Name="cat" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="DDL_Branch" Name="Subdept_id" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                Issue Date To
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <igsch:WebDateChooser ID="WebDateChooser_Date_To" runat="server" Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                            <td style="font-weight: bold;">
                                Issue to</td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <asp:DropDownList ID="DDL_Branch0" runat="server" DataSourceID="SDS_Branch0" DataTextField="SubDept_Name"
                                    DataValueField="SubDept_Id" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Branch0" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="SELECT      0 SubDept_Id, 'All' SubDept_Name
UNION
SELECT        SubDepartment.SubDept_Id, SubDepartment.SubDept_Name
FROM            SubDepartment INNER JOIN
                         Group_Financial_Companies ON SubDepartment.Financial_Company_Id = Group_Financial_Companies.Financial_Company_Id
Where         SubDepartment.Financial_Company_Id=@Financial_Company_Id">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_Company" Name="Financial_Company_Id" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:TextBox ID="txtCustomerName" runat="server" Visible="False"></asp:TextBox>
                            </td>
                            <td style="font-weight: bold;">
                                Type</td>
                            <td style="font-weight: bold;">
                                :</td>
                            <td>
                               <%-- <asp:DropDownList ID="ddlDCType"   DataSourceID="SqlDataSourceTypes"
                                    DataTextField="Type_Name" DataValueField="Type_Name"    runat="server">
                                    
                                </asp:DropDownList>--%>
                                <asp:DropDownList ID="ddltypes"   runat="server" DataSourceID="SqlDataSourceTypes"
                                    DataTextField="Type_Name" DataValueField="Type_Name" AutoPostBack="True" >
                                </asp:DropDownList>

                            </td>
                             <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT 0 as   [TypeID]      ,'All' as [Type_Name]   UNION SELECT  [TypeID]      ,[Type_Name]     FROM [STORE].[dbo].[InternalRequsitionTypes]" >
       
      
    </asp:SqlDataSource>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td align="center">
                &nbsp;
                <asp:Button ID="btnSearch" runat="server" Text="Search" />
                &nbsp; &nbsp;
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" Visible="false" />
                <asp:Button ID="btn_Report" runat="server" Text="Report" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                <asp:Label ID="lblmsgGen" runat="server" Text="Selected customers are not same."
                    Visible="false" Font-Bold="true" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Consumption_Id"
                    DataSourceID="SqlDataSource1" Width="99%" EmptyDataText="No Record(s) Found" ShowFooter="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr. No.">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="50px"></ItemStyle>
                        </asp:TemplateField>
                       <asp:HyperLinkField DataNavigateUrlFields="Consumption_id" Target="_blank" DataTextField="Requisition_Id" HeaderText="Requisition No."
                            DataNavigateUrlFormatString="Search_Order_Wise.aspx?C_ID={0}"/>
                      
                       
                        <asp:BoundField DataField="Consumed_Date" DataFormatString="{0:dd/MM/yyyy hh:mm:ss tt}"
                            HeaderText="Issue Date" SortExpression="Consumed_Date" />
                        <asp:BoundField DataField="ReqType" HeaderText="Type" />
                        <asp:BoundField DataField="Party_Name" HeaderText="Customer Name" SortExpression="Party_Name" Visible ="false" />
                        <asp:BoundField DataField="Delivery_Site" HeaderText="Delivery Site" SortExpression="Delivery_Site" />
                        <asp:BoundField DataField="Delivery_Address" HeaderText="Delivery Site Address" SortExpression="Delivery_Address" />
                        <asp:BoundField DataField="Contact_Person" HeaderText="Contact Person" SortExpression="Contact_Person" />
                        <asp:TemplateField HeaderText="Phone No.">
                            <ItemTemplate>
                                <asp:Label ID="lblPhone_No" runat="server" Text='<%# Eval("Phone_No") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbltotal" runat="server" Text="Total: "></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="Phone_No" HeaderText="Phone No." SortExpression="Phone_No" />--%>
                        <asp:TemplateField HeaderText="Total Qty">
                            <ItemTemplate>
                                <asp:Label ID="lblqty" runat="server" Text='<%# Eval("Qty") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbltotalqty" runat="server" Text=""></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="Qty" HeaderText="Total Qty" SortExpression="Qty" />--%>
                        <asp:BoundField DataField="Delivery_Person_Info" HeaderText="Delivery Person Information"
                            SortExpression="Delivery_Person_Info" Visible="False" />
                        <asp:BoundField DataField="Delivery_Method" HeaderText="Delivery by" SortExpression="Delivery_Method"
                            Visible="False" />
                        <asp:BoundField DataField="EFName" HeaderText="Employee name" SortExpression="EFName"
                            Visible="False" />
                        <asp:BoundField DataField="SubDept_Name" HeaderText="Issue To" SortExpression="SubDept_Name"
                            Visible="True" />
                        <asp:HyperLinkField DataNavigateUrlFields="Consumption_id" Target="_blank" Text="Issued Detail"
                            DataNavigateUrlFormatString="IssuedItemsReport.aspx?C_ID={0}"/>
                            <asp:HyperLinkField DataNavigateUrlFields="Consumption_id" Target="_blank" Text="Delivery Challan"
                            DataNavigateUrlFormatString="Search_Order_Wise.aspx?C_ID={0}"/>
                        <asp:HyperLinkField DataNavigateUrlFields="Consumption_id" Target="_blank" Text="DC With Order #"
                            DataNavigateUrlFormatString="Search_Order_Wise.aspx?C_ID={0}" Visible="false" />
                        <asp:HyperLinkField DataNavigateUrlFields="Consumption_ID" DataNavigateUrlFormatString="Customer_DC_View.aspx?C_ID={0}"
                            Text="Tag #" Target="_blank" Visible="false" />
                        <asp:HyperLinkField DataNavigateUrlFields="Consumption_id" DataNavigateUrlFormatString="Search_Order_Wise_Sum.aspx?C_ID={0}"
                            Target="_blank" Text="DC With Tag #" Visible="false" />
                        <asp:HyperLinkField DataNavigateUrlFields="Consumption_id" DataNavigateUrlFormatString="Consumption_Wise_ReturnItems.aspx?C_ID={0}"
                            Target="_blank" Text="Return Item" Visible="False" />
                        <asp:TemplateField HeaderText="Invoice" Visible="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LBN_Invoice" runat="server" CommandArgument='<%# Eval("Consumption_Id") %>'
                                    Visible='<%# Eval("gen_vis") %>' OnClick="LBN_Invoice_Click">Generate</asp:LinkButton>
                                <asp:LinkButton ID="LBN_View" runat="server" CommandArgument='<%# Eval("SO_Id") %>'
                                    Visible='<%# Eval("View_vis") %>' OnClick="LBN_View_Click">View</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField  Visible="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="LBN_Update" runat="server" CommandArgument='<%# Eval("Consumption_Id") %>'
                                    OnClick="LBN_Update_Click">Update Invoice</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="3%" Visible="false">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkboxGenerate" runat="server" AutoPostBack="true" OnCheckedChanged="chkboxGenerate_CheckedChanged" />
                                <asp:HiddenField ID="hdfCustomerId" runat="server" Value='<%# Eval("Company_Id") %>' />
                                <asp:HiddenField ID="hdfConsumptionId" runat="server" Value='<%# Eval("Consumption_Id") %>' />
                            </ItemTemplate>
                            <ItemStyle Width="3%"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="False" Enabled="false" OnClientClick='return confirm("Do you want to delete this record?");'
                                    Width="16px" ImageUrl="~/images/icon_delete.gif" Text="Delete" CommandArgument='<%# Eval("Consumption_Id") %>'
                                    OnClick="imgDelete_Click" Visible='<%# Eval("gen_vis") %>' />
                            </ItemTemplate>
                            <ItemStyle CssClass="elementCenterAlign" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                 <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
              
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <%--SELECT StoreItem_Consumption_Main.Consumption_Id, StoreItem_Consumption_Main.Consumed_Date, StoreItem_Consumption_Main.Requisition_Id, parties.Party_Name, StoreItem_Consumption_Main.Delivery_Site, StoreItem_Consumption_Main.Delivery_Address, StoreItem_Consumption_Main.Contact_Person, StoreItem_Consumption_Main.Phone_No, StoreItem_Consumption_Main.Delivery_Person_Info, StoreItem_Consumption_Main.Delivery_Method, Employee.EFName, Department.Dept_Name, SubDepartment.SubDept_Name, StoreItem_Consumption_Main.SubDept_Id FROM StoreItem_Consumption_Main INNER JOIN parties ON StoreItem_Consumption_Main.Company_Id = parties.Party_Id INNER JOIN Employee ON StoreItem_Consumption_Main.Consumed_By = Employee.EmpID INNER JOIN Department ON StoreItem_Consumption_Main.Dept_iD = Department.Dept_ID INNER JOIN SubDepartment ON StoreItem_Consumption_Main.SubDept_Id = SubDepartment.SubDept_Id WHERE (StoreItem_Consumption_Main.SubDept_Id = @SubDept_Id) ORDER BY StoreItem_Consumption_Main.Consumption_Id DESC--%>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                    SelectCommand="usp_CustomerDeliveryChallan" SelectCommandType="StoredProcedure"
                    InsertCommand="Insert_SaleInvoice_By_DC" InsertCommandType="StoredProcedure"
                    DeleteCommand="usp_Delete_DC" DeleteCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="Consumption_ID" Type="Decimal" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HF_C_ID" Name="Consumption_Id" PropertyName="Value"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="Hf_SO_No" Direction="InputOutput" Name="SO_ID" PropertyName="Value"
                            Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="hfld_RequisitionNo" Name="RequisitionNo" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="hfld_PartyName" Name="Party_Name" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="hfld_IssueDateFrom" Name="IssueDateFrom" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="hfld_IssueDateTo" Name="IssueDateTo" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="hfld_PartyName" Name="CustomerName" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="ddltypes" Name="DCType" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SDS_Report" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                    SelectCommand="usp_CustomerDeliveryChallanItem_wise" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="hfld_RequisitionNo" Name="RequisitionNo" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="hfld_PartyName" Name="Party_Name" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="hfld_IssueDateFrom" Name="IssueDateFrom" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="hfld_IssueDateTo" Name="IssueDateTo" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="hfld_PartyName" Name="CustomerName" PropertyName="Value"
                            Type="String" />
                        <asp:ControlParameter ControlID="DDL_item" Name="Item_code" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="DDL_item_cat" Name="Cat_ID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="issue_to" Type="Int32" />
                        <asp:ControlParameter ControlID="ddltypes" Name="DCType" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="HF_C_ID" runat="server" />
                <asp:HiddenField ID="Hf_SO_No" runat="server" />
                <asp:HiddenField ID="hfld_RequisitionNo" runat="server" />
                <asp:HiddenField ID="hfld_PartyName" runat="server" />
                <asp:HiddenField ID="hfld_IssueDateFrom" runat="server" />
                <asp:HiddenField ID="hfld_IssueDateTo" runat="server" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:Panel ID="PnlUpdateInvoice" runat="server" Visible="false" CssClass="lightbox"
        Width="500px" Height="200px">
        <table width="100%">
            <tr>
                <td align="right">
                    Invoice No:
                </td>
                <td align="left">
                    <asp:TextBox ID="tbxInvoiceNo" runat="server" AutoPostBack="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="3" style="padding-left: 150px;">
                    <asp:Button ID="btnUpdateInvoice" runat="server" Text="Update" Enabled="False" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" />
                    <asp:Label ID="lblMsg" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblQtyval" runat="server" Text="" Visible="false" Font-Bold="True"></asp:Label>
                </td>
                <td align="left">
                    <asp:Label ID="lblAmount" runat="server" Text="" Visible="false" Font-Bold="True"></asp:Label>
                </td>
                <asp:Label ID="lblSOID" runat="server" Text="" Visible="false"></asp:Label>
            </tr>
            <asp:HiddenField ID="hdfConsumptionID" runat="server" />
        </table>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            SelectCommand="SELECT Sale_Order_Main.SO_ID, sum(isnull(Sale_Order_Sub.Qty,0)) as Qty , sum(isnull(Sale_Order_Sub.Amount,0)) as Amount
FROM Sale_Order_Main INNER JOIN Sale_Order_Sub ON Sale_Order_Main.SO_ID = Sale_Order_Sub.SO_ID
                      where Sale_Order_Main.Sys_Invoice_NO=@InvoiceNo group by Sale_Order_Main.SO_ID"
            UpdateCommand="UPDATE    StoreItem_Consumption_Main
SET              SO_Id =@SoID where Consumption_Id=@cosumptionID">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbxInvoiceNo" Name="InvoiceNo" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="lblSOID" Name="SoID" PropertyName="Text" />
                <asp:ControlParameter ControlID="hdfConsumptionID" Name="cosumptionID" PropertyName="Value" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </asp:Panel>
</asp:Content>
