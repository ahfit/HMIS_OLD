<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddAppointment.aspx.cs" Inherits="OT_Management_AddAppointment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <h1 class="title">Add Patient OT Appointment</h1>
    <div>
        <table class="table  table-content table-bordered well " style="width: 100%;">

            <tr>
                <td style="text-align: right">Mode of Operation :
                </td>
                <td>
                      <asp:RadioButtonList ID="RadioButtonList_Type" runat="server"
                                                                            DataSourceID="SqlDataSource_Test_Type" DataTextField="Test_Type"
                                                                            DataValueField="Test_Type_ID" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                                                            TabIndex="16" Width="100%">
                                                                        </asp:RadioButtonList>
                    <asp:SqlDataSource ID="SqlDataSource_Test_Type" runat="server"
                                                                SelectCommand="SELECT [Test_Type], [Test_Type_ID] FROM [Test_Type]"
                                                                ConnectionString="<%$ ConnectionStrings:OT_ManagementConnectionString %>"></asp:SqlDataSource>
                </td>
                <td style="text-align: right">Consultant :
                </td>
                <td>
                     <asp:DropDownList ID="DropDownListConsultant" runat="server" Height="25px" Width="228px">
                                      </asp:DropDownList>
                                                                      
                </td>
            </tr>

            <tr>
                <td style="text-align: right">Anesthesia :</td>
                <td>
                    
                     <asp:DropDownList ID="ddlAnesthsia" runat="server"></asp:DropDownList>
                </td>

                <td style="text-align: right">Date of Admission :</td>
                <td>
                    <asp:TextBox ID="txtboxDOA" Enabled="false" TextMode="Date" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Date of Operation :</td>
                <td>

                    <asp:TextBox ID="txtboxDOO" Enabled="true"  OnTextChanged="txtboxDOO_TextChanged" AutoPostBack="true" TextMode="Date" runat="server"></asp:TextBox>
                </td>

                <td style="text-align: right">Package Name :
                </td>
                <td>
                    <asp:Label runat="server" ID="lblpackage"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Procedures:</td>
                <td>
                    <asp:Label ID="lblProcedures" runat="server"></asp:Label>
                </td>
                <td style="text-align: right">OT Time :
                </td>
                <td>
                    <asp:DropDownList ID="ddltimeslot" runat="server">
                        
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align:center;">
                    <asp:Button ID="btnSave" Visible="false" runat="server" Text="Save" OnClick="btnSave_Click" />
                </td>
                <td>
                    <asp:Label ID="lblMessage" runat="server" Visible="false" Font-Bold="true" ></asp:Label>
                </td>
            </tr>
        </table>

    </div>
    <div>
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
        </Columns>
    </asp:GridView>
    </div>

</asp:Content>

