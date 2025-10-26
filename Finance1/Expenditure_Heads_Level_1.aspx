<%@ page language="C#" autoeventwireup="true" inherits="Expenditure_Heads_Level_1, App_Web_ymbcbbcj" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div  >

  
<div class="bxmain inner_content" style="width:100%;">
<h2><span>Account Heads Level I</span></h2>
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form" >
            <tr>
    <td align="right" width="40%"  >
                                Level 1 Code : </td>
                            <td width="60%">
                                <asp:TextBox ID="TextBox_EH_Code" runat="server"  ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_EH_Code"
                                    Display="Dynamic" ErrorMessage="Enter Level 1 Code"></asp:RequiredFieldValidator></td>
          </tr>
                        <tr>
                            <td align="right" >
                                Level 1 Old Code : </td>
                            <td >
                                <asp:TextBox ID="TextBox_old_Code" runat="server" ></asp:TextBox></td>
                        </tr>
            <tr>
                <td align="right" >
                    Level 1 Name :</td>
                <td>
                                <asp:TextBox ID="TextBox_EH_Name" runat="server"  ></asp:TextBox><asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_EH_Name"
                                    Display="Dynamic" ErrorMessage="Enter Level 1 Name"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
              <td colspan="2" align="center"><asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Save"  />
                <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Visible="false"></asp:Label>
              </td>
            </tr>
      </table>
</div>
                   
                    
                    <br />

                    <asp:SqlDataSource ID="SqlDataSource_Level_1" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" DeleteCommand="DELETE FROM [Expenditure_Main] WHERE [EM_Code] = @EM_Code" InsertCommand="INSERT INTO Expenditure_Main(EM_Code, EM_Name, EM_Old_Code) VALUES (@EM_Code, @EM_Name, @EM_Old_Code)" SelectCommand="SELECT EM_Code, EM_Name, EM_Old_Code FROM Expenditure_Main" UpdateCommand="UPDATE [Expenditure_Main] SET [EM_Name] = @EM_Name WHERE [EM_Code] = @EM_Code">
                        <DeleteParameters>
                            <asp:Parameter Name="EM_Code" Type="String" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="EM_Name" Type="String" />
                            <asp:Parameter Name="EM_Code" Type="String" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:ControlParameter ControlID="TextBox_EH_Code" Name="EM_Code" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="TextBox_EH_Name" Name="EM_Name" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="TextBox_old_Code" Name="EM_Old_Code" PropertyName="Text" />
                        </InsertParameters>
                    </asp:SqlDataSource>

    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="EM_Code" DataSourceID="SqlDataSource_Level_1" Width="100%" AllowPaging="True">
                        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                        <Columns>
                            <asp:BoundField DataField="EM_Code" HeaderText="Level 1 Code" ReadOnly="True" SortExpression="EM_Code" />
                            <asp:BoundField DataField="EM_Old_Code" HeaderText="Level 1 Old Code" SortExpression="EM_Old_Code" />
                            <asp:BoundField DataField="EM_Name" HeaderText="Level 1 Name" SortExpression="EM_Name" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                        OnClientClick="return confirm('are you sure you want To delete ?');" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView><br />

    


   


       



</div>



</asp:Content>