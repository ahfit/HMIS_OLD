<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="~/RecordManagement/Patient_Record_File_Activity.aspx.cs" AutoEventWireup="true" Inherits="RecordManagement_Patient_Record_File_Activity" EnableEventValidation="false" Theme="theme_hacims" ViewStateEncryptionMode="Never" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--<div class="bxmain PageHeading">
    
    Patient Record Activity
    
</div>--%>

    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span style="font-size: 20px ! important">Patient Record Activity</span></h2>
        <div class="bxmain" style="margin-left: 200px ! important">
            <table width="100%" cellpadding="0" cellspacing="0" class="tbl_form">

                <tr>
                    <td width="100px" align="right" valign="top">Date</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server"
                            Width="290px">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">Name</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <asp:TextBox ID="txtName" runat="server" Width="290px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ErrorMessage="Please Enter The Name" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">Phone</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <asp:TextBox ID="txtPhone" runat="server" Width="290px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ErrorMessage="Please Enter The Phone#" ControlToValidate="txtPhone"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">CNIC</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <asp:TextBox ID="txtCNIC1" runat="server" Width="45px" MaxLength="5"></asp:TextBox>
                        -
                          <asp:TextBox ID="txtCNIC2" runat="server" Width="175px" MaxLength="7"></asp:TextBox>
                        -  
                          <asp:TextBox ID="txtCNIC3" runat="server" Width="44px" MaxLength="1"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">Address</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <asp:TextBox ID="txtAddress" runat="server" Width="285px" Height="150px"
                            TextMode="MultiLine"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                            ErrorMessage="Required" ControlToValidate="txtAddress"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">Relation</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <asp:TextBox ID="txtRelation" runat="server" Width="290px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_rel" runat="server"
                            ErrorMessage="Required" ControlToValidate="txtRelation"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td width="100px" align="right" valign="top">Remarks</td>
                    <td width="10px" valign="top">:</td>
                    <td width="290px">
                        <asp:TextBox ID="txtRemarks" runat="server" Width="285px" Height="150px"
                            TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                            ControlToValidate="txtRemarks" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="padding-left: 377px;">
                        <asp:Button ID="btn_Save" runat="server" Text="Save" OnClick="btn_Save_Click" />
                        <%--<asp:Button ID="btn_Cancel" runat="server" Text="Cancel"
                            OnClick="btn_Cancel_Click" />--%>
                    </td>
                </tr>

            </table>
            <asp:Label ID="lbl_Msg" ForeColor="Red" Font-Bold="true" Visible="false" runat="server"></asp:Label>

            <asp:SqlDataSource ID="Sql_PatientRecordActivity" runat="server" ConnectionString="<%$ ConnectionStrings:Record_ManagementConnectionString %>"
                InsertCommand="usp_Insert_Patient_Record_File_Activity"
                InsertCommandType="StoredProcedure"
                SelectCommand="SELECT * FROM Patient_Record_File_Activity WHERE Patient_File_ID=@Patient_File_ID">
                <InsertParameters>
                    <asp:Parameter Name="Patient_File_ID" Type="Int32" />
                    <asp:Parameter Name="DateTime" Type="DateTime" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Phone" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                    <asp:Parameter Name="Relation" Type="String" />
                    <asp:Parameter Name="Remarks" Type="String" />
                    <asp:Parameter Name="CNIC" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="Patient_File_ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
    <table width="100%" style="padding-top: 20px;">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="Sql_PatientRecordActivity" Width="100%" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone No." />
                        <asp:BoundField DataField="Address" HeaderText="Address" />
                        <asp:BoundField DataField="CNIC" HeaderText="CNIC" />
                        <asp:BoundField DataField="Relation" HeaderText="Relation" />
                        <asp:BoundField DataField="DateTime" HeaderText="Date Time" />
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                    </Columns>

                </asp:GridView>
            </td>
        </tr>
    </table>


</asp:Content>

