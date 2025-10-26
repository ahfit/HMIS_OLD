<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Appointment.aspx.cs" Inherits="OT_Management_Appointment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    

        <h1 class="title">OT Patients Appointment List </h1>

    <div class="div-filter">
    <table style="width:100%">
        <tr>
            <td style="width:10%;text-align:right">MR #:</td>
            <td style="width:30%"><asp:TextBox ID="txtMrNO" runat="server"></asp:TextBox></td>
            <td  style="width:10%;text-align:right">Visit #:</td>
            <td><asp:TextBox ID="txtVisitNo" runat="server"></asp:TextBox></td>
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
            <asp:TemplateField HeaderText="Procedure">
                <ItemTemplate>
                      <asp:Label ID="lblName" runat="server" Text='<%# Eval("Procedure") %>'></asp:Label>
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
          
            <asp:TemplateField HeaderText="Add Appointment">
                <ItemTemplate>
                      <asp:hyperlink id="hpAddAppointment" runat="server" target="_blank" 
                                                 NavigateUrl='<%# String.Format("../OT_Management/AddAppointment.aspx?VisitNo={0}&RegNo={1}&MainId={2}", Eval("VisitNo"), Eval("RegNo"), Eval("Main_ID"))%>' 
                                                 Text='Add Appointment'></asp:hyperlink>

                    
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
</asp:Content>

