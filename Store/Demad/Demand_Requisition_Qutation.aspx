<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Demand_Requisition_Qutation.aspx.cs" Inherits="Store_Demand_Requisition_Approval_New" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
function ClientItemSelected(sender, e) {
            $get("<%=hfPaymentToId.ClientID %>").value = e.get_value();
        }
    </script>
    <style type="text/css">
        .bxmain2
        {
            background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
            border: 1px solid #D2BFEA;
            border-radius: 4px;
            margin: 0;
            padding-bottom: 15px;
            padding-top: 10px;
            height: 530px;
        }

        
        .margin_right10
        {
            margin-right: 10px;
        }
        .txtright span
        {
            text-align: right;
            display: block;
            margin-right: 5px;
        }
        .boldt
        {
            font-weight: bold;
            text-align: right;
            display: block;
            margin-right: 5px;
        }
        .sel_pos
        {
            position: relative;
            margin-top: -36px;
            float: right;
            margin-right: 10px;
        }
        .splt
        {
            padding-left: 5px;
            padding-right: 5px;
        }
        
        
        .bxmain
        {
            min-height: 175px;
        }
        .bxmain2
        {
            min-height: 175px;
        }
        .bxmain3
        {
            min-height: 175px;
        }
        .bxmain4
        {
            min-height: 175px;
        }
        
        .data_scroll
        {
            height: 650px;
            overflow-x: hidden;
            overflow-y: auto;
            width: 99%;
            padding-left: 5px;
        }
        
        
        .color_b
        {
            color: #000000;
        }
    </style>
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Search Demand Requisitions</span></h2>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
        <tr>
            <td align="right" width="40%">
                Demand No:
            </td>
            <td width="60%">
                <asp:TextBox ID="txtIndentBookNo" runat="server" CssClass="input_txt" Width="196px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                Department Name:
            </td>
            <td width="60%">
                <asp:DropDownList ID="ddlSubDepartment" runat="server" DataValueField="SubDept_Id" DataTextField="SubDept_Name"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                From Date:
            </td>
            <td width="60%">


                  <igsch:WebDateChooser ID="txtStartDate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>

                
            </td>
        </tr>
        <tr>
            <td align="right" width="40%" class="style1">
                To Date:
            </td>
            <td width="60%" class="style1">
                        <igsch:WebDateChooser ID="txtEndDate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>


              
            </td>
        </tr>
        <tr>
            <td align="right" width="40%">
                &nbsp;
            </td>
            <td width="60%">
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
               
            </td>
        </tr>
    </table>
    </div>
    <br />
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="middle" colspan="3">
                <div class="inner_content" style="width:100%;">
                    <h2>
                        <span>Demand Requisition Quotations</span></h2>
                    <div class="data_scroll">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                            EmptyDataText="No Requisition(s) Found" 
                            Width="100%" OnRowDataBound="GridView1_RowDataBound" >
                            <Columns>
                                <asp:TemplateField>
                                <itemTemplate>
                                    <asp:LinkButton ID="lnkViewApprove" runat="server" CommandArgument='<%# Eval("Qutation_Main_ID") %>'
                                         OnClick="lnkViewApprove_Click" Text="View & Generate PO" Visible="false"></asp:LinkButton>
                                    <asp:LinkButton ID="lbAddQutation" runat="server" 
                                        CommandArgument='<%# Bind("Demand_RQ_ID") %>' 
                                        text="Add Qutation" onclick="lbAddQutation_Click" ></asp:LinkButton>
                                        <asp:HiddenField ID="hfMainID" runat="server" Value='<%# Eval("Qutation_Main_ID") %>' />
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkGeneratePO"  Text="Generate PO" 
                                        runat="server" OnClick="lnkGeneratePO_Click" Visible='<%# Eval("viewstats") %>' CommandArgument='<%# Bind("Demand_RQ_ID") %>' ></asp:LinkButton>
                                </ItemTemplate> 
                            </asp:TemplateField>
                            <asp:TemplateField headerText="Qutation Report">
                                <itemTemplate>
                                    <asp:LinkButton ID="lbQutationReport" runat="server" 
                                        CommandArgument='<%# Bind("Demand_RQ_ID") %>' 
                                        text="View Report" onclick="lbQutationReport_Click"
                                        Visible='<%# Eval("viewstat") %>'></asp:LinkButton>
                                </itemtemplate>
                            </asp:TemplateField>
                            <asp:TemplateField headerText="View Qutation" Visible="false">
                                <itemTemplate>
                                    <asp:LinkButton ID="lbApproveQutation" runat="server" 
                                        CommandArgument='<%# Bind("Demand_RQ_ID") %>' 
                                        text="View" onclick="lbApproveQutation_Click" 
                                        Visible='<%# Eval("viewstat") %>'></asp:LinkButton>
                                </itemtemplate>
                            </asp:TemplateField>
                                <asp:TemplateField HeaderText="Demand #" SortExpression="Demand_RQ_ID">
                                    <itemTemplate>
                                        <asp:Label ID="lblDemandNo" runat="server" Text='<%# Eval("Demand_RQ_ID") %>'></asp:Label>
                                    </itemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Employee" DataField="Employee" SortExpression="Employee" />
                                <asp:BoundField DataField="From_Department" HeaderText="Department" SortExpression="From_Department" />
                                <asp:BoundField DataField="To_Department" HeaderText="Requisition For" SortExpression="To_Department" />
                                <asp:BoundField DataField="Date_Time" HeaderText="Date_Time" SortExpression="Date_Time" />
                                <asp:BoundField DataField="Emp_ID" HeaderText="Emp_ID" SortExpression="Emp_ID" Visible="false" />
                                <asp:BoundField DataField="Total_Qty" HeaderText="Total_Qty" ReadOnly="True" SortExpression="Total_Qty" />
                                
                            </Columns>
                            
                        </asp:GridView>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlGenPO" runat="server" Visible="false">
        <div class="lightbox">
            <asp:Button ID="btnClose" runat="server" Text="X" OnClick="btnClose_Click" style="float:Right" CausesValidation="false" />
            <div style="width:100%;text-align:center">
                <h3>Generate Purchase Order</h3>
                <br />
                                    <b>Payment to :</b>
                              
                                    <asp:TextBox ID="ddlPaymentTo" runat="server" Width="185px" ></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="Auto_Parties_Extender" runat="server" ServiceMethod="SearchCustomers"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="ddlPaymentTo" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected" CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
                                    <asp:HiddenField ID="hfPaymentToId" runat="server" Value="-1" />
                         <br />
                <asp:Button ID="btnGenratePO" runat="server" Text="Generate" OnClick="btnGenratePO_Click" />      
               
                <asp:HiddenField ID="hfDemandRQ_ID" runat="server" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>

