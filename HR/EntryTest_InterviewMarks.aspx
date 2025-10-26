<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="~/HR/EntryTest_InterviewMarks.aspx.cs" Inherits="HR_EntryTest_InterviewMarks" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .spacing
        {
            padding-left: 100px;
        }
        
        .dis
        {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
  <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Interview / Entry Test Result</span></h2>
        <table width="100%" cellspacing="0" cellpadding="0" border="0px">
            <tr>
                <td>
                    <label runat="server" class="spacing" id="Label1">
                        Advertisment
                    </label>
                    <asp:DropDownList ID="DDL_Advertisement" runat="server" autopostback="true" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                        </asp:DropDownList>
                    <label runat="server" class="spacing" id="Label2">
                        Post
                    </label>
                     <asp:DropDownList ID="ddlPosts" runat="server">
                        </asp:DropDownList>
                    <asp:Label Text="Select :" class="spacing" runat="server" />
                    <asp:DropDownList runat="server" AutoPostBack="true" ID="DDL_Qualification" DataTextField="Qualification_Name"
                        DataValueField="Qualification_Id" 
                        onselectedindexchanged="DDL_Qualification_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="center" style="padding-top: 10px;">
                    <asp:Button ID="btnSearch" Text="Search" runat="server" OnClick="btnSearch_Click"
                        CausesValidation="false" />
                    <asp:Button ID="btnBlankReport" runat="server" Text="Qualification's Report"
                        CausesValidation="false" onclick="btnBlankReport_Click" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <div class="bxmain inner_content" style="width: 100%;">
        <div>
            <h2>
                <span>Applicants</span>
            </h2>
        </div>
        <div>
            <table id="tblMarks" runat="server" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <asp:Label ID="Label3" Text=" Total Marks:" runat="server" />
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" ID="txtTotalMarks" autocomplete="off" onblur="addTotalMarks()" TextMode="Number"></asp:TextBox>
                    </td>                    
                </tr>
            </table>
        </div>
       <asp:GridView Width="100%" AutoGenerateColumns="false" ID="GridView_Applicants" runat="server"
            ShowHeaderWhenEmpty="true" 
            onrowdatabound="GridView_Applicants_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Applicant Name" >
                    <ItemTemplate>
                        <asp:Label ID="lblAdd_App_ID" Text='<%# Eval("name") %>' 
                            runat="server"></asp:Label>
                            <asp:HiddenField ID="hfappid" runat="server" Value='<%# Eval("AppID") %>' />
                            <asp:HiddenField ID="App_Quali_Id" runat="server" Value='<%# Eval("App_Quali_Id") %>' />
                            <asp:HiddenField ID="Merit_experience" runat="server" Value='<%# Eval("Total") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Advertisment Name">
                    <ItemTemplate>
                        <asp:Label ID="lblF_Name" Text='<%# Eval("Ad_Title") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Post Name">
                    <ItemTemplate>
                        <asp:Label ID="lblL_Name" Text='<%# Eval("Title") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Marks">
                    <ItemTemplate>
                        <asp:TextBox ID="lblEntryTestTotal" Text='<%# bind("TotalMarks") %>' runat="server"
                            Enabled="true"></asp:TextBox>
                        <asp:HiddenField ID="hdnTestTotal" Value='<%# Eval("TotalMarks") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Obtained Marks">
                    <ItemTemplate>
                        <asp:TextBox ID="txtEntryTestobtain" Text='<%# bind("ObtainedBy") %>' AutoComplete="off"  runat="server"  runat="server" onkeyUp="calculateGrade(this);"></asp:TextBox>
                        <asp:CompareValidator ErrorMessage="Invalid Marks" ValidationGroup="mainGroup" ControlToValidate="txtEntryTestobtain"
                            ControlToCompare="lblEntryTestTotal" Operator="LessThanEqual" Type="Double" runat="server" />
                         
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div style="text-align: center; padding-top: 10px;">
        <asp:Button ID="btnUpdate"  runat="server" Text="Save" OnClick="btnUpdate_Click"
            ValidationGroup="mainGroup" />
       <%-- <asp:Button ID="btnEtoExcel" Visible="false" runat="server" Text="Export to Excel"
            CausesValidation="false" OnClick="btnEtoExcel_Click" />--%>
    </div>


  <asp:GridView Width="100%" AutoGenerateColumns="false" ID="gvdShowApplicantInterviewMarks" runat="server"
            ShowHeaderWhenEmpty="true">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Applicant Name" >
                    <ItemTemplate>
                        <asp:Label ID="lblAdd_App_ID" Text='<%# Eval("name") %>' 
                            runat="server"></asp:Label>
                            <asp:HiddenField ID="hfappid" runat="server" Value='<%# Eval("AppID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Advertisment Name">
                    <ItemTemplate>
                        <asp:Label ID="lblF_Name" Text='<%# Eval("Ad_Title") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Post Name">
                    <ItemTemplate>
                        <asp:Label ID="lblL_Name" Text='<%# Eval("Title") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Marks">
                    <ItemTemplate>
                        <asp:Label ID="HiddenField1" Value='<%# Eval("Total_Marks") %>' runat="server" />
                        <asp:HiddenField ID="hdnTestTotal" Value='<%# Eval("Total_Marks") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Obtained Marks">
                    <ItemTemplate>
                         <asp:Label ID="HiddenField1" Value='<%# Eval("Total_Marks") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>






    <script type="text/javascript">
       
        function addTotalMarks() {
            var totalMarks = $.trim($("[id$='txtTotalMarks']").val());
            $("[id*='lblEntryTestTotal']").val(totalMarks);
            $("[id*='hdnTestTotal']").val(totalMarks);
            //            $("[id*='rvObtainedMarks']").MinimumValue(-1);
            //$("[id*='rvObtainedMarks']").MaximumValue(totalMarks);
        }

    </script>
    <div style=" Width:100%">
       
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
