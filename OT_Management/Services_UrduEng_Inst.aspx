<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="Services_UrduEng_Inst.aspx.cs" Inherits="Services_UrduEng_Inst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
     <link href="../Scripts/JqueryUrduEditor.css" rel="stylesheet" type="text/css" />  
     <script src="../Scripts/jquery.UrduEditor.js" type="text/javascript"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            $("[id$='txtUrduInstruction']").UrduEditor().css("background", "#fff");
            $(".imgUrduBtn").hide();
            $(".imgEngBtn").hide();
        });
        
        function validatForm() {
            if ($("[id$='ddlCategory']").val() == "" || $("[id$='ddlCategory']").val() == "0") {
                alert("Please select Service Category");
                return false;
            }
            if ($("[id$='ddlServices']").val() == "" || $("[id$='ddlServices']").val() == "0") {
                alert("Please select Service Name");
                return false;
            }
            if ($.trim($("[id$='txtUrduInstruction']").val()) == "" && $.trim($("[id$='txtEnglishInstruction']").val()) == "") {
                alert("Please enter Instruction in Urdu or English");
                return false;
            }
        }
        function confirmChangeStatus(elem) {            
            var r = confirm("Do you want to change status?");
            if (r == true) {
                setTimeout("__doPostBack(" + $(elem).attr("id") + ")", 0);
            } else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <table cellpadding="1" cellspacing="12" style="width: 100%;">
        <tr>
            <td style="width: 11%">
                Service Category
            </td>
            <td style="width: 40%">
                <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_ServiceCategory"
                    DataTextField="Asc_Name" DataValueField="Asc_id" Style="width: 81%" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_ServiceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                    SelectCommand="SELECT '' as Asc_id, '' as Asc_Name union SELECT Asc_id, Asc_Name FROM Admin_Service_Category"></asp:SqlDataSource>
            </td>
            <td style="width: 11%">
                Service Name
            </td>
            <td>
                <asp:DropDownList ID="ddlServices" runat="server" DataSourceID="SqlDataSource_Services"
                    DataTextField="S_Name" DataValueField="S_ID" Style="width: 81%">
                </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Services" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                    SelectCommand="Select '' as S_ID, '' as S_Name
	                union 
                    SELECT     Admin_Services.S_ID, Admin_Services.S_Name
                    FROM         Admin_Services
                    where Admin_Services.S_ID  in (

                    select Admin_Hospital_Services.S_Id from Admin_Hospital_Services
 
                    WHERE     
                    Admin_Hospital_Services.Hospital_Id=@Hospital_Id)
 
                    and (Admin_Services.S_Category = @S_category)
                    and S_ID not in (SELECT SId FROM Admin_Radiology.dbo.Services_UrduEng_Inst WHERE HospitalId=@Hospital_Id and Status=1)">
                    <SelectParameters>
                    <asp:ControlParameter ControlID="ddlCategory" Name="S_category" PropertyName="SelectedValue" />
                    <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                    </SelectParameters>
                    </asp:SqlDataSource>              
            </td>
        </tr>
        <tr>
            <td>
                Urdu Instructions
            </td>
            <td class="urdurEditorWrapper" style="position: relative;">
           
                <asp:TextBox TextMode="MultiLine" ID="txtUrduInstruction"  runat="server" Style="height: 70px;  width: 80%"></asp:TextBox>
              
             <div class="divKeyboardIcon" style="position:absolute;top: 0;  left: -28px;"> </div>
            </td>
            <td>
                English Instructions
            </td>
            <td>
                <asp:TextBox TextMode="MultiLine" ID="txtEnglishInstruction" runat="server" Style="height: 70px;
                    width: 80%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="return validatForm()" OnClick="btnSave_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:GridView ID="grdServicesInstructions" runat="server" AutoGenerateColumns="False"
                    Width="98%" DataSourceID="SqlDataSource_ServicesInstructions" 
                    onrowdatabound="grdServicesInstructions_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                        <HeaderStyle Width="2%" />
                            <HeaderTemplate>
                                Sr#
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField>
                         <HeaderStyle Width="15%" />
                            <HeaderTemplate>
                                Service Category
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# Eval("CategoryName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                        <HeaderStyle Width="20%" />
                            <HeaderTemplate>
                                Service Name
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# Eval("ServiceName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>                       
                            <HeaderTemplate>
                                English Instructions
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# Eval("EnglishInst")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                        <HeaderStyle Width="20%" />
                            <HeaderTemplate>
                                Urdu Instructions
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%# Eval("UrduInst")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                        <HeaderStyle Width="5%" />
                        
                            <HeaderTemplate>
                                Status
                                
                            </HeaderTemplate>
                            <ItemTemplate>
                           
                            <asp:CheckBox ID="chkStatus"  runat="server"  AutoPostBack="true" OnCheckedChanged="chkStatus_CheckedChanged"
                            Checked='<%# Convert.ToBoolean(Eval("Status")) %>' />
                                       <asp:HiddenField  ID="hdnId" runat="server" Value='<%# Eval("Id")%>' />           
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <PagerStyle CssClass="GridPager" />
                    <SelectedRowStyle CssClass="gridselect" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_ServicesInstructions" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                    SelectCommand="Services_UrduEng_Inst_Get_ByHospital">
                    <SelectParameters>
                        <asp:SessionParameter Name="HospitalId" SessionField="HospitalID" />
                    </SelectParameters>
                </asp:SqlDataSource>

                
            </td>
        </tr>
    </table>
</asp:Content>
