<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Add_Financial_Company.aspx.cs" Inherits="Finance_Add_Financial_Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
    <div class="bxmain" >
<table width="100%" cellpadding="0" cellspacing="0" class="tbl_form">
    
    <tr >
        <td width="100px" align="right">Company Name</td>
        <td width="10px">:</td>
        <td width="290px"><asp:TextBox ID="txt_Name" runat="server" Width="295px"></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Description</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txt_Description" runat="server" Width="290px" Height="300px"
                TextMode="MultiLine"></asp:TextBox>  </td>
    </tr>
    <tr>
        <td colspan="3" style="padding-left:380px;">
            <asp:Button ID="btn_Save" runat="server" Text="Save" onclick="btn_Save_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                onclick="btnCancel_Click" />
        </td>
    </tr>
</table>
<asp:Label ID="lbl_Msg" runat="server" Font-Bold="true" ForeColor="Red" Visible="false"></asp:Label>
        <asp:SqlDataSource ID="sql_FinancialComapny" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
         InsertCommand="usp_Insert_Financial_Comapny" 
        InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="Financial_Company_Name" Type="String"  />
                <asp:Parameter Name="Description" Type="String" />
                
            
            </InsertParameters>
        
        </asp:SqlDataSource>

</div>
</div>

</asp:Content>

