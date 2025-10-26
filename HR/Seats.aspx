<%@ page language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_Seats, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:Panel ID="pnlMsg" runat="server">
    <asp:Label ID="lblMessage" runat="server" CssClass="lblErrorSpan" Text=""></asp:Label>
</asp:Panel>

<div class="bxmain">
     <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
        <tr>
            <td align="right" width="40%"  >
                Department:</td>
            <td  >
                <asp:DropDownList ID="DropDownList_Department" runat="server" DataSourceID="SqlDataSource_Department"
                    DataTextField="Dept_Name" DataValueField="Dept_ID" OnSelectedIndexChanged="DropDownList_Department_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] order by Dept_Name asc">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right"  >
                Designation :</td>
            <td  >
                <asp:DropDownList ID="DropDownList_Designation" runat="server" DataSourceID="SqlDataSource_Designation"
                    DataTextField="Designation_Name" DataValueField="Designation_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_Designation" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT Designation_ID, Designation_Name FROM Designation ORDER BY Min_PayScale asc">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right"  >
                Seats: 
                
            </td>
            <td >
             <asp:TextBox ID="TextBox_Seats" runat="server" MaxLength="4"></asp:TextBox>
                
                 
                <asp:RangeValidator ID="RangeValidator_Seat" runat="server" ControlToValidate="TextBox_Seats"
                    ErrorMessage="Please Enter Correct Integer Value" MaximumValue="100" MinimumValue="0"
                    Type="Integer" Width="97px"></asp:RangeValidator> </td>
        </tr>
        <tr>
          <td align="right" >&nbsp;</td>
          <td  ><asp:Button ID="Button_Save" runat="server" OnClick="Button_Save_Click" Text="Save" />&nbsp;
              </td>
        </tr>
    </table></div>
    <br />

    <asp:GridView ID="GridView_Dept_Seats" runat="server" AutoGenerateColumns="False"
        DataKeyNames="Dept_Seat_ID" DataSourceID="SqlDataSource_Dept_Seats"  Width="100%" OnSelectedIndexChanged="GridView_Dept_Seats_SelectedIndexChanged">
    <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:TemplateField HeaderText="Department" SortExpression="Dept_Name">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Edit_Department" runat="server" DataSourceID="SqlDataSource_Edit_Department"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" SelectedValue='<%# Bind("Dept_ID") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Edit_Department" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department ORDER BY Dept_Name">
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Edit_Dept" runat="server" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Designation" SortExpression="Designation_Name">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Edit_Designation" runat="server" DataSourceID="SqlDataSource_Edit_Designation"
                        DataTextField="Designation_Name" DataValueField="Designation_ID" SelectedValue='<%# Bind("Designation_ID") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Edit_Designation" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT Designation_ID, Designation_Name FROM Designation ORDER BY Min_PayScale">
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_Edit_Designation" runat="server" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Designation_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Designation_Type" HeaderText="Designation Type" SortExpression="Designation_Type" ReadOnly="True" />
            <asp:TemplateField HeaderText="Seats" SortExpression="Seats">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox_Edit_Seats" runat="server" Text='<%# Bind("Seats") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Seats") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
           

        </Columns>   <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView><br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Dept_Seat_ID" Width="100%"
        DataSourceID="SqlDataSource_Dept_Seats" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Visible="False">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:TemplateField HeaderText="Department" SortExpression="Dept_ID">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Edit_Department" runat="server" DataSourceID="SqlDataSource_Edit_Department"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" SelectedValue='<%# Bind("Dept_ID") %>' OnSelectedIndexChanged="DropDownList_Edit_Department_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Edit_Department" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department ORDER BY Dept_Name"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Designation" SortExpression="Designation_Name">
                <EditItemTemplate>
                  <asp:DropDownList ID="DropDownList_Edit_Designation" runat="server" DataSourceID="SqlDataSource_Edit_Designation"
                        DataTextField="Designation_Name" DataValueField="Designation_ID" SelectedValue='<%# Bind("Designation_ID") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Edit_Designation" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT Designation_ID, Designation_Name FROM Designation ORDER BY Min_PayScale">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Designation_Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Designation Type" SortExpression="Designation_Type">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Designation_Type") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Seats" HeaderText="Seats" SortExpression="Seats" />
            

        </Columns>  <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:HiddenField ID="HiddenField_Department" runat="server" />
    <asp:HiddenField ID="HiddenField_Designation" runat="server" />
    <asp:HiddenField ID="HiddenField_Seats" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Dept_Seats" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
        DeleteCommand="DELETE FROM Department_Seats&#13;&#10;WHERE     (Dept_Seat_ID = @Dept_Seat_ID)"
        InsertCommand="INSERT INTO Department_Seats(Dept_ID, Designation_ID, Seats, Emp_Id) VALUES (@Dept_ID, @Designation_ID, @Seats, @Emp_Id)"
        ProviderName="<%$ ConnectionStrings:BasicDataConnectionString.ProviderName %>"
        SelectCommand="SELECT Department.Dept_Name, Department_Seats.Dept_Seat_ID, Designation.Designation_Name, Designation.Designation_Type, Department_Seats.Seats, Department.Dept_ID, Designation.Designation_ID FROM Department_Seats INNER JOIN Department ON Department_Seats.Dept_ID = Department.Dept_ID INNER JOIN Designation ON Department_Seats.Designation_ID = Designation.Designation_ID"
        UpdateCommand="UPDATE Department_Seats SET Dept_ID = @Dept_ID, Designation_ID = @Designation_ID, Seats = @Seats WHERE (Dept_Seat_ID = @Dept_Seat_ID)">
        <UpdateParameters>
            <asp:Parameter Name="Dept_ID" />
            <asp:Parameter Name="Designation_ID" />
            <asp:Parameter Name="Seats" />
            <asp:ControlParameter ControlID="GridView1" Name="Dept_Seat_ID" PropertyName="SelectedValue" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Seats" Name="Seats" PropertyName="Text" />
            <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" />
            <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Designation" Name="Designation_ID"
                PropertyName="SelectedValue" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="Dept_Seat_ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

