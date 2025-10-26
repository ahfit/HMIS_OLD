<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Doctor_Services, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
            <tr>
                <td width="40%" align="right">
                    &nbsp;
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList1" TabIndex="22" runat="server" DataSourceID="SqlDataSource_SubDept"
                        Width="250px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand=" 
 select ' All' as SubDept_Name , 0 as SubDept_Id union 
SELECT DISTINCT SubDept_Name, SubDept_Id
FROM         SubDepartment
WHERE    (SubDepartment.SubDept_Type = 1) AND 
(Dept_Id IN
                          (SELECT     SubDepartment.Dept_Id
                            FROM          Week_Day_Department
                            WHERE      (Week_Day_Id = DATEPART(dw, GETDATE()))))
ORDER BY SubDept_Name "></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right">
                    Select Doctor :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Doctor" runat="server" DataSourceID="SqlDataSource_Doctor"
                        DataTextField="Employee" DataValueField="EmpID" Width="250px" AutoPostBack="True"
                        CssClass="dropbox">
                    </asp:DropDownList>
                    <asp:Label ID="Label_Message" runat="server" CssClass="err"></asp:Label>
                </td>
            </tr>

               <tr>
                <td width="40%" align="right">
                    Forward To :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource_Doctor"
                        DataTextField="Employee" DataValueField="EmpID" Width="250px" AutoPostBack="True"
                        CssClass="dropbox">
                    </asp:DropDownList>
                    <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>

                    <asp:Button id="btnForward" runat="server" Text="Forward"  />
                </td>
            </tr>
        </table>
    </div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top" style="height: 298px">
                <asp:RadioButtonList ID="RadioButtonList_Cat" runat="server" AutoPostBack="True"
                    DataSourceID="SqlDataSource_Category" DataTextField="Asc_Name" DataValueField="Asc_id"
                    Style="font-size: 10px;" RepeatColumns="3" RepeatDirection="Horizontal">
                </asp:RadioButtonList>
                <br />
                <div style="height: 250px; overflow: auto; overflow-x: hidden;">
                    <asp:GridView ID="GridView_Category" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                        DataKeyNames="S_ID" DataSourceID="SqlDataSource_Service" Width="99%">
                        <Columns>
                            
                            <asp:BoundField DataField="S_ID" HeaderText="SID" InsertVisible="False" ReadOnly="True"
                                SortExpression="S_ID"  />
                            <asp:BoundField DataField="S_Name" HeaderText="Service" SortExpression="S_Name" />
                            
                            <asp:BoundField DataField="S_Amount" HeaderText="Services Charges" SortExpression="S_Amount" />
                            <asp:TemplateField HeaderText="Doctor Charges">
                                <ItemTemplate>
                                    <asp:TextBox ID="TextBox_Charges" runat="server" Width="95px"></asp:TextBox>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("S_ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pay via Bank" SortExpression="Bank Charges">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("[Bank Charges]") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:TextBox ID="TextBox_pay_via_bank" runat="server" Width="95px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                </div>
            </td>
            <td width="50%" valign="top" style="height: 298px">
                <br />
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource_Grid_View"
                    DataKeyNames="DS_ID">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr #.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1%>
                            </ItemTemplate>
                            <ItemStyle Width="8%" />
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
                <br />
                <asp:Button ID="Button1" runat="server" Text="Update Service Rate" />
            </td>
        </tr>
    </table>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Save_Info" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Doctor_Service" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure" DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)"
        SelectCommand="SELECT Admin_Services.S_Name, Doctor_Service.Charges, Doctor_Service.Doctor_ID, Doctor_Service.DS_ID, Doctor_Service.Bank_Payment AS [Bank Charges], Admin_Services.S_Amount AS [Services Charges], Admin_Services.S_ID FROM Doctor_Service INNER JOIN Admin_Services ON Doctor_Service.Service_ID = Admin_Services.S_ID WHERE (Doctor_Service.Doctor_ID = @Doctor_ID)">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Charges" DefaultValue="" Name="Charges"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_S_ID" Name="Service_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_Doctor" Name="Doctor_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_pay_via_bank" Name="pay_via_bank" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Doctor" Name="Doctor_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="DS_ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Service" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Admin_Services.S_Name, Admin_Services.S_ID, Admin_Services.S_Category, Admin_Services.S_Amount, Doctor_Service.Bank_Payment AS [Bank Charges] FROM Admin_Services LEFT OUTER JOIN Doctor_Service ON Admin_Services.S_ID = Doctor_Service.Service_ID WHERE (Admin_Services.S_Category = @S_Category)">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadioButtonList_Cat" DefaultValue="1" Name="S_Category"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Doctor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT   ' All' as Employee,
0 as EmpID 
union
SELECT  ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')  as Employee,
  EmpID  
 FROM Employee
where activestatus=1 and isnull(Is_Consultant,0)=1  and (@subdeptid=0 or Employee.subdeptid=@subdeptid)
 ORDER BY Employee 
 ">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="subdeptid" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_S_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_pay_via_bank" runat="server" />
    <asp:HiddenField ID="HiddenField_Charges" runat="server" />
    <div align="center">
        <asp:Button ID="Button_Save" runat="server" Text="Save" /></div>
    <asp:SqlDataSource ID="SqlDataSource_Grid_View" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Admin_Services.S_ID,Admin_Services.S_Name, Doctor_Service.Charges, Doctor_Service.Doctor_ID, Doctor_Service.DS_ID, Doctor_Service.Bank_Payment AS [Bank Charges], Admin_Services.S_Amount AS [Services Charges] FROM Doctor_Service INNER JOIN Admin_Services ON Doctor_Service.Service_ID = Admin_Services.S_ID WHERE (Doctor_Service.Doctor_ID = @Doctor_ID) order by S_Name "
        DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Doctor" DefaultValue="" Name="Doctor_ID"
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="DS_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Category" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Asc_Name, Asc_id  FROM Admin_Service_Category"></asp:SqlDataSource>
</asp:Content>
