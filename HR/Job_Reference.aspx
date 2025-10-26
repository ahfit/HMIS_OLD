<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Job_Reference, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="40%" align="right"> Name :</td>
    <td width="60%">
      <asp:TextBox ID="TextBox_name" runat="server"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Tital :</td>
    <td>
      <asp:TextBox ID="TextBox_tital" runat="server"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right"> Organization :</td>
    <td>
      <asp:TextBox ID="TextBox_Organization" runat="server"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Address :</td>
    <td>
      <asp:TextBox ID="TextBox_Address" runat="server"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">
      Telephone No :
    </td>
    <td>
      <asp:TextBox ID="TextBox_tel_no" runat="server"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right"></td>
    <td>
      <asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />      
    </td>
  </tr>
</table>

</div>
 

<br />
              <asp:SqlDataSource ID="SqlDataSource_job_referance" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
            DeleteCommand="DELETE FROM [Job_Reference] WHERE [Ref_ID] = @Ref_ID" InsertCommand="INSERT INTO [Job_Reference] ([Employee_ID], [Ref_Name], [Ref_Tital], [Ref_Organization], [Ref_Address], [Ref_Tel_No]) VALUES (@Employee_ID, @Ref_Name, @Ref_Tital, @Ref_Organization, @Ref_Address, @Ref_Tel_No)"
            SelectCommand="SELECT [Ref_ID], [Employee_ID], [Ref_Name], [Ref_Tital], [Ref_Organization], [Ref_Address], [Ref_Tel_No] FROM [Job_Reference]"
            UpdateCommand="UPDATE [Job_Reference] SET [Employee_ID] = @Employee_ID, [Ref_Name] = @Ref_Name, [Ref_Tital] = @Ref_Tital, [Ref_Organization] = @Ref_Organization, [Ref_Address] = @Ref_Address, [Ref_Tel_No] = @Ref_Tel_No WHERE [Ref_ID] = @Ref_ID">
                <DeleteParameters>
                    <asp:Parameter Name="Ref_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Employee_ID" Type="Int32" />
                    <asp:Parameter Name="Ref_Name" Type="String" />
                    <asp:Parameter Name="Ref_Tital" Type="String" />
                    <asp:Parameter Name="Ref_Organization" Type="String" />
                    <asp:Parameter Name="Ref_Address" Type="String" />
                    <asp:Parameter Name="Ref_Tel_No" Type="Decimal" />
                    <asp:Parameter Name="Ref_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox_name" Name="Ref_Name" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBox_tital" Name="Ref_Tital" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBox_Organization" Name="Ref_Organization" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBox_Address" Name="Ref_Address" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="TextBox_tel_no" Name="Ref_Tel_No" PropertyName="Text"
                        Type="Decimal" />
                </InsertParameters>
              </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Ref_ID"
                    DataSourceID="SqlDataSource_job_referance" Width="100%" CssClass="Grid_1">
                    <Columns>
                        <asp:BoundField DataField="Ref_Name" HeaderText="Name" SortExpression="Ref_Name" />
                        <asp:BoundField DataField="Ref_Tital" HeaderText="Tital" SortExpression="Ref_Tital" />
                        <asp:BoundField DataField="Ref_Organization" HeaderText="Organization" SortExpression="Ref_Organization" />
                        <asp:BoundField DataField="Ref_Address" HeaderText="Address" SortExpression="Ref_Address" />
                        <asp:BoundField DataField="Ref_Tel_No" HeaderText="Telephone Number" SortExpression="Ref_Tel_No" />
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" /><asp:ImageButton
                                    ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                    OnClientClick="return confirmation_edit(this)" /><asp:ImageButton ID="ImageButton2"
                                        runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />

                                <script src="../Validate.js" type="text/javascript"></script>

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
<br />
  </asp:Content>