<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Non_Returnable_Gate_Pass, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Non Returnable Gate Pass</span></h2>
        <table class="style1">
            <tr>
                <td align="center" colspan="4">
                    <asp:Label ID="lblMsg" Font-Bold="true" ForeColor="Red" runat="server" 
                    Text="Please Enter No. And Date." Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>GP Date:&nbsp;
                </strong>
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_date" runat="server" Width="300px" 
                        Height="30px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                </igsch:WebDateChooser>
                </td>
                <td align="right">
                    <strong>GP No:</strong></td>
                <td>
                    <asp:TextBox ID="TextBox_No" runat="server" Width="300px" Height="30px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>Reference No:
                </strong>
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Name_Supplier" runat="server" Width="300px" 
                        Height="30px"></asp:TextBox>
                </td>
                <td align="right">
                    <b style="mso-bidi-font-weight:normal"><span>Transporter</span></b><strong>:
                </strong>
                </td>
                <td>
                    <asp:TextBox ID="TextBoxThrough" runat="server" Width="300px" Height="30px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong><b style="mso-bidi-font-weight:normal"><span>Vehicle</span></b> No:</strong>
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Vehicle_No" runat="server" Width="300px" Height="30px"></asp:TextBox>
                </td>
                <td align="right">
                    <strong>From:
                </strong>
                </td>
                <td>
                    <asp:TextBox ID="TextBox_TR_No" runat="server" Width="300px" Height="30px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>To: </strong>
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Ch_For_Rs" runat="server" Width="300px" Height="30px"></asp:TextBox>
                </td>
                <td align="right">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="right">
                    <strong>Reason: </strong>
                </td>
                <td colspan="3">
                    <asp:TextBox ID="TextBox_Ch_For_Rs0" runat="server" Width="100%" Height="30px"></asp:TextBox>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnsave" runat="server" Text="Save" Width="100px" 
                        Font-Bold="True" Font-Italic="False" onclick="btnsave_Click" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <asp:GridView ID="Outward_Gate_Pass_Info" runat="server" Width="100%" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="RowNumber" HeaderText="Sr. #" ItemStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" />

            <asp:TemplateField HeaderText="Item Code" >
                <HeaderStyle Width="20%" />
                <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                <ItemTemplate>
                    <asp:TextBox ID="tbxItemCode" runat="server" Text="" Width="200px" Height="25px"></asp:TextBox>
                </ItemTemplate>



            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description and Size" >
                <HeaderStyle Width="65%" />
                <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                <ItemTemplate>
                    <asp:TextBox ID="tbxDescription" runat="server" Text="" Width="550px" Height="25px"></asp:TextBox>
                </ItemTemplate>


            </asp:TemplateField>
            <asp:TemplateField HeaderText="Quantity">
            <HeaderStyle Width="15%"  Font-Bold="true" />
            <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:TextBox ID="tbxqty" runat="server" Text="" Width="100px" Height="25px"></asp:TextBox>
                </ItemTemplate>


            </asp:TemplateField>
             <asp:TemplateField HeaderText="UOM">
            <HeaderStyle Width="15%"  Font-Bold="true" />
            <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:TextBox ID="tbxUOM" runat="server" Text="" Width="100px" Height="25px"></asp:TextBox>
                </ItemTemplate>


            </asp:TemplateField>
            <asp:TemplateField HeaderText="Unit(s)">
            <HeaderStyle Width="15%"  Font-Bold="true" />
            <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:TextBox ID="tbxunit" runat="server" Text="" Width="100px" Height="25px"></asp:TextBox>
                </ItemTemplate>


            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div style="float: right;">
        <asp:Button Font-Bold="true" ID="btnaddrow" runat="server" Text="Add New Row" OnClick="btnaddrow_Click"  /></div>
    <asp:SqlDataSource ID="sdsOutGatePass_Main" runat="server"
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="Outward_Gate_Pass" InsertCommandType="StoredProcedure" oninserted="sdsOutGatePass_Main_Inserted"
    >
        <InsertParameters>
            <asp:Parameter Name="Gate_PassDate" Type="DateTime" />
            <asp:ControlParameter ControlID="TextBox_No" Name="G_PassNO" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Name_Supplier" Name="ReferenceNo" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBoxThrough" Name="Transporter" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Vehicle_No" Name="Vehicle_No" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_TR_No" Name="Trv_From" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Ch_For_Rs" Name="Trv_To" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Ch_For_Rs0" Name="Reason" PropertyName="Text" Type="String" />
           <asp:Parameter Direction="InputOutput" Name="GP_ID" Type="Int32" />
            <asp:ControlParameter ControlID="HF_Type" Name="Type" PropertyName="Value" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="sdsOutGatePss_Sub" runat="server"
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="usp_Insert_Out_GatePass_Sub" InsertCommandType="StoredProcedure"
    >
         <InsertParameters>
             <asp:Parameter Name="Sr_No" Type="Int32" />
             <asp:Parameter Name="Description" Type="String" />
             <asp:Parameter Name="Unit" Type="String" />
             <asp:Parameter Name="Qty" Type="String" />
             <asp:Parameter Name="Remarks" Type="String" />
             <asp:ControlParameter ControlID="GatePass_Main_ID" Name="Gate_Pass_Main_ID" 
                 PropertyName="Value" Type="Int32" />
             <asp:Parameter Name="ItemCode" Type="String" />
         </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="GatePass_Main_ID" runat="server" />

    <br />
    <asp:HiddenField ID="HF_Type" runat="server" value="Non Returnable"/>

</asp:Content>

