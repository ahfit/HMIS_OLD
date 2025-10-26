<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="DeliveryNotes.aspx.cs" Inherits="DeliveryNotes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function Alphabets() {
            var ch = String.fromCharCode(event.keyCode);
            var filter = /^[A-Za-z ]+$/;
            if (!filter.test(ch)) {
                event.returnValue = false;
            }
        }

        <%-- function ValidateRegForm() {

            var email = document.getElementById("<%=txtEmail.ClientID%>");
            var filter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;

            if (!filter.test(email.value)) {
                alert('Please provide a valid email address');
                email.focus;
                return false;
            }
            return true;

        }--%>

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="leftnav" valign="top">
                <asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
            </td>
            <td style="width: auto;" valign="top">

                <div class="bxmain inner_content" style="width: 100%">
                    <h2><span>Deliver Notes</span>
                    </h2>
                    <table style="width: 100%; margin: 0 auto;">
                        <tr>
                            <td class="text-right" style="width: 25%;">Name of Patients :
                            </td>
                            <td style="width: 25%;">
                                <asp:TextBox ID="txtNamePatient" Text="" onkeypress="return Alphabets(event,this);" runat="server"></asp:TextBox>
                            </td>
                            <td class="text-right" style="width: 20%;">Husband Name :
                            </td>
                            <td>
                                <asp:TextBox ID="txtHusbandName" Text="" onkeypress="return Alphabets(event,this);" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right">CNIC of Husband:</td>
                            <td>
                                <asp:TextBox ID="txtCNICHusband" MaxLength="13" Text="" onkeypress="return event.charCode === 0 || /\d/.test(String.fromCharCode(event.charCode));" runat="server"></asp:TextBox>
                            </td>
                            <td class="text-right">&nbsp;</td>
                            <td>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right">Date of Delivery:</td>
                            <td>
                                <asp:TextBox ID="txtDateDelivery" runat="server" TextMode="Date"></asp:TextBox>
                            </td>

                            <td class="text-right">Time :</td>
                            <td>
                                <asp:TextBox ID="txtTime" Text="" runat="server" type="time"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="text-right">Sex of Baby (M/F) :
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSexofBaby" runat="server">
                                    <asp:ListItem Text="Male" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Female"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="text-right">Weight :</td>
                            <td colspan="3">
                                <asp:TextBox ID="txtWeight" Text="" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right">Apgar :</td>
                            <td>
                                <asp:TextBox ID="txtApgar" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="text-right">1 Min :</td>
                            <td>
                                <asp:TextBox ID="txt1Minut" runat="server" Width="120px"></asp:TextBox>
                                &nbsp; <span class="text-right">5 Min :</span> &nbsp;<asp:TextBox ID="txt5Minut" runat="server" Width="120px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right" style="width: 320px">Types of Delivery(SVD/SVD with api/Forcep/LS.C.S) :</td>
                            <td>
                                <asp:TextBox ID="txtTypesofDelivery" Text="" runat="server"></asp:TextBox>
                            </td>
                            <td class="text-right">Delivery Conducted By(R.M.O / Consultant) :</td>
                            <td>
                                <asp:TextBox ID="txtDeliveryConductedBy" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>

                            <td class="text-right">Assistant(Nurse) :</td>
                            <td>
                                <asp:TextBox ID="txtAssistant" Text="" runat="server"></asp:TextBox>
                            </td>
                            <td class="text-right">Birth Certificate Sr.No :</td>
                            <td>
                                <asp:TextBox ID="txtBCSrNo" Text="" runat="server" TextMode="Number"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td class="text-right">Sign of R.M.O :</td>
                            <td>
                                <asp:TextBox ID="txtSignRMO" Text="" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="text-align: center; margin-top: 1%">
                    <asp:Button ID="btnSave" runat="server" Text="Save" Style="height: 5%" OnClick="btnSave_Click" />
                    <asp:Label ID="lblMsg" Text="" runat="server"></asp:Label>
                </div>
                <div style="margin-top:10px; width:100%;">
        <asp:GridView ID="gvDeliveryNote" runat="server" AutoGenerateColumns="false"
             Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                </asp:TemplateField>
               <%-- <asp:BoundField DataField="RegNo" HeaderText="MR #" />--%>
                <asp:BoundField DataField="YearlyNo" HeaderText="Visit #" />
                <asp:BoundField DataField="Patientname" HeaderText="Patient Name" />
                <asp:BoundField DataField="Husbandname" HeaderText="Husband Name" />
                <asp:BoundField DataField="Cnic" HeaderText="CNIC #" />
                <%--<asp:BoundField DataField="Deliverydate" HeaderText="Delivery Date" />--%>
                <asp:BoundField DataField="Deliverytime" HeaderText="Time" />
                <asp:BoundField DataField="Babysex" HeaderText="Baby sex" />
                <asp:BoundField DataField="Weight" HeaderText="Baby Weight" />
               <%-- <asp:HyperLinkField HeaderText="" DataNavigateUrlFields="ID" Text="View Report" DataNavigateUrlFormatString="~/Nursing/DeliveryNoteReport.aspx?ID={0}"
                     Target="_blank" />--%>
            </Columns>
        </asp:GridView>
    </div>
            </td>
        </tr>
       
    </table>
    
</asp:Content>

