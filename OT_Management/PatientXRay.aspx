<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientXRay.aspx.vb" MasterPageFile="~/hacims_masterpage.master"
    Inherits="Administrator_PatientXRay1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script language="jscript" type="text/javascript">
function Image_NEw(YearlyNo,RegNo,TableID) 
{ 
//alert("dsfsd");
var regno;
var yearlyno;
var query = window.location.search.substring(1); 
var vars = query.split("&"); 
    for (var i=0;i<vars.length;i++) 
    { 
   var  pair = vars[i].split("="); 
        if (pair[0] == RegNo) 
        { 
        regno = pair[1]
        } 
    } 
     var querys = window.location.search.substring(1); 
var varss = querys.split("&"); 
    for (var i=0;i<varss.length;i++) 
    { 
     var pairs = varss[i].split("="); 
        if (pairs[0] == YearlyNo) 
        { 
        yearlyno = pairs[1]
        } 
    } 
    window.open("ptxrayview.aspx?Xray_ID=" + TableID + "&payId=" + YearlyNo + "&rig_no=" + RegNo,"Mywindow","")
return false;
}


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label_message" runat="server"> </asp:Label>
    <asp:Label CssClass="text_lables_login" ID="LabelAttach" runat="server"> </asp:Label>
    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceXray"
        Width="100%" DataKeyNames="Expr1" Visible="False">
        <Columns>
            <asp:BoundField DataField="Expr1" HeaderText="Part Id" SortExpression="Expr1" />
            <asp:BoundField DataField="Rd_body_part" HeaderText="Body Part" SortExpression="Rd_body_part" />
            <asp:BoundField DataField="Projection" HeaderText="Projection" SortExpression="Projection" />
            <asp:BoundField DataField="Reg_No" HeaderText="Reg_No" SortExpression="Reg_No" Visible="False" />
            <asp:BoundField DataField="Yearly_No" HeaderText="Yearly_No" SortExpression="Yearly_No"
                Visible="False" />
            <asp:BoundField DataField="Time_Stamp" HeaderText="Assigning Date" SortExpression="Date Time" />
            <asp:TemplateField HeaderText="Entry Date">
                <ItemTemplate>
                    <asp:Label ID="Label_Date" runat="server" Width="121px">
                    </asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Expr1", "{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Image Count">
                <ItemTemplate>
                    <asp:Label ID="Label_Count" runat="server" Width="76px">
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                        Text="Attach"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="XID" HeaderText="XID" InsertVisible="False" ReadOnly="True"
                SortExpression="XID" Visible="False" />
            <asp:ButtonField CommandName="Final" Text="Final" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader2" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <br />
    <asp:Panel ID="Panel2" runat="server" Height="50px" Width="125px" Wrap="False">
    </asp:Panel>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    <asp:Panel ID="Panel1" runat="server" Width="100%">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
            <tr>
                <td width="40%" align="right" dir="ltr">
                    <asp:Label ID="Bodypart" runat="server" CssClass="text_titles_bold" Text="Body Part :"
                        Width="127px"></asp:Label></td>
                <td width="60%">
                    <asp:Label ID="LabelXray" runat="server">
                    </asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="projec" runat="server" CssClass="text_titles_bold" Text="Projection :"></asp:Label></td>
                <td>
                    <asp:Label ID="labelpro" runat="server">
                    </asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Image 1 :</td>
                <td>
                    <asp:FileUpload ID="FileUpload_image_1" runat="server" Width="404px" />
                    <asp:DropDownList ID="DropDownList_Performed_By" runat="server" DataSourceID="SqlDataSource_Employee"
                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Image 2 :</td>
                <td>
                    <asp:FileUpload ID="FileUpload_Image_2" runat="server" Width="404px" />
                    <asp:DropDownList ID="DropDownList_Performed_By_2" runat="server" DataSourceID="SqlDataSource_Employee"
                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Image 3 :</td>
                <td>
                    <asp:FileUpload ID="FileUpload_Image_3" runat="server" Width="404px" />
                    <asp:DropDownList ID="DropDownList_Performed_By_3" runat="server" DataSourceID="SqlDataSource_Employee"
                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Image 4 :</td>
                <td>
                    <asp:FileUpload ID="FileUpload_Images_4" runat="server" Width="404px" />
                    <asp:DropDownList ID="DropDownList_Performed_By_4" runat="server" DataSourceID="SqlDataSource_Employee"
                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td>
                    <asp:Button ID="Button_Upload" runat="server" Text="Upload Image" />&nbsp;<asp:Button
                        ID="Button_Next" runat="server" Text="Upload Image And Report" Width="187px"
                        Visible="False" />
                    <asp:Button ID="Button_Next_Patient" runat="server" Text="Next Patient" Visible="False" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="HiddenField_PayID" runat="server" />
    <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
        ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Pt_Xray SET Status = @Status WHERE (Reg_No = @Reg_No) AND (Yearly_No = @Yearly_No) AND (XRay_ID = @XRay_ID)">
        <UpdateParameters>
            <asp:Parameter DefaultValue="Final And Report" Name="Status" />
            <asp:ControlParameter ControlID="HiddenField_RegNo" DefaultValue="" Name="Reg_No"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PayID" Name="Yearly_No" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_ID" Name="XRay_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceXray" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
        SelectCommand="SELECT Pt_Xray.ID AS XID, Pt_Xray.XRay_ID AS Expr1, Rd_xray_projections.Projections AS Projection, Pt_Xray.Reg_No, Pt_Xray.Yearly_No, Pt_Xray.Time_Stamp, Rd_body_part.Rd_body_part FROM Pt_Xray INNER JOIN Rd_xray_projections ON Pt_Xray.XRay_ID = Rd_xray_projections.Projection_ID INNER JOIN Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id WHERE (Pt_Xray.Reg_No = @regno) AND (Pt_Xray.Yearly_No = @yearlyno) AND (Pt_Xray.Status <> 'Done AND Final')"
        ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Pt_Xray SET Status = @Status WHERE (Reg_No = @Reg_No) AND (Yearly_No = @Yearly_No) AND (XRay_ID = @XRay_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_RegNo" Name="regno" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PayID" Name="yearlyno" PropertyName="Value" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter DefaultValue="Final" Name="Status" />
            <asp:ControlParameter ControlID="HiddenField_RegNo" DefaultValue="" Name="Reg_No"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PayID" DefaultValue="" Name="Yearly_No"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_XRAYID" DefaultValue="" Name="XRay_ID"
                PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
    <asp:HiddenField ID="HiddenField_XRAYID" runat="server" />
    <asp:HiddenField ID="HiddenField_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT ISNULL(Prefix, '') + ' ' + ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, ' ') AS Employee_Name, EmpID FROM Employee WHERE (SubDeptId = @SubDeptId)"
        UpdateCommand="UPDATE Pt_Xray SET Status = @Status WHERE (Reg_No = @Reg_No) AND (Yearly_No = @Yearly_No) AND (XRay_ID = @XRay_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="SubDeptId" SessionField="SubDeptID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter DefaultValue="Done And Report" Name="Status" />
            <asp:ControlParameter ControlID="HiddenField_RegNo" DefaultValue="" Name="Reg_No"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PayID" Name="Yearly_No" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_XRAYID" Name="XRay_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
