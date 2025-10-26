<%@ page language="VB" autoeventwireup="true" inherits="Finance_Trial_Balance, App_Web_se3xxsm3" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(document).ready(function () {

            $(".linkopen").colorbox({ width: "1000px", height: "75%", iframe: true });


        });

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ExporttoExport").click(function (e) {
                window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#dvData').html())); 
                e.preventDefault();
            });
        });

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width:98%;">
    <h2><span>Trial Balance</span></h2>
        <table cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td width="40%" align="right">
                    Select Company :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Companyname" runat="server" AutoPostBack="True"
                        DataSourceID="SQL_Companyname" DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id"  Width="213px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Select Branch :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Branchname" runat="server" AutoPostBack="False"
                        DataSourceID="SQL_Branchname" DataTextField="Company_Branch_Name" DataValueField="Company_Branch_Id"  Width="213px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Select Cost Centre :</td>
                <td>
                    <asp:DropDownList ID="DropDownList_CostCentre" runat="server"
                        DataSourceID="SQL_CostCentre" DataTextField="CostCenterName" DataValueField="CostCenterID"  Width="213px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Start Date:
                </td>
                <td>
                    <asp:DropDownList ID="DDL_Sel_Financial_Year" runat="server" Style="margin-left: 0px"
                        Height="19px" Width="98px" Visible="False">
                        <asp:ListItem Value="2015">2015-2016</asp:ListItem>
                        <asp:ListItem Value="2016">2016-2017</asp:ListItem>
                        <asp:ListItem Value="2017">2017-2018</asp:ListItem>
                    </asp:DropDownList>
                    <%--<igsch:WebDateChooser ID="StartDate_Search" runat="server" Width="213px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>--%>
                    <asp:TextBox runat = "server" ID = "StartDate_Search" Width="213px" TextMode = "Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    End Date:
                </td>
                <td>
                   <%-- <igsch:WebDateChooser ID="EndDate_Search" runat="server" Width="213px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>--%>
                     <asp:TextBox runat = "server" ID = "EndDate_Search" Width="213px" TextMode = "Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td colspan="3" style="text-align:Left;padding-left:10px;">
                    <asp:RadioButtonList ID="DDLVoucher" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="2">All</asp:ListItem>
                        <asp:ListItem  Value="1">Posted</asp:ListItem>
                        <asp:ListItem  Value="0">Not Posted</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="Button_search" runat="server" Text="Search" />
                    <asp:Button ID="btnExportToExcel" runat="server" Text="Export to Excel" />
                     &nbsp;</td>
            </tr>
        </table>
    </div>
    <br />
    <asp:SqlDataSource ID="SQL_Companyname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies ">
      
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQL_Branchname" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="   SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE Financial_Company_Id=@Financial_Company_Id">
        <SelectParameters>
            
            <asp:ControlParameter ControlID="DropDownList_Companyname" Name="Financial_Company_Id"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SQL_CostCentre" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        SelectCommand="SELECT  0 CostCenterID, '   --- All --- 'CostCenterName
Union
SELECT  CostCenterID, CostCenterName   FROM CostCenter">
    </asp:SqlDataSource>
    <br />
    <br />
        <div id="dvData">
    <asp:GridView ID="GridView_Trial_Balance" runat="server" AutoGenerateColumns="False"
        Width="100%" ShowFooter="True" DataKeyNames="E_Code">
        <Columns>
            <asp:BoundField DataField="EM_Name" HeaderText="Level I" SortExpression="EM_Name">
                <ItemStyle CssClass="level_a" />
            </asp:BoundField>
            <asp:BoundField DataField="EH_Name" HeaderText="Level II" SortExpression="EH_Name">
                <ItemStyle CssClass="level_b" />
            </asp:BoundField>
            <asp:BoundField DataField="ESH_Name" HeaderText="Level III" SortExpression="ESH_Name">
                <ItemStyle CssClass="level_c" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Level IV">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtnControlAccount" runat="server" Text='<%# Eval("E_Name") %>'
                        OnClick="lnkbtnControlAccount_Click"></asp:LinkButton>
                    <asp:HiddenField ID="hdfE_Code" runat="server" Value='<%# Eval("E_Code") %>' />
                    <asp:HiddenField ID="hdfcontrolaccountval" runat="server" Value='<%# Bind("Control_Account") %>' />
                </ItemTemplate>
            </asp:TemplateField>
           <%-- <asp:HyperLinkField DataTextField="E_Name" DataNavigateUrlFields="E_Code" DataNavigateUrlFormatString="~/Finance/Trial_Balance_Heads_Detail.aspx?E_Code={0}"
                HeaderText="Level IV" Target="_blank" />--%>
            <asp:TemplateField HeaderText="Dr" SortExpression="Dr">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Dr") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="Label_Dr_Footer" runat="server" Text="0" Font-Bold="true"></asp:Label>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label_Dr" runat="server" Text='<%# Bind("Dr") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="toright" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cr" SortExpression="Cr">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Cr") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="Label_Cr_Footer" runat="server" Text="0" Font-Bold="true"></asp:Label>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label_Cr" runat="server" Text='<%# Bind("Cr") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="toright" />
            </asp:TemplateField>
            <%--  <asp:BoundField DataField="Balance" HeaderText="Balance" 
                                SortExpression="Balance">
                               <ItemStyle  CssClass="toright"/>
                               </asp:BoundField>--%>
        </Columns>
        <FooterStyle CssClass="accounts_foot" />
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    </div>
            <br />
    <br />
</asp:Content>
