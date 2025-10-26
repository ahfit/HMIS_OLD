<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="New_Advertisement.aspx.cs" Inherits="HR_Advertisement_New_Advertisement" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 40%;
            text-align: right;
        }

        .style2 {
            width: 60%;
            text-align: left;
        }

        .Panelstyle1 {
            width: 22%;
            text-align: right;
        }

        .Panelstyle2 {
            width: 22%;
            text-align: left;
        }
    </style>
    <script type="text/javascript">
        function PanelAddPosts() {
            $("[id$='PanelAddPosts']").toggle();

        }
        function PanelQuotaPosts() {
            $("[id$='PanelQuotaPosts']").toggle();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>New Advertisement</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td class="style1">Title</td>
                <td class="style2">
                    <asp:TextBox runat="server" ID="txtTitle"></asp:TextBox>
                </td>
            </tr>
             <tr>
                <td class="style1">Advertisement No: </td>
                <td class="style2">
                    <asp:TextBox runat="server" ID="txtAdNo"></asp:TextBox>
                </td>
            </tr><tr>
                <td class="style1">From Date
                </td>
                <td class="style2">
                    <igsch:WebDateChooser ID="From_Date" runat="server" Width="200px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style1">To Date
                </td>
                <td class="style2">
                    <igsch:WebDateChooser ID="To_Date" runat="server" Width="200px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style1">Description</td>
                <td>
                    <asp:TextBox runat="server" ID="txtDescription" TextMode="MultiLine" Width="600px" Height="70px" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Add" ID="btnAdd" runat="server" OnClick="btnAdd_Click" />
                    <asp:Label ID="lblMsg" runat="server" />
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False"
            AllowPaging="True" PageSize="50" EmptyDataText="No Record(s) Found">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ad No">
                    <ItemTemplate>
                        <asp:Label ID="lblAdNo" ToolTip='<%# Bind("Ad_Id") %>' Text='<%# Bind("Ad_No") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Title">
                    <ItemTemplate>
                        <asp:Label ID="lblTitle" ToolTip='<%# Bind("Ad_Id") %>' Text='<%# Bind("Ad_Title") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <asp:TextBox ID="GridtxtDescription" Width="350px" Height="70px" Enabled="false" Text='<%# Bind("Description") %>' TextMode="MultiLine" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Start Date">
                    <ItemTemplate>
                        <asp:Label ID="GridlblStart_Date" Text='<%# Bind("Start_Date") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField >
                <asp:TemplateField HeaderText="End Date">
                    <ItemTemplate>
                        <asp:Label ID="GridlblEnd_Date" Text='<%# Bind("End_Date") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton Text="Edit" CommandArgument='<%# Bind("Ad_Id") %>' runat="server" ID="lbtnEdit" OnClick="lbtnEdit_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton Text="Add Posts" CommandArgument='<%# Bind("Ad_Id") %>' runat="server" ID="lbtnAddPosts" OnClick="lbtnAddPosts_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton Text="Add Quota for Posts" CommandArgument='<%# Bind("Ad_Id") %>' runat="server" ID="lbtnAddQuota" OnClick="lbtnAddQuota_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField Text="Report" DataNavigateUrlFields="Ad_Id" Target="_blank" DataNavigateUrlFormatString="~/HR/Advertisement_Report.aspx?Id={0}" />
            </Columns>
        </asp:GridView>

    </div>
    <asp:Panel runat="server" ID="PanelAddPosts" Visible="False"  Width="">
        <div class="bxmain inner_content" style="width: 800px">
            <h2>
                <span>Advertisement Posts</span></h2>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td class="Panelstyle1">Title</td>
                    <td class="Panelstyle2">
                        <asp:TextBox runat="server" ID="txtPostsTitle"></asp:TextBox>
                    </td>
                    <td class="Panelstyle1">Total Posts
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox ID="txtPosts" runat="server" TextMode="Number" />
                    </td>
                </tr>
                <tr>
                    <td class="Panelstyle1">Pay Scale
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox ID="txtPayScale" runat="server" TextMode="Number" />
                    </td>
                    <td class="Panelstyle1">Description</td>
                    <td>
                        <asp:TextBox runat="server" ID="txtPostsDescription" TextMode="MultiLine" Width="200px" Height="70px" />
                    </td>
                </tr>
                <tr>
                    <td class="Panelstyle1">Qualification
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox runat="server" ID="txtPostQualification" TextMode="MultiLine" Width="200px" Height="70px" />

                    </td>
                    <td class="Panelstyle1">Experience(in Year)</td>
                    <td>
                        <asp:TextBox runat="server" placeholder="Numeric Value" ID="txtPostExperience" TextMode="Number" Width="200px"  />
                    </td>
                </tr>
                <tr>
                <td class="Panelstyle1">Age From
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox placeholder="Numeric Value" runat="server" ID="txtboxUnderAge" TextMode="Number" Width="100px"  />

                    </td>
                    <td class="Panelstyle1">Age To
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox placeholder="Numeric Value" runat="server" ID="txtboxOverAge" TextMode="Number" Width="100px"  />

                    </td>
                    
                    <td class="Panelstyle1">Division</td>
                    <td>
                        <asp:TextBox runat="server" placeholder="Numeric Value" ID="txtboxDivision" TextMode="Number" Width="100px"  />
                    </td>
                </tr>
                <tr>
                
                <td class="Panelstyle1">Documnets Required
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox runat="server" ID="txtboxdocumentsrequired" TextMode="MultiLine" Width="200px" Height="70px" />

                    </td>
                </tr>
              
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button Text="Add" ID="btnAddPost" runat="server" OnClick="btnAddPost_Click" />
                        <asp:Label Text="Cancel" onClick="PanelAddPosts();" ForeColor="Blue" Font-Bold="true"
                             runat="server" />
                        <asp:Label ID="lblPostMsg" runat="server" />
                    </td>
                </tr>
            </table>
            <asp:GridView ID="GridViewPosts" runat="server" Width="100%" AutoGenerateColumns="False"
                AllowPaging="True" PageSize="50" EmptyDataText="No Record(s) Found">
                <Columns>
                    <asp:BoundField DataField="Ad_Sub_Id" HeaderText="ID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Posts" HeaderText="Posts" />
                    <asp:BoundField DataField="Pay_Scale" HeaderText="Pay Scale" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Qualification" HeaderText="Qualificaion" />
                    <asp:BoundField DataField="Experience" HeaderText="Experience" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton Text="Delete" CommandArgument='<%# Bind("Ad_Sub_Id") %>' runat="server" ID="lbtnDeletePosts" OnClick="lbtnDeletePosts_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="PanelQuotaPosts" Visible="false" CssClass="lightbox" Width="">
        <div class="bxmain inner_content" style="width: 800px">
            <h2>
                <span>Quota Posts</span></h2>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                <tr>
                    <td class="Panelstyle1">Select Post</td>
                    <td class="Panelstyle2">
                        <asp:DropDownList ID="DDL_Posts" DataTextField="Title" DataValueField="Ad_Sub_Id" AutoPostBack="true" OnSelectedIndexChanged="DDL_Posts_SelectedIndexChanged" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td class="Panelstyle1">Total Post</td>
                    <td class="Panelstyle2">
                        <asp:DropDownList ID="DDL_Posts_Qty" DataTextField="Posts" DataValueField="Ad_Sub_Id" Enabled="false" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="Panelstyle1">Quota For
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox ID="txtQuotaFor" runat="server" />
                    </td>
                    <td class="Panelstyle1">Quota Posts
                    </td>
                    <td class="Panelstyle2">
                        <asp:TextBox ID="txtQuotaPosts" runat="server" TextMode="Number" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button Text="Add" ID="btnAddQuotaPosts" runat="server" OnClick="btnAddQuotaPosts_Click" />
                        <asp:Label Text="Cancel" onClick="PanelQuotaPosts();" runat="server" ForeColor="Blue" Font-Bold="true" />
                        <asp:Label ID="lblQuotaMsg" runat="server" />
                    </td>
                </tr>
            </table>
            <asp:GridView ID="GridViewQuotaPosts" runat="server" Width="100%" AutoGenerateColumns="False"
                AllowPaging="True" PageSize="50" EmptyDataText="No Record(s) Found">
                <Columns>
                    <asp:BoundField DataField="Post_Quota_Id" HeaderText="ID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Total_Posts" HeaderText="Total Posts" />
                    <asp:BoundField DataField="Post_For" HeaderText="Post For" />
                    <asp:BoundField DataField="Posts" HeaderText="Quota Posts" />

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton Text="Delete" CommandArgument='<%# Bind("Post_Quota_Id") %>' runat="server" ID="lbtnDeleteQuotaPosts" OnClick="lbtnDeleteQuotaPosts_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>
</asp:Content>
