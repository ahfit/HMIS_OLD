<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="SearchPatientsForRecord.aspx.vb" Inherits="RecordManagement_SearchPatientsForRecord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script type="text/javascript">
        function resetform() { document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
        function enablelist(a) {
            if (a.checked == true) {
                document.getElementById("dropdownlistDiagnosis").disabled = false;
            }
            else {

                document.getElementById("dropdownlistDiagnosis").disabled = true;
            }

        }
    </script>

    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
    <script src="../css_hacims/ck.js" type="text/javascript"></script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<%--    <div class="bxmain PageHeading">
        Search Patients for Admission Records
    
    </div>--%>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span style="font-size:20px ! important">Search Patients for Admission Records</span></h2>
    </div> <hr />

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <div class="bx_rad" style="width: 100%;">
                    <ul id="tp1">
                        <li><strong>&nbsp;Search Patient For Record</strong></li>
                        <li>
                            <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel>

                            <br />
                            <div align="center">
                                <asp:Button CssClass="btn1" ID="Button1" runat="server" Text="Search" /><br /><br />
                            </div>
                        </li>
                    </ul>
                </div>

            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label>
                <hr />
                <asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="Grid_1" Width="100%" PageSize="25">
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" Text="" />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSelectHeader" AutoPostBack="true" OnCheckedChanged="chkSelect_CheckedChanged" runat="server" Text="" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="GridPager" />

                </asp:GridView><hr />
                <br />
                <div align="center">
                    <asp:Button ID="btnAssignFileNo" runat="server" Text="Assign File #" />
                </div><br /><hr />
            </td>
        </tr>
    </table>


    <asp:Panel ID="pnlReceivingDetail" Visible="false" runat="server"
        CssClass="lightbox" Height="500px" Width="800px" HorizontalAlign="Center">
        <table style="text-align: center;">
            <tr hidden>
                <td>Received by:
                </td>
                <td hidden >
                    <asp:TextBox ID="txtEmployee" AutoPostBack="true" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                 Received by:
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmployee" DataSourceID="SqlDs_Employee" DataTextField="Name" DataValueField="EmpID"
                        runat="server" Enabled="false">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="SqlDs_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="System.Data.SqlClient"
                        SelectCommand="
                    Select * From (SELECT     EmpID, Prefix + ' ' + IsNull(EFName,'') + ' ' + IsNull(EMName,'') + ' ' + IsNull(ELName,'') Name
FROM         Employee ) TMP where TMP.Name Like '%' + @empName + '%'
Order BY Name">
                        <SelectParameters>
                            <asp:Parameter Name="empName" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
            </tr>
            <tr align="right">
                <td></td>
                <td colspan="2">
                    
                    <asp:Button ID="btnRecieveRecord" runat="server" Text="Receive" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                </td>
            </tr>

            <tr>

                <td colspan="2" align="left">
                    <asp:Label ID="lbl_Msg" runat="server" ForeColor="Red" Font-Bold="true" Visible="false"></asp:Label>

                </td>
            </tr>

        </table>
    </asp:Panel>


    <asp:SqlDataSource ID="sqlDs_PatientRecord"
        ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
        InsertCommand="usp_Patient_Record_File_Insert" InsertCommandType="StoredProcedure"
        runat="server">
        <InsertParameters>
            <asp:Parameter Name="Patient_File_ID" Type="Int64" />
            <asp:Parameter Name="YearlyNo" Type="Int64" />
            <asp:Parameter Name="FileNo" Type="String" />
            <asp:Parameter Name="EmpId" Type="Int32" />
            <asp:Parameter Name="FileNoAlotDate" Type="DateTime" />
        </InsertParameters>
    </asp:SqlDataSource>


    <script type="text/javascript">

        var cookies = Spry.Utils.Cookie("read", "tabbedpanels");

        if (cookies == "true") {
            var tp1 = new Spry.Widget.CollapsiblePanel("tp1", { contentIsOpen: true });
        } else {
            var tp1 = new Spry.Widget.CollapsiblePanel("tp1", { contentIsOpen: false });
        }

        Spry.Utils.addUnLoadListener(function () {

            Spry.Utils.Cookie("create", "tabbedpanels", tp1.isOpen());

        });


    </script>

</asp:Content>

