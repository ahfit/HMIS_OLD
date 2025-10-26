<%@ Page Title="" Language="C#" MasterPageFile="~/tcp_masterpage.master" AutoEventWireup="true" CodeFile="POReceivePosting.aspx.cs" Inherits="Store_POReceiveDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            font-size: small;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>PO Receive Detail </span></h2>
     
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form" style="padding-top: 5px">

            <tr>
                <td align="right" width="40%">Start Date : </td>
                <td width="60%">
         <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
              </td>
            </tr>
             <tr>
                <td align="right" width="40%">End Date :</td>
                <td width="60%">
           <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
              </td>
            </tr>
             <tr>
                <td align="right" width="40%">Purchase Order :</td>
                <td width="60%">
           <asp:TextBox ID="txtPO" runat="server"></asp:TextBox>
              </td>
            </tr>
              <tr>
                  <td align="right" width="40%">Sub Department  </td>
                  <td width="60%">
                      <asp:DropDownList ID="ddlBranch" runat="server"></asp:DropDownList>
                  </td>
              </tr> 
              <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click"    runat="server"  Text="Search"     />              
                   
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Btn_PO_POST" runat="server" OnClick="Btn_PO_POST_Click" style="height: 26px" Text="POST" />
                   
                </td>
                 </tr>
              <tr>
                <td align="center" colspan="2">
                    &nbsp;</td>
                 </tr>
            </table>
            </div>
        <div style="width: 100%; text-align: center;" align="center">
        
            <asp:GridView ID="Gv_PO" runat="server" Width ="100%" align="center" AutoGenerateColumns="False" DataKeyNames="PO_ID" DataSourceID="SDS_PO" OnPreRender="Gv_PO_PreRender">
                <Columns>
                    <asp:BoundField DataField="PO_ID" HeaderText="Purchase Order" ReadOnly="True" SortExpression="PO_ID" />
                    <asp:BoundField DataField="Date_Time" HeaderText="Date Time" SortExpression="Date_Time" />
                    <asp:BoundField DataField="Name" HeaderText="Post By" SortExpression="Name" />
                    <asp:BoundField DataField="POQty" HeaderText="Purchase Qty" ReadOnly="True" SortExpression="POQty" />
                    <asp:BoundField DataField="POAmount" HeaderText="Purchase Amount" ReadOnly="True" SortExpression="POAmount" />
                    <asp:BoundField DataField="RecQty" HeaderText="Receive Qty" ReadOnly="True" SortExpression="RecQty" />
                    <asp:BoundField DataField="RecAmount" HeaderText="Receive Amount" ReadOnly="True" SortExpression="RecAmount" />
                    <asp:BoundField DataField="Party_Name" HeaderText="Party Name" SortExpression="Party_Name" />
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <strong><span class="auto-style1">Expense Detail</span></strong>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:GridView ID="GV_Detail" runat="server" AutoGenerateColumns="False" CssClass="GridAltItem" DataSourceID="SDS_PO_Expense">
                                <Columns>
                                    <asp:TemplateField HeaderText="Statement" SortExpression="Statement">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Statement") %>'></asp:Label>
                                            <br />
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("PO_Expense_ID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SDS_PO_Expense" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="SELECT        PE.PO_Expense_ID, E.Expense_Name +' For Company  '+P.Party_Name+' of Amount Rs. ' +Convert(varchar, PE.Expense_Cost) +' on '+  Convert(varchar,PE.Entry_DateTime,103) Statement
                FROM            Purchase_Order_Item_Expenses AS PE INNER JOIN
                         Admin_Item_Expense AS E ON PE.Expenses_ID = E.Expenses_ID
                        Inner join parties P on P.Party_Id = PE.Company_ID
                WHERE        (PO_ID = @po_ID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HF_PO_ID" DefaultValue="1" Name="po_ID" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HF_PO_ID" runat="server" Value='<%# Eval("PO_ID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="CB_header" runat="server" AutoPostBack="True" OnCheckedChanged="CB_header_CheckedChanged"  />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CB_Item" runat="server"  />
                            <asp:LinkButton ID ="lbl_V_Voucher" runat ="server"  Visible='<%# Eval("vis_VTI") %>' Text ='<%# Eval("VTI") %>' OnClick="lbl_V_Voucher_Click"></asp:LinkButton>
                            &nbsp;
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        
            <br />
            <br />
        
            <asp:SqlDataSource ID="SDS_PO" runat="server" CancelSelectOnNullParameter="False"
                 ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" SelectCommand="Usp_POReceiveSummery" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtStartDate" Name="StartDate" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtEndDate" Name="EndDate" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtPO" Name="POID" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="ddlBranch" Name="SubDeptID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        
    </div>

</asp:Content>

