<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatienttestImage.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="PatienttestImage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script language ="jscript" type ="text/javascript" >
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:Label ID="Label_message" runat="server" > </asp:Label>
<asp:Label CssClass="text_lables_login" ID="LabelAttach" runat="server"> </asp:Label>&nbsp;
                <br />
                <asp:Panel ID="Panel2" runat="server" Height="50px" Width="125px" Wrap="False">
                </asp:Panel>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            <br />

                    <asp:Panel ID="Panel1" runat="server"   Width="100%">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                             
                            <tr>
                                <td width="40%" align="right"   dir="ltr" >
                                    </td>
                                <td width="60%"  >
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right"  >
                                    </td>
                                <td  >
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right"  >
                                    Image 1 :</td>
                                <td  >
                                    <asp:TextBox ID="TextBox_Image1" runat="server" Width="250px"></asp:TextBox>
                            <asp:FileUpload ID="FileUpload_image_1" runat="server" Width="404px" />&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" >
                                    Image 2 :</td>
                                <td  >
                                    <asp:TextBox ID="TextBox_Image2" runat="server" Width="250px"></asp:TextBox>
                            <asp:FileUpload ID="FileUpload_Image_2" runat="server" Width="404px" />&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right"  >
                                    Image 3 :</td>
                                <td  >
                                    <asp:TextBox ID="TextBox_Image3" runat="server" Width="250px"></asp:TextBox>
                            <asp:FileUpload ID="FileUpload_Image_3" runat="server" Width="404px" />&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right"  >
                                    Image 4 :</td>
                                <td  >
                                    <asp:TextBox ID="TextBox_Image4" runat="server" Width="250px"></asp:TextBox>
                            <asp:FileUpload ID="FileUpload_Images_4" runat="server" Width="404px" />&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right"  >
                                </td>
                                <td>
                                <asp:Button ID="Button_Upload" runat="server" Text="Upload Image" />&nbsp;<asp:Button
                                        ID="Button_Next" runat="server" Text="Upload Image And Report" Width="187px" Visible="False" />
                                    <asp:Button ID="Button_Next_Patient" runat="server" Text="Next Patient" Visible="False" />                                </td>
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
                            <asp:DropDownList ID="DropDownList_Performed_By_4" runat="server" DataSourceID="SqlDataSource_Employee"
                                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False"> </asp:DropDownList>                              
                            <asp:DropDownList ID="DropDownList_Performed_By_2" runat="server" DataSourceID="SqlDataSource_Employee"
                                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False"> </asp:DropDownList>
    &nbsp;&nbsp;
                            <asp:DropDownList ID="DropDownList_Performed_By" runat="server" DataSourceID="SqlDataSource_Employee"
                                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False"> </asp:DropDownList>                              
                            <asp:DropDownList ID="DropDownList_Performed_By_3" runat="server" DataSourceID="SqlDataSource_Employee"
                                        DataTextField="Employee_Name" DataValueField="EmpID" Width="148px" Visible="False"> </asp:DropDownList>                              
<asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
                <asp:HiddenField ID="HiddenField_XRAYID" runat="server" />
                <asp:HiddenField ID="HiddenField_ID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT ISNULL(Prefix, '') + ' ' + ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, ' ') AS Employee_Name, EmpID FROM Employee WHERE (SubDeptId = @SubDeptId)" UpdateCommand="UPDATE Pt_Xray SET Status = @Status WHERE (Reg_No = @Reg_No) AND (Yearly_No = @Yearly_No) AND (XRay_ID = @XRay_ID)">
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