<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MonthlyYearlyTax.aspx.cs" Inherits="PayRoll_MonthlyYearlyTax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">
.style3{
width:30px;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain inner_content" style="width:100%;">
        <h2><span>Calculate Tax</span></h2>
            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
            <td style="width:45%;text-align:right;color:Maroon;font-size:15px;font-weight:bold"   >
                     <asp:Label ID="lbl" runat="server" Text="Monthly Salary:" ></asp:Label>   
                    </td>
                    <td style="width:40px;" class="style1">
                        <asp:TextBox ID="txtboxSlabFrom" TextMode="Number"  runat="server"></asp:TextBox>
                    </td>
            </tr>
               
              
                <tr style="line-height:2px;">
                   
                    <td colspan="2" style="text-align:center"  >
                        <asp:Button ID="btnCalculate" runat="server" Text="Calculate" 
                            onclick="btnCalculate_Click"   />
                        
                    </td>
                   

                  
                </tr>

                <tr style="line-height:5px;" >
                <td  colspan="2" style="text-align:center"><asp:Label ID="lblMonthlyTax" ForeColor="Green" Font-Bold="true" Font-Size="Medium" runat="server" ></asp:Label></td>
                </tr>
                  <tr style="line-height:5px;">
                <td colspan="2" style="text-align:center"><asp:Label ID="lblYearlyTax" ForeColor="Green" Font-Bold="true" Font-Size="Medium" runat="server" ></asp:Label></td>
                </tr>
            </table>
        </div>

        <asp:GridView ID="gvdTaxSlab" runat="server" AutoGenerateColumns="true" DataSourceID="dsTaxSlab"></asp:GridView>

<asp:SqlDataSource ID="dsTaxSlab" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
        SelectCommand="SELECT [Financial_Year], 
[Slab_From], [Slab_To], [Tax], [Fixed_Amount] FROM [TaxSlab]
where Financial_Year in (select MAX(Financial_Year) from [TaxSlab])"></asp:SqlDataSource>


</asp:Content>


