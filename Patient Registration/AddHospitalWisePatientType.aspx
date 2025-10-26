<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Patient Registration/AddHospitalWisePatientType.aspx.cs" Inherits="Patient_Registration_AddHospitalWisePatientType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%"><span><h2>Add Hospital Wise Type</h2></span>
    <table class="diagnosis_list">
        <tr>
            <td align="right"><strong>Hospital :</strong></td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
        <tr>
            <td align="right"><strong>Patient type :</strong></td>
            <td>
                  <asp:DropDownList ID="ddl_PatientType" runat="server" Width="202px" AutoPostBack="true" OnSelectedIndexChanged="ddl_PatientType_SelectedIndexChanged" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btn_markReceptionest" runat="server" Text="Add Hospital Patient Type Wsie" 
                    onclick="btn_markReceptionest_Click" />
                <asp:Label ID="lblmg" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
        </div>
        <div>
                <asp:GridView  ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" Width="100%">
              <Columns>
                  
                  <asp:TemplateField HeaderText="Type ID">
                      <ItemTemplate>
                          <asp:Label ID="lblHospital_ID" runat="server" Text='<%#Bind("Hospital_ID") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Hospital Name">
                      <ItemTemplate>
                          <asp:Label ID="lblHospital_Name" runat="server" Text='<%#Bind("Hospital_Name") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                     <asp:TemplateField HeaderText="Patient Type">
                      <ItemTemplate>
                          <asp:Label ID="lblPatient_type" runat="server" Text='<%#Bind("Patient_type") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                     <asp:TemplateField HeaderText="Dependent Allow">
                      <ItemTemplate>
                             <asp:LinkButton ID="LinkButton1" Text='<%# Eval("DependentAllow") %>'  CommandArgument='<%# Bind ("Id") %>' OnClick="LinkButton1_Click" runat="server">

                          </asp:LinkButton>
                      </ItemTemplate>
                  </asp:TemplateField>
                     <asp:TemplateField HeaderText="Panel Company">
                      <ItemTemplate>
                          <asp:LinkButton ID="LinkButton2" Text='<%#Eval("PanelCompany") %>' CommandArgument='<%#Bind("Id") %>' OnClick="LinkButton2_Click" runat="server"></asp:LinkButton>
                      </ItemTemplate>
                  </asp:TemplateField>
                
              </Columns>
                      </asp:GridView>
                    <asp:HiddenField runat="server" id = "HF_Status"></asp:HiddenField>  
            </div>
</asp:Content>

