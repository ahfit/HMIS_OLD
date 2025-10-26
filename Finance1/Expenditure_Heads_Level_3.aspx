<%@ page language="C#" autoeventwireup="true" inherits="Expenditure_Heads_Level_3, App_Web_ymbcbbcj" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


 


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div class="bxmain inner_content" style="width:100%;">
<h2><span>Account Heads Level III</span></h2>

                                <table cellpadding="0" cellspacing="0" width="100%"  class="tbl_form">
                                    <tr>
                                        <td align="right" width="40%" >
                                            Level 1 Name :</td>
                                      <td  >
                                          <asp:DropDownList ID="DropDownList_level1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Main_Level"
                                              DataTextField="EM_Name" DataValueField="EM_Code" OnSelectedIndexChanged="DropDownList_level1_SelectedIndexChanged"
                                               OnDataBinding="DropDownList_level1_DataBinding" OnDataBound="DropDownList_level1_DataBound" Width="212px">
                                          </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right"  >
                                            Level 2 Name :</td>
                                      <td >
                                        <asp:DropDownList ID="DropDownList_EH_Name" runat="server" DataSourceID="SqlDataSource_EH"
                                                DataTextField="EH_Name" DataValueField="EH_Code"  AutoPostBack="True"  OnSelectedIndexChanged="DropDownList_EH_Name_SelectedIndexChanged" OnDataBinding="DropDownList_EH_Name_DataBinding" OnDataBound="DropDownList_EH_Name_DataBound" Width="212px">
                                      </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right"  >
                                            Level 3 Code :</td>
                                      <td >
                                      <asp:TextBox ID="TextBox_ESH_Code" runat="server"  Width="211px" ></asp:TextBox>
                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_ESH_Code"
                                              Display="Dynamic" ErrorMessage="Enter Level 3 Code"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td align="right" >
                                            Level 3 Old Code :</td>
                                        <td>
                                            <asp:TextBox ID="TextBox_old_code" runat="server" Width="211px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td align="right" >
                                            Level 3 Name :</td>
                                        <td>
                                      <asp:TextBox ID="TextBox_ESH_Name" runat="server"  Width="211px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_ESH_Name"
                                                Display="Dynamic" ErrorMessage="Enter Level 3 Name"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                      <td align="center" colspan="2" ><asp:Button ID="Button2" runat="server" OnClick="Button2_Click1" Text="Save"  />
                                        <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                                      </td>
                                    </tr>
    </table></div>
                                <br />

                               

                                <asp:SqlDataSource ID="SqlDataSource_ESH" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    DeleteCommand="DELETE FROM [Expenditure_Sub_Heading] WHERE [ESH_Code] = @ESH_Code" InsertCommand="INSERT INTO Expenditure_Sub_Heading(ESH_Code, ESH_Name, EH_Code, ESH_Old_Code) VALUES (@ESH_Code, @ESH_Name, @EH_Code, @ESH_Old_Code)"
                                    SelectCommand="SELECT ESH_Code, ESH_Name, EH_Code, ESH_Old_Code FROM Expenditure_Sub_Heading WHERE (EH_Code = @EH_Code)"
                                    UpdateCommand="UPDATE [Expenditure_Sub_Heading] SET [ESH_Name] = @ESH_Name  WHERE [ESH_Code] = @ESH_Code">
                                    <DeleteParameters>
                                        <asp:Parameter Name="ESH_Code" Type="String" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="ESH_Name" Type="String" />
                                        <asp:Parameter Name="ESH_Code" Type="String" />
                                    </UpdateParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_EH_Name" Name="EH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="TextBox_ESH_Code" Name="ESH_Code" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="TextBox_ESH_Name" Name="ESH_Name" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_EH_Name" Name="EH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="TextBox_old_code" Name="ESH_Old_Code" PropertyName="Text" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_Main_Level" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="SELECT [EM_Code], [EM_Name] FROM [Expenditure_Main]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_EH" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            DeleteCommand="DELETE FROM [Expenditure_Heading] WHERE [EH_Code] = @EH_Code"
            InsertCommand="INSERT INTO Expenditure_Heading(EH_Code, EH_Name, EM_Code) VALUES (@EH_Code, @EH_Name, @EM_Code)"
            SelectCommand="SELECT EH_Code, EH_Name FROM Expenditure_Heading WHERE (EM_Code = @EM_Code)"
            UpdateCommand="UPDATE [Expenditure_Heading] SET [EH_Name] = @EH_Name WHERE [EH_Code] = @EH_Code">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_level1" Name="EM_Code" PropertyName="SelectedValue" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="EH_Code" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="EH_Name" Type="String" />
                <asp:Parameter Name="EH_Code" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_EH_Code" Name="EH_Code" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBox_EH_Name" Name="EH_Name" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList_level1" Name="EM_Code" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        

                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                        DataKeyNames="ESH_Code" DataSourceID="SqlDataSource_ESH" Width="100%">
                                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                    <Columns>
                                        <asp:BoundField DataField="ESH_Code" HeaderText="Level 3 Code" ReadOnly="True" SortExpression="ESH_Code" />
                                        <asp:BoundField DataField="ESH_Old_Code" HeaderText="Level 3 Old Code" SortExpression="ESH_Old_Code" />
                                        <asp:BoundField DataField="ESH_Name" HeaderText="Level 3 Name" SortExpression="ESH_Name" />
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




</asp:Content>