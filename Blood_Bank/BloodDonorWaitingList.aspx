<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="BloodDonorWaitingList, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            <div class="bxmain inner_content" style="width:100%">
            <h2><span style="font-size: 20px !important">Blood Donor Waiting List</span></h2>
                </div>


<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1" DataKeyNames="Donor_Registration_No" DataSourceID="SqlDataSource_blood_waiting_List"
                
                PageSize="15" Width="100%" OnPreRender="GridView1_PreRender">
              <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />            
              <Columns>
              <asp:BoundField DataField="DonorName" HeaderText="DonorName" ReadOnly="True" SortExpression="DonorName" />
              <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
              <asp:BoundField DataField="RelationName" HeaderText="RelationName" ReadOnly="True"
                        SortExpression="RelationName" />
              <asp:BoundField DataField="Sample_No" HeaderText="Sample No" SortExpression="Sample_No" />
              <asp:BoundField DataField="BloodGroup" HeaderText="BloodGroup" ReadOnly="True" SortExpression="BloodGroup" />
              <asp:BoundField DataField="CrossMatch" HeaderText="CrossMatch" ReadOnly="True" SortExpression="CrossMatch" />
              <asp:BoundField DataField="Donor_Registration_No" HeaderText="Donor Registration"
                        ReadOnly="True" SortExpression="Donor_Registration_No" Visible="False" />
              <asp:HyperLinkField DataNavigateUrlFields="Donor_Registration_No,Visit_Id" DataNavigateUrlFormatString="donorbloodgroup.aspx?D_Reg_No={0}&amp;visitNo={1}"
                        Text="Blood Group" />
              <asp:HyperLinkField DataNavigateUrlFields="Donor_Registration_No,Visit_Id,Request_Id" DataNavigateUrlFormatString="Bloodtake.aspx?donorRegistrationid={0}&amp;Visit_Id={1}&amp;Request_Id={2}"
                        Text="Take Blood" />
              <asp:BoundField DataField="Hb" HeaderText="Hb" ReadOnly="True" SortExpression="Hb" />
              <asp:BoundField DataField="Hc" HeaderText="Hc" ReadOnly="True" SortExpression="Hc" />
              <asp:BoundField DataField="HIV" HeaderText="HIV" ReadOnly="True" SortExpression="HIV" />
              <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status" />
              <asp:BoundField DataField="Bag_No" SortExpression="Bag_No" Visible="False" />
              <asp:TemplateField>
                <ItemTemplate>
                  <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Bag_No", "{0}") %>' />
                </ItemTemplate>
              </asp:TemplateField>
                  <asp:HyperLinkField DataNavigateUrlFields="Donor_Registration_No" DataNavigateUrlFormatString="BloodScreeningMark.aspx?Donor_Reg_No={0}"
                      Text="Screening" />
                  <asp:HyperLinkField DataNavigateUrlFields="Donor_Registration_No,Visit_Id" DataNavigateUrlFormatString="Blood_Collection.aspx?Donor_Reg_No={0}&amp;Visit_No={1}"
                      DataTextField="Decision" />
              </Columns>
              <RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />
   
</asp:GridView>
              <asp:SqlDataSource ID="SqlDataSource_blood_waiting_List" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="BloodBank_Donor_Waiting_List" SelectCommandType="StoredProcedure" InsertCommand="INSERT INTO Donor_Transfusion_Detail(Patient_Registration_No, BloodRequest_Id, Emp_Id, Dept_Id, Date_Time, Bag_No) VALUES ('Find' + 've', 0, 0, 0, GETDATE(), @Bag_No)" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                <InsertParameters>
                  <asp:ControlParameter ControlID="HiddenField_bag_no" Name="Bag_No" PropertyName="Value" />
                </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_bag_no" runat="server" />
              
              
              
<br />
<br />
  </asp:Content>