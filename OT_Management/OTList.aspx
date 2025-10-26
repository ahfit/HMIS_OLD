<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="OTList.aspx.cs" Inherits="OT_Management_OTList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    

        <h1 class="title">Patients OT List </h1>

    <div class="div-filter">
    <table style="width:100%">
        <tr>
            <td style="width:10%;text-align:right">MR #: </td>
            <td style="width:20%"><asp:TextBox ID="txtMrNO" runat="server"></asp:TextBox></td>
            <td  style="width:10%;text-align:right">Visit #: </td>
            <td style="width:20%"><asp:TextBox ID="txtVisitNo" runat="server"></asp:TextBox></td>
            <td style="width:10%;text-align:right">Operation Date: </td>
            <td style="width:20%">
                  <asp:TextBox ID="txtDate" runat="server" TextMode="Date" Style="width: 98%"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="btnSearch" Text="Search" runat="server" OnClick="btnSearch_Click" />
            </td>
        </tr>        
    </table>
   </div>
    <asp:GridView ID="grdAppointments" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="MR #">
                <ItemTemplate>
                      <asp:Label ID="lblMR" runat="server" Text='<%# Eval("RegNo") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Name">
                <ItemTemplate>
                      <asp:Label ID="lblName" runat="server" Text='<%# Eval("PatientName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Mode Of Operation">
                <ItemTemplate>
                      <asp:Label ID="lblOpeationDate" runat="server" Text='<%# Eval("ModeOfOperation") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Operation Date">
                <ItemTemplate>
                      <asp:Label ID="lblOpeationDate" runat="server" Text='<%# Eval("OpeationDate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
           
             <asp:TemplateField HeaderText="Consultant">
                <ItemTemplate>
                      <asp:Label ID="lblConsultant" runat="server" Text='<%# Eval("Consultant") %>'></asp:Label>
                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
          
              <asp:TemplateField HeaderText="Time">
                <ItemTemplate>
                      <asp:Label ID="lblTimeSlot" runat="server" Text='<%# Eval("TimeSlot") %>'></asp:Label>
                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
              <asp:TemplateField HeaderText="Doctor Assesment">
                <ItemTemplate>
                     <asp:hyperlink id="hpDocAss" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../OT_Management/DoctorAssesment.aspx?YearlyNo={0}", Eval("PayID"))%>' 
                                                 Text='Doctor Assesment'></asp:hyperlink>


                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
              <asp:TemplateField HeaderText="Anaesthetist Assesment">
                <ItemTemplate>
                     <asp:hyperlink id="hpANAss" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../OT_Management/AnesthesiastAssesment.aspx?YearlyNo={0}", Eval("PayID"))%>' 
                                                 Text='Anaesthetist Assesment'></asp:hyperlink>


                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Nursing Pr-OP Checklist">
                <ItemTemplate>
                     <asp:hyperlink id="hpNPOChecklist" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../OT_Management/NursingChecklistPreOP.aspx?YearlyNo={0}", Eval("PayID"))%>' 
                                                 Text='Nursing Pr-OP Checklist'></asp:hyperlink>


                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Vitals">
                <ItemTemplate>
                     <asp:hyperlink id="hpNPOChecklist" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../Nursing/Patient_Vital.aspx?YearlyNo={0}", Eval("PayID"))%>' 
                                                 Text='Vitals'></asp:hyperlink>


                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>

             <%--<asp:TemplateField HeaderText="Vitals">
                <ItemTemplate>
                     <asp:hyperlink id="hpNPOChecklist" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../Nursing/Patient_Vital.aspx?YearlyNo={0}", Eval("PayID"))%>' 
                                                 Text='Vitals'></asp:hyperlink>


                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>--%>

              <asp:TemplateField HeaderText="OT Notes">
                <ItemTemplate>
                     <asp:hyperlink id="hpAddAppointment" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../OT_Management/Ot_operation_Notes.aspx?VisitNo={0}&RegNo={1}&OrderId={2}&DateofOperation={3}&TimeSlot={4}", Eval("PayID"), Eval("RegNo"), Eval("Order_ID"),Eval("DateOfOperation"),Eval("TimeSlot"))%>' 
                                                 Text='OT Notes'></asp:hyperlink>

                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Consent Form">
                <ItemTemplate>
                     <asp:hyperlink id="hpAddConsentForm" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../OT_Management/Consent.aspx?YearlyNo={0}", Eval("PayID"))%>'  
                                                 Text='Consent Form'></asp:hyperlink>

                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
</asp:Content>

