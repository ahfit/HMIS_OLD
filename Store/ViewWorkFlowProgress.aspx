<%@ Page Title="" Language="C#"  MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="ViewWorkFlowProgress.aspx.cs" Inherits="Store_ViewWorkFlowProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
        .Form_View tr
        {
            height: 25px;
        }
        
        .labelColor
        {
            width:50px;
            height:18px;
            text-align:center;
            color:White;
            font-weight:bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div style="margin-bottom:10px;">
    <span class="labelColor" style="background-color:Red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> &nbsp;&nbsp; Not Approved &nbsp;&nbsp;
    <span class="labelColor" style="background-color:Green;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> &nbsp;&nbsp; Approved &nbsp;&nbsp;
    <span class="labelColor" style="background-color:Blue;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> &nbsp;&nbsp; Request Not Send &nbsp;&nbsp;
    <span class="labelColor" style="background-color:Maroon;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> &nbsp;&nbsp; Rejected
</div>

<asp:GridView ID="gvRequisitionApprovalLevels"  ShowHeader="true" Width="100%" runat="server" 
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource4" 
                    onrowdatabound="gvRequisitionApprovalLevels_RowDataBound">
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="55px">
                            <ItemTemplate>
                                <asp:Label ID="lblColor" CssClass="labelColor" runat="server" Width="25" Text='<%# Eval("Auth_Level") %>'></asp:Label>
                                <asp:HiddenField ID="hfldColor" runat="server" Value='<%# Eval("Color") %>' />
                            </ItemTemplate>

<ItemStyle Width="55px"></ItemStyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="SendBy" HeaderText="Forwarded By" />
                        <asp:BoundField DataField="SendDate" DataFormatString="{0:dd MMMM yyyy hh:mm ttt}" HeaderText="Send Date" />
                        <asp:BoundField DataField="Requisition_Remarks" 
                            HeaderText="Sending Remarks" />
                        <asp:BoundField DataField="Name" HeaderText="Approved By" ReadOnly="True" 
                            SortExpression="Name" />
                        <asp:BoundField DataField="Approved_Date" DataFormatString="{0:dd MMMM yyyy hh:mm ttt}" HeaderText="Approved Date" />
                        <asp:BoundField DataField="Approved_Status" HeaderText="Approved Status" />
                        <asp:BoundField DataField="Approval_Remarks" HeaderText="Approval Remarks" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                    SelectCommand="GetRequisitionApprovalLevels" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="RQ_ID" 
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

</asp:Content>

