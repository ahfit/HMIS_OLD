<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="SearchQuotation.aspx.cs" Inherits="Store_Demad_SearchQuotation" %>
 
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    <script type="text/javascript">

        $(document).ready(function (e) {

            $.fn.commas = function () {
                return this.each(function () {
                    $(this).text($(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                })
            }


            $(".total_payable").html($("#ctl00_ContentPlaceHolder1_GridviewPayable .boldt").text());
            $(".total_receiveable").html($("#ctl00_ContentPlaceHolder1_GridviewReceiveable .boldt").text());

            $("span").commas();

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Search Demand Requisitions Quotations</span></h2>
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
                  <igsch:WebDateChooser ID="txtStartDate" Width="200px" runat="server">
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

                  <igsch:WebDateChooser ID="txtEndDate" Width="200px" runat="server">
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
                                <asp:TemplateField ItemStyle-Width="83px">
                                    <ItemTemplate>
                                         <asp:HyperLink runat="server" Target="_blank" Text="Edit Qutation"
                                        NavigateUrl='<%# string.Format("~/Store/Demad/Update_Qutation.aspx?RQ_ID={0}&Main_ID={1}", Eval("Demand_RQ_ID"),Eval("Qutation_Main_ID"))%>' 
                                        Visible='<%# Eval("EditQutation").ToString()=="0" ? false : true   %>'></asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                <itemTemplate>
                                    <asp:LinkButton ID="lnkViewApprove" runat="server" CommandArgument='<%# Eval("Qutation_Main_ID") %>'
                                         OnClick="lnkViewApprove_Click" Text="View & Generate PO" Visible='<%# Eval("POView").ToString()=="0" ? false : true %>'></asp:LinkButton>
                                        <asp:HiddenField ID="hfMainID" runat="server" Value='<%# Eval("Qutation_Main_ID") %>' />
                                    <asp:HyperLink runat="server" Target="_blank" Text="View PO"
                                        NavigateUrl='<%# string.Format("~/Store/PurchaseOrderReport.aspx?PO_ID={0}", Eval("PO_ID"))%>' 
                                        Visible='<%# Eval("ISPOView").ToString()=="0" ? false : true   %>'></asp:HyperLink>
                                </itemtemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField headerText="Local Comparitive">
                                <itemTemplate>
                                    <asp:LinkButton ID="lbQutationReport" runat="server" 
                                        CommandArgument='<%# Bind("Demand_RQ_ID") %>' 
                                        text="Local CS" onclick="lbQutationReport_Click"
                                        ></asp:LinkButton>
                                </itemtemplate>
                            </asp:TemplateField>
                                 <asp:TemplateField headerText="Import Comparitive">
                                <itemTemplate>
                                    <asp:LinkButton ID="lbImport" runat="server" 
                                        CommandArgument='<%# Bind("Demand_RQ_ID") %>' 
                                        text="Import CS" onclick="lbImport_Click"
                                        ></asp:LinkButton>
                                </itemtemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField headerText="View Qutation" Visible="false">
                                <itemTemplate>
                                    <asp:LinkButton ID="lbApproveQutation" runat="server" 
                                        CommandArgument='<%# Bind("Demand_RQ_ID") %>' 
                                        Text="View" onclick="lbApproveQutation_Click" 
                                       ></asp:LinkButton>
                                </itemtemplate>
                            </asp:TemplateField>--%>
                                
                                <asp:TemplateField HeaderText="Demand #" SortExpression="Demand_RQ_ID">
                                    <itemTemplate>
                                        <asp:Label ID="lblDemandNo" runat="server" Text='<%# Eval("Demand_RQ_ID") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfAppID" runat="server" Value='<%# Eval("Approval_Request_ID") %>' />
                                    </itemTemplate>
                                </asp:TemplateField>
                                  <asp:BoundField HeaderText="Demand By" DataField="FromEMployee" SortExpression="FromEMployee" />
                              <asp:BoundField DataField="FromDepartment" HeaderText="Demand For Department" SortExpression="FromDepartment" />
                                <asp:BoundField DataField="DemandDate" HeaderText="Demand Date" SortExpression="DemandDate" />
                                <asp:BoundField DataField="Qutation_Main_ID" HeaderText="Quotation #" SortExpression="Qutation_Main_ID" />
                                <asp:BoundField DataField="Party_Name" HeaderText="Quotation By Vendor" SortExpression="Party_Name" />
                                <asp:BoundField DataField="Qutation_Date" HeaderText="Quotation Date" SortExpression="Qutation_Date" />
                                <asp:BoundField DataField="Qty" HeaderText="Total Qty" ReadOnly="True" SortExpression="Qty" />
                                <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount" ReadOnly="True" SortExpression="Total_Amount" />

                            </Columns>
                            
                        </asp:GridView>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    
    <asp:SqlDataSource ID="sds_Approve" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        UpdateCommand="usp_UpdateQutationMain" UpdateCommandType="StoredProcedure" >
        <UpdateParameters>
            <asp:Parameter Name="Qutation_Main_ID" Type="Int32" />
            <asp:Parameter Name="Demand_RQ_ID" Type="String" />
            <asp:Parameter Name="Approval_Request_Id" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="Approval_Remarks" Type="String" />
        </UpdateParameters>
                   
                </asp:SqlDataSource>
</asp:Content>
