<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="Donor_Search, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<div class="bxmain inner_content" style="width:100%">
    <h2><span style="font-size: 20px !important">Search Blood Donor</span></h2>
<table cellpadding="0" cellspacing="0" width="100%" border="0" class="tbl_form">
                    <tr>
                        <td width="25%" align="right"  >
                            Donor Registration No. :</td>
                        <td width="25%"  >
                    <asp:TextBox ID="TextBox_Donor_RegistrationNo" runat="server" CssClass="input_txt" Width="175px" ></asp:TextBox></td>
                        <td width="25%" align="right"  >
                            Telephone No. :</td>
                        <td width="25%"  >
                            <asp:TextBox ID="TextBox_TelephoneNo" runat="server" CssClass="input_txt" Width="175px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="right"  >
                           Status:  </td>
                        <td >

                         <asp:DropDownList ID="DropDownList_Status" runat="server" Width="178px" DataSourceID="SqlDataSource_Status" DataTextField="Status" DataValueField="Blood_Donor_Visit_Status_Id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>" SelectCommand="SELECT [Blood_Donor_Visit_Status_Id], [Status] FROM [Blood_Donor_Visit_Status]"></asp:SqlDataSource>
                    </td>
                        <td align="right">
                            Blood Group :</td>
                        <td>
                            <asp:DropDownList ID="DropDownList_BloodGroup" runat="server" DataSourceID="SqlDataSource_Group_Names"
                                DataTextField="Group_Name" DataValueField="Group_Name" Width="50px" OnSelectedIndexChanged="DropDownList_BloodGroup_SelectedIndexChanged">
                            </asp:DropDownList><asp:RadioButtonList ID="RadioButtonList_BloodGroup" runat="server" 
                                RepeatColumns="5" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                <asp:ListItem Selected="True"> </asp:ListItem>
                                <asp:ListItem>+</asp:ListItem>
                                <asp:ListItem>-</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
    <tr>
        <td align="right" style="display:none">
         Patient Registration :  </td>
        <td style="display:none">
           <asp:TextBox ID="TextBox_PatientRegistration" runat="server" CssClass="input_txt" Width="175px"></asp:TextBox>
        </td>
        <td align="right">
        </td>
        <td>
        </td>
    </tr>
                    <tr>
                        <td align="center" colspan="4">
                            <asp:Button ID="Button_Search" runat="server" OnClick="Button_Search_Click" Text="Search" /></td>
                    </tr>
                </table>
                </div>
                <br />
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                CssClass="Grid_1"
              
                PageSize="15" Width="100%" OnPreRender="GridView1_PreRender" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging">
              <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />            
              <HeaderStyle CssClass="GridHeader" />            
                <Columns>
                    <asp:BoundField DataField="Visit_Id" HeaderText="Visit #" SortExpression="Visit_Id" />
                    <asp:BoundField DataField="Donor #" HeaderText="Donor #" ReadOnly="True" SortExpression="Donor #" />
                    <asp:BoundField DataField="Bag #" HeaderText="Bag #" SortExpression="Bag #" />
                    <asp:BoundField DataField="Reg. Date" HeaderText="Reg. Date" SortExpression="Reg. Date" />
                    <asp:BoundField DataField="Donor Name" HeaderText="Donor Name" SortExpression="Donor Name" />
                    <asp:BoundField DataField="Sample_No" HeaderText="Sample_No" SortExpression="Sample_No" />
                    <asp:BoundField DataField="Patient Name" HeaderText="Patient Name" SortExpression="Patient Name" />
                    <asp:ButtonField CommandName="BloodGroup" DataTextField="Blood Group" HeaderText="Blood Group"
                        SortExpression="Blood Group" Text="Blood Group" />
                    <asp:BoundField DataField="Last Bleed" HeaderText="Last Bleed" SortExpression="Last Bleed" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                    <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                   <asp:TemplateField HeaderText="Assesment">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton_Assessment" runat="server" OnClick="LinkButton_Assessment_Click">Assesment</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Screening">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">Screening</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField SortExpression="Donor #" HeaderText="Report">
                        <ItemTemplate>
                            &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click">Report</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="New Visit" ShowHeader="False" SortExpression="New Visit">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server"
                                Text="New Visit" OnClick="LinkButton1_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

</asp:GridView>
              <asp:SqlDataSource ID="SqlDataSource_blood_waiting_List" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT     Donor_Detail.Donor_Registration_No AS [Donor #], Blood_Donation.Bag_No AS [Bag #], CONVERT(varchar, Donor_Detail.Date_Time, 103) AS [Reg. Date], &#13;&#10;                      Donor_Detail.Prefix + ' ' + Donor_Detail.First_Name + ' ' + ISNULL(Donor_Detail.Last_Name, '') &#13;&#10;                      + ' ' + Donor_Detail.Relation + ' ' + Donor_Detail.Relation_First_Name + ' ' + ISNULL(Donor_Detail.Relation_Last_Name, '') AS [Donor Name], &#13;&#10;                      Donor_Detail.Sample_No, ' ' AS [Patient Name], ISNULL(Donor_Blood_Group_Marked.Group_Name, '') + ' ' + ISNULL(Donor_Blood_Group_Marked.Rh_Factor, '') &#13;&#10;                      AS [Blood Group], CONVERT(varchar, Donor_Detail.Previous_Place, 103) AS [Last Bleed], Donor_Detail.Phone, Donor_Detail.Address, Donor_Detail.Age&#13;&#10;FROM         Donor_Detail LEFT OUTER JOIN&#13;&#10;                      Blood_Donation ON Donor_Detail.Donor_Registration_No = Blood_Donation.Donor_Registration_No LEFT OUTER JOIN&#13;&#10;                      Donor_Screening_Pointer ON Donor_Detail.Donor_Registration_No = Donor_Screening_Pointer.Donor_Registration_No LEFT OUTER JOIN&#13;&#10;                      Donor_Screening_Component_Marked ON Donor_Detail.Donor_Registration_No = Donor_Screening_Component_Marked.Donor_Registration_No LEFT OUTER JOIN&#13;&#10;                      Donor_Blood_Group_Marked ON Donor_Detail.Donor_Registration_No = Donor_Blood_Group_Marked.Donor_Registration_No" InsertCommand="INSERT INTO Donor_Transfusion_Detail(Patient_Registration_No, BloodRequest_Id, Emp_Id, Dept_Id, Date_Time, Bag_No) VALUES ('Find' + 've', 0, 0, 0, GETDATE(), @Bag_No)" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                <InsertParameters>
                  <asp:ControlParameter ControlID="HiddenField_bag_no" Name="Bag_No" PropertyName="Value" />
                </InsertParameters>
              </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenField_bag_no" runat="server" />
              
              <asp:SqlDataSource ID="SqlDataSource_Group_Names" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT [Group_Name] FROM [Blood_Group]"></asp:SqlDataSource>
<br />
  </asp:Content>