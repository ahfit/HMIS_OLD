<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="HR_AdminDashboard.aspx.cs" Inherits="HR_HR_AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script type="text/javascript">


        function showModal() {
            $("#myModal").modal('show');
        }


    </script>
    
    <style>
        .col-md-2
        {
                margin: 5px 0;
        }
        .badge
        {
                float: right;
    right: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div style="background-color: aliceblue; padding: 5px" class="container">
        <div>
            <div class="row" style="padding-top: 10px;">
                <div class="col-md-2">
                    <button id="btnCnicExpiry" runat="server" type="button" class="btn  btn-block btn-primary">Cnic Exp. <span id="spanCnic" runat="server" class="badge">7</span></button>
                </div>
                <div class="col-md-2">
                    <button id="Button1" runat="server" type="button" class="btn  btn-block btn-danger">PMDC Exp. <span id="spanPMDC" runat="server" class="badge">7</span></button>
                </div>

                <div class="col-md-2">
                    <button id="Button2" runat="server" type="button" class="btn  btn-block  btn-success">PNC Exp. <span id="spanPNC" runat="server" class="badge">7</span></button>
                </div>

                <div class="col-md-2">
                    <button id="Button3" runat="server" type="button" class="btn  btn-block  btn-success">Probation Exp. <span id="spanProb" runat="server" class="badge">7</span></button>
                </div>

                <div class="col-md-4">
                    <button id="Button5" runat="server" type="button" class="btn  btn-block  btn-success">Probation Extension Status<span id="spanProbationExtensionStatus" runat="server" class="badge">7</span></button>
                </div>

            </div>
            <div style="padding-top: 2px" class="form-group">
                <div class="row">


                    <div class="col-md-4">
                        <button id="Button4" runat="server" type="button" class="btn   btn-block  btn-danger">New Employee Earned Leaves  <span id="spanELAgainstProRata" runat="server" class="badge">7</span></button>
                    </div>

                    <div class="col-md-4" style="display:none;">
                        <button id="Button7" runat="server" type="button" class="btn   btn-block  btn-info">Employee Annual Leaves  <span id="spanELAgainstCalanderYear" runat="server" class="badge">7</span></button>
                    </div>

                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">Certification Expiry</a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <asp:UpdatePanel ID="upp_gvdCertificatons" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvdCertificatons" CssClass="table table-bordered"
                                            AutoGenerateColumns="false" runat="server" EmptyDataText="No Record Found . . ."
                                            AllowSorting="true" OnSorting="gvdCertificatons_Sorting"
                                             OnPageIndexChanging="gvdCertificatons_PageIndexChanging">
                                            <Columns>
                                                <asp:BoundField DataField="EmpID" HeaderText="Emp. ID" SortExpression="EmpID" />
                                                <asp:BoundField DataField="EmployeeName" HeaderText="Name" SortExpression="EmployeeName" />
                                                <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
                                                <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
                                                <asp:BoundField DataField="CertificationType" HeaderText="Certification" SortExpression="CertificationType" />
                                                <asp:BoundField DataField="expiry_date" HeaderText="Expiry Date" SortExpression="expiry_date" />
                                            </Columns>
                                        </asp:GridView>
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                                    <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                                        <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                                    </span>
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">CNIC Expiry
                                   
                                </a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">

                            <div class="panel-body">
                                <asp:UpdatePanel ID="pnl_gvdCnicExpiry" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvdCnicExpiry" CssClass="table table-bordered"
                                            EnableViewState="true" AutoGenerateColumns="false"
                                            runat="server" EmptyDataText="No Record Found . . ."
                                            AllowSorting="true" OnSorting="gvdCnicExpiry_Sorting"
                                            OnPageIndexChanging="gvdCnicExpiry_PageIndexChanging">
                                            <Columns>
                                                <asp:BoundField DataField="EmpID" HeaderText="Emp. ID" SortExpression="EmpID" />
                                                <asp:BoundField DataField="EmployeeName" HeaderText="Name" SortExpression="EmployeeName" />
                                                <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
                                                <asp:BoundField DataField="CNIC" HeaderText="CNIC" SortExpression="CNIC" />
                                                <asp:BoundField DataField="CNICExpiry" HeaderText="Expiry Date" SortExpression="CNICExpiry" />
                                            </Columns>
                                        </asp:GridView>
                                         <asp:UpdateProgress ID="upd_Cnicgvd" runat="server">
                                        <progresstemplate>
                                                <div style="position: fixed; text-align: center; 
                                                      height: 100%; width: 100%; top: 0; right: 0; 
                                                      left: 0; z-index: 9999999;
                                                       background-color: #ffffff; opacity: 0.7;">
                                                    <span style="border-width: 0px; 
                                                           position: fixed; padding: 50px; 
                                                           background-color: #ffffff; font-size: 36px;
                                                            left: 40%; top: 40%;">
                                                             <img src="../images/progressbarimg.png" width="120px" height="120px" style="background:#ffffff" />  </span>
                                                </div>
                                            </progresstemplate>
                                    </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                    </div>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">Probation Expiry
                                </a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse">
                            <div class="panel-body">
                                <asp:UpdatePanel ID="pnl_gvdProbabation" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvdProbabation" CssClass="table table-bordered"
                                             AutoGenerateColumns="false" runat="server"
                                             EmptyDataText="No Record Found . . ."
                                             AllowSorting="true" EnableViewState="true"
                                            OnSorting="gvdProbabation_Sorting" 
                                            OnPageIndexChanging="gvdProbabation_PageIndexChanging">
                                            <Columns>
                                                <asp:BoundField DataField="EmpID" HeaderText="Emp. ID" />
                                                <asp:BoundField DataField="EmployeeName" HeaderText="Name" />
                                                <asp:BoundField DataField="SubDept_Name" HeaderText="Department" />
                                                <asp:BoundField DataField="CNIC" HeaderText="CNIC" />
                                                <asp:BoundField DataField="TypeName" HeaderText="Type" />
                                                <asp:BoundField DataField="Enddate" HeaderText="Expiry Date" />
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkbtn" runat="server" CommandName='<%# Eval("EmpID") %>' CommandArgument='<%# Eval("EmpProbationID") %>' Text="Initate Process" OnClick="lnkbtn_Click"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                            <ProgressTemplate>
                                                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                                    <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                                        <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                                    </span>
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse5">Probation Extension / Confirmation                                   
                                </a>
                            </h4>
                        </div>
                        <div id="collapse5" class="panel-collapse collapse">
                            <div class="panel-body">
                                <asp:UpdatePanel ID="pnl_gvdProbationExtensionConfirmationStatus" 
                                    runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvdProbationExtensionConfirmationStatus" 
                                            OnRowDataBound="gvdProbationExtensionConfirmationStatus_RowDataBound" 
                                            CssClass="table table-bordered"
                                            AutoGenerateColumns="false" runat="server"
                                             EmptyDataText="No Record Found . . ."
                                             AllowSorting="true" EnableViewState="true"
                                            OnSorting="gvdProbationExtensionConfirmationStatus_Sorting"
                                            OnPageIndexChanging="gvdProbationExtensionConfirmationStatus_PageIndexChanging">
                                            <Columns>
                                                <asp:BoundField DataField="EmpID" HeaderText="Emp. ID" />
                                                <asp:BoundField DataField="ForEmployeeName" HeaderText="Emp. Name" />
                                                <asp:BoundField DataField="SenderEmployeeName" HeaderText="Sender Name" />
                                                <asp:BoundField DataField="SenderSubdept" HeaderText="Sender Dept" />
                                                <asp:BoundField DataField="AuthorityEmployeeName" HeaderText="Authority Person" />
                                                <asp:BoundField DataField="AuthorityDeptName" HeaderText="Deptartment" />
                                                <asp:BoundField DataField="AuthorityDesignationName" HeaderText="Designation" />
                                                <asp:BoundField DataField="ExtentionMonths" HeaderText="Extension" ItemStyle-HorizontalAlign="Center" />

                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hfEmpProbationID" runat="server" Value='<%# Eval("EmpProbationID") %>' />
                                                        <asp:HiddenField ID="hfEmpID" runat="server" Value='<%# Eval("EmpID") %>' />

                                                        <asp:HyperLink Visible="false" ID="hpEmployeeProbation" runat="server" Target="_blank" Enabled="false"
                                                            NavigateUrl='<%# String.Format("../hr/EmployeeProbation.aspx?empid={0}&IsExtend=True&Months={1}", Eval("EmpID"),Eval("ExtentionMonths"))%>'
                                                            Text='Add Extension'></asp:HyperLink>

                                                        <asp:HyperLink Visible="false" ID="hpEmployeeConfirmation" runat="server" Target="_blank" Enabled="false"
                                                            NavigateUrl='<%# String.Format("../hr/Employee_Confirmation.aspx?empid={0}&IsExtend=True", Eval("EmpID"))%>'
                                                            Text='Add Confirmation'></asp:HyperLink>

                                                        <asp:LinkButton ID="lnkEmployeeProbationStatus" Visible="false" CausesValidation="false" Text="In Process"
                                                            runat="server"></asp:LinkButton>
                                                    </ItemTemplate>

                                                </asp:TemplateField>
                                            </Columns>

                                        </asp:GridView>
                                        <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                            <ProgressTemplate>
                                                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                                    <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                                        <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                                    </span>
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">New Employee Earned Leaves
                                </a>
                                <span runat="server" visible="false" id="spanAddbtnNewEmpLeavesRota" style="margin-left: 100px;">
                                    <a target="_blank" style="font-weight: bold; font-size: 20px; text-align: right;" href="InsertEmployeeRotaLeaves.aspx?Type=ProRate">Add  
                                    </a>
                                </span>
                            </h4>
                        </div>
                        <div id="collapse4" class="panel-collapse collapse">
                            <div class="panel-body">
                                <asp:UpdatePanel ID="pnl_gvdProRataLeaves" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvdProRataLeaves"
                                           CssClass="table table-bordered" AutoGenerateColumns="false"
                                            runat="server" EmptyDataText="No Record Found . . ."
                                            AllowSorting="true" EnableViewState="true"
                                            OnSorting="gvdProRataLeaves_Sorting" OnPageIndexChanging="gvdProRataLeaves_PageIndexChanging">
                                            <Columns>
                                                <asp:BoundField DataField="EmpID" HeaderText="Emp. ID" />
                                                <asp:BoundField DataField="EmployeeName" HeaderText="Name" />
                                                <asp:BoundField DataField="SubDept_Name" HeaderText="Department" />
                                                <asp:BoundField DataField="CNIC" HeaderText="CNIC" />
                                                <asp:BoundField DataField="serviceDays" HeaderText="Service Days" />
                                            </Columns>
                                        </asp:GridView>
                                        <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                            <ProgressTemplate>
                                                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                                    <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                                        <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                                    </span>
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse7">Employee  Clearance Process </a>
                            </h4>
                        </div>
                        <div id="collapse7" class="panel-collapse collapse">
                            <div class="panel-body">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvdClearance"
                                            runat="server" AutoGenerateColumns="False"
                                            EmptyDataText="No Record Found . . ."
                                            DataSourceID="SqlDataSourceClearance"
                                            CssClass="Grid_1" Width="100%">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr#">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
                                                <asp:BoundField DataField="EmpId" HeaderText="EmpId" SortExpression="EmpId" />
                                                <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee" />
                                                <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
                                                <asp:BoundField DataField="JoiningDate" HeaderText="Joining Date" SortExpression="JoiningDate" />
                                                <asp:BoundField DataField="InitiateDate" HeaderText="Initiate Date" SortExpression="InitiateDate" />
                                                <asp:BoundField DataField="IsCleared" HeaderText="Cleared Status" SortExpression="IsCleared" />

                                                <asp:HyperLinkField DataNavigateUrlFormatString="~/hr/FullandFinalSettelement.aspx?Emp_Id={0}"
                        HeaderText="Full and Final Settelement" Target="_blank" Text="Full and Final Settelement"
                        DataNavigateUrlFields="EmpId" />

                                                <%-- <asp:TemplateField HeaderText="Delete" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkDeleteClearance" runat="server" Text="Delete" CommandArgument='<%#Bind("ClearanceId")%>' OnClick="lnkDeleteClearance_Delete"></asp:LinkButton>
                                                        <asp:HiddenField runat="server" ID="HfEmpId" Value='<%#Bind("EmpId")%>' />
                                                        <asp:HiddenField runat="server" ID="HfClearanceId" Value='<%#Bind("ClearanceId")%>' />


                                                    </ItemTemplate>

                                                </asp:TemplateField>--%>
                                            </Columns>
                                            <HeaderStyle CssClass="GridHeader" />
                                            <AlternatingRowStyle CssClass="GridAltItem" />
                                        </asp:GridView>
                                        <asp:UpdateProgress ID="UpdateProgress5" runat="server">
                                            <ProgressTemplate>
                                                <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                                    <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                                        <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                                    </span>
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                    </div>
                     <asp:SqlDataSource ID="SqlDataSourceClearance" runat="server"
                                     ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                                    SelectCommand="Usp_GetEmployeeClearanceMain" 
                                    SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                    <div class="panel panel-info" style="display:none;">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse7">Employee Annual Leaves
                                </a>
                                <span runat="server" visible="false" id="spanEmpAnnualLeaves" style="margin-left: 100px;">
                                    <a target="_blank" style="font-weight: bold; font-size: 20px; text-align: right;" href="InsertEmployeeRotaLeaves.aspx?Type=Annual">Add  
                                    </a>
                                </span>
                            </h4>
                        </div>
                    </div>

               <%--     <div class="panel panel-info">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse6">Employee Loan Requests</a>
                            </h4>
                        </div>
                        <div id="collapse6" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <asp:GridView ID="gvLoanEmployee" runat="server" AutoGenerateColumns="False"
                                    CssClass="Grid_1" Width="100%" AllowPaging="True" DataKeyNames="ID"
                                    PageSize="50" EnableModelValidation="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Application #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApplicationId" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                <asp:HiddenField ID="HiddenField_EmpId" runat="server"
                                                    Value='<%# Eval("LoanEmpId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Employee">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmployee" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Apply Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblApplyDate" runat="server" Text='<%# Bind("ApplyDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Loan Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLoanAmount" runat="server" Text='<%# Bind("LoanAmount") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Surity Employee">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSurityEmployee" runat="server" Text='<%# Bind("SurityEmployee") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Installment Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInstallmentAmount" runat="server" Text='<%# Bind("InstallmentAmount") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartDate" runat="server" Text='<%# Bind("StartDate") %>'></asp:Label>
                                                <asp:HiddenField ID="HfStartDate" runat="server"
                                                    Value='<%# Bind("EStartDate") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="End Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEndDate" runat="server" Text='<%# Bind("EndDate") %>'></asp:Label>
                                                <asp:HiddenField ID="HfEndDate" runat="server"
                                                    Value='<%# Bind("EEndDate") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                       <asp:BoundField DataField="ApprovedByHR" HeaderText="Approved By HR" SortExpression="ApprovedByHR" />
            <asp:BoundField DataField="ApprovedByFinance" HeaderText="Approved By Finance" SortExpression="ApprovedByFinance" />
                                        <asp:TemplateField HeaderText="Initiate">
                                            <ItemStyle Width="10%" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkInitiate" CausesValidation="false" Text="Initiate Process" CommandArgument='<%# Bind("ID") %>' CommandName='<%# Bind("LoanEmpId") %>' runat="server" OnClick="lnkInitiateLoan_Click"></asp:LinkButton>
                                                <asp:HiddenField ID="HfJoinDate" runat="server"
                                                    Value='<%# Bind("JoiningDate") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>--%>


                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Probation Expiry Status</h4>
                </div>
                <div class="modal-body">
                    <asp:Label Font-Size="16px" ID="lblMessage" runat="server"></asp:Label>
                </div>

            </div>
        </div>
    </div>
   

</asp:Content>

