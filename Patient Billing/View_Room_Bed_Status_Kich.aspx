<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Billing_View_Room_Bed_Status_Kich, App_Web_asx2a3aw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
    .bxmain3 
    {
        background: honeydew !important;
        
    }
     @-webkit-keyframes blink {
    from {
        opacity: 1.0;
    }
    to {
        opacity: 0.0;
    }
}
.blink {
    -webkit-animation-name: blink;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-timing-function: cubic-bezier(1.0, 0, 0, 1.0);
    -webkit-animation-duration: 1s;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span style="font-size: 20px;">View Room/Bed Status</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td width="70%" align="center">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr style="display:none;">
                            <td width="40%" align="right">
                                <strong>Department :</strong>&nbsp;
                            </td>
                            <td width="60%">
                                <asp:DropDownList ID="DDL_Department" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Department"
                                    DataTextField="Dept_Name" CssClass="dropbox" DataValueField="Dept_ID" Width="250px">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="select 0 as Dept_ID,'--ALL--' as Dept_Name union select Dept_ID,Dept_Name from Department">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td width="40%" align="right">
                                <strong>Unit / Floor :</strong>&nbsp;
                            </td>
                            <td width="60%">
                                <asp:DropDownList ID="DropDownListFloor" runat="server" AutoPostBack="false" DataSourceID="SqlDataSourceFloor"
                                    DataTextField="Ward_Name" CssClass="dropbox" DataValueField="Ward_id" Width="250px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Button ID="btnViewData" runat="server" Text="Search" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnViewReport" runat="server" Text="View Report" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="right" width="30%">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <td align="center" width="100%">
                                    <%--<asp:Label ID="lblDischargePati" Text="Dischargeable Patients :" Font-Bold="true"
                                        ForeColor="Black" runat="server" Font-Size="Large" />
                                    <asp:Label ID="lblTotalDischargeable" ForeColor="blue" Font-Bold="true" Font-Size="Large"
                                        Text="" runat="server" />--%>
                                </td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:DataList ID="dlFloors" runat="server" RepeatLayout="Table" RepeatColumns="6"
        RepeatDirection="Horizontal" Style="margin-left: 10px;">
        <ItemTemplate>
            <div class="bxmain3 inner_content" style="padding-left: 5px; padding-right: 5px;
                width: 170px; margin-right: 10px; margin-bottom: 5px;">
                <h2>
                    <asp:Label ID="lblFloorName" runat="server" Text='<%# Eval("Ward_Name") %>' Font-Size="Larger"
                        ForeColor="Black" Font-Bold="true"></asp:Label>
                    :
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Allocated") %>' ForeColor="lightseagreen"
                        Font-Size="X-Large" Font-Bold="true"></asp:Label>
                    <%--<table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td valign="top">
                <strong style="color:darkgreen;">
                    Total Room :  </strong>
                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("Total") %>' Font-Bold="true"></asp:Label>
               
                </td>
            </tr>
            <tr>
                <td valign="top">
                <strong style="color: orangered;">
                    Allocated :  </strong>
                    <asp:Label ID="lblAllocated" runat="server" Text='<%# Eval("Allocated") %>' Font-Bold="true"></asp:Label>
               </td>
            </tr>
            <tr>
                <td valign="top">
                <strong style="color: indigo;">
                    Un Allocated :  </strong>
                    <asp:Label ID="lblUnAllocated" runat="server" Text='<%# Eval("UnAllocated") %>' Font-Bold="true"></asp:Label>
               
                 </td>
            </tr>
                </table>--%>
            </div>
        </ItemTemplate>
        <%-- <SelectedItemStyle BackColor="#666666" />--%>
    </asp:DataList>
    <%--  <asp:CheckBoxList runat="server" ID="CbList" DataTextField="Ward_Detail" DataValueField="Ward_Id"
        RepeatDirection="Horizontal" RepeatLayout="Table" Font-Bold="true" ForeColor="blue">
    </asp:CheckBoxList>--%>
    <asp:Panel ID="pnlGrid" runat="server" Visible="true">
        <br />
        <div style="color: brown; font-weight: bold; font-size: 20px; padding: 10px">
            Room/Bed Detail <span style="padding-left: 80px; color: Red; font-size: 16px;">
                <asp:Label ID="lblmsg" runat="server" Text="Patient Is Not Discharge Due To Bill Not Paid"
                    Visible="false"></asp:Label></span></div>
        <br />
        <asp:GridView ID="GridViewTest" runat="server" AutoGenerateColumns="False" CssClass="Grid_2"
            Font-Bold="True" Style="font-size: large !important" DataKeyNames="Bed_No,ward_Id"
            Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" >
                    <ItemTemplate>
                        <asp:Label  runat="server" ID="lblSerial"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField  DataField="Yearly_No" HeaderText="File No." SortExpression="Indoor_No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Reg_No" HeaderText="Reg No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField HeaderText="Floor/Unit Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate >
                        
                        <asp:Label  Text='<%#Bind("Ward_Name") %>' ID="lblWardName" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Bed_No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderText="Bed/Room No." SortExpression="Bed_No" />
                <asp:TemplateField HeaderText="Patient Name">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton_Patient" Visible="false" Text='<%# Bind("Patient_Name")%>' runat="server"
                            EnableTheming="False" ToolTip='<%# Eval("Yearly_No") %>' CommandArgument='<%# Eval("Reg_No") %>'
                            OnClick="LinkButton_Patient_Click"></asp:LinkButton><%--CommandName="Select"--%>

                            <asp:Label Text='<%#Bind("Patient_Name")%>'    ForeColor="Blue"
                            ID="lblPatient_Name" runat="server" />

                        <asp:Label ID="Label2" runat="server" Text="Label" Visible="False"></asp:Label>
                        <asp:HiddenField ID="hf_regno" runat="server" Value='<%# Eval("Reg_No") %>' />
                        <asp:HiddenField ID="Hf_Yearly" runat="server" Value='<%# Eval("Yearly_No") %>' />
                        <asp:HiddenField ID="hf_WardID" runat="server" Value='<%# Eval("Ward_id") %>' />
                        <asp:HiddenField ID="hf_BedID" runat="server" Value='<%# Eval("Bed_id") %>' />
                        <asp:HiddenField ID="hf_FloorID" runat="server" Value='<%# Eval("FloorID")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Addmission_Date" HeaderText="Admission Date" SortExpression="Addmission_Date" />
                
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" Visible="false" ItemStyle-HorizontalAlign="Center" DataField="Datedifference" HeaderText="Total Days" SortExpression="Datedifference" />
                <asp:BoundField DataField="Consultant_Name" HeaderText="Consultant Name"  Visible="false" SortExpression="Consultant_Name" />
                 
                <asp:TemplateField HeaderText="Bill" HeaderStyle-HorizontalAlign="Center"  Visible="false" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("Bill")%>'   Width="50px" ForeColor="Blue" Font-Underline="true"
                            ID="glblBill" runat="server" />
                       
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Remarks" HeaderText="Remarks"  Visible="false" SortExpression="Remarks" />
                <%--<asp:TemplateField HeaderText="Medicine">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_btn" runat="server" OnClick="lnk_btn_Click">Medicine</asp:LinkButton>                       
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Services"  Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="Slnk_btn" runat="server" OnClick="lnk_btn_Click">Services</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Package" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_PacKage" runat="server"  CommandArgument='<%# Bind("Reg_No") %>'
                            ToolTip='<%# Bind("Yearly_No") %>'
                            Text="Add" onclick="lnk_PacKage_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Discharge-Expired" Visible="True">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbtnDischarge" Visible="false" CommandArgument='<%# Bind("Yearly_No") %>' ToolTip='<%#Bind("Is_Dischargeable") %>' Font-Bold="true"
                            ForeColor="Red" runat="server" Text="Discharge" OnClick="lnkbtnDischarge_Click"></asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;
                            <%--<asp:LinkButton ID="lnkExpired"  Visible="false"  Font-Bold="true"
                            ForeColor="Red" runat="server"    Text="Expired" OnClick="lnkExpired_Click"></asp:LinkButton>--%>
                            <asp:HyperLink runat="server" Visible="false" ID="lnkExpired" 

				NavigateUrl='<%# string.Format("~/PT_EMR/Pt_Death_Certificate.aspx?RegNo={0}&YearlyNo={1}",
		                    HttpUtility.UrlEncode(Eval("Reg_No").ToString()), HttpUtility.UrlEncode(Eval("Yearly_No").ToString())) %>'
                            Target="_blank" style="color: Red;"    Text="Expired"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Add Limit" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_AddLimit" runat="server" CommandArgument='<%# Eval("Reg_No") %>'
                            OnClick="lnk_btn_Click">Add Limit</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Patient_type" HeaderText="" SortExpression="Patient_type" />
                <asp:TemplateField HeaderText="Panel Bill" Visible="false">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnk_PanelBill" runat="server" CommandArgument='<%# Eval("Reg_No") %>'
                            ToolTip='<%# Eval("Yearly_No") %>' OnClick="lnk_btn_Click">Panel Bill</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="GridHeader2" />
        </asp:GridView>
    </asp:Panel>
    <asp:Panel ID="pnlReport" runat="server" Visible="false">
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </asp:Panel>
    <br />
    <asp:Panel ID="panelReasonDischarge" runat="server" Visible="false">
         <div class="bxmain" style="float: right; width: 50%">
                        <h2>
                            <span>Reason For Discharge</span></h2>
                        <table border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                            <tr>
                                <td align="right">
                                    <b>Reason For Discharge :</b>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="rbtreason" runat="server" RepeatDirection="Horizontal" RepeatColumns="2"
                                        RepeatLayout="Table">
                                        <asp:ListItem Text="Normal Discharge With Improved Health" Value="0" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Leave With Request" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Leave Without Medical Advice" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Death" Value="3"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Remarks :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRemarks" Text="" runat="server" TextMode="MultiLine" Width="70%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="btnReason" Text="Save" runat="server" OnClick="btnReason_Click" />
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" CacheExpirationPolicy="Sliding"
                                        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
                                        UpdateCommand="Patient_Discharge_FinalBill" UpdateCommandType="StoredProcedure">
                                        <UpdateParameters>
                                            <asp:Parameter Name="Reg_No" Type="String" DefaultValue="0" />
                                            <asp:Parameter Name="Yearly_No" Type="Int32" DefaultValue="0" />
                                            <asp:Parameter Name="Remarks" Type="String" DefaultValue="" />
                                            <asp:Parameter Name="Reason_Id" Type="Int32" DefaultValue="0" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </div>

    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSourceFloor" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select 0 as Ward_id,'--ALL--' as Ward_Name union SELECT DISTINCT  Ward_id,Ward_Name FROM  admin_Hospital_Wards WHERE (isDeleted = 0)">
        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRoomBed" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT Ward_Beds.ward_Id, Ward_Beds.Bed_No, Ward_Beds.Bed_Status FROM admin_Hospital_Wards INNER JOIN SubDepartment ON admin_Hospital_Wards.SubDept_Id = SubDepartment.SubDept_Id INNER JOIN Ward_Beds ON admin_Hospital_Wards.Ward_id = Ward_Beds.ward_Id WHERE (admin_Hospital_Wards.SubDept_Id = @SubDept_Id) AND (Ward_Beds.Bed_Status = 0)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListFloor" Name="SubDept_Id" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_EncrRegNo" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="insert_Patient_Assign_Bed" InsertCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldWard_Id" Name="Ward_id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldBedID" Name="Bed_id" PropertyName="Value" />
            <asp:SessionParameter Name="admission_By" SessionField="emp_id" />
            <asp:SessionParameter Name="Reg_No" SessionField="registrationNo" />
            <asp:SessionParameter Name="Yearly_No" SessionField="YearlyNo" />
            <asp:Parameter DefaultValue="false" Name="Pt_Status" />
            <asp:ControlParameter ControlID="DropDownListFloor" Name="FloorID" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Update" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        UpdateCommand="UPDATE Ward_Beds SET Bed_Status = 1 WHERE (ward_Id = @ward_Id) AND (Bed_id = @Bed_ID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldWard_Id" Name="ward_Id" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldBedID" Name="Bed_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldBedID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Pt_View_AssignBed" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListFloor" Name="SubDept_Id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldWard_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
        UpdateCommand="Patient_Discharge_FinalBill" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Reg_No" Type="String" DefaultValue="0" />
            <asp:Parameter Name="Yearly_No" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="Remarks" Type="String" DefaultValue="" />
            <asp:Parameter Name="Reason_Id" Type="Int32" DefaultValue="0" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
