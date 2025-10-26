<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Approved_Report_Status.aspx.cs" Inherits="Pathology_Approved_Report_Status" %>
<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .style1
    {
        width: 482px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager> 

      <div class="bxmain inner_content" style="width:100%">
           <h2><span>View Lab History </span></h2>

<table class="bxmain">
        <tr>
            <td align="right" class="style1"> 
    
   
    
                <strong>MR #:&nbsp;</strong></td>
            <td>
                <asp:TextBox ID="Tb_regno" runat="server" AutoPostBack="True" 
                    ontextchanged="Tb_regno_TextChanged"></asp:TextBox>
                <asp:HiddenField ID="HiddenField_reg_NO" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1"> 
    
   
    
                <strong>Patient Name:</strong></td>
            <td>
                <asp:TextBox ID="TextBox_PFname" runat="server" 
                    ontextchanged="TextBox_PFname_TextChanged" AutoPostBack="True"></asp:TextBox>
                <asp:HiddenField ID="HiddenField_Pfname" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1"> 
    
   
    
                <strong>Sample No:</strong></td>
            <td>
                <asp:TextBox ID="TextBox_sample" runat="server" 
                    ontextchanged="TextBox_sample_TextChanged" AutoPostBack="True"></asp:TextBox>
                <asp:HiddenField ID="HiddenField_sample" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1"><strong>Start Date :</strong></td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" 
                            CssClass="drop_date" Width="200px">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                <asp:HiddenField ID="HiddenField_start" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="right" class="style1"><strong>End Date:</strong></td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_End_Date0" runat="server" 
                            CssClass="drop_date" Width="200px">
                            <AutoPostBack ValueChanged="True" />
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                <asp:HiddenField ID="HiddenField_End" runat="server" />
            </td>
        </tr>
    </table>

         
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
    
    <asp:Button ID="Button1" runat="server" Text="Search" onclick="Button1_Click" />
    <asp:Button ID="Report" runat="server" Text="Report" 
    onclick="Report_Click"  Visible="false"   />
          </div>
    <asp:GridView ID="GridView1" runat="server" 
        
        AutoGenerateColumns="False" onprerender="GridView1_PreRender" 
    DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="50" Width="100%" 
        >
        <Columns>
            <asp:TemplateField HeaderText="RegNo" SortExpression="RegNo">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("RegNo") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" ></asp:Label>
                    <asp:HiddenField ID="HiddenField_Enc_RegNo" value='<%# Bind("RegNo") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="PatientFname" SortExpression="PatientFname">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PatientFname") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("PatientFname") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField_PFNAME" runat="server" 
                        Value='<%# Bind("PatientFname") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" 
                SortExpression="YearlyNo" />
            
            <asp:BoundField DataField="Sample_No" HeaderText="Sample No" 
                SortExpression="Sample_No" />
                 <asp:BoundField DataField="TB_Name" HeaderText=" Test Name" 
                SortExpression="TB_Name" />
            <asp:BoundField DataField="trDate" HeaderText="Test Result Date" 
                SortExpression="trDate" />
            
            <asp:BoundField DataField="Approved_By" HeaderText="Approved By" 
                SortExpression="Approved_By" Visible="false" />
            
             <asp:BoundField DataField="EFName" HeaderText="Approved By" 
                SortExpression="EFName" />
            <asp:BoundField DataField="Status" HeaderText="StatusID" 
                SortExpression="Status" Visible="false" />
            
            <asp:BoundField DataField="Status1" HeaderText="Status" 
                SortExpression="Status1" Visible="False" />
            
           
            
        </Columns>
    
    </asp:GridView>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>" 
        SelectCommand="usp_Approved_Employee_Record" 
        CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure" 
    >
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_reg_NO" Name="Regno" 
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_start" Name="startDate" 
                PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_End" Name="EndDate" 
                PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_sample" Name="sampleNo" 
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Pfname" Name="PFName" 
                PropertyName="Value" Type="String" />
       </SelectParameters> 
    </asp:SqlDataSource>
    
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
</rsweb:ReportViewer>
    
    </asp:Content>

