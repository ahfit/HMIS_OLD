<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Test_Services, App_Web_zvadaqir" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<asp:ScriptManager ID="ScriptManager1" runat="server">
                      </asp:ScriptManager>
                      
                    <%--  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>--%>
                                
  <div class="bxmain">                              
    <table border="0" cellpadding="0" cellspacing="0"  class="tbl_form" width="100%">
                            <tr>
                                <td align="right" width="40%" >
                                    Main Group :                                </td>
                                <td >
                                    <asp:DropDownList ID="DropDownList_MGName" runat="server" DataSourceID="SqlDataSource_MG_Name"
                                        DataTextField="TGName" DataValueField="TGID" AutoPostBack="True" Width="200px">                                    </asp:DropDownList>
                                    <span style="height: 18px">
                                    <asp:Button ID="Button_Update" runat="server"  Text="Update" Width="88px"/>                                    
                                  </span></td>
                            </tr>
                           
                          
                           </table>
</div>   
                           
       
                           
                          <br />
 

<div style="width:100%; height:300px; overflow:auto; overflow-x:hidden;">

                                    <asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False" DataKeyNames="TB_ID" DataSourceID="SqlDataSource_For_Grid" Width="100%">
                                        <RowStyle CssClass="GridItem" />
                                        <HeaderStyle CssClass="GridHeader" />
                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                        <Columns>
                                            <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                                                SortExpression="TB_ID" />
                                            <asp:TemplateField HeaderText="Name" SortExpression="TB_Name">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox_TBName" runat="server" Text='<%# Eval("TB_Name") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("TB_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Public Price" SortExpression="Public_Price">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Public_Price") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    &nbsp;<asp:TextBox ID="TextBox_Public" runat="server" Text='<%# Bind("Public_Price") %>'
                                                        Width="73px"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Private Price" SortExpression="Private_Price">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Private_Price") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    &nbsp;<asp:TextBox ID="TextBox_Private" runat="server" Text='<%# Bind("Private_Price") %>'
                                                        Width="71px"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Collection Time">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBox_Collection_Time" runat="server" MaxLength="3" Text='<%# Bind("Collection_Time", "{0}") %>'
                                                        Width="38px"></asp:TextBox>
                                                    <asp:Label ID="Label1" runat="server" Text="HH"></asp:Label>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_Collection_Time"
                                                        ErrorMessage="Enter valid value" ValidationExpression="\d*"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Specimen Required">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBox_Specimen_Required" runat="server" Text='<%# Bind("Specimen_Required_By_Test", "{0}") %>'
                                                        Width="215px"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
    <asp:HiddenField ID="HiddenField_TBID" runat="server" />
    <asp:HiddenField ID="HiddenField_Public" runat="server" />
    <asp:HiddenField ID="HiddenField_Private" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_update" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Test_Booking SET Private_Price = @Private_Price, Public_Price = @Public_Price, Specimen_Required_By_Test =@Specimen_Required_By_Test, Collection_Time =@Collection_Time   WHERE (TB_ID = @TB_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Private" Name="Private_Price" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Public" Name="Public_Price" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Specimen_Required" Name="Specimen_Required_By_Test"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Collection_Time" Name="Collection_Time"
                PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Collection_Time" runat="server" />
    <asp:HiddenField ID="HiddenField_Specimen_Required" runat="server" />
            </div> <br />
    &nbsp;<%-- </ContentTemplate>
                            </asp:UpdatePanel>--%><br />
<br />
<br />



<asp:HiddenField ID="HiddenField_TID" runat="server" />
    &nbsp;
                            <asp:HiddenField ID="HiddenField_TName" runat="server" />
    &nbsp;
                            <asp:SqlDataSource ID="SqlDataSource_MG_Name" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                                InsertCommand="INSERT INTO Test_Booking(TB_Name, Private_Price, Public_Price, MG_ID,S_Id) VALUES (@TB_Name, @Private_Price, @Public_Price, @MG_ID,@S_Id)"
                                ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT TGName, TGID FROM TestGroup">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox_TBNAme" Name="TB_Name" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="TextBox_Private_Price" Name="Private_Price" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="TextBox_Public_Price" Name="Public_Price" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownList_Service" Name="S_Id" PropertyName="SelectedValue" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" DeleteCommand="DELETE FROM Test_Booking WHERE (TB_ID = @TB_ID)" SelectCommand="SELECT TB_Name, Private_Price, Public_Price, TB_ID, Specimen_Required_By_Test, Collection_Time FROM Test_Booking WHERE (MG_ID LIKE @MG_ID) ORDER BY TB_Name">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="GridView1" Name="TB_ID" PropertyName="SelectedValue" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
    &nbsp; &nbsp;


  </asp:Content>