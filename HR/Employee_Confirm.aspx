<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_Employee_confirm, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style2
        {
            height: 24px;
            width: 436px;
        }
        .style3
        {
            text-align: right;
            height: 24px;
            width: 146px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain" >
        <h1 style="color: #0048A0;font-family: Calibri; font-size: medium;font-weight: bold; text-shadow: 1px 1px 0 #FFFFFF;"> Employee Confirmation</h1>
    </div>
    <br />
    <div class="bxmain">
          <table class="diagnosis_list">
            <tr>
                <td class="style3">
                    Appointment Letter:
                </td>
                <td class="style2">
                    <asp:FileUpload ID="Apptletterupload" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style3">
                    Appointment Letter Date:
                </td>
                <td class="style2">
                    <igsch:WebDateChooser ID="Apptdatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:Label ID="lblapptdate" runat="server" Text=""></asp:Label>
                     </td>
            </tr>
            <tr>
                <td class="style3">
                    Confirmation Letter :
                </td>
                <td class="style2">
                    <asp:FileUpload ID="Confletterupload" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style3">
                    Confirmation Letter Date:
                </td>
                <td class="style2">
                    <igsch:WebDateChooser ID="Confdatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                       </igsch:WebDateChooser>
                       <asp:Label ID="lblconfdate" runat="server" Text=""></asp:Label>
                       </td>
                     </tr>
            <tr>
                <td class="style3">
                    Confirmed:
                </td>
                <td class="style2">
                    <asp:CheckBox ID="confirmedchkbox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style3">
                    Remarks:
                </td>
                <td class="style2">
                    <asp:TextBox ID="Remarksbox" runat="server" Height="50px" TextMode="MultiLine" Width="500px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp
                </td>
                <td class="style2">
                    <asp:Button ID="Savebttn" Text="Save" runat="server" OnClick="Savebttn_Click" />
                    <asp:Label ID="lblAttachfile" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
   
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="usp_Empconfirm" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM Employee_Confirmed_info where Emp_Id = @Emp_Id "
        OnSelecting="SqlDataSource1_Selecting">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="Emp_Id" Type="Int32" />
            <asp:Parameter Name="Appt_Letter_Date" Type="DateTime" />
            <asp:Parameter Name="Appt_Letter_File_Name" Type="String" />
            <asp:Parameter Name="Appt_Letter_path" Type="String" />
            <asp:Parameter Name="Conf_Letter_Date" Type="DateTime" />
            <asp:Parameter Name="Conf_Letter_File_Name" Type="String" />
            <asp:Parameter Name="Conf_Letter_Path" Type="String" />
            <asp:Parameter Name="Remarks" Type="String" />
            <asp:Parameter Name="Is_Confirmed" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="Emp_Id" QueryStringField="empid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" EmptyDataText="No Record Found "
        DataKeyNames="Confirmed_Employee" DataSourceID="SqlDataSource1" Width="100%">
        <Columns>
            <asp:BoundField DataField="Confirmed_Employee" HeaderText="Confirmed Employee" InsertVisible="False"
                ReadOnly="True" Visible="false" SortExpression="Confirmed_Employee" />
            <asp:BoundField DataField="Emp_Id" HeaderText="Employee Id" SortExpression="Emp_Id" />
            <asp:BoundField DataField="Appt_Letter_Date" HeaderText="Appointment Letter Date"
                SortExpression="Appt_Letter_Date" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl='<%# Eval("Appt_Letter_Path") %>'
                        Text='<%#Eval("Appt_Letter_File_Name") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%-- <asp:BoundField DataField="Appt_Letter_File_Name" 
                HeaderText="Appt. Letter File Name" SortExpression="Appt_Letter_File_Name" />--%>
            <%--<asp:BoundField DataField="Appt_Letter_Path"  HeaderText="Appt. Letter Path" 
                SortExpression="Appt_Letter_Path" />--%>
            <asp:BoundField DataField="Conf_Letter_Date" HeaderText="Confirmation Letter Date"
                SortExpression="Conf_Letter_Date" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink runat="server" Target="_blank" NavigateUrl='<%# Eval("Conf_Letter_Path") %>'
                        Text='<%#Eval("Conf_Letter_File_Name") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <%--<asp:BoundField DataField="Conf_Letter_Path" HeaderText="Conf. Letter Path" 
                SortExpression="Conf_Letter_Path" />--%>
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
            <asp:CheckBoxField DataField="Is_Confirmed" HeaderText="Is Confirmed" SortExpression="Is_Confirmed" />
        </Columns>
    </asp:GridView>
</asp:Content>
