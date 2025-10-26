<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="BloodScreeningMark, App_Web_ob4gay25" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 
 <div class="bxmain">
          <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                <tr>
                    <td align="right" width="40%" >
                        HBsAG :</td>
                    <td  ><asp:RadioButtonList ID="RadioButtonList_HB" runat="server" 
                            RepeatColumns="2"  >
                            <asp:ListItem Value="True">Positive</asp:ListItem>
                        <asp:ListItem Value="False">Negative</asp:ListItem>
                  </asp:RadioButtonList>                  </td>
            </tr>
                <tr>
                    <td align="right"  >
                        ANTI
                        HC :</td>
                    <td  >
                        <asp:RadioButtonList ID="RadioButtonList_HC" runat="server"  
                            RepeatColumns="2"  >
                            <asp:ListItem Value="True">Positive</asp:ListItem>
                        <asp:ListItem Value="False">Negative</asp:ListItem>
                  </asp:RadioButtonList>                  </td>
            </tr>
                <tr>
                    <td align="right"  >
                        HIV :</td>
                    <td  >
                        <asp:RadioButtonList ID="RadioButtonList_HIV" runat="server"  
                            RepeatColumns="2" 
                             >
                            <asp:ListItem Value="True">Positive</asp:ListItem>
                        <asp:ListItem Value="False">Negative</asp:ListItem>
                  </asp:RadioButtonList>                  </td>
            </tr>
                <tr>
                    <td align="right"  >
                        VDRL:</td>
                    <td  >
                        <asp:RadioButtonList ID="RadioButtonList_HIV0" runat="server"  
                            RepeatColumns="2" 
                           >
                            <asp:ListItem Value="True">Positive</asp:ListItem>
                        <asp:ListItem Value="False">Negative</asp:ListItem>
                  </asp:RadioButtonList>                  </td>
            </tr>
                <tr>
                    <td align="right"  >
                        MALARIAL PARASITE:</td>
                    <td  >
                        <asp:RadioButtonList ID="RadioButtonList_HIV1" runat="server"  
                            RepeatColumns="2" 
                            >
                            <asp:ListItem Value="True">Positive</asp:ListItem>
                        <asp:ListItem Value="False">Negative</asp:ListItem>
                  </asp:RadioButtonList>                  </td>
            </tr>
                <tr>
                  <td align="right"  >&nbsp;</td>
                  <td  ><asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" /></td>
                </tr>
  </table></div>
    &nbsp;&nbsp;
<br />
<br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Bags" CssClass="text_boxtitle" Width="154px">
            </asp:GridView>
            <asp:HiddenField ID="HiddenField_bag_no" runat="server" />
            <asp:HiddenField ID="HiddenField_VisitNo" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_Bags" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="INSERT INTO Donor_Transfusion_Detail(Patient_Registration_No, BloodRequest_Id, Emp_Id, Dept_Id, Date_Time, Bag_No) VALUES ('Find +ve', 0, 0, 0, GETDATE(), @Bag_No)"
                ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>" SelectCommand="SELECT Bag_No FROM Blood_Donation WHERE (Donor_Registration_No = @Donor_Registration_No) AND (Donor_Visit_Id = @Donor_Visit_Id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_VisitNo" Name="Donor_Visit_Id" PropertyName="Value" />
                </SelectParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenField_bag_no" Name="Bag_No" PropertyName="Value" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField_Donor_Reg_No" runat="server" />
            <asp:HiddenField ID="HiddenField_emp_id" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource_insert_screening" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="INSERT INTO Donor_Screening_Component_Marked(Donor_Registration_No, Emp_Id, Date_Time, Hb, Hc, HIV, Visit_Id) VALUES (@Donor_Registration_No, @Emp_Id, GETDATE(), @Hb, @Hc, @HIV, @Visit_Id)"
                UpdateCommand="update Donor_Screening_Component_Marked set  Hb=@Hb, Hc=@Hc, HIV=@HIV where Visit_Id=@Visit_Id"
                ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                 <UpdateParameters>
           
                    <asp:ControlParameter ControlID="RadioButtonList_HB" Name="Hb" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="RadioButtonList_HC" Name="Hc" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="RadioButtonList_HIV" Name="HIV" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="HiddenField_VisitNo" Name="Visit_Id" PropertyName="Value" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                        PropertyName="Value" />
                    <asp:SessionParameter DefaultValue="" Name="Emp_Id" SessionField="Emp_Id" />
                    <asp:ControlParameter ControlID="RadioButtonList_HB" Name="Hb" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="RadioButtonList_HC" Name="Hc" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="RadioButtonList_HIV" Name="HIV" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="HiddenField_VisitNo" Name="Visit_Id" PropertyName="Value" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource_list" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="UPDATE Donor_Screening_Pointer SET Status = 1 WHERE (Donor_Registration_No = @Donor_Registration_No)"
                ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Donor_Screening_Pointer SET Status = 1 WHERE (Donor_Registration_No = @Donor_Registration_No) AND (Visit_Id = @Visit_Id)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                        PropertyName="Value" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_VisitNo" Name="Visit_Id" PropertyName="Value" />
                </UpdateParameters>
            </asp:SqlDataSource>
           
        
</asp:Content>   
        
        