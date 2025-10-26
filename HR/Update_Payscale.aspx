<%@ page title="" language="VB" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="false" inherits="HR_Update_Payscale, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



     <div class="bxmain inner_content" style="text-align:left; width:100%;color:#f67f2e; background-color:transparent; border:none; font-weight:bold;">
<h3><span>Update Payscale </span> </h3> </div>
    <table class="diagnosis_list">
        <tr>
            <td align="right">
                Designation:</td>
            <td>
                <asp:DropDownList ID="DropDownList_desg" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_desg" DataTextField="Designation_Name"
                      DataValueField="Designation_ID" TabIndex="5" Width="262px" 
                    AutoPostBack="True" >
        </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT [Designation_ID], [Designation_Name] FROM [Designation]
                     
                      order by [Designation_Name]">
        <SelectParameters>
         
        </SelectParameters>
    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Payscale</td>
            <td align="left">
                <asp:DropDownList ID="DropDownList_Payscale" runat="server"
                      CssClass="dropbox" DataSourceID="SqlDataSource_payscale" DataTextField="Pay_Scale_name"
                      DataValueField="Pay_scale_ID" TabIndex="5" Width="262px" >
        </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_payscale" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BasicDatainfoConnectionString %>" 
                    SelectCommand="SELECT Payscale.* FROM Payscale"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                &nbsp;</td>
            <td align="left">
                <asp:Button ID="Button1" runat="server" Text="Update" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"  
                    ConnectionString="<%$ ConnectionStrings:BasicDatainfoConnectionString %>" UpdateCommand="update Employee 
set PayScale=@payscale
where DesignationID = @Deig;
update Designation 
set Min_PayScale = @payscale
where Designation_ID = @Deig;" 
                >
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="DropDownList_Payscale" Name="payscale" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList_desg" Name="Deig" 
                            PropertyName="SelectedValue" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource_Grid">
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDatainfoConnectionString %>" SelectCommand="SELECT     Isnull(E.Prefix,'')+' '+ Isnull(E.EFName,'')+' '+ Isnull(E.EMName,'')+' '+ Isnull(E.ELName,'') [Employee Name], De.Designation_Name [Designation Name], P.Pay_Scale_name [Pay Scale]
FROM         BasicDataInfo.dbo.Employee AS E INNER JOIN
                      BasicDataInfo.dbo.Designation AS De ON E.DesignationID = De.Designation_ID LEFT OUTER JOIN
                      BasicDataInfo.dbo.Payscale AS P ON P.Pay_scale_ID = De.Min_PayScale
WHERE     (E.DesignationID = @DesignationID)

">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_desg" Name="DesignationID" 
                            PropertyName="SelectedValue" />
                        
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>




</asp:Content>

