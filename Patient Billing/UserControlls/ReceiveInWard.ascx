<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ReceiveInWard.ascx.vb" Inherits="Patient_Billing_UserControlls_ReceiveInWard" %>
<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right">By Consultant : </td>
                <td>

                  
                    <asp:DropDownList ID="DropDownList_Consultant" Enabled="false" runat="server" DataSourceID="SqlDataSource_Consultant" DataTextField="Employee Name" DataValueField="EmpID" Width="202px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" SelectCommand="select ''  AS [Employee Name], 0 as EmpID union SELECT  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], EmpID FROM  Employee WHERE   (isnull(IS_Consultant,0) = 1) and (isnull(Employee.ActiveStatus,0)=1)"></asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td align="right">Floor/ Ward : </td>
                <td>
                    <asp:DropDownList ID="DropDownListFloor" Enabled="false"  AutoPostBack="true" OnSelectedIndexChanged="DropDownListFloor_SelectedIndexChanged" runat="server" DataSourceID="SqlDataSourceFloor" DataTextField="Ward_Name" DataValueField="Ward_id" Width="125px">
                    </asp:DropDownList>
                </td>
            </tr>

               <tr>
                            <td align="right">
                                <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>
                                :
                            </td>
                            <td align="left">
                                <asp:CheckBoxList ID="CheckBoxListRoom" runat="server" CssClass="chklist" 
                                    DataTextField="Bed_No" DataValueField="Bed_id" RepeatDirection="Horizontal"
                                    Visible="False" RepeatColumns="8">
                                </asp:CheckBoxList>
                                <asp:RadioButtonList ID="RadioButtonListBed" runat="server" CssClass="radlist" 
                                    DataTextField="Bed_No" DataValueField="Bed_id" RepeatDirection="Horizontal"
                                    Visible="False" RepeatColumns="8">
                                </asp:RadioButtonList>
                            </td>
                        </tr>


            <tr>
                <td align="right">&nbsp; </td>
                <td>
                    <asp:Button ID="btnReceive" runat="server" CssClass="btn1" Text="Receive" OnClick="btnReceive_Click" />

                    &nbsp;
                    &nbsp;
                     <asp:Button ID="btnClose" runat="server" CssClass="btn1" Text="Close" OnClick="btnClose_Click" />

                    <asp:Label ID="Lbl_Mg" runat="server" Font-Bold="True" Font-Strikeout="False" ForeColor="#FF0066"></asp:Label>
                </td>
            </tr>
        </table>

   
    <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT '' Ward_Name, 0 Ward_id  union all SELECT DISTINCT Ward_Name, Ward_id FROM         admin_Hospital_Wards WHERE     (isDeleted = 0)"></asp:SqlDataSource>
 
    
    
    <asp:SqlDataSource ID="SqlDataSourceRoomBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status
FROM         admin_Hospital_Wards INNER JOIN
                      Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id
WHERE     (isnull(Ward_Beds.Bed_Status,0) = 0) and Ward_Beds.Ward_Id=@Ward_Id">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListFloor" Name="Ward_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>