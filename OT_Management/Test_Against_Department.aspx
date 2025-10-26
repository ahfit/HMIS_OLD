<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Test_Against_Department.aspx.vb" Inherits="Test_Against_Department" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    Department Name :</td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="PatientSaveRecord"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" Width="195px">
                    </asp:DropDownList></td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    Test Group :<br />
                </td>
                <td style="width: 100px">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GVTSGName" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="TGID" DataSourceID="ForTestGroup" Height="163px" Width="324px">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" Visible="False" />
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                                Text='<%# Eval("TGName") %>'></asp:LinkButton>
                                            <asp:HiddenField ID="HiddenField_GNAme" runat="server" Value='<%# Bind("TGName", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TGName" HeaderText="Test Group" SortExpression="TGName"
                                        Visible="False" />
                                    <asp:BoundField DataField="TGID" HeaderText="TGID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="TGID" Visible="False" />
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    Test Sub Group :</td>
                <td style="width: 100px">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <%--                    <asp:RadioButtonList ID="RadioButtonListTestSubgroup" runat="server" AutoPostBack="True"
                            DataSourceID="ForTestSubGroup" DataTextField="TSGName" DataValueField="TSGID"
                            Width="261px" CssClass="text_titles_bold"> </asp:RadioButtonList>--%>
                            &nbsp;<asp:Label ID="Label3" runat="server" Width="211px"></asp:Label>&nbsp;<asp:GridView
                                ID="GridGorSubGroup" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="TSGID" DataSourceID="ForTestSubGroup"  Width="324px">
                              
                                <Columns>
                                    <asp:ButtonField CommandName="Select" Text="Select" Visible="False" />
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                                                Text='<%# Eval("TSGName") %>'></asp:LinkButton>
                                            <asp:HiddenField ID="HiddenField_SG_Name" runat="server" Value='<%# Bind("TSGID", "{0}") %>' />
                                            <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Bind("TGName", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TSGName" HeaderText="Sub Group Name" SortExpression="TSGName"
                                        Visible="False" />
                                    <asp:BoundField DataField="TSGID" HeaderText="TSGID" InsertVisible="False" ReadOnly="True"
                                        SortExpression="TSGID" Visible="False" />
                                    <asp:TemplateField>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("TSGID", "{0}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                    <asp:Button ID="Button_Save" runat="server" Text="Save" Width="98px" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 23px">
                </td>
                <td style="width: 100px; height: 23px">
                </td>
                <td style="width: 100px; height: 23px">
                </td>
                <td style="width: 100px; height: 23px">
                </td>
                <td style="width: 100px; height: 23px">
                </td>
            </tr>
        </table>
    
    </div>
        <asp:SqlDataSource ID="ForTestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
            SelectCommand="SELECT [TGName], [TGID] FROM [TestGroup]" InsertCommand="Insert_TestSubGroup_aginst_Dept" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:ControlParameter Name="TSGID" Type="Int32" ControlID="HiddenField_SGID" PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownList3" Name="Dept_ID" PropertyName="SelectedValue"
                    Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField2" runat="server" />
        <asp:HiddenField ID="HiddenField_SGID" runat="server" />
        <asp:SqlDataSource ID="ForTestSubGroup" runat="server" ConnectionString="Data Source=SERVER;Initial Catalog=Pathalogy;User ID=sa;Password=123"
            ProviderName="System.Data.SqlClient" SelectCommand="SELECT TestSubGroup.TSGName, TestSubGroup.TSGID, TestGroup.TGName FROM TestSubGroup INNER JOIN TestGroup ON TestSubGroup.TGID = TestGroup.TGID WHERE (TestSubGroup.TGID = @TGID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="GVTSGName" Name="TGID" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="PatientSaveRecord" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString1 %>"
            InsertCommand="PatientRegistration" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"
            SelectCommand="SELECT Dept_Name, Dept_ID FROM Department-- WHERE (Dept_ID = 6)">
            <InsertParameters>
                <asp:FormParameter FormField="rblprefix" Name="Prefix" Type="String" />
                <asp:FormParameter FormField="txtpfname" Name="PFName" Type="String" />
                <asp:FormParameter FormField="txtpmname" Name="PMName" Type="String" />
                <asp:FormParameter FormField="txtplname" Name="PLName" Type="String" />
                <asp:FormParameter FormField="rblrelation" Name="Relation" Type="String" />
                <asp:FormParameter FormField="txtrfname" Name="RFName" Type="String" />
                <asp:FormParameter FormField="txtrmname" Name="RMName" Type="String" />
                <asp:FormParameter FormField="txtrlname" Name="RLName" Type="String" />
                <asp:FormParameter FormField="sex" Name="sexID" Type="Int32" />
                <asp:FormParameter FormField="txtage" Name="Age" Type="Int32" />
                <asp:SessionParameter Name="RegDateTime" SessionField="DT" Type="DateTime" />
                <asp:FormParameter FormField="country" Name="CountryCode" Type="Int32" />
                <asp:FormParameter FormField="province" Name="ProvinceID" Type="Int32" />
                <asp:FormParameter FormField="district" Name="DistrictID" Type="Int32" />
                <asp:FormParameter FormField="tehsil" Name="Tehsil" Type="Int32" />
                <asp:FormParameter FormField="txtzipcode" Name="Zipcode" Type="Int32" />
                <asp:Parameter Name="House_No" Type="String" />
                <asp:FormParameter FormField="txtstreetaddress" Name="StreetAddress" Type="String" />
                <asp:FormParameter FormField="txtcolony" Name="Colony" Type="String" />
                <asp:SessionParameter Name="HomePhone" SessionField="PHP" Type="String" />
                <asp:SessionParameter Name="MobilePhone" SessionField="PMP" Type="String" />
                <asp:SessionParameter Name="nic" SessionField="nic" Type="String" />
                <asp:SessionParameter Name="DateOfBirth" SessionField="dob" Type="DateTime" />
                <asp:Parameter Direction="InputOutput" Name="NewRegNo" Type="String" />
                <asp:Parameter Name="DateTime" Type="DateTime" />
                <asp:Parameter Name="DeptID" Type="Int32" />
                <asp:Parameter Name="Status" Type="String" />
                <asp:Parameter Name="EmpID" Type="Int32" />
                <asp:Parameter Name="Diagonosis" Type="String" />
                <asp:Parameter Name="PatientType" Type="String" />
                <asp:Parameter Name="AgeType" Type="String" />
                <asp:Parameter Name="ReferFrom" Type="String" />
                <asp:Parameter Direction="InputOutput" Name="paymentid" Type="Decimal" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
