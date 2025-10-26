<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="profitandlossheads.aspx.cs" Inherits="Finance_profitandlossheads" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .bxmain2 {
            background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
            border: 1px solid #D2BFEA;
            border-radius: 4px;
            margin: 0;
            padding-bottom: 15px;
            padding-top: 10px;
            height: 530px;
        }

        .margin_right10 {
            margin-right: 10px;
        }

        .txtright span {
            text-align: right;
            display: block;
            margin-right: 5px;
        }

        .boldt {
            font-weight: bold;
            text-align: right;
            display: block;
            margin-right: 5px;
        }

        .sel_pos {
            position: relative;
            margin-top: -36px;
            float: right;
            margin-right: 10px;
        }

        .splt {
            padding-left: 5px;
            padding-right: 5px;
        }


        .bxmain {
            min-height: 175px;
        }

        .bxmain2 {
            min-height: 175px;
        }

        .bxmain3 {
            min-height: 175px;
        }

        .bxmain4 {
            min-height: 175px;
        }

        .data_scroll {
            height: 650px;
            overflow-x: hidden;
            overflow-y: auto;
            width: 99%;
            padding-left: 5px;
        }


        .color_b {
            color: #000000;
        }


        #h2 {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%; height: 100%">
        <h2 id="h2"><span>Balance Sheet Heads</span></h2>
        </br>
        <table width="100%" style="align-items: center; align-content: center; align-self: center">
            <tr align="center">
                <td align="right">Main Heading :&nbsp</td>
                <td align="left">
                    <asp:TextBox ID="main_heading" runat="server"></asp:TextBox>
                    <asp:Label ID="PL_id" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>


            <tr align="center">
                <td align="right">Sub Heading :&nbsp</td>
                <td align="left">
                    <asp:TextBox ID="sub_heading" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr align="center">
                <td align="right">Sub Heading2 :&nbsp</td>
                <td align="left">
                    <asp:TextBox ID="sub_heading2" runat="server"></asp:TextBox>
                </td>
            </tr>


            <tr align="center">
                <td align="right">Sort Order :&nbsp</td>
                <td align="left">
                    <asp:TextBox ID="sort_order" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr align="center">
                <td align="right">Notes :&nbsp</td>
                <td align="left">
                    <asp:TextBox ID="notes" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr align="center">

                <td align="right">Group Type :&nbsp</td>
                <td align="left">
                    <asp:DropDownList ID="group_type" runat="server" DataSourceID="SqlDataSource1" DataTextField="Group_type" DataValueField="Group_type"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
            <tr align="center">

                <td align="right"></td>
                <td align="left">
                    <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" />

                    <asp:Button ID="btnClear" runat="server" Text="Clear Info" OnClick="btnClear_Click" />

                    <asp:Label ID="lblinsert" runat="server" Text=""></asp:Label>
                </td>
            </tr>

        </table>
        </br>
        <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="false">
            <Columns>

                <asp:TemplateField HeaderText="PL Id" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="plid" runat="server" Text='<%# Bind("PL_Id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Main Heading" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="mnhdng" runat="server" Text='<%# Bind("Main_Heading") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sub Heading" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="sbhdng" runat="server" Text='<%# Bind("Sub_Heading") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sub Heading2" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="sbhdng2" runat="server" Text='<%# Bind("Sub_Heading2") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Sort Order" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="srtordr" runat="server" Text='<%# Bind("Sort_Order") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Notes" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="notes" runat="server" Text='<%# Bind("Notes") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Group Type" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="grptype" runat="server" Text='<%# Bind("Group_type") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Button ID="Editbtn" Text="Edit" runat="server" CommandArgument='<%# Eval("PL_Id") %>' OnClick="LinkButton" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" SelectCommand="SELECT Distinct [Group_type] FROM [ProfitAndLossHeads]"></asp:SqlDataSource>
</asp:Content>


