<%@ Control Language="VB" AutoEventWireup="false" CodeFile="changeRoomRequest.ascx.vb" Inherits="Patient_Billing_UserControlls_changeRoomRequest" %>
   <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right">By Consultant : </td>
                <td>

                    <asp:HiddenField ID="hf_consultant" runat="server" Value="%" />
                    <asp:DropDownList ID="ddlConsultant" runat="server"  DataSourceID="SqlDataSource_Consultant" DataTextField="Employee Name" DataValueField="EmpID" Width="202px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Consultant" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" SelectCommand=" SELECT  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], EmpID FROM  Employee WHERE   (isnull(IS_Consultant,0) = 1) and (isnull(Employee.ActiveStatus,0)=1)"></asp:SqlDataSource>
                </td>
            </tr>


            <tr>
                <td align="right">Floor/ Ward : </td>
                <td>
                    <asp:DropDownList ID="ddlWard" runat="server" DataSourceID="SqlDataSourceFloor" DataTextField="Ward_Name" DataValueField="Ward_id" Width="125px">
                    </asp:DropDownList>
                </td>
            </tr>


            <tr>
                <td align="right">Remarks : </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Style="width: 50%; height: 70px;"></asp:TextBox>
                </td>
            </tr>



            <tr>
                <td align="right">&nbsp; </td>
                <td>
                    <asp:Button ID="btnRequest" runat="server" CssClass="btn1" Text="Request" OnClick="btnRequest_Click" />


                    &nbsp;&nbsp;

                    <asp:Button ID="btnClose" runat="server" CssClass="btn1" Text="Close" OnClick="btnClose_Click" />

                    <asp:Label ID="Lbl_Mg" runat="server" Font-Bold="True" Font-Strikeout="False" ForeColor="#FF0066"></asp:Label>
                </td>
            </tr>
        </table>


    <br />

    <br />
    <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT Ward_Name, Ward_id, isDeleted&#13;&#10;FROM         admin_Hospital_Wards&#13;&#10;WHERE     (isDeleted = 0) &#13;&#10;"></asp:SqlDataSource>
 
   
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