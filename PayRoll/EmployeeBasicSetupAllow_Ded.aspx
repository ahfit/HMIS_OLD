<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_EmployeeBasicSetupAllow_Ded, App_Web_uyhcueiz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        
        tr td
        {
            
            
            }
        
        .style1
        {
            width: 100%;
        }
        .style2
        {
            font-weight: bold;
            width: 647px;
        }
        .style3
        {
            width: 647px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="bxmain inner_content" id="" style="width:100%;">
   <h2><span>Employee Basic Setting</span></h2>
    <table class="style1">
        <tr>
            <td align="right" style="font-weight: bold;color:blueviolet;" class="style2">
                Employee Scale :</td>
            <td>
                    <asp:DropDownList ID="Dropdownlistpayscale" Width="202px" runat="server" Visible="true" AutoPostBack="true"  OnSelectedIndexChanged="DDL_Payscale_SelectedIndexChanged">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                        <asp:ListItem>6</asp:ListItem>
                        <asp:ListItem>7</asp:ListItem>
                        <asp:ListItem>8</asp:ListItem>
                        <asp:ListItem>9</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                        <asp:ListItem>16</asp:ListItem>
                        <asp:ListItem>17</asp:ListItem>
                        <asp:ListItem>18</asp:ListItem>
                        <asp:ListItem>19</asp:ListItem>
                        <asp:ListItem>20</asp:ListItem>
                        <asp:ListItem>21</asp:ListItem>
                    </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" style="font-weight: bold;color:blueviolet;" class="style3">
                Allowances / Deductions :</td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList_Allowance_Deduction" runat="server" 
                    RepeatDirection="Horizontal" 
                    onselectedindexchanged="RadioButtonList_Allowance_Deduction_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Selected="True">Allowance</asp:ListItem>
                    <asp:ListItem>Deduction</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right" style="font-weight: bold;color:blueviolet;" class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td>
            <asp:Button ID="btnAdd" Text="Add Allowances & Deductions" runat="server" OnClick="btnAdd_Click" /><asp:Button
                ID="btnDelete" runat="server" Text="Delete Save Record" 
                    onclick="btnDelete_Click" />
            </td>
        </tr>
<%--        <tr>
        
            <td align="center" style="font-weight: bold;color:blueviolet;padding-top:10px;padding-bottom:10px;" colspan="2">
            <asp:Label runat="server" Text="All Allowances / Deductions"></asp:Label>
            </td>
           
        </tr>--%>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3"  >
            <div class="bxmain inner_content" style="width:97%" ><span><h2>All Allowances/Deductions Detail</h2></span>
                <asp:GridView ID="GridView_AllowanceDeductionInfo" runat="server" Width="97%" AutoGenerateColumns="false" >
                <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                <ItemTemplate >
                <%# Container.DataItemIndex+1  %>
                </ItemTemplate>
                </asp:TemplateField>
                   <asp:TemplateField HeaderText="Financial Code">
                <ItemTemplate>
                <asp:Label ID ="LebelCode" Text='<%#bind("BI_Report_Head") %>' runat="server"></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Head Name">
                <ItemTemplate>
                <asp:Label ID ="LebelType" Text='<%#bind("Head_Name") %>' runat="server"></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
              
                <asp:TemplateField HeaderText="Amount">
                <ItemTemplate>
                <asp:TextBox ID ="Textamount" ToolTip='<%#bind("E_ID") %>' runat="server"></asp:TextBox>
                </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField >
                <ItemTemplate>
                <asp:CheckBox ID ="ChkBox"  runat="server"></asp:CheckBox>
                </ItemTemplate>
                </asp:TemplateField>

                </Columns>
                </asp:GridView>
                </div>
            </td>
            <td style="vertical-align:top;" >
            <div class="bxmain inner_content" style="width:100%" ><span><h2>Selective Allowances/Deductions</h2></span>
                <asp:GridView ID="GridView_MarkedAllowances" runat="server" Width="97%" AutoGenerateColumns="false" >
                <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                <ItemTemplate >
                <%# Container.DataItemIndex+1  %>
                </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Head Name">
                <ItemTemplate>
                <asp:Label ID ="LebelType" Text='<%#bind("Head_Name") %>' runat="server"></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lblAmount" Text='<%#bind("Amount") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField >
                <ItemTemplate>
                <asp:CheckBox ID ="ChkBox"  runat="server"></asp:CheckBox>
                    <asp:HiddenField ID="Hf_id" runat="server" Value='<%#bind("ID") %>' />
                </ItemTemplate>
                </asp:TemplateField>

                </Columns>
                </asp:GridView>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

