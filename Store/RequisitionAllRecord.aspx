<%@ Page Language="C#" AutoEventWireup="true" Inherits="RequisitionWaitingList" CodeFile="RequisitionAllRecord.aspx.cs"
    MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <asp:SqlDataSource ID="SqlDataSource_List" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Search_Requisitions"
        SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource_List_Selecting">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfld_IndentBookNo" Name="IndentBookNo" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="hfld_FromSubDept_Id" Name="FromSubDept_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="hfld_ToSubDept_Id" Name="ToSubDept_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="hfld_From_Date" Name="FromDate" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="hfld_To_Date" Name="ToDate" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="ddlRequestType" Name="Req_Type" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="rblRequestStatus" Name="Req_Status" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_dept_ID" runat="server" />
    <asp:HiddenField ID="hfld_From_Date" runat="server" />
    <asp:HiddenField ID="hfld_FromSubDept_Id" runat="server" />
    <asp:HiddenField ID="hfld_IndentBookNo" runat="server" />
    <asp:HiddenField ID="hfld_To_Date" runat="server" />
    <asp:HiddenField ID="hfld_ToSubDept_Id" runat="server" />
    <asp:HiddenField ID="HF_Re_ID" runat="server" />
    <asp:Panel ID="Panel_Remarks" runat="server" CssClass="lightbox" Visible="False">
        <table class="style1">
            <tr>
                <td colspan="2">
                    <asp:Label ID="Lbl_Requisition_No" runat="server"></asp:Label>
                    <br />
                    <asp:TextBox ID="TextBox_Remarks" runat="server" Width="400px" Rows="7" TextMode="MultiLine"></asp:TextBox>
                    <asp:SqlDataSource ID="Sql_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="SELECT Remarks FROM Store_Indent_Book_Main WHERE (IB_ID = @IB_ID)"
                        UpdateCommand="UPDATE Store_Indent_Book_Main SET Remarks = @Remarks WHERE (IB_ID = @IB_ID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HF_Re_ID" Name="IB_ID" PropertyName="Value" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="TextBox_Remarks" Name="Remarks" PropertyName="Text" />
                            <asp:ControlParameter ControlID="HF_Re_ID" Name="IB_ID" PropertyName="Value" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Label" runat="server"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btn_Save" runat="server" OnClick="btn_Save_Click" Text="Save" />
                    <asp:Button ID="btn_Cancel" runat="server" OnClick="btn_Cancel_Click" Text="Cancel" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <table class="style1">
        <tr>
            <td colspan="2">
                <div style="width: 100%;">
                    <table style="width: 500px; margin: auto;">
                        <tr>
                            <td style="font-weight: bold;">
                                Indent Book No
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <asp:TextBox ID="txtIdentBookNo" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                From Department
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFromDepartment" runat="server" DataSourceID="sqlds_SubDepartment"
                                    DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sqlds_SubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="Select 0 SubDept_Id, ' --- All --- ' SubDept_Name Union All Select SubDept_Id,SubDept_Name From SubDepartment Order By SubDept_Name">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                To Department
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlToDepartment" runat="server" DataSourceID="sqlds_SubDepartment"
                                    DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                Request Type
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlRequestType" runat="server">
                                    <asp:ListItem Selected="True" Text="Customer Requests"></asp:ListItem>
                                    <asp:ListItem Text="Departmental Requests"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                From Date
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
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                To Date
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <igsch:WebDateChooser ID="WebDateChooser_date_To" runat="server" Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">
                                Request Status
                            </td>
                            <td style="font-weight: bold;">
                                :
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rblRequestStatus" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Text="All" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Done" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                            </td>
                            <td>
                                <asp:Button ID="btnSearchRequisitions" runat="server" Text="Search" OnClick="btnSearchRequisitions_Click" />
                                <span style="font-weight:bold; color:Red;">Total Record(s) Found : </span>
                                <asp:Label ID="lblRecords" runat="server" Text="0" ForeColor="Red" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <%--Visible="False"--%>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="lightbox"
                    DataKeyNames="IB_ID" DataSourceID="SqlDataSource_List" EnableModelValidation="True"
                    OnPreRender="GridView2_PreRender" OnSelectedIndexChanged="GridView2_SelectedIndexChanged"
                    EmptyDataText="No Record Found" Width="100%">
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
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="select" Text='<%# Bind("IB_ID") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="By" HeaderText="Employee" ReadOnly="True" SortExpression="By" />
                        <asp:BoundField DataField="By Department" HeaderText="From Department" SortExpression="By Department" />
                        <asp:BoundField DataField="To_Department" HeaderText="To Department" SortExpression="To_Department" />
                        <asp:BoundField DataField="Date Time" HeaderText="Date Time" ReadOnly="True" SortExpression="Date Time" />
                        <asp:CheckBoxField DataField="Request_Status" HeaderText="Request Status" SortExpression="Request_Status"
                            Visible="False" />
                        <asp:CheckBoxField DataField="Status" HeaderText="Status" SortExpression="Status"
                            Visible="False" />
                        <asp:HyperLinkField DataNavigateUrlFields="Store_Item_Issue_Id" DataNavigateUrlFormatString="Issue_Wise_Items.aspx?Issue_id={0}"
                            Target="_blank" Text="Delivery Report" />
                        <asp:HyperLinkField DataNavigateUrlFields="IB_ID" DataNavigateUrlFormatString="Requsition_Report.aspx?RequsitionNo={0}"
                            Target="_blank" Text="Requisition No." />
                        <asp:TemplateField HeaderText="Add Remarks">
                            <ItemTemplate>
                                <asp:LinkButton ID="Lb_Remarks" runat="server" CommandArgument='<%# Eval("IB_ID") %>'
                                    OnClick="Lb_Remarks_Click">Remarks</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
            <td align="center">
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
