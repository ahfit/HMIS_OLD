<%@ Page Language="C#" AutoEventWireup="true" Inherits="RecievedRequisitionList" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="RecievedRequisitionList.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td align="right" width="30%">From Office :
                </td>
                <td>
                    <asp:DropDownList ID="ddlFromOffice" runat="server" DataSourceID="SQL_ForSubDepartment"
                        DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True" Width="290px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SQL_ForSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT   Distinct     S.SubDept_Name, S.SubDept_Id
                                            FROM            SubDepartment AS S JOIN
                                                                     requisition_department_filter AS R ON S.SubDept_Id = R.sub_Subdept_ID
                                            WHERE        (R.Main_Subdept_ID = @SubDept_Id) and (R.Requisition_Type = 'Internal')">
                        <SelectParameters>
                            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                        </SelectParameters>

                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
        Width="100%" DataKeyNames="IB_ID" DataSourceID="SqlDataSource_List"
        OnPreRender="GridView2_PreRender"
        EnableModelValidation="True">
        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <Columns>
            <asp:BoundField DataField="ShiftID" HeaderText="ShiftID" SortExpression="ShiftID"
                Visible="False" />
            <asp:TemplateField HeaderText="Requisition #" SortExpression="IB_ID">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("IB_ID") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("IB_ID") %>'></asp:Label>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="select"
                        Text='<%# Bind("IB_ID") %>' Visible="False"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="By" HeaderText="Employee" ReadOnly="True" SortExpression="By" />
            <asp:BoundField DataField="By Department" HeaderText="To Office"
                SortExpression="By Department" />
            <asp:BoundField DataField="Date Time" HeaderText="Date Time" ReadOnly="True" SortExpression="Date Time" />
            <asp:BoundField DataField="Issued_By" HeaderText="Issued By Employee"
                SortExpression="Issued_By" />
            <asp:BoundField DataField="Issued_from" HeaderText="From Office"
                SortExpression="Issued_from" />
            <asp:BoundField DataField="customer" HeaderText="For Customer"
                SortExpression="customer" />

            <asp:TemplateField Visible="false" HeaderText="Reject">
                <ItemTemplate>
                    <asp:LinkButton ID="lbn_Remarks" runat="server" CommandArgument='<%# Eval("Consumption_Id") %>'
                        OnClick="lbn_Remarks_Click">Reject</asp:LinkButton>
                    <asp:HiddenField ID="hf_Consumption" runat="server" Value='<%# Eval("IB_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Consumption_Id,IB_ID,subdeptid" HeaderText="Receive/Reject Items" DataNavigateUrlFormatString="ItemsRecieveRequisition.aspx?C_ID={0}&amp;IB_ID={1}&subdeptid={2}"
                Text="Receive" />


            <asp:HyperLinkField DataNavigateUrlFields="Consumption_Id,IB_ID,subdeptid" HeaderText="Report" DataNavigateUrlFormatString="Recieved_Wise_Items.aspx?C_ID={0}&amp;IB_ID={1}&subdeptid={2}"
                Text="View Report" />
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <br />




    <asp:Panel ID="Panel_Remarks" runat="server" Visible="False" CssClass="lightbox" Wrap="False">
        <br />
        <div class="bxmain">
            &nbsp;<strong style="font-weight: bold; font-size: 13px;">Requisition No. : </strong>

            <asp:Label ID="Lbl_Requisition_No" runat="server" Style="color: #900; font-weight: bold; font-size: 13px; padding-bottom: 5px;"></asp:Label>
            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                <tr>
                    <td>
                        <asp:TextBox ID="TextBox_Remarks" runat="server" Width="100%" Height="250px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>

                    <td colspan="2" align="center">

                        <asp:Button ID="btn_Save" runat="server" OnClick="btn_Save_Click" Text="Save And Reject" />
                        <asp:Button ID="btn_Cancel" runat="server" OnClick="btn_Cancel_Click" Text="Cancel" />
                    </td>

                </tr>
            </table>
        </div>



        <asp:SqlDataSource ID="Sql_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            UpdateCommand="Rejected_Requisition"
            UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="TextBox_Remarks" Name="Reject_Remarks" PropertyName="Text" />
                <asp:ControlParameter ControlID="HF_Re_ID" Name="Consumption_Id" PropertyName="Value" />
                <asp:SessionParameter Name="Approved_by" SessionField="emp_id" Type="Int32" />

            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <div align="center">

            <strong>
                <asp:Label ID="Label" runat="server" Style="color: #CC0000;"></asp:Label></strong>
        </div>
        <br />
        <asp:HiddenField ID="HiddenField1" runat="server" />
    </asp:Panel>

    <asp:HiddenField ID="HF_Re_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_List" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        SelectCommand="usp_Select_Internal_Department_Issue" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlFromOffice" Name="Sub_Dept_ID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_dept_ID" runat="server" />

</asp:Content>
