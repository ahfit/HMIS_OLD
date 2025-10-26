<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Stock_Expiry_Status.aspx.cs" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Blood_Bank_Stock_Expiry_Status" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="inner_content" style="width: 100%; text-align: center !important">
        <h2 style="font-size: 17px">Stock Detail
        </h2>
    </div>
    <fieldset>
        <legend>Search Criteria</legend>
    <div class="bxmain inner_content " style="width: 100%">

        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
            <tr>
                <td width="40%" align="right">Blood Group :
                </td>

                <td>
                    <asp:DropDownList ID="DropDownList_BG" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_BG"
                        DataTextField="BG" DataValueField="Blood_Group_Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_BG" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        SelectCommand="SELECT Blood_Group_Id, ISNULL(Group_Name, '') + ISNULL(Rh_Factor, '') AS BG FROM Blood_Group"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Component :
                </td>

                <td>
                    <asp:DropDownList ID="DropDownList_COMP" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_COMP"
                        DataTextField="Component_Name" DataValueField="Component_id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_COMP" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        SelectCommand="SELECT [Component_id], [Component_Name] FROM [Blood_Component]"></asp:SqlDataSource>

                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnreport" Text="Showreport" OnClick="btnreport_Click" runat="server" />
                </td>
            </tr>
        </table>

    </div>
    </fieldset>
    <br />


     <asp:Panel ID="panelRemarks" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline;  width: 50%;" class="bxmain inner_content">

             
                <table style="margin: 10px; line-height: 2; ">


                    <tr>
                <td class="label_text">
                    Remarks :
                </td>
                <td style="margin-left:25px">
                           <asp:TextBox TextMode="MultiLine" runat="server" ID="txtRemarks" Width="250px" Height="150px" ></asp:TextBox>
                        </td>
                    </tr>
                      <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="Button1" runat="server"  Text="Save" OnClick="Button1_Click"    />
                    <asp:Button ID="Button2" Text="Close" runat="server" OnClick="Button2_Click"/>
                    <asp:Label ID="Label3" runat="server" Visible="false" Text="Save Successfully...." ForeColor="Green"></asp:Label>
                </td>
            </tr>


                    </table>
                </div>
            </div>
         </asp:Panel>

         <asp:Panel ID="panel" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline;  width: 50%;" class="bxmain inner_content">

             
                <table style="margin: 10px; line-height: 2; ">


                    <tr>
                <td class="label_text">
                    Convert to :
                </td>
                <td style="margin-left:25px">
                            <asp:DropDownList runat="server" Width="200px" ID="ddl_Component" AutoPostBack="true"></asp:DropDownList>
                            
                        </td>
                    </tr>
                      <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnSave" runat="server"  Text="Save" OnClick="btnSave_Click"    />
                    <asp:Button ID="btnclose" Text="Close" runat="server" OnClick="btnclose_Click" />
                    <asp:Label ID="lblsaveReason" runat="server" Visible="false" Text="Save Successfully...." ForeColor="Green"></asp:Label>
                </td>
            </tr>


                    </table>
                </div>
            </div>
         </asp:Panel>


    <asp:HiddenField ID="hfdDisposeID" runat="server" />
    <asp:GridView ID="GridView_ExpiryStatus" runat="server" AutoGenerateColumns="False"
        DataKeyNames="Product_Formation_Id" DataSourceID="SqlDataSource_ExpiryStatus" OnPreRender="GridView_ExpiryStatus_PreRender" CssClass="Grid_1" Width="100%">
        <Columns>
            <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
            <asp:BoundField DataField="Bag_Name" HeaderText="Type" SortExpression="Bag_Name" />
            <asp:BoundField DataField="Product_Qty" HeaderText="Quantity (ML)" SortExpression="Product_Qty" />
            <asp:BoundField DataField="Product_Formation_Status" HeaderText="Availability" SortExpression="Product_Formation_Status" />
            <asp:BoundField DataField="Formation_DateTime" HeaderText="Formation Date &amp; Time" SortExpression="Formation_DateTime" />
            <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry Date &amp; Time" SortExpression="Expiry_DateTime" />
            <asp:BoundField DataField="BG" HeaderText="Blood Group" ReadOnly="True" SortExpression="BG" />
            <asp:BoundField DataField="Component_Name" HeaderText="Component" SortExpression="Component_Name" />
            <asp:BoundField DataField="Expiry_Days" HeaderText="Component Life(Days)" SortExpression="Expiry_Days" />
            <asp:TemplateField HeaderText="Warning Level (Hours)" SortExpression="Warning_Level">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Warning_Level") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>

                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label_NA1" runat="server" Text='<%# Eval("Warning_Level", "Warning: {0} Hour(s)") %>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label_WHL" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                    <br />
                    <asp:HiddenField ID="HiddenField_WL" runat="server" Value='<%# Eval("Warning_Level") %>' />
                    <asp:HiddenField ID="HiddenField_ExpDate" runat="server" Value='<%# Eval("Expiry_DateTime", "{0:G}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Critical Level (Hours)" SortExpression="Critical_Level">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Critical_Level") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>

                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label_NA2" runat="server" Text='<%# Eval("Warning_Level", "Critical Time: {0} Hour(s)") %>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label_CHL" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="HiddenField_CL" runat="server" Value='<%# Eval("Critical_Level") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Critical Level (Hours)" SortExpression="Critical_Level">
              
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtn_Dispose" runat="server" CommandArgument='<%# Eval("Product_Formation_Id") %>' OnClick="lnkbtn_Dispose_Click" text="Dispose"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
               <asp:TemplateField HeaderText="Blood Conversion" >              
                <ItemTemplate>
                    <asp:LinkButton ID="lnkbtn_Conversion" runat="server" CommandArgument='<%# Eval("Product_Formation_Id") %>'    text="Convert" OnClick="lnkbtn_Conversion_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_ExpiryStatus" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
        SelectCommand="Stock_Expiry_Status_Optimize" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_BG" Name="BG" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_COMP" Name="Component_Name" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:QueryStringParameter Name="Status" QueryStringField="status" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server"></rsweb:ReportViewer>


    <br />
</asp:Content>
