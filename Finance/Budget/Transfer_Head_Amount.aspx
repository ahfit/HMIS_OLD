<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="Transfer_Head_Amount.aspx.vb" Inherits="Finance_Transfer_Head_Amount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            font-weight: bold;
            font-style: italic;
            /*font-size: medium;*/
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


     <div class="bxmain inner_content" style="width: 100%;">
    <h2> TRANSFER HEAD AMOUNT :     </h2>
    <%--<div style="width:100%" class="h2">

        <span class ="h1" >  /span>
    </div>--%>

    <br />
    <table class="diagnosis_list">
        <tr>
            <td align="right" width="50%" class="auto-style1">Transfer From :</td>
            <td align="left">
                <asp:TextBox ID="txt_TF" runat="server" Width="81px" AutoPostBack="True"></asp:TextBox>
                &nbsp;<asp:DropDownList ID="DDL_TF" runat="server"  Width="205px" DataSourceID="SDS_TF" DataTextField="E_Name" DataValueField="E_Code" AutoPostBack="True">
                </asp:DropDownList>
                <asp:Label ID="lbl_TF" runat="server" text ="0"></asp:Label>
                <asp:SqlDataSource ID="SDS_TF" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" SelectCommand="SELECT Expenditure.E_Name, Expenditure.E_Code FROM Budget_Detail INNER JOIN Expenditure ON Budget_Detail.E_Code = Expenditure.E_Code WHERE (Budget_Detail.B_ID = @B_ID)
and (Expenditure.E_Name+ Expenditure.E_Code like @Name)" InsertCommand="Budget_Transfer_amount" InsertCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DDL_TF" Name="Transfer_from" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="lbl_TF" Name="T_Previous_amount" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txt_TA" Name="Transfer_amount" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DDL_TT" Name="Transfer_To" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="lbl_TT" Name="T_To_Previous_amount" PropertyName="Text" />
                        <asp:SessionParameter Name="Transfer_by" SessionField="emp_id" />
                        <asp:QueryStringParameter Name="B_ID" QueryStringField="B_ID" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="B_ID" QueryStringField="B_ID" />
                        <asp:ControlParameter ControlID="HFD_TF" Name="Name" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HFD_TF" runat="server" Value ="%" />
            </td>
        </tr>
        <tr>
            <td align="right" width="50%" class="auto-style1">&nbsp;</td>
            <td align="left">&nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="50%" class="auto-style1">Transfer To :</td>
            <td align="left">
                <asp:TextBox ID="txt_TT" runat="server" Width="81px" AutoPostBack="True"></asp:TextBox>
                &nbsp;<asp:DropDownList ID="DDL_TT" runat="server"  Width="205px" DataSourceID="SDS_TT" DataTextField="E_Name" DataValueField="E_Code" AutoPostBack="True">
                </asp:DropDownList>
                <asp:Label ID="lbl_TT" runat="server" ></asp:Label>

                <asp:SqlDataSource ID="SDS_TT" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" SelectCommand="SELECT Expenditure.E_Name, Expenditure.E_Code FROM Budget_Detail INNER JOIN Expenditure ON Budget_Detail.E_Code = Expenditure.E_Code WHERE (Budget_Detail.B_ID = @B_ID)
and (Expenditure.E_Name+ Expenditure.E_Code like @Name)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="B_ID" QueryStringField="B_ID" />
                        <asp:ControlParameter ControlID="HFD_TT" Name="Name" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HFD_TT" runat="server" Value ="%" />

            </td>
        </tr>
        <tr>
            <td align="right" width="50%" class="auto-style1">&nbsp;</td>
            <td align="left">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="50%" class="auto-style1">Transfer Amount :</td>
            <td align="left">
                <asp:TextBox ID="txt_TA" runat="server" TextMode="number" min="0" SkinID="intdata" MaxLength ="8" AutoPostBack="True"></asp:TextBox>
                <asp:Label ID="lbl_TA" runat="server" ForeColor ="Red" ></asp:Label>

                <%--<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare ="txt_TA" ControlToValidate="lbl_TF" Operator="LessThanEqual" Type="Integer" ErrorMessage="Enter Amount is greater than transferable Amount."></asp:CompareValidator>--%>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%" class="auto-style1">&nbsp;</td>
            <td align="left">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" width="50%">&nbsp;</td>
            <td align="left">
                <asp:Button ID="Btn_T" runat="server" Text="Transfer" Visible="False" />
                <asp:Label ID="lbl_Msg" runat="server" ForeColor ="Red" ></asp:Label>

            </td>
        </tr>
    </table>
</div>
</asp:Content>

