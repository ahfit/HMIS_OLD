<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Degree_Program_workshopTraining, App_Web_03pfcqoi" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            height: 13px;
        }

        .hide_view {
            display: none;
        }

        .show_view {
        }

        .auto-style2 {
            height: 14px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table class="diagnosis_list">
        <tr>
            <td align="right" width="50%">&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">Training Type :
            </td>
            <td>
                <asp:DropDownList ID="DDL_Training_type" runat="server" AutoPostBack="True">
                </asp:DropDownList>

            </td>
        </tr>
        <tr>
            <td align="right" class="auto-style1" width="50%">Project Code :
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="txtProjectCode" runat="server" SkinID="captxt" Style="background-color: #f9dde2;"></asp:TextBox><span
                    style="font-size: 10pt; color: #d92542">*</span>

            </td>
        </tr>
        <tr>
            <td align="right" class="auto-style1" width="50%">Title :
            </td>
            <td class="auto-style1">
                <asp:TextBox ID="TXT_P_Name" runat="server" SkinID="captxt" TextMode="MultiLine" Height="50px" Style="background-color: #f9dde2;"></asp:TextBox><span
                    style="font-size: 10pt; color: #d92542">*</span>
                <%--<asp:RequiredFieldValidator ID="P_Name_Validator" runat="server" ErrorMessage="Must Enter project Name" Display="Dynamic"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>

        <tr>
            <td align="right" width="50%">Organized By:
            </td>
            <td>
                <asp:DropDownList ID="DDL_Organize_by" runat="server" DataSourceID="SDS_Fund_By" DataTextField="Party_Name"
                    DataValueField="Party_Id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SDS_Fund_By" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                    SelectCommand="SELECT Party_Id, Party_Name FROM Parties"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">Total Participants 
            </td>
            <td>
                <asp:TextBox ID="txtTotalParticipant" runat="server" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">Start date
            </td>
            <td>
                <asp:TextBox ID="TXT_S_date" runat="server" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" width="50%">End date
            </td>
            <td>
                <asp:TextBox ID="txt_traininEnd_Date" runat="server" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Button ID="BTN_Save" runat="server" Text="Save" Height="26px" OnClick="BTN_Save_Click" />
                <br />
                <asp:Label ID="LBL_MSG" runat="server" CssClass="alerts" ForeColor="Red" Width="108px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">&nbsp;
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:GridView ID="GVD_Data" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.#">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Project_Code" HeaderText="Project Type" SortExpression="Project_Code" />
                        <asp:BoundField DataField="Training_name" HeaderText="Project Name" SortExpression="Training_name" />
                        <asp:BoundField DataField="Project_name" HeaderText="Project Name" SortExpression="Project_name" />
                        <asp:BoundField DataField="Tota_Participant" HeaderText="Participant" SortExpression="Tota_Participant" />
                        <asp:BoundField DataField="Project_Start_Date" HeaderText="Start Date" SortExpression="Project_Start_Date" />
                        <asp:BoundField DataField="Project_End_Date" HeaderText="End Date" SortExpression="Project_End_Date" />
                        <asp:BoundField DataField="Party_Name" HeaderText="Organized By" SortExpression="Party_Name" />

                        <asp:TemplateField HeaderText="Add Participants">
                            <ItemTemplate>
                                <asp:LinkButton ID="LNK_add_Participants" runat="server" CssClass="add_icon" CommandArgument='<%# Eval("Project_Id") %>'
                                    OnClick="LNK_add_Participants_Click">ADD</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Add Guests">
                            <ItemTemplate>
                                <asp:LinkButton ID="LNK_add_Guests" runat="server" CssClass="add_icon" CommandArgument='<%# Eval("Project_Id") %>'
                                    OnClick="LNK_add_Guests_Click">ADD</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Add Theme">
                            <ItemTemplate>
                                <asp:LinkButton ID="LNK_add_Theme" runat="server" CssClass="add_icon" CommandArgument='<%# Eval("Project_Id") %>'
                                    OnClick="LNK_add_Theme_Click">ADD</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:HyperLinkField DataNavigateUrlFields="project_id" HeaderText="Participant Report"
                             DataNavigateUrlFormatString="~/Degree_Program/TrainingParticipantReport.aspx?P_Id={0}"
                            Target="_blank" Text="Participant Report">
                              </asp:HyperLinkField>
                        <asp:HyperLinkField DataNavigateUrlFields="project_id" HeaderText="Guest Report"
                             DataNavigateUrlFormatString="~/Degree_Program/Training_GuestReport.aspx?P_Id={0}"
                            Target="_blank" Text="Guest Report">
                           
                        </asp:HyperLinkField>
                        <asp:HyperLinkField DataNavigateUrlFields="project_id" Text="Project Detail" DataNavigateUrlFormatString="~/Degree_Program/ProjectWorkshopDetailReport.aspx?project_id={0}"
                            HeaderText="Project Detail" Target="_blank" />
                    </Columns>
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="SDS_Data" runat="server" ConnectionString="<%$ ConnectionStrings:Degree_programConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Degree_programConnectionString.ProviderName %>"
                    SelectCommand="SELECT Project_main.Project_Id, Project_main.Project_name, Project_main.Project_Type, Project_main.Organized_by, Project_main.Fund_Amount, Project_main.Project_Start_Date,Project_main.Project_Start_Date, P.Party_Name AS Funded_by FROM Project_main INNER JOIN BasicDataInfo.dbo.Parties AS P ON P.Party_Id = Project_main.Funded_by"
                    InsertCommand="INSERT INTO Project_main(Project_name, Project_Type, Organized_by, Funded_by, Fund_Amount, Project_Date, Enter_By, Entry_time) VALUES (@Project_name, @Project_Type, @Organized_by, @Funded_by, @Fund_Amount, @Project_Date, @Enter_By, GETDATE())">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="TXT_P_Name" Name="Project_name" PropertyName="Text" />
                        <asp:ControlParameter ControlID="TXT_P_Type" Name="Project_Type" PropertyName="Text" />
                        <asp:ControlParameter ControlID="TXT_Organized_by" Name="Organized_by" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DDL_Fund_by" Name="Funded_by" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="TXT_F_Amount" DefaultValue="0" Name="Fund_Amount"
                            PropertyName="Text" />
                        <asp:ControlParameter ControlID="TXT_O_date" Name="Project_Date" PropertyName="Text" />
                        <asp:SessionParameter Name="Enter_By" SessionField="emp_ID" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Panel ID="PanelAddParticipants" runat="server" Visible="false" CssClass="lightbox_bg">
                    <div class="lightbox">
                        <table>
                <tr>
                    <td colspan="2" align="center">
                        <span style="font-size: x-large; align-content: center">Add Participant</span>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style2" width="50%">Name :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txtP_Name" runat="server"
                            Style="background-color: #f9dde2;"></asp:TextBox><span style="font-size: 10pt; color: #d92542">*</span>
                    </td>
                    <td align="right" class="auto-style2" width="50%">CNIC :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txtP_CNIC" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                </tr>
                <tr>
              
                    <td align="right" width="50%">Designation :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="DDL_P_Designation" DataValueField="Training_Desig_Id" DataTextField="Training_Designation" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="right" class="auto-style2" width="50%">Facility :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txt_P_Facility" runat="server"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style2" width="50%">Contact No :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txt_P_Contact" runat="server" MaxLength="12"></asp:TextBox>
                    </td>
                    <td align="right" width="50%">District :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="DDL_P_District" DataValueField="DistrictCode" DataTextField="DistrictName" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Button ID="btnSaveParticipant" runat="server" Text="Save Participant" OnClick="btnSaveParticipant_Click" />
                        <asp:Button ID="btnSaveParticipantClose" runat="server" Text="Close" OnClick="btnSaveParticipantClose_Click" />
                        <asp:Label ID="lblMsgParticipant" runat="server" CssClass="alerts" ForeColor="Red" Width="146px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:GridView ID="GridView_Participant" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.#">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="P_Name" HeaderText="Name" SortExpression="P_Name" />
                                <asp:BoundField DataField="P_Cnic" HeaderText="CNIC" SortExpression="P_Cnic" />
                                
                                <asp:BoundField DataField="Training_Designation" HeaderText="Designation" SortExpression="Training_Designation" />
                                <asp:BoundField DataField="P_Facility" HeaderText="Facility" SortExpression="P_Facility" />
                                <asp:BoundField DataField="P_Contact_No" HeaderText="Contact" SortExpression="P_Contact_No" />
                                <asp:BoundField DataField="DistrictName" HeaderText="District/Agency" SortExpression="DistrictName" />

                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LNK_Delet_Participant" runat="server" Text="Delete" CommandArgument='<%# Eval("parcipantId") %>'
                                            OnClick="LNK_Delet_Participant_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="50%">&nbsp;
                    </td>
                    <td align="left">&nbsp;
                    </td>
                </tr>
            </table>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">&nbsp;
            </td>
        </tr>
    </table>
    <asp:Panel ID="Panel_Guests" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <table>
                <tr>
                    <td colspan="2" align="center">
                        <span style="font-size: x-large; align-content: center">Add Guests</span>
                    </td>
                </tr>
                <tr>
                    <td align="right" class="auto-style2" width="50%">Name :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txtGuestName" runat="server"
                            Style="background-color: #f9dde2;"></asp:TextBox><span style="font-size: 10pt; color: #d92542">*</span>
                    </td>
                    <td align="right" width="50%">Training Designation :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="DDL_Train_Desi" DataValueField="Training_Desig_Id" DataTextField="Training_Designation" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
              <td align="right" class="auto-style2" width="50%">Facility :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txtGuestfacility" runat="server"></asp:TextBox>

                    </td>
                    <td align="right" width="50%">Original Designation :
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="DDL_Guest_oDesi" DataValueField="Training_Desig_Id" DataTextField="Training_Designation" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                  
                    <td align="right" class="auto-style2" width="50%">CNIC :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txtGuestCnic" runat="server" MaxLength="15"></asp:TextBox>
                    </td>
                    <td align="right" class="auto-style2" width="50%">Contact No :
                    </td>
                    <td align="left" class="auto-style2">
                        <asp:TextBox ID="txtGuestContact" runat="server" MaxLength="12"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Button ID="btnSaveGuests" runat="server" Text="Save Guest" OnClick="btnSaveGuests_Click" />
                        <asp:Button ID="btnCloseGuestPanel" runat="server" Text="Close" OnClick="btnCloseGuestPanel_Click" />
                        <asp:Label ID="Label1" runat="server" CssClass="alerts" ForeColor="Red" Width="146px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:GridView ID="GridView_Guests" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.#">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Guest_Name" HeaderText="Name" SortExpression="Guest_Name" />
                                <asp:BoundField DataField="Train_Desi" HeaderText=" Training Designation" SortExpression="Train_Desi" />
                                <asp:BoundField DataField="Guest_CNIC" HeaderText="CNIC" SortExpression="Guest_CNIC" />
                                <asp:BoundField DataField="orig_Desi" HeaderText="Designation" SortExpression="orig_Desi" />
                                <asp:BoundField DataField="Guest_Facility" HeaderText="Facility" SortExpression="Guest_Facility" />
                                <asp:BoundField DataField="Guest_CNIC" HeaderText="CNIC" SortExpression="Guest_CNIC" />
                                <asp:BoundField DataField="Contact_No" HeaderText="Contact" SortExpression="Contact_No" />

                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LNK_Delete_Guest" runat="server" Text="Delete" CommandArgument='<%# Eval("workshop_guest_id") %>'
                                            OnClick="LNK_Del_guest_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="50%">&nbsp;
                    </td>
                    <td align="left">&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>


    <asp:Panel ID="Panel_Theme" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox" style="overflow: scroll;">
            <table width="100%" cellpadding="0" cellspacing="10">
                <tr>
                    <td colspan="2" align="center">
                        <span style="font-size: x-large; align-content: center">Add Contents & Detail</span>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="10%">Title :
                    </td>
                    <td align="left" width="90%">
                        <asp:TextBox ID="txtThemeTitle" runat="server" Style="background-color: #f9dde2;"></asp:TextBox><span style="font-size: 10pt;"></span>

                    </td>
                </tr>

                <tr>
                    <td align="right" width="10%" valign="top">Content Detail :
                    </td>
                    <td align="left" width="90%">
                        <asp:TextBox ID="txtThemeContent" TextMode="MultiLine" runat="server" AutoCompleteType="Disabled" Width="500px" Height="800px" BackColor="LightGray"></asp:TextBox><span
                            style="font-size: 10pt;"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="10%">Conclusion :
                    </td>
                    <td align="left" width="90%">
                        <asp:TextBox ID="txtThemeConclusion" runat="server" Height="53px" Width="500px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btnSaveTheme" runat="server" Text="Save Theme" OnClick="btnSaveTheme_Click" />
                        <asp:Button ID="btnCloseTheme" runat="server" Text="Close" OnClick="btnCloseTheme_Click" />
                        <asp:Label ID="Label2" runat="server" CssClass="alerts" ForeColor="Red" Width="146px"></asp:Label>
                    </td>
                </tr>


            </table>
        </div>
    </asp:Panel>

</asp:Content>
