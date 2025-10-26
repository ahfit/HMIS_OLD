<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Admin_shift.aspx.vb" Inherits="Administrator_Admin_shift" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <div><h2><span>Add Shift</span></h2></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1"
            onclick="return TABLE1_onclick()">
            <tr>
                <td align="right" width="40%">
                    Shift Name :
                </td>
                <td width="60%">
                    <asp:TextBox ID="TextBoxShiftName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Shift Description :
                </td>
                <td>
                    <asp:TextBox ID="TextBoxDescription" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Abberivation :
                </td>
                <td>
                    <asp:TextBox ID="TextBoxAbb" runat="server"></asp:TextBox>
                </td>
            </tr>
             <%--<tr>
                <td align="right">
                    Next Day(Night Shift):
                </td>
                <td>
                    <asp:CheckBox ID="CKNightSHift" runat="server" />
                </td>
            </tr>--%>
            <tr>
                    <td align="right">
                      Start Time :</td>
                    <td >
                        <igtxt:webdatetimeedit id="WebDateTimeEditStartTime" runat="server" displaymodeformat="t"
                            editmodeformat="t" nullable="False"  ></igtxt:webdatetimeedit>                                        </td>
                </tr>
            <tr>
                    <td align="right">
                      End Time :</td>
                    <td >
                        <igtxt:webdatetimeedit id="WebDateTimeEdit1" runat="server" displaymodeformat="t"
                            editmodeformat="t" nullable="False"  ></igtxt:webdatetimeedit>                                        </td>
                </tr>
            <tr>
                <td align="right" style="width: 375px; height: 24px;">
                    Time Relaxation :&nbsp; <%--</strong>--%>
                </td>
                <td style="height: 24px">
                    <asp:DropDownList ID="DDLRelaxationTime" runat="server" Width="200px" Css  AutoPostBack="True">
                        <asp:ListItem Value="0">0</asp:ListItem>
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                        <asp:ListItem Value="5">5</asp:ListItem>
                        <asp:ListItem Value="6">6</asp:ListItem>
                        <asp:ListItem Value="7">7</asp:ListItem>
                        <asp:ListItem Value="8">8</asp:ListItem>
                        <asp:ListItem Value="9">9</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="11">11</asp:ListItem>
                        <asp:ListItem Value="12">12</asp:ListItem>
                        <asp:ListItem Value="13">13</asp:ListItem>
                        <asp:ListItem Value="14">14</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="16">16</asp:ListItem>
                        <asp:ListItem Value="17">17</asp:ListItem>
                        <asp:ListItem Value="18">18</asp:ListItem>
                        <asp:ListItem Value="19">19</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="21">21</asp:ListItem>
                        <asp:ListItem Value="22">22</asp:ListItem>
                        <asp:ListItem Value="23">23</asp:ListItem>
                        <asp:ListItem Value="24">24</asp:ListItem>
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="26">26</asp:ListItem>
                        <asp:ListItem Value="27">27</asp:ListItem>
                        <asp:ListItem Value="28">28</asp:ListItem>
                        <asp:ListItem Value="29">29</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>

                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="BtnSave" runat="server" Text="Save" />
                    <asp:Label runat="server" ID="lblMsg"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceShift"
        CssClass="Grid_1" Width="100%" DataKeyNames="ShiftID">
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    Serial No.</HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSRNO" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ShiftID" HeaderText="ShiftID" SortExpression="ShiftID"
                Visible="False" />
            <asp:BoundField DataField="ShiftName" HeaderText="ShiftName" SortExpression="ShiftName" />
            <asp:BoundField DataField="Abberivation" HeaderText="Abberivation" SortExpression="Abberivation" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="RelaxationTime" HeaderText="Relaxation Time" SortExpression="RelaxationTime" />
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceShift" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT ShiftID, ShiftName, Abberivation, Description,RelaxationTime FROM Admin_Shift"
        InsertCommand="CreateShift" InsertCommandType ="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        DeleteCommand="DELETE FROM Admin_Shift
WHERE     (ShiftID = @ShiftID)" UpdateCommand="UPDATE    Admin_Shift
SET              ShiftName = @ShiftName, Abberivation = @Abberivation, Description = @Description,RelaxationTime=@RelaxationTime
WHERE     (ShiftID = @ShiftID)">
        <DeleteParameters>
            <asp:Parameter Name="ShiftID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ShiftName" />
            <asp:Parameter Name="Abberivation" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="RelaxationTime" />
            <asp:Parameter Name="ShiftID" />
            
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxShiftName" Name="ShiftName" PropertyName="Text" />
            <asp:ControlParameter ControlID="DDLRelaxationTime" Name="RT" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBoxDescription" Name="Description" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBoxAbb" Name="Abberivation" PropertyName="Text" />
            <asp:ControlParameter ControlID="WebDateTimeEditStartTime" Name="Stime" PropertyName="Text" />
            <asp:ControlParameter ControlID="WebDateTimeEdit1" Name="Etime" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <br />
</asp:Content>
