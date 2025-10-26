<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Add_New_Company.aspx.vb" Inherits="Administrator_Add_New_Company" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script language="javascript" type="text/jscript">
        function CheckRequirment() {
            if (document.getElementById("TextBox_Comp_Name").value.length == 0) {
                alert("Enter Creditor Name");
                document.getElementById("TextBox_Comp_Name").focus();
                return false;
            }
        }



    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="formds_items">


        <table cellspacing="0" cellpadding="0" border="0" width="100%">
            <tr>
                <td width="40%" valign="top">

                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Save_Comp_Info" Width="100%" DataKeyNames="Account_No">
                        <Columns>
                            <asp:BoundField DataField="Account_No" HeaderText="Account No" SortExpression="Account_No" />
                            <asp:BoundField ItemStyle-Width="45%" DataField="Account_Title" HeaderText="Account Title" SortExpression="Account_Title" />
                            <asp:BoundField DataField="Created On" HeaderText="Created On" SortExpression="Created On" />
                            <asp:ButtonField CommandName="Select" Text="Select" />
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblPartyId" runat="server" Text='<% #Bind("Party_Id")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" Text="Mark Billing Party" OnClick="Mark_Billing_Party_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>


                </td>
                <td valign="top">
                    <div class="bxmain">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                            <tr>
                                <td align="right" width="40%">Company/Party Name :
                                </td>
                                .          
                                <td colspan="2">

                                    <asp:TextBox ID="TextBox_Comp_Name" runat="server" Width="95%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right" width="40%">NTN # :</td>
                                <td width="23%">

                                    <asp:TextBox ID="TextBox_NTN_No" runat="server"></asp:TextBox></td>
                                <td width="37%">

                                    <asp:Button ID="Button_Search" runat="server" Text="Search" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="40%">City :</td>
                                <td colspan="2">

                                    <asp:TextBox ID="TextBox_City" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Address :
                                </td>
                                <td colspan="2">


                                    <asp:TextBox ID="TextBox_Address" runat="server" Height="50px" TextMode="MultiLine"
                                        Width="95%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">Contact Person Name :
                                </td>
                                <td colspan="2">


                                    <asp:TextBox ID="TextBox_Contact_Person" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">C.N.I.C :</td>
                                <td colspan="2">


                                    <asp:TextBox ID="TextBox_CNIC1" runat="server" MaxLength="5" SkinID="number" Width="45px"></asp:TextBox>
                                    -<asp:TextBox ID="TextBox_CNIC2" runat="server" MaxLength="7" SkinID="number" Width="60px"></asp:TextBox>-<asp:TextBox
                                        ID="TextBox_CNIC3" runat="server" MaxLength="1" Width="25px" SkinID="number"></asp:TextBox><asp:HiddenField
                                            ID="HiddenField_CNIC" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Phone :
                                </td>
                                <td colspan="2">


                                    <asp:TextBox ID="TextBox_Phone" runat="server" SkinID="number"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">Fax :
                                </td>
                                <td colspan="2">


                                    <asp:TextBox ID="TextBox_Fax" runat="server" SkinID="number"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">Email :
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="TextBox_Email" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">Website :
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="TextBox_WebSite" runat="server"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td align="right">STR # :</td>
                                <td colspan="2">
                                    <asp:TextBox ID="TextBox_STR_No" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">Bank A/C No. :</td>
                                <td colspan="2">
                                    <asp:TextBox ID="TextBox_ACNo" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">Status :</td>
                                <td colspan="2">
                                    <asp:DropDownList ID="DropDownList_Status" runat="server">
                                        <asp:ListItem>Individual</asp:ListItem>
                                        <asp:ListItem>Business Individual</asp:ListItem>
                                        <asp:ListItem>AOP</asp:ListItem>
                                        <asp:ListItem>Other Individual</asp:ListItem>
                                        <asp:ListItem>Registered Firm</asp:ListItem>
                                        <asp:ListItem>Company</asp:ListItem>
                                        <asp:ListItem>WHA NTP</asp:ListItem>
                                        <asp:ListItem>NGO</asp:ListItem>
                                        <asp:ListItem>Trust</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Party Type :</td>
                                <td colspan="2">
                                    <asp:DropDownList ID="ddlPartyType" runat="server">
                                        <asp:ListItem>Vendor</asp:ListItem>
                                        <asp:ListItem>Customer</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">&nbsp;</td>
                                <td colspan="2">
                                    <asp:Button ID="Button_Save_Name" Text="Save" runat="server" />
                                    <asp:Button ID="Button_Update" Text="Update" runat="server" Visible="False" />
                                    <asp:Button ID="Button_Back" Text="Back" runat="server" Visible="false" /></td>
                            </tr>

                        </table>

                    </div>
                </td>
            </tr>
        </table>




        <br />



        <asp:SqlDataSource ID="SqlDataSource_Save_Comp_Info" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            InsertCommand="insert_Parties_For_Purchasing"
            InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
            DeleteCommand="DELETE FROM Companies WHERE (Company_ID = @Company_ID)"
            SelectCommand="SELECT Party_Id, Account_Titles.Account_No, Account_Titles.Account_Title, CONVERT (varchar, Account_Titles.Created_On, 103) AS [Created On] FROM Account_Titles INNER JOIN Parties ON Account_Titles.Account_No = Parties.Party_Id WHERE (Account_Titles.Entity_Type_Id = 2) AND (Account_Titles.Account_Title LIKE '%' + @Party_Name + '%')">
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_Comp_Name" Name="Party_Name" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Phone" Name="Party_Phone" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Fax" Name="Party_Fax" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_WebSite" Name="Website" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Email" Name="Email" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Address" Name="Address" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_ACNo" Name="Bank_Account_No" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_Contact_Person" Name="Contact_Person_Name"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="HiddenField_AID" Name="IN_Account_No" PropertyName="Value"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_NTN_No" Name="NTN_No"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_STR_No" Name="STRN"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox_City" Name="City" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="HiddenField_CNIC" Name="CNIC"
                    PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="DropDownList_Status" Name="STATUS"
                    PropertyName="SelectedValue" Type="String" />
                 <asp:ControlParameter ControlID="ddlPartyType" Name="Party_Type"
                    PropertyName="SelectedValue" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="TextBox_Comp_Name" DefaultValue="%" Name="Party_Name" PropertyName="Text" />
            </SelectParameters>
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView1" Name="Company_ID" PropertyName="SelectedValue" />
            </DeleteParameters>
        </asp:SqlDataSource>

        <br />
        <br />
        <asp:HiddenField ID="HiddenField_AID" runat="server" Value="0" />


    </div>
</asp:Content>
