Imports System.Data
Imports System.IO

Imports System.Data.SqlClient

Partial Class HR_SearchEmployeeDetail
    Inherits System.Web.UI.Page
    'Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
    '    Dropdownlistdepartment.Items.Insert(0, "")
    'End Sub

   


    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        search()
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Dim Enter_Emp_id As HiddenField = CType(GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_EmpId"), HiddenField)


        Session.Add("Enter_emp_ID", Enter_Emp_id.Value)
        Session.Add("SelectedEmpId", Enter_Emp_id.Value)
        Response.Redirect(Convert.ToString("Employee.aspx?PName=Edit+Employee&MName=Employee+Info&emp_ID=" + Convert.ToString(GridView1.SelectedValue)))

        ' Response.Write("<script language='javascript' type='text/javascript'>window.open('Reception_Main.aspx', '_top')</script>")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
        If Not IsPostBack Then
            ddlHospital.DataBind()
            ddlHospital.SelectedValue = Session("HospitalId")
            GetSubDept()
            GetEmpBySubDept()
            GetSubDesg()
            ddlEmpType.DataBind()
        End If


    End Sub
    Protected Sub GetEmpBySubDept()
        Dim objManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
          New SqlParameter("@SubDeptId", Dropdownlistdepartment.SelectedValue)
           }
        ddlEmpId.DataSource = objManager.ExecuteDataTable("GetemployeeBySubDept", "Basic_Data_ConnectionString", sqlParams)
        ddlEmpId.DataBind()
        ddlEmpId.Items.Insert(0, New ListItem("All", "0"))

    End Sub
    Protected Sub GetSubDept()
        Dim objManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
          New SqlParameter("@HospitalId", ddlHospital.SelectedValue),
          New SqlParameter("@Type", "0")
           }
        Dim dt As DataTable = objManager.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", sqlParams)
        Dropdownlistdepartment.DataSource = dt
        Dropdownlistdepartment.DataBind()
        Dropdownlistdepartment.Items.Insert(0, New ListItem("All", "0"))

    End Sub
    Protected Sub GetSubDesg()
        Dim objManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
           }
        DropDownList_desg.DataSource = objManager.ExecuteDataTable("GetDesignations", "Basic_Data_ConnectionString", sqlParams)
        DropDownList_desg.DataBind()
        DropDownList_desg.Items.Insert(0, New ListItem("All", "0"))

    End Sub
    Sub search()

         Dim objManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
          New SqlParameter("@SubDeptID", Dropdownlistdepartment.SelectedValue),
          New SqlParameter("@DesignationID", DropDownList_desg.SelectedValue),
        New SqlParameter("@EmpId", ddlEmpId.SelectedValue),
        New SqlParameter("@Type", ddlEmpType.SelectedValue),
          New SqlParameter("@ActiveStatus", RBL_Emp_stat.SelectedValue)
           }
        Dim dt As DataTable = objManager.ExecuteDataTable("Employee_GetByFilter", "Basic_Data_ConnectionString", sqlParams)

        GridView1.DataSource = dt
        GridView1.DataBind()

    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "DelEmployee" Then
            'Response.Write(e.CommandArgument)
            HiddenField_Emp_ID.Value = e.CommandArgument
            SqlDataSourceEmpDelStatus.Update()
            search()
        End If
    End Sub

    Protected Sub LinkButton_Education_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + empid.Value))


    End Sub

    Protected Sub LinkButton_Certification_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton_Skill_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("HR_Performs.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + Request.QueryString(empid.Value)))

    End Sub

    Protected Sub LinkButton_AdditionalInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton_Relationship_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton_Documents_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub lnkViewDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lik As LinkButton = sender
        Session.Add("employeeid", lik.CommandArgument)
        Response.Redirect("~/Administrator/participant.aspx")
    End Sub

    Protected Sub lbtnEmpBenifit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("~/Operation_Theater/EmployeeBenifit.aspx?emp_id=" + empid.Value))


    End Sub

    Protected Sub lbtnGenrateID_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbtn As LinkButton = sender
        Response.Redirect("~/hr/Consultantcard.aspx?empid=" + lbtn.CommandArgument)




    End Sub

    Protected Sub ddlHospital_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlHospital.SelectedIndexChanged
        Dropdownlistdepartment.DataBind()

    End Sub

    Protected Sub DropDownList_desg_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_desg.TextChanged
        GridView1.DataBind()


    End Sub

    Protected Sub btn_export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_export.Click

        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "Active Employee" & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView1
        repAllCustomers.AllowPaging = False
        'repAllCustomers.DataBind()
        repAllCustomers.CssClass = "grid_dash"
        'repAllCustomers.Columns(0).Visible = false;
        'repAllCustomers.Columns(1).Visible = false;
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()
        'HF_is_Report.Value = "0";
    End Sub
    Protected Sub Dropdownlistdepartment_SelectedIndexChanged(sender As Object, e As EventArgs)
        GetEmpBySubDept()
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'base.VerifyRenderingInServerForm(control);
    End Sub
End Class
