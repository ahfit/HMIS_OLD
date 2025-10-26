<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Add_DegreeProgram, App_Web_ybbpntbq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     
     


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" valign="top">

 <div class="bxmain" style="width:98%;"> 
  <table cellpadding="0" cellspacing="0" border="0" width="98%" class="tbl_form" >
  <tr>
    <td align="right"> New Degree :</td>
    <td><asp:TextBox ID="TextBox_Degree" runat="server" Width="150px"></asp:TextBox> <asp:Button   ID="Button1" runat="server" Text="Save" Width="55px"  />
        <asp:Label ID="lblNewDegree" runat="server" Text=""></asp:Label>
      </td>
  </tr>
   
</table></div>
 <br>

                             
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="Degree_Program_ID" DataSourceID="SqlDataSourceDegreeGrid" Width="98%">
                        <Columns>
                            <asp:BoundField DataField="Degree_Program_ID" HeaderText="Degree_Program_ID" InsertVisible="False"
                                ReadOnly="True" SortExpression="Degree_Program_ID" Visible="False" />
                            <asp:BoundField DataField="Degree_Program_Name" HeaderText="Degree Program Name"
                                SortExpression="Degree_Program_Name" />
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif" /><asp:ImageButton
                                        ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images_hacims/icon_err.gif" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"
                                        OnClientClick="return confirmation_edit(this)" /><asp:ImageButton ID="ImageButton2"
                                            runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif" OnClientClick="return confirmation(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                         <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    
                    <br>
</td>
                    
    <td width="50%" valign="top"> 
    
     <div class="bxmain"> 
    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                                    <tr>
                             <td align="right"  >
                                            
                                      New Qualification :</td>
                                      <td >
                    <asp:TextBox ID="TextBox_Qualification" runat="server" Width="150px"></asp:TextBox><asp:Button   ID="Button_Qualification" Width="55px" runat="server" Text="Save" /></td>
                                      
                                    </tr>
                                     </table></div>
                                     <br>

                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="Qualification_ID" DataSourceID="SqlDataSource_QualificationGrid" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="Qualification_ID" HeaderText="Qualification_ID" InsertVisible="False"
                                ReadOnly="True" SortExpression="Qualification_ID" Visible="False" />
                            <asp:BoundField DataField="Qualification_name" HeaderText="Qualification" SortExpression="Qualification_name" />
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif" /><asp:ImageButton
                                        ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images_hacims/icon_err.gif" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"
                                        OnClientClick="return confirmation_edit(this)" /><asp:ImageButton ID="ImageButton2"
                                            runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif" OnClientClick="return confirmation(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                      <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    
                    <br>

                    
                    </td>
  </tr>
</table>


             
                   <br>

                    <div class="bxmain">   
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                    <tr>
                        <td width="40%" align="right" >
                            Qualification :</td>
                        <td width="60%" >
          <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_Qualification"
              DataTextField="Qualification_name" DataValueField="Qualification_ID" Width="248px" AutoPostBack="True">
          </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td align="right" >
          
              Degree :</td>
                        <td >
                            <asp:DropDownList ID="DropDownList_Degree_Program" runat="server"
                  DataSourceID="SqlDataSource3" DataTextField="Degree_Program_Name" DataValueField="Degree_Program_ID"
                  Width="248px">
              </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td >&nbsp;</td>
                        <td> <asp:Button CssClass="buttonSubmit" ID="Button_continue" runat="server" Text="Save" />
                           
                        </td>
                    </tr>
                    
                </table></div>
                             <br>
      
               <asp:GridView ID="GridView3" Width="100%" runat="server" AutoGenerateColumns="False"  DataKeyNames="Degree_Program_ID" DataSourceID="SqlDataSourceGrid">
                                <Columns>
                                    <asp:TemplateField HeaderText="Qualification" SortExpression="Qualification_name">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_Qualification"
              DataTextField="Qualification_name" DataValueField="Qualification_ID" Width="248px" AutoPostBack="True" SelectedValue='<%# Bind("Qualification_ID", "{0}") %>'>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Qualification_name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Degree Program" SortExpression="Degree_Program_Name">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList_Degree_Program" runat="server"
                  DataSourceID="SqlDataSource3" DataTextField="Degree_Program_Name" DataValueField="Degree_Program_ID"
                  Width="248px" SelectedValue='<%# Bind("Degree_Program_ID", "{0}") %>'>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Degree_Program_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                               <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
 </asp:GridView>
                            
                                    
           
           
           
           
           
                    <asp:SqlDataSource ID="SqlDataSource_NewDegree" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                        InsertCommand="INSERT INTO Degree_Program(Degree_Program_Name) VALUES (@Degree_Program_Name)"
                        ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>">
                      <InsertParameters>
                            <asp:ControlParameter ControlID="TextBox_Degree" Name="Degree_Program_Name" PropertyName="Text" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSourceDegreeGrid" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                        DeleteCommand="DELETE FROM [Degree_Program] WHERE [Degree_Program_ID] = @Degree_Program_ID"
                        InsertCommand="INSERT INTO [Degree_Program] ([Degree_Program_Name]) VALUES (@Degree_Program_Name)"
                        SelectCommand="SELECT [Degree_Program_ID], [Degree_Program_Name] FROM [Degree_Program]"
                        UpdateCommand="UPDATE [Degree_Program] SET [Degree_Program_Name] = @Degree_Program_Name WHERE [Degree_Program_ID] = @Degree_Program_ID">
                        <DeleteParameters>
                            <asp:Parameter Name="Degree_Program_ID" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Degree_Program_Name" Type="String" />
                            <asp:Parameter Name="Degree_Program_ID" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Degree_Program_Name" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_New_Qualification" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                        InsertCommand="INSERT INTO Qualification(Qualification_name) VALUES (@Qualification_name)"
                        ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="TextBox_Qualification" Name="Qualification_name"
                                PropertyName="Text" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_QualificationGrid" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                        DeleteCommand="DELETE FROM [Qualification] WHERE [Qualification_ID] = @Qualification_ID"
                        InsertCommand="INSERT INTO [Qualification] ([Qualification_name]) VALUES (@Qualification_name)"
                        SelectCommand="SELECT [Qualification_ID], [Qualification_name] FROM [Qualification]"
                        UpdateCommand="UPDATE [Qualification] SET [Qualification_name] = @Qualification_name WHERE [Qualification_ID] = @Qualification_ID">
                        <DeleteParameters>
                            <asp:Parameter Name="Qualification_ID" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Qualification_name" Type="String" />
                            <asp:Parameter Name="Qualification_ID" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Qualification_name" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                    DeleteCommand="DELETE FROM Qualification_Degree_Program WHERE (Degree_Program_ID = @DegreeID) AND (Qualification_ID = @Qid)"
                    SelectCommand="SELECT Degree_Program.Degree_Program_Name, Qualification.Qualification_name, Qualification_Degree_Program.Degree_Program_ID, Qualification.Qualification_ID FROM Qualification INNER JOIN Qualification_Degree_Program ON Qualification.Qualification_ID = Qualification_Degree_Program.Qualification_ID INNER JOIN Degree_Program ON Qualification_Degree_Program.Degree_Program_ID = Degree_Program.Degree_Program_ID WHERE (Qualification.Qualification_ID = @Qualification_ID)"
                    UpdateCommand="UPDATE Qualification_Degree_Program SET Degree_Program_ID = @Degree_Program_ID, Qualification_ID = @Qualification_ID WHERE (Degree_Program_ID = @Degree_Program_ID)">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="GridView3" Name="DegreeID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="GridView3" Name="Qid" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenField_Degree" Name="Degree_Program_ID" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_Qualification" Name="Qualification_ID"
                            PropertyName="Value" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Qualification_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Qualification" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                    SelectCommand="SELECT [Qualification_ID], [Qualification_name] FROM [Qualification]">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                    SelectCommand="SELECT Degree_Program_Name, Degree_Program_ID FROM Degree_Program">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                    InsertCommand="INSERT INTO Qualification_Degree_Program(Degree_Program_ID, Qualification_ID) VALUES (@Degree_Program_ID, @Qualification_ID)"
                    ProviderName="<%$ ConnectionStrings:job ApplicationConnectionString.ProviderName %>">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DropDownList_Degree_Program" Name="Degree_Program_ID"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList1" Name="Qualification_ID" PropertyName="SelectedValue" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Qualification" runat="server" />
                <asp:HiddenField ID="HiddenField_Degree" runat="server" />
                
                
                   
</td>
</tr>
</table>

  
              </asp:Content>