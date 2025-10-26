<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PatientFeedBackReport.aspx.cs" Inherits="Pathology_LabTestSummaryReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content" style="width:100%">
           <h2><span>Patient Feedback Summary Report</span></h2>
                <table class="style1" style="margin-left:320px">
                  
                    <tr>
                       <%-- <td class="style2">
                           Department :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="True" onselectedindexchanged="ddlDepartment_SelectedIndexChanged" AppendDataBoundItems="true"
                                DataTextField="Dept_Name" DataValueField="Dept_ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>--%>
                        <td class="style2">
                          Department :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlSubDepartment" runat="server" AutoPostBack="True" onselectedindexchanged="ddlSubDepartment_SelectedIndexChanged" AppendDataBoundItems="true"
                                DataTextField="SubDept_Name" DataValueField="SubDept_ID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                   </tr>
                    <tr>
                        <td class="style2">
                            Employee :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlEmployee" runat="server" AutoPostBack="True"  AppendDataBoundItems="true"
                                DataTextField="EFName" DataValueField="EmpID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>

                    </tr>
                     <tr>
                        <td class="style2">
                            Starting Date :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="startDate" runat="server" 
                                Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                      <tr>
                        <td class="style2">
                            Ending Date :
                        </td>
                        <td>
                            <igsch:WebDateChooser ID="endDate" runat="server" 
                                Width="202px">
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser>
                        </td>
                    </tr>
                    <tr>
                      
                        <td></td>
                    <td colspan="2" align="center" style="padding-top:20px">
                        <asp:Button ID="btnSearch" OnClick="btnOpen_Click" runat="server" Text="Open"  
                             CssClass="btn_1" style="float:right"/>
                      </td>
                    </tr>
    </table>
    </div>
    <div style="width:100%; margin-top:20px;">
          <asp:GridView  CssClass="table table-striped table-bordered" ID="grdcode" runat="server" DataKeyNames="RegNo" OnSelectedIndexChanged="grdcode_SelectedIndexChanged" AutoGenerateColumns="False" AllowPaging="True" EmptyDataText="No record found." Width="100%" PageSize="25" >
         <Columns>
               <asp:BoundField HeaderText="Registration No" DataField="RegNo" />
                <asp:BoundField HeaderText="Patient Name" DataField="FullName" />
                <asp:BoundField HeaderText="Relation" DataField="Relation" />
                <asp:BoundField HeaderText="Relation Name" DataField="RFName" />
                <asp:BoundField HeaderText="Mobile Phone" DataField="MobilePhone" />
                <asp:BoundField HeaderText="Service Date" DataField="ServiceDate" />
               <asp:TemplateField HeaderText="Doctor Behavior" SortExpression="Status" ControlStyle-Width="80px" >
                    <ItemTemplate>
                   <asp:DropDownList ID="drBe" runat="server">
                        <asp:ListItem>Excellent</asp:ListItem>
                        <asp:ListItem>Good</asp:ListItem>
                       <asp:ListItem>Satisfactory</asp:ListItem>
                       <asp:ListItem>Bad</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>  
                </asp:TemplateField>
             <asp:TemplateField HeaderText="Recp. Behaviour" SortExpression="Status"  ControlStyle-Width="80px">
                    <ItemTemplate>
                   <asp:DropDownList ID="RecBe" runat="server">
                        <asp:ListItem>Excellent</asp:ListItem>
                        <asp:ListItem>Good</asp:ListItem>
                       <asp:ListItem>Satisfactory</asp:ListItem>
                       <asp:ListItem>Bad</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>  
                </asp:TemplateField>
             <asp:TemplateField HeaderText="Staff Behaviour" SortExpression="Status"  ControlStyle-Width="80px">
                    <ItemTemplate>
                   <asp:DropDownList ID="StaffBe" runat="server">
                        <asp:ListItem>Excellent</asp:ListItem>
                        <asp:ListItem>Good</asp:ListItem>
                       <asp:ListItem>Satisfactory</asp:ListItem>
                       <asp:ListItem>Bad</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>  
                </asp:TemplateField>
             <asp:TemplateField HeaderText="Cleanlines" SortExpression="Status"  ControlStyle-Width="80px">
                    <ItemTemplate>
                   <asp:DropDownList ID="cleandd" runat="server">
                        <asp:ListItem>Excellent</asp:ListItem>
                        <asp:ListItem>Good</asp:ListItem>
                       <asp:ListItem>Satisfactory</asp:ListItem>
                       <asp:ListItem>Bad</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>  
                </asp:TemplateField>
              <asp:TemplateField HeaderText="Waiting Time" SortExpression="Status"  ControlStyle-Width="80px">
                    <ItemTemplate>
                   <asp:DropDownList ID="waitdd" runat="server">
                        <asp:ListItem>30Mins</asp:ListItem>
                        <asp:ListItem>1Hour</asp:ListItem>
                       <asp:ListItem>2Hours</asp:ListItem>
                       <asp:ListItem>>2Hours</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>  
                </asp:TemplateField>
              <asp:TemplateField HeaderText="Hospital Experience" SortExpression="Status"  ControlStyle-Width="80px">
                    <ItemTemplate>
                   <asp:DropDownList ID="HosptlExp" runat="server">
                        <asp:ListItem>Excellent</asp:ListItem>
                        <asp:ListItem>Good</asp:ListItem>
                       <asp:ListItem>Satisfactory</asp:ListItem>
                       <asp:ListItem>Bad</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>  
                </asp:TemplateField>
    
                <asp:CommandField ShowSelectButton="true" ButtonType="Link" SelectText="Save" />
            </Columns>
    </asp:GridView>
    </div>
    <div style="width: 100%; margin-top:20px;">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       <rsweb:ReportViewer ID="ReportViewer1"  runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>



</asp:Content>

