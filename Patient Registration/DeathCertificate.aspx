<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="DeathCertificate.aspx.cs" Inherits="Patient_Registration_DeathCertificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Death Certificate</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td align="left" width="50%">
                    <asp:Label ID="lblMsgTop" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" width="50%">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                        <tr>
                            <td align="right" width="40%">MR # :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtMRNo" runat="server" MaxLength="14" Width="120px"></asp:TextBox>
                                <asp:Button ID="btnSearchMR" runat="server" Text="Search" OnClick="btnSearchMR_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Name :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                           <td align="right" width="40%">&nbsp;</td>
                            <td align="left" width="60%">
                                <asp:Label ID="lblRelation" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Relation Name :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtRelationName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">CNIC :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtCNICNo" runat="server" MaxLength="13"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Brief History :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtHistory" runat="server" TextMode="MultiLine" Width="250px" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Cause Of Death :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtCauseOfDeath" runat="server" TextMode="MultiLine" Width="250px" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="right" width="50%">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form">

                        <tr>
                            <td align="right" width="40%">Place Of Death :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtPlace" runat="server"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Date :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Hours :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtHours" runat="server" TextMode="Number"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Address :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Width="250px" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Finding of Examination :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtExamination" runat="server" TextMode="MultiLine" Width="250px" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Handed Over / Refer for Postmortem :</td>
                            <td align="left" width="60%">
                                <asp:RadioButtonList ID="rblRefer" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="Hand Over" Value="Handover" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Refer" Value="Refer"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div class="bxmain inner_content" style="width: 100%; margin-top: 10px;">
        <h2><span>Particular Information</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td align="left" width="50%">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                        <tr>
                            <td align="right" width="40%">Name :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtPatName" runat="server"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">CNIC :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtPCNIC" runat="server"></asp:TextBox>
                            </td>
                        </tr>

                    </table>
                </td>
                <td align="right" width="50%">
                    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form">

                        <tr>
                            <td align="right" width="40%">Contact # :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtPContactNo" runat="server"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Address :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine" Width="250px" Height="75px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSave" runat="server" Text="Save"  OnClick="btnSave_Click"/>
                </td>
            </tr>
             <tr>
                <td align="center" colspan="2">
                   <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
     <div style="margin-top:10px; width:100%;">
        <asp:GridView ID="gvDetails" runat="server" AutoGenerateColumns="false"
             Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="RegNo" HeaderText="MR #" />
                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                <asp:BoundField DataField="Relation" HeaderText="Relation" />
                <asp:BoundField DataField="RelationName" HeaderText="Relation Name" />
                <asp:BoundField DataField="CNIC" HeaderText="CNIC #" />
                <asp:BoundField DataField="DeathDate" HeaderText="Death Date" />
                <asp:HyperLinkField HeaderText="" DataNavigateUrlFields="ID,RegNo" Text="View Report" 
                    DataNavigateUrlFormatString="~/Patient Registration/DeathCertificateReport.aspx?ID={0}&regNo={1}"
                     Target="_blank" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

