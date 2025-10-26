<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Test_Services, App_Web_42zygch0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 

<asp:ScriptManager ID="ScriptManager1" runat="server">
                      </asp:ScriptManager>
     
                    <div class="bxmain">        
<table border="0" cellpadding="0" cellspacing="0"  width="100%" class="tbl_form">

                          <tr>
                            <td width="25%" align="right"   >
                                 Name :                            </td>
                            <td width="25%"   >
                                <asp:TextBox ID="TextBox_TBNAme" runat="server" CssClass="input_txt"></asp:TextBox></td>
                            <td width="25%" align="right"  >
                                Private Price :</td>
                            <td width="25%"  >
                                <asp:TextBox ID="TextBox_Private_Price" CssClass="input_txt" runat="server"></asp:TextBox></td>
                          </tr>
                            <tr>
                                <td align="right"    >
                                    Public Price :</td>
                                <td   >
                                    <asp:TextBox ID="TextBox_Public_Price" CssClass="input_txt" runat="server"></asp:TextBox></td>
                                <td align="right"   >
                                    Main Group :                                </td>
                                <td  >
                                    <asp:DropDownList ID="DropDownList_MGName" runat="server" DataSourceID="SqlDataSource_MG_Name"
                                        DataTextField="TGName" DataValueField="TGID" Width="200px" AutoPostBack="True">                                    </asp:DropDownList>                                </td>
                            </tr>
                            <tr>
                                <td align="right"  >                                Service Category :</td>
                                <td  >                                    <asp:DropDownList id="DropDownList_service_Category" runat="server" DataValueField="Asc_id" DataTextField="Asc_Name" DataSourceID="SqlDataSource_Service_category" AutoPostBack="True" Width="200px"></asp:DropDownList></td>
                                <td align="right" >                                    Admin Service :</td>
                                <td ><asp:DropDownList id="DropDownList1" runat="server" DataValueField="S_ID" DataTextField="S_Name" DataSourceID="SqlDataSource1" Width="200px">
                                </asp:DropDownList></td>
                            </tr>
    <tr>
        <td align="right" style="height: 18px">
                                    Template Type :</td>
        <td style="height: 18px">
            <asp:DropDownList ID="DropDownList_template_type" runat="server" Width="200px" AutoPostBack="True">
                                    <asp:ListItem>New</asp:ListItem>
                                    <asp:ListItem>Old</asp:ListItem>
                                </asp:DropDownList></td>
        <td align="right" style="height: 18px">
        </td>
        <td style="height: 18px">
        </td>
    </tr>
                            <tr>
                                <td colspan="4" align="center">                                                                <asp:SqlDataSource id="SqlDataSource1" runat="server" SelectCommand="SELECT S_ID, S_Name, S_Amount, S_Category FROM Admin_Services WHERE S_Category=@S_Category ORDER BY S_Name" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_service_Category" Name="S_Category"
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                    <asp:SqlDataSource id="SqlDataSource_Service_category" runat="server" SelectCommand="SELECT Asc_id, Asc_Name FROM Admin_Service_Category" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"></asp:SqlDataSource>                                
                                <asp:Button ID="Button_Save" runat="server"  Text="Save"/>                                                                </td>
                            </tr>
                            </table></div>
                            <br />


<div style="width:100%; height:300px; overflow:auto; overflow-x:hidden;">
                                    <asp:GridView ID="GridView1" runat="server"   AutoGenerateColumns="False" DataKeyNames="TB_ID" DataSourceID="SqlDataSource_For_Grid" Width="100%" AutoGenerateEditButton="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                        <RowStyle CssClass="GridItem" />
                                        <HeaderStyle CssClass="GridHeader" />
                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                        <Columns>
                                            <asp:CommandField ShowDeleteButton="True" />
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
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Public_Price") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Private Price" SortExpression="Private_Price">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Private_Price") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Private_Price") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                                                SortExpression="TB_ID" Visible="False" />
                                            <asp:TemplateField HeaderText="Template Type" SortExpression="Page_type">
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="DropDownList_template_type" runat="server"  AutoPostBack="True" SelectedValue='<%# Bind("Page_type", "{0}") %>'>
                                                        <asp:ListItem>New</asp:ListItem>
                                                        <asp:ListItem>Old</asp:ListItem>
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Page_type") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" DeleteCommand="DELETE FROM Test_Booking WHERE (TB_ID = @TB_ID)" SelectCommand="SELECT TB_Name, Private_Price, Public_Price, TB_ID, Page_type FROM Test_Booking WHERE (MG_ID = @MG_ID)" UpdateCommand="UPDATE Test_Booking SET Private_Price = @Private_Price, Public_Price = @Public_Price, TB_Name = @TB_Name, Page_type = @Page_type WHERE (TB_ID = @TB_ID)">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="GridView1" Name="TB_ID" PropertyName="SelectedValue" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Private_fee" Name="Private_Price" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="HiddenField_Public_Fee" Name="Public_Price" PropertyName="Value" />
                                    <asp:ControlParameter ControlID ="GridView1" Name="TB_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="HiddenField_TName" Name="TB_Name" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="GridView1" Name="Page_type" PropertyName="SelectedValue" />
                                </UpdateParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
  </div> <br />
  <asp:Label ID="Label_message" runat="server" CssClass="err"  ></asp:Label><br />
                                                             
                         <div class="bxmain">   
                   <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >          
                            <tr>
<td align="right" width="25%"  >
                                    Main Group : </td>
<td  width="75%">
                                    <asp:DropDownList ID="DropDownList_Assign_Group" runat="server" AutoPostBack="True"
                                       DataSourceID="SqlDataSource_MG_Name" DataTextField="TGName" DataValueField="TGID" 
                                         OnSelectedIndexChanged="DropDownList_Assign_Group_SelectedIndexChanged" Width="262px">                                    </asp:DropDownList></td>
                                        
                                        </tr><tr>
<td align="right"   >
                                    Name :                                </td>
<td  >
                                    <asp:DropDownList ID="DropDownList_BName" runat="server" DataSourceID="SqlDataSource_BName"
                                        DataTextField="TB_Name" DataValueField="TB_ID" Width="90%" AutoPostBack="True">                                    </asp:DropDownList>                                </td>
                            </tr>
</table> </div>
                        <!--</ContentTemplate>
                            </asp:UpdatePanel>-->
                            
<br />
<div style="width:100%; height:350px; overflow:auto; overflow-x:hidden; border:#CCCCCC solid 1px;">
 <!--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>-->
                            <div align="left" >
                            <asp:CheckBoxList ID="CheckBoxList_Test" runat="server" DataSourceID="SqlDataSource_Test"
                                DataTextField="TestName" DataValueField="TID" RepeatColumns="4" RepeatDirection="Horizontal" Width="100%"
                               >
                            </asp:CheckBoxList></div>
                                    <br />
                            <div align="center"><asp:Button ID="Button1" runat="server" CssClass="btn2" Text="Assign Test" /></div>
                            <!--    </ContentTemplate>
                            </asp:UpdatePanel>-->
                            <br />

</div>
<br />
<br />



<asp:HiddenField ID="HiddenField_TID" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_BName" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TB_Name, TB_ID FROM Test_Booking WHERE (MG_ID = @MG_ID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList_Assign_Group" Name="MG_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_TName" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource_Test" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                InsertCommand="Insert_Test_Services" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>"
                                SelectCommand="SELECT TestName, TID, TGID FROM Test WHERE (TGID = @TGID) order by TestName" DeleteCommand="DELETE FROM Test_Services WHERE (Test_ID = @Test_ID) AND (TB_ID = @TB_ID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList_Assign_Group" Name="TGID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="HiddenField_TID" Name="Test_ID" PropertyName="Value"
                                        Type="Int32" />
                                    <asp:ControlParameter ControlID="DropDownList_BName" Name="TB_ID" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </InsertParameters>
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="HiddenField_TID" Name="Test_ID" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="DropDownList_BName" Name="TB_ID" PropertyName="SelectedValue" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
     
                            <asp:HiddenField ID="HiddenField_Private_fee" runat="server" />
                            <asp:HiddenField ID="HiddenField_Public_Fee" runat="server" />
    
<asp:SqlDataSource ID="SqlDataSource_MG_Name" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                                InsertCommand="INSERT INTO Test_Booking(TB_Name, Private_Price, Public_Price, MG_ID, S_Id, Page_type) VALUES (@TB_Name, @Private_Price, @Public_Price, @MG_ID, @S_Id, @Page_type)"
                                ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT TGName, TGID FROM TestGroup">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox_TBNAme" Name="TB_Name" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="TextBox_Private_Price" Name="Private_Price" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="TextBox_Public_Price" Name="Public_Price" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownList1" Name="S_Id" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownList_template_type" Name="Page_type" PropertyName="SelectedValue" />
                                </InsertParameters>
                            </asp:SqlDataSource>

  </asp:Content>