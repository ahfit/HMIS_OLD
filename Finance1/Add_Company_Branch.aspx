<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="Add_Company_Branch.aspx.cs" Inherits="Finance_Add_Company_Branch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div>
    <div class="bxmain" >
<table width="100%" cellpadding="0" cellspacing="0" class="tbl_form">
    
    <tr >
        <td width="100px" align="right">Company Name</td>
        <td width="10px">:</td>
        <td width="290px"><asp:DropDownList ID="ddl_FinancialCompany" runat="server" AutoPostBack="True"
                            DataSourceID="SqlDataSource_FinancialCompany" DataTextField="Financial_Company_Name"
                            DataValueField="Financial_Company_Id" Width="290px">
                        
                        </asp:DropDownList></td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Branch Name</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtBranchName" runat="server" Width="290px" 
                ></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Branch Address</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtAddress" runat="server" Width="285px" Height="150px"
                TextMode="MultiLine"></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Account No.</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtAccount" runat="server" Width="290px" 
                ></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">SIT Head</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtSIT" runat="server" Width="290px" 
                ></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Payable Head</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtPayable" runat="server" Width="290px" 
                ></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Description</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txt_Description" runat="server" Width="285px" Height="150px"
                TextMode="MultiLine"></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Receivable Head</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtReceivable" runat="server" Width="290px" 
                ></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Inventory Head</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtInventory" runat="server" Width="290px" 
                ></asp:TextBox>  </td>
    </tr>
    <tr >
        <td width="100px" align="right" valign="top">Backup Store Head</td>
        <td width="10px" valign="top">:</td>
        <td width="290px"><asp:TextBox ID="txtBackup" runat="server" Width="290px" 
                ></asp:TextBox>  </td>
    </tr>
    <tr>
        <td colspan="3" style="padding-left:377px;">
            <asp:Button ID="btn_Save" runat="server" Text="Save" onclick="btn_Save_Click" />
            <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" 
                onclick="btn_Cancel_Click" />
        </td>
    </tr>
    
</table>
<asp:Label ID="lbl_Msg" ForeColor="Red" Font-Bold="true" Visible="false" runat="server"></asp:Label>
<asp:SqlDataSource ID="SqlDataSource_FinancialCompany" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="SELECT     Financial_Company_Id, Financial_Company_Name
FROM         Group_Financial_Companies"></asp:SqlDataSource>

        <asp:SqlDataSource ID="sql_ComapnyBranch" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
         InsertCommand="usp_Insert_Company_Branch" 
        InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="Financial_Company_Id" Type="Int32"  />
                <asp:Parameter Name="Company_Branch_Name" Type="String" />
                <asp:Parameter Name="Company__Branch_Address" Type="String" />
                <asp:Parameter Name="Account_No" Type="String" />
                <asp:Parameter Name="Payable_Head" Type="String" />
                <asp:Parameter Name="SIT_Head" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Receivable_Head" Type="String" />
                <asp:Parameter Name="Inventory_Head" Type="String" />
                <asp:Parameter Name="Backup_Store_Head" Type="String" />
                
            
            </InsertParameters>
        
        </asp:SqlDataSource>
</div>
</div>

</asp:Content>

