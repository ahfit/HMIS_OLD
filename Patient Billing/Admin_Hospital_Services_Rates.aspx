<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="Admin_Hospital_Services_Rates.aspx.cs" Inherits="Patient_Billing_Admin_Hospital_Services_Rates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div align="center">
        <asp:Button ID="Button1" runat="server" Text=" >> " OnClick="Button1_Click" />
        <asp:Button ID="Button3" runat="server" Text=" << " OnClick="Button3_Click" />
    </div>

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">

                <h1 class="h1" style="width: 98%">
                    <span>Services</span></h1>

                <div class="bxmain" style="width: 98%">
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                        <tr>
                            <td width="24%" align="right">Hospital :</td>
                            <td width="76%">
                                <asp:DropDownList ID="DropDownList1" Enabled="false" runat="server" DataSourceID="SqlDataSource_Hospital"
                                    DataTextField="Hospital_Name" DataValueField="Hospital_ID" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital] ORDER BY [Attachment_Name]"></asp:SqlDataSource>
                            </td>
                        </tr>

                        <tr>
                            <td align="right">Service Category :</td>
                            <td>
                                <asp:DropDownList ID="ddlCategory" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" runat="server" AutoPostBack="True" DataSourceID="SQL_ServiceCategory"
                                    DataTextField="Asc_Name" DataValueField="Asc_id">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SQL_ServiceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    SelectCommand="SELECT [Asc_id], [Asc_Name] FROM [Admin_Service_Category] WHERE ISNULL(Active,0)=1"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td align="right">IPD/OPD :
                            </td>
                            <td>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="True">
                                    <asp:ListItem Selected="True">IPD</asp:ListItem>
                                    <asp:ListItem>OPD</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Services"
                    DataKeyNames="S_ID" Width="98%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
                        <asp:TemplateField HeaderText="Amount" SortExpression="S_Amount">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("S_Amount") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("S_Amount") %>' Width="55px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField_SID" runat="server" Value='<%# Eval("S_ID") %>' />
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckBox3" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox3_CheckedChanged" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_Services" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT [S_ID], [S_Name], [S_Amount] FROM [Admin_Services] where Active=1 AND S_ID NOT IN (SELECT S_Id FROM Admin_Hospital_Services_Rates WHERE Hospital_Id = @Hospital_Id) AND (@S_Category = 0 or S_Category = @S_Category)"
                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </td>

            <td width="50%" valign="top">
                <h1 class="h1">
                    <span>Selected Services</span></h1>
                <asp:GridView ID="GridView_HospitalServices" runat="server" AutoGenerateColumns="False"
                    Width="98%" DataKeyNames="Hospital_Id,S_Id,Patient_Type_Id" DataSourceID="SqlDataSource_HospitalServices">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
                        <asp:BoundField DataField="S_Amount" HeaderText="Amount" SortExpression="S_Amount" />
                        <asp:BoundField DataField="IPD_OPD" HeaderText="IPD/OPD" SortExpression="IPD_OPD" />
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckBox4" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox4_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox2" runat="server" />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("S_Id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_HospitalServices" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT     Admin_Hospital_Services_Rates.Hospital_Id, Admin_Hospital_Services_Rates.S_Id, Admin_Hospital_Services_Rates.Patient_Type_Id, Admin_Hospital_Services_Rates.S_Amount, Admin_Hospital_Services_Rates.IPD_OPD, Admin_Services.S_Name, Admin_Services.S_Category FROM Admin_Hospital_Services_Rates INNER JOIN  Admin_Services ON Admin_Hospital_Services_Rates.S_Id = Admin_Services.S_ID WHERE     Admin_Hospital_Services_Rates.Hospital_Id = @Hospital_Id AND (Admin_Services.S_Category = @S_Category)"
                    DeleteCommand="DELETE FROM Admin_Hospital_Services_Rates WHERE  (S_Id = @S_Id) AND (Hospital_Id = @Hospital_Id) "
                    InsertCommand="INSERT INTO Admin_Hospital_Services_Rates(Hospital_Id, S_Id, S_Amount, Entry_Date, Modify_Date) VALUES (@Hospital_Id, @S_Id,  @S_Amount, GETDATE(), GETDATE())">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="S_Amount" PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
                <asp:HiddenField ID="HiddenFieldSID" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
