<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="BudgetHead_distribution.aspx.vb" Inherits="Finance_Budget_BudgetHead_distribution" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="UDP_1" runat="server">
    <ContentTemplate>

    
 <div class="bxmain inner_content" style="width:100%;">
<h2><span>Add Budget Head Distribution  </span></h2>
<table cellpadding="0" cellspacing="0" width="100%" class="tbl_form" >
    <tr>
        <td align ="right"width ="50%">
            Add Service:
        </td>
        <td width ="50%">
             <asp:TextBox ID="TextBox_Search_Service" runat="server" CssClass="input_txt"
                                        Width="400px" OnTextChanged="TextBox_Search_Service_TextChanged"
                                        AutoPostBack="True" ></asp:TextBox>

                                       <cc1:AutoCompleteExtender ID="AutoComplete_Complaint" runat="server" CompletionInterval="10"
                                            CompletionSetCount="12" EnableCaching="true" UseContextKey="true" MinimumPrefixLength="2"
                                            ServiceMethod="SearchItems"  TargetControlID="TextBox_Search_Service">
                                        </cc1:AutoCompleteExtender>
            <asp:HiddenField ID="HF_S_ID" runat="server" />
             
            
        </td>
    </tr>
    <tr>
        <td align ="right"width ="50%" >
            Add Rate :</td>
        <td width ="50%" >
             <asp:TextBox ID="Txt_Rate" runat="server" min="0" Width="400px" TextMode ="Number" AutoPostBack="True" ></asp:TextBox>

            
        </td>
    </tr>

    <tr>
        <td align ="right"width ="50%" >
            Add Qty :</td>
        <td width ="50%" >
             <asp:TextBox ID="Txt_Qty" runat="server" min="0" Width="400px" TextMode ="Number" AutoPostBack="True" ></asp:TextBox>

            
        </td>
    </tr>

    <tr>
        <td align ="right"width ="50%">
            Total Value :</td>
        <td width ="50%">
             <strong><asp:Label ID="lbl_Total_value" runat="server"  ForeColor="DarkBlue"  ></asp:Label></strong>
        </td>
    </tr>

    <tr>
        <td align ="center" colspan="2">
            <asp:Button ID="Btn_add" runat ="server"  Text="Add"/>
            <asp:Button ID="btn_clr" runat ="server"  Text="clear"/>
            <asp:Button ID="btn_rtn" runat ="server"  Text="Back"/>
            <asp:Button ID="btn_finalized" runat ="server"  Text="Approve"/>
        </td>
    </tr>

</table>
     </div>
    </ContentTemplate>
</asp:UpdatePanel>
    <br />
    <br />
    <asp:UpdatePanel ID="UDP_2" runat="server">
    <ContentTemplate>
    <div class="bxmain inner_content" style="width:100%;">
        <h2><Table width="100%"><tr><td width ="50%" align="left">Distribution Detail</td><td width ="50%" align="right"><asp:Label ID="lbl_Month_Total" runat="server" Font-Size="X-Large" ForeColor="Yellow"></asp:Label></td></tr></Table> </h2>
        
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form" align="center" >
            <tr>
                <td>
                    <asp:GridView ID="gv_detail" runat="server"  EmptyDataText="No record found..." AutoGenerateColumns="False" DataSourceID="sds_detail" Width="100%"  CssClass="Grid_2" DataKeyNames="ID">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr. #">   
                                 <ItemTemplate>
                                         <%# Container.DataItemIndex + 1 %>   
                                 </ItemTemplate>
                             </asp:TemplateField>
                            <asp:BoundField DataField="Services_name" HeaderText="Services" SortExpression="Services_name" />
                            <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
                            <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" />
                            <asp:TemplateField HeaderText="Total" SortExpression="total">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("total") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_total" runat="server" Text='<%# Bind("total") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/images/deletebtn.png" ShowDeleteButton="True" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID ="sds_detail" runat ="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" SelectCommand="SELECT Services_name, Qty, Rate, Qty * Rate AS total, ID FROM Budget_Estimation_Detail WHERE (B_ID = @B_ID) AND (E_Code = @e_code)" DeleteCommand="DELETE FROM Budget_Estimation_Detail WHERE (ID = @ID)">
                        <DeleteParameters>
                            <asp:Parameter Name="ID" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="B_ID" QueryStringField="B_ID" />
                            <asp:QueryStringParameter Name="e_code" QueryStringField="e_code" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>

