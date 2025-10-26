<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PharmacyPatients.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="PharmacyPatients" %>

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

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <div class="bx_rad" style="width: 100%;">
                    <ul id="tp1">
                        <li><strong>&nbsp;Search</strong></li>
                        <li>



                            <asp:Panel ID="Panel2" runat="server" Width="100%"></asp:Panel>

                            <br />


                            <div align="center">
                                <asp:Button ID="Button1" runat="server" Text="Search" />
                            </div>
                        </li>

                    </ul>
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top">


                <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label><br />
                <div style="width: 100%; overflow: auto;">
                    <asp:GridView ID="GridViewSearch" runat="server" AllowPaging="True"  AutoGenerateColumns="false"
        CssClass="Grid_1" Width="100%" PageSize="20">
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <Columns>   
             <asp:TemplateField HeaderText="S.NO">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                    <asp:HiddenField ID="HiddenField_EmpId" runat="server"
                         />
                </ItemTemplate>

            </asp:TemplateField>        
            <%--<asp:TemplateField HeaderText="MR #">
             <ItemTemplate>
                   <asp:LinkButton ID="lnkbIssueMedicine" runat="server" OnClick="lnkbIssueMedicine_Click">Issue Medicine</asp:LinkButton>&nbsp;&nbsp;     
                     <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Eval("RegistrationNo") %>' />
                    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" Value='<%# Eval("PayID") %>' />
                    <asp:HiddenField ID="HiddenField_Patient_Type_ID" runat="server" Value='<%# Eval("[Patient_Type_ID]") %>' />       
                 <asp:Label ID="lblRegNo" runat="server" Text='<%# Eval("RegistrationNo") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>

         <asp:TemplateField HeaderText="MR #">
             <ItemTemplate>                   
                     <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Eval("RegistrationNo") %>' />
                    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" Value='<%# Eval("PayID") %>' />
                    <asp:HiddenField ID="HiddenField_Patient_Type_ID" runat="server" Value='<%# Eval("[Patient_Type_ID]") %>' />       
                 <asp:Label ID="lblRegNo" runat="server" Text='<%# Eval("RegistrationNo") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>--%>

             <asp:TemplateField Visible="true">
                <ItemTemplate>

                    <asp:LinkButton ID="lnkbIssueMedicine" runat="server" OnClick="lnkbIssueMedicine_Click">Issue Medicine</asp:LinkButton>&nbsp;&nbsp;     
                    
                    
                </ItemTemplate>                
            </asp:TemplateField>
         <asp:TemplateField HeaderText="MR #">
             <ItemTemplate>
                 <asp:Label ID="lblRegNo" runat="server" Text='<%# Eval("RegistrationNo") %>'></asp:Label>
                  <asp:HiddenField ID="HiddenField_RegNo" runat="server" Value='<%# Eval("RegistrationNo") %>' />
                    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" Value='<%# Eval("PayID") %>' />
                    <asp:HiddenField ID="HiddenField_Patient_Type_ID" runat="server" Value='<%# Eval("[Patient_Type_ID]") %>' />                                  
             </ItemTemplate>
         </asp:TemplateField>

             <asp:TemplateField  HeaderText="Patient Name">
             <ItemTemplate>
                 <asp:Label ID="lblPatientName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="Visit #">
             <ItemTemplate>
                 <asp:Label ID="lblPayID" runat="server" Text='<%# Eval("PayID") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="Relation">
             <ItemTemplate>
                 <asp:Label ID="lblRelation" runat="server" Text='<%# Eval("Relation") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="Relation Name">
             <ItemTemplate>
                 <asp:Label ID="lblRelationName" runat="server" Text='<%# Eval("RelationName") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="Gender">
             <ItemTemplate>
                 <asp:Label ID="lblGender" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="Registration Date">
             <ItemTemplate>
                 <asp:Label ID="lblDateOfBirth" runat="server" Text='<%# Eval("DateOfBirth") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="Mobile Phone">
             <ItemTemplate>
                 <asp:Label ID="lblMobilePhone" runat="server" Text='<%# Eval("MobilePhone") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="CNIC">
             <ItemTemplate>
                 <asp:Label ID="lblCNIC" runat="server" Text='<%# Eval("CNIC") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
             <asp:TemplateField  HeaderText="Patient Type">
             <ItemTemplate>
                 <asp:Label ID="lblPatientType" runat="server" Text='<%# Eval("Patient_Type") %>'></asp:Label>
             </ItemTemplate>
         </asp:TemplateField>
        </Columns>
        <PagerStyle CssClass="GridPager" />
    </asp:GridView>

                </div>

            </td>
        </tr>
    </table>



    <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
        SelectCommand="SELECT [Diagnosis] FROM [Diagnosis]"></asp:SqlDataSource>


    <br />
    <br />
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
    <br />
</asp:Content>
