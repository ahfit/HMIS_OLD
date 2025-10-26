<%@ Page Language="VB" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="false" CodeFile="Cancel_Test.aspx.vb" Inherits="Pathology_Cancel_Test"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">
#nav {display:none;}

</style>

</asp:Content>





<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <asp:GridView ID="GridViewMain" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataKeyNames="TGID" DataSourceID="SqlDataSource_Status" Width="100%">
        <RowStyle CssClass="GridItem" />
        <Columns>
            <asp:BoundField DataField="TB_Name" HeaderText="Test" ReadOnly="True" SortExpression="TB_Name" />
            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Status" runat="server" DataSourceID="SqlDataSource_Status_Edit"
                        DataTextField="Status" DataValueField="Status_ID" Width="167px">
                    </asp:DropDownList><br />
                    <asp:SqlDataSource ID="SqlDataSource_Status_Edit" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Status, Status_ID FROM Test_Status WHERE (Status_ID = 3) OR (Status_ID = 5) OR (Status_ID = 9)">
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Bind("ID", "{0}") %>' />
                 
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField_Status" runat="server" Value='<%# Eval("Status_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Date_Time" HeaderText="Date Time" ReadOnly="True" SortExpression="Date_Time" />
            <asp:TemplateField HeaderText="Test Group Name" ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Select"
                        Text='<%# Eval("TGName") %>'></asp:LinkButton><br />
                    <asp:HiddenField ID="HiddenField6" runat="server" Value='<%# Eval("TGID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField7" runat="server" Value='<%# Eval("TGName", "{0}") %>' />
                    <asp:HiddenField ID="HiddenField8" runat="server" Value='<%# Eval("Main_ID", "{0}") %>' />
                    <asp:HiddenField ID="HiddenFieldTBID" runat="server" Value='<%# Bind("TB_ID", "{0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TGName" HeaderText="Test Group Name" ReadOnly="True" SortExpression="TGName"
                Visible="False" />
            <asp:BoundField DataField="Sample No." HeaderText="Sample No." ReadOnly="True" SortExpression="Sample No." Visible="False" />
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="INSERT INTO Lab_Status_Record(TB_ID, Order_ID, Status,Detail) VALUES (@TB_ID, @Order_ID, @Status,@Detail)"
        ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="pt_select_status"
        SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Test_Booking_Services SET Status = @Status WHERE (TB_ID = @TB_ID) and (Main_ID=@Main_ID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="RegNo" QueryStringField="Reg_No" />
            <asp:QueryStringParameter Name="YearlyNo" QueryStringField="YearlyNo" />
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
            <asp:QueryStringParameter DefaultValue="" Name="Status" QueryStringField="status_ID"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="DropDownList_status" Name="Status" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldMainID" Name="Main_ID" PropertyName="Value" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldMainID" Name="Order_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_status" Name="Status" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox_Remarks" Name="Detail" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <asp:HiddenField ID="HiddenField_TGID" runat="server" />
    <asp:HiddenField ID="HiddenFieldMainID" runat="server" />
    <asp:HiddenField ID="HiddenField_TBID" runat="server" />
    <br />
   
   
   
   
    <asp:Panel ID="Panel1" runat="server" Visible="False" Width="100%">
         <table  cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" >
                    Remarks :</td>
                <td >
                    <asp:TextBox ID="TextBox_Remarks" runat="server" Height="100px" Width="90%" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" >
                    Status :</td>
                <td >
                    <asp:DropDownList ID="DropDownList_status" runat="server" DataSourceID="SqlDataSource_Status1"
                        DataTextField="Status" DataValueField="Status_ID"  >
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td >
                </td>
                <td >
                    <asp:Button ID="Button_Save" runat="server" Text="Save" /></td>
            </tr>
        </table>
    </asp:Panel>
    <br />
 <asp:SqlDataSource ID="SqlDataSource_Status1" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        SelectCommand="SELECT Status_ID, Status FROM Test_Status WHERE (act_status = 1)"
        UpdateCommand="UPDATE Lab_Status_Record SET Detail = @detail WHERE (TB_ID = @TB_ID) AND (Order_ID = @Order_ID) AND (Status =3)" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
        <UpdateParameters>
            <asp:ControlParameter ControlID="TextBox_Remarks" Name="detail" PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenField_TBID" Name="TB_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldMainID" Name="Order_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

