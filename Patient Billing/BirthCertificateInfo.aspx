<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="BirthCertificateInfo.aspx.cs" Inherits="Patient_Registration_BirthCertificateInfo" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Birth Certificate Form</span></h2>
    <table class="diagnosis_list">
        <tr>
            <td align="right"><b>MR # :</b></td>
            <td>
                <asp:TextBox ID="TextBoxMRNO" runat="server" MaxLength="20"></asp:TextBox>
                                
                <asp:Button ID="btn_Update" runat="server" OnClick="btn_Update_Click" Text="Search" />
                                
                <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                
            </td>
        </tr>
        <tr>
            <td align="right"><b>IPD # :</b></td>
            <td>
                <asp:TextBox ID="TextBoxVISIT_IPDNO" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr style="display:none">
            <td align="right"><b>Bill # :</b></td>
            <td>
                <asp:TextBox ID="TextBoxBillNO" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr >
            <td align="right" ><b>Name Of Child:</b></td>
            <td >
                <asp:TextBox ID="TextBoxPatientName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"><b>Delivered By:</b></td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="150px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right"><b>Status :</b></td>
            <td>
                <asp:TextBox ID="TextBoxStatus" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"><strong>Gender :</strong></td>
            <td>
                            <asp:DropDownList ID="DropDownListGender" runat="server" Width="130px">
                            </asp:DropDownList>
            </td>
        </tr>
        <tr >
            <td align="right"><b>Place Of Birth :</b></td>
            <td>
                <asp:TextBox ID="TextBoxPlaceofBirth" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr >
            <td align="right"><strong>Alive / Dead :</strong></td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True">Alive</asp:ListItem>
                    <asp:ListItem>Dead</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td align="right"><b>Father Name :</b></td>
            <td>
                <asp:TextBox ID="TextBoxFatherName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"><b>Mother Name :</b></td>
            <td>
                <asp:TextBox ID="TextBoxMotherName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"><strong>Father CNIC :</strong></td>
            <td>
                <asp:TextBox ID="TextBoxFatherCNIC" runat="server" MaxLength="13"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"><strong>Mother CNIC :</strong></td>
            <td>
                <asp:TextBox ID="TextBoxMotherCNIC" runat="server" MaxLength="13"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"><b>Residentail Address :</b></td>
            <td>
                <asp:TextBox ID="TextBoxResidentailAddress" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right"><b>Time Of Birth :</b></td>
            <td>
                <asp:TextBox ID="startDateChooser" runat="server" TextMode="Date" ></asp:TextBox>
                  <%--  <igsch:WebDateChooser Width="180px" ID="startDateChooser" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
               
                    <asp:HiddenField ID="HiddenFieldDate" runat="server" />--%>
               
                <asp:TextBox ID="startDateChooserTime" runat="server" TextMode="Time" ></asp:TextBox>
               
                </td>
        </tr>
        <tr style="display:none">
            <td align="right"><b>Issued By :</b></td>
            <td>
                <asp:TextBox ID="TextBoxIssuedBy" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>

        <tr>
            <td align="right"><b></b></td>
            <td>
                <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" />
                <asp:Button CausesValidation="false" ID="btnUpdate" Visible="false" ValidationGroup="validate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
              
                <asp:Label ID="Label1" runat="server" BorderColor="#FF0066" Font-Bold="True" ></asp:Label>
            </td>
           
        </tr>
        <tr>
            <td align="right">&nbsp;</td>
            <td>
                &nbsp;</td>
           
        </tr>
        <tr>
            <td align="right" colspan="2">
              
                <asp:GridView ID="GridViewBirthCertificateInfo" runat="server" AutoGenerateColumns="False" Width="100%">
                    <Columns>
                         <asp:TemplateField HeaderText="Sr#">
                      <ItemTemplate>
                          <%#Container.DataItemIndex+1 %>
                      </ItemTemplate>
                  </asp:TemplateField>
                      <asp:TemplateField HeaderText="Mr #">
                      <ItemTemplate>
                          <asp:Label ID="lblMrNo" runat="server" Text='<%#Bind("MrNo") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                         
                      <asp:TemplateField HeaderText="IPD #">
                      <ItemTemplate>
                          <asp:Label ID="lblVisitNo" runat="server" Text='<%#Bind("VisitNo") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bill #">
                      <ItemTemplate>
                          <asp:Label ID="lblBillNo" runat="server" Text='<%#Bind("BillNo") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                           <asp:TemplateField HeaderText="Patient Name">
                      <ItemTemplate>
                          <asp:Label ID="lblPatientName" runat="server" Text='<%#Bind("PatientName") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                         <asp:TemplateField HeaderText="Consultant">
                      <ItemTemplate>
                          <asp:Label ID="lblConsultant" runat="server" Text='<%#Bind("Consultant") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                      <ItemTemplate>
                          <asp:Label ID="lblStatus" runat="server" Text='<%#Bind("Status") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                         <asp:TemplateField HeaderText="Residentail Address">
                      <ItemTemplate>
                          <asp:Label ID="lblProcedureFor" runat="server" Text='<%#Bind("ResidentailAddress") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                          <asp:TemplateField HeaderText="Place Of Birth">
                      <ItemTemplate>
                          <asp:Label ID="lblProcedureForPlace" runat="server" Text='<%#Bind("PlaceofBirth") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                         <asp:TemplateField HeaderText="Gender">
                      <ItemTemplate>
                          <asp:Label ID="lblGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                        
                         <asp:TemplateField HeaderText="Father Name">
                      <ItemTemplate>
                          <asp:Label ID="lblFatherName" runat="server" Text='<%#Bind("FatherName") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                         <asp:TemplateField HeaderText="Mother Name">
                      <ItemTemplate>
                          <asp:Label ID="lblMotherName" runat="server" Text='<%#Bind("MotherName") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                        
                         <asp:TemplateField HeaderText="Father CNIC">
                      <ItemTemplate>
                          <asp:Label ID="lblFatherNameCNIC" runat="server" Text='<%#Bind("FatherCNIC") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                         <asp:TemplateField HeaderText="Mother CNIC">
                      <ItemTemplate>
                          <asp:Label ID="lblMotherNameCNIC" runat="server" Text='<%#Bind("MatherCNIC") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                      
                        <asp:TemplateField HeaderText="DOB">
                      <ItemTemplate>
                          <asp:Label ID="lblDateofBirth" runat="server" Text='<%#Bind("DateofBirth") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                         <asp:TemplateField HeaderText="Issued by">
                      <ItemTemplate>
                          <asp:Label ID="lblIssuedBy" runat="server" Text='<%#Bind("IssuedBy") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                            <asp:HyperLinkField HeaderText="Print Report" Target="_blank" Text="Print" DataNavigateUrlFields="BillNo" DataNavigateUrlFormatString="~\Patient Registration\DateofbirthCertificateReport.aspx?BillNo={0}" />
                     
                     <asp:TemplateField HeaderText="Edit Record">
                                <ItemTemplate>
                                    <asp:LinkButton CausesValidation="false" ID="lnkbtnedit" text="Edit" CommandName='<%# Bind("MrNo") %>' runat="server" OnClick="lnkbtnedit_Click"> </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                 <asp:HiddenField ID="hdMrNo" runat="server" />
                <br />
            </td>
        </tr>
    </table>
          </div>
   <asp:SqlDataSource ID="SqlDataSourceUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>"
        UpdateCommandType="StoredProcedure" SelectCommand="Search_BirthCertificateInfo" SelectCommandType="StoredProcedure">
       <SelectParameters>
           <asp:ControlParameter ControlID="TextBoxMRNO" Name="RegNo" PropertyName="Text" Type="String" />
       </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

