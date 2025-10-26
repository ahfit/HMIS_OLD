<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AdminServicePackagesSub.aspx.cs" Inherits="Patient_Billing_AdminServicePackagesSub" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table style="width: 100%;">
        <tr>
            <td align="right">Package :</td>
            <td>
                <asp:dropdownlist id="ddlPackages" runat="server" datasourceid="dsPackagesMain"
                    datatextfield="AP_Name" datavaluefield="ASP_ID" autopostback="True">
                </asp:dropdownlist>
                <asp:sqldatasource id="dsPackagesMain" runat="server"
                    connectionstring="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    selectcommand="SELECT ASP_ID, AP_Name FROM Admin_Service_Package where HospitalId=@HospitalId">
                    <SelectParameters>
            <asp:SessionParameter Name="HospitalId" SessionField="HospitalID" />
        </SelectParameters>
                </asp:sqldatasource>
            </td>
        </tr>
        <tr>
            <td align="right">Admin Service Category :</td>
            <td>
                <asp:dropdownlist id="ddlAdminServiceCategory" runat="server"
                    autopostback="True" datasourceid="dsAdminServices" datatextfield="Asc_Name"
                    datavaluefield="Asc_id">
                </asp:dropdownlist>
                <asp:sqldatasource id="dsAdminServices" runat="server"
                    connectionstring="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    selectcommand="SELECT Asc_id, Asc_Name FROM Admin_Service_Category"></asp:sqldatasource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:label id="lblMessage" Visible="false" runat="server" ForeColor="Red"></asp:label>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td width="45%">
                <div style="overflow: scroll; height: 300px;">
                    <asp:gridview id="grdServices" runat="server" autogeneratecolumns="False" width="100%"
                        datasourceid="dsServices">
    <Columns>
        <asp:BoundField DataField="S_Name" HeaderText="Service" 
            SortExpression="S_Name" />
        <asp:BoundField DataField="S_Category" HeaderText="Service Category" 
            SortExpression="S_Category" />
        <asp:TemplateField HeaderText="Amount" SortExpression="S_Amount">
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("S_Amount") %>'></asp:Label>
                <asp:HiddenField ID="hfS_ID" runat="server" Value='<%# Eval("S_ID") %>' />
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("S_Amount") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Rate">
            <ItemTemplate>
                <asp:TextBox ID="txtRate" runat="server" Width="35px" Text='<%# Bind("S_Amount") %>'></asp:TextBox>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:CheckBox ID="chkSelect" runat="server" />
            </ItemTemplate>
            <HeaderTemplate>
                <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="True" 
                    oncheckedchanged="chkSelectAll_CheckedChanged" />
            </HeaderTemplate>
        </asp:TemplateField>
    </Columns>
    </asp:gridview>
                    <asp:sqldatasource id="dsServices" runat="server"
                        connectionstring="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        selectcommand="SELECT S_ID, S_Name, S_Category, S_Amount FROM Admin_Services WHERE (S_Category = @S_Category)">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlAdminServiceCategory" Name="S_Category" 
            PropertyName="SelectedValue" />
    </SelectParameters>
    </asp:sqldatasource>
                    <asp:hiddenfield id="hfS_IDPage" runat="server" />
                </div>
            </td>
            <td width="10%">
                <asp:button id="btnSave" text="Save" runat="server" onclick="btnSave_Click" />
            </td>
            <td width="45%">
                <div style="height: 300px; overflow: auto;">
                    <asp:gridview id="grdPckages" runat="server" autogeneratecolumns="False" width="100%" showfooter="true"
                        datakeynames="S_ID,ASP_ID,ID" datasourceid="dsPackages" onrowdatabound="grdPckages_RowDataBound" OnRowUpdating="grdPckages_RowUpdating">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
         <asp:TemplateField HeaderText="Package">
           <ItemTemplate>
           <asp:Label Visible="true" ID="lblAP_Name" runat="server" Text='<%# Eval("AP_Name") %>'></asp:Label>
           </ItemTemplate>
           
           </asp:TemplateField>        
           <asp:TemplateField HeaderText="Services">
           <ItemTemplate>
           <asp:Label Visible="true" ID="lblServiceName" runat="server" Text='<%# Eval("S_Name") %>'></asp:Label>
           </ItemTemplate>
            
               <FooterTemplate>
                   <asp:Label ID="lblTotal" runat="server" Text="Total" Font-Bold="true"></asp:Label>
               </FooterTemplate>
           </asp:TemplateField>
        
            <asp:TemplateField HeaderText="Rate">
           <ItemTemplate>
           <asp:TextBox Visible="true" ID="lblRate" runat="server" Text='<%# Eval("Rate") %>'></asp:TextBox>          
           </ItemTemplate>
            
                <FooterTemplate>
                    <asp:Label  ForeColor="Red" Visible="true" ID="lblSum" Font-Bold="true" runat="server" ></asp:Label>
                </FooterTemplate>
           </asp:TemplateField>
       
    </Columns>
    </asp:gridview>
                    <asp:sqldatasource id="dsPackages" runat="server"
                        connectionstring="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        insertcommand="INSERT INTO Admin_Service_Package_Sub(ASP_ID, S_ID, Rate) VALUES (@ASP_ID, @S_ID, @Rate)"
                        selectcommand="SELECT Admin_Services.S_Name,Admin_Service_Package_Sub.ID, Admin_Service_Package_Sub.Rate, Admin_Service_Package_Sub.S_ID, Admin_Service_Package_Sub.ASP_ID, Admin_Service_Package.AP_Name FROM Admin_Service_Package_Sub INNER JOIN Admin_Services ON Admin_Service_Package_Sub.S_ID = Admin_Services.S_ID INNER JOIN Admin_Service_Package ON Admin_Service_Package_Sub.ASP_ID = Admin_Service_Package.ASP_ID WHERE (Admin_Service_Package_Sub.ASP_ID = @ASP_ID)"
                        deletecommand="delete from Admin_Service_Package_Sub where ID=@ID" updatecommand="UPDATE   Admin_Service_Package_Sub
SET              Rate = @Rate
WHERE     (ID = @ID)">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlPackages" Name="ASP_ID" 
            PropertyName="SelectedValue" />
    </SelectParameters>
    <UpdateParameters>       
    <asp:Parameter Name="Rate" />     
    
    
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" />
    </DeleteParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="ddlPackages" Name="ASP_ID" 
            PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="hfS_IDPage" Name="S_ID" PropertyName="Value" />
        <asp:ControlParameter ControlID="hfRate" Name="Rate" PropertyName="Value" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" />
    </UpdateParameters>
    </asp:sqldatasource>
                    <asp:hiddenfield id="hfRate" runat="server" />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

