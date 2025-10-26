<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Pathology_Administrator_AdminService_TestBooking, App_Web_zvadaqir" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<asp:ScriptManager ID="ScriptManager1" runat="server">
                      </asp:ScriptManager>
                      
                    <%--  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>--%>
                                
  <div class="bxmain">                              
    <table border="0" cellpadding="0" cellspacing="0"  class="tbl_form" width="100%">
                          <tr>
                            <td width="40%"  align="right"    >
                                 Name :                            </td>
                            <td  >
                                <asp:TextBox ID="TextBox_TBNAme" runat="server" CssClass="input_txt"  ></asp:TextBox>
                                <asp:Button ID="ButtonSearch" runat="server" Text="Search" />                            </td>
                          </tr>
                            <tr>
                                <td align="right"    >
                                    Main Group :</td>
                                <td   >
                                    <asp:DropDownList ID="DropDownList_TestGroup" runat="server" AutoPostBack="True"
                                        DataSourceID="SqlDataSource_MG_Name" DataTextField="TGName" DataValueField="TGID"
                                         >
                                    </asp:DropDownList>                                
                            </tr>
        <tr>
            <td align="right"  >
                Test Services :
            </td>
            <td >
                <asp:DropDownList ID="DropDownList_BName" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_BName" DataTextField="TB_Name" DataValueField="TB_ID"  >
                </asp:DropDownList>
                <asp:TextBox ID="TextBoxAdmin_ServiceName" runat="server" Width="100px"  ></asp:TextBox>            </td>
        </tr>
                            <tr>
                                <td align="right" >
                                    Admin
                                    Services :</td>
                                <td >
                                  <asp:DropDownList ID="DropDownList_Service" runat="server" DataSourceID="SqlDataSource1"
                                        DataTextField="S_Name" DataValueField="S_ID"   AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                              <td align="right" >&nbsp;</td>
                              <td ><asp:Button ID="Button_Save" runat="server"  Text="Save"  /></td>
                            </tr>
                          
                           </table>
</div>   
    <asp:HiddenField ID="HiddenField_TBName" runat="server" />
                            <br />
             
                   
 

<div style="width:100%; height:225px; overflow:auto; overflow-x:hidden;">

                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT     Test_Booking.TB_ID, Test_Booking.TB_Name, Admin_Services.S_Name,Admin_Services.S_Id&#13;&#10;FROM         Test_Booking RIGHT OUTER JOIN&#13;&#10;                      Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID&#13;&#10;WHERE     (Admin_Services.S_Category IN(10)) AND (Test_Booking.S_Id IS NULL)&#13;&#10;order by Admin_Services.S_Name asc">
                </asp:SqlDataSource>

    <asp:GridView ID="GridView_ServicesTest" runat="server" AutoGenerateColumns="False"
        DataKeyNames="Test_id,TB_ID" DataSourceID="SqlDataSource_TestServices" Width="99%">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="Test_ID" HeaderText="Test_ID" SortExpression="Test_ID" />
            <asp:BoundField DataField="TestName" HeaderText="TestName" SortExpression="TestName" />
            <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" SortExpression="ComponentName" />
            <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" SortExpression="TB_ID" />
            <asp:BoundField DataField="TCID" HeaderText="TCID" InsertVisible="False" ReadOnly="True"
                SortExpression="TCID" />
        </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

</asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_MG_Name" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT TGName, TGID FROM TestGroup">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_BName" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT ISNULL(Test_Booking.TB_Name, '') + '----' + TestGroup.TGName AS TB_Name, Test_Booking.TB_ID FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE (Test_Booking.TB_Name LIKE @TBName) ORDER BY TB_Name" 
                                UpdateCommand="UPDATE Test_Booking SET S_Id =@S_Id where Tb_Id=@TB_Id">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_TBName" Name="TBName" PropertyName="Value" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="DropDownList_Service" Name="S_Id" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownList_BName" Name="TB_Id" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="TextBoxAdmin_ServiceName" Name="TB_Name" PropertyName="Text" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_TestServices" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
        DeleteCommand="delete from Test_Services where Test_Services.Test_ID=@Test_Id and  Test_Services.TB_ID=@TB_Id"
        SelectCommand="SELECT     Test.TestName, Test_Services.Test_ID, Test_Services.TB_ID, TestComponent.ComponentName, TestComponent.TCID&#13;&#10;FROM         Test_Services INNER JOIN&#13;&#10;                      Test ON Test_Services.Test_ID = Test.TID INNER JOIN&#13;&#10;                      TestComponent ON Test.TID = TestComponent.TID&#13;&#10;WHERE     (Test_Services.TB_ID = @TB_Id)&#13;&#10;order by Test.TestName, TestComponent.ComponentName asc">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_BName" Name="TB_Id" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView_ServicesTest" Name="Test_Id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Service" Name="TB_Id" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
            </div> 
 
   
   
   
                                                           
    
                       <%-- </ContentTemplate>
                            </asp:UpdatePanel>--%>
                            
<br />
<%--<div style="width:100%; height:250px; overflow:auto; overflow-x:hidden">--%>

   
    <br />

<%--</div>--%>
 
 
 

 </asp:Content>