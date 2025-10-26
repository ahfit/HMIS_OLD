Imports System.Data
Imports System.Data.SqlClient
Imports System.Io
Partial Class Certification
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Protected Sub Button_save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            hdf_ExpiryDate.Value = Convert.ToDateTime(WDC_ExpiryDate.Text).ToString("yyyy-MM-dd")
            HiddenField_Date_From.Value = Convert.ToDateTime(WebDateChooser_Date_From.Text).ToString("yyyy-MM-dd")
            HiddenField_date_to.Value = Convert.ToDateTime(WebDateChooser_Date_To.Text).ToString("yyyy-MM-dd")

            Label5.Visible = False
            attach()
            Dim objDbManager As DbManager = New DbManager()

            Dim sqlParams As SqlParameter() = {
            New SqlParameter("@CertificationType", ddlCertificationType.SelectedValue.ToString()),
            New SqlParameter("@Employee_ID", Request.QueryString("Emp_Id")),
            New SqlParameter("@Certification", TextBox_certification_Name.Text),
            New SqlParameter("@Date_From", Convert.ToDateTime(HiddenField_Date_From.Value).ToString("yyyyMMdd")),
            New SqlParameter("@Date_To", Convert.ToDateTime(HiddenField_date_to.Value).ToString("yyyyMMdd")),
            New SqlParameter("@Institution", TextBox_Institution_Name.Text),
            New SqlParameter("@Detail", TextBox_Detail.Text),
            New SqlParameter("@Certification_No", TextBox_Certification_No.Text),
            New SqlParameter("@validity", TextBox_Validity.Text),
            New SqlParameter("@Image_URL", HiddenField_file_URL.Value),
            New SqlParameter("@Need_renewal", chkNeedRenuwal.Checked),
            New SqlParameter("@expiry_date", Convert.ToDateTime(hdf_ExpiryDate.Value).ToString("yyyyMMdd")),
            New SqlParameter("@Image_name", HiddenField_fileName.Value)
            }

            objDbManager.ExecuteNonQuery("Certification_Add", "job ApplicationConnectionString", sqlParams)
            'SqlDataSource1.Insert()
            GetCertifications()
            TextBox_certification_Name.Text = ""
            TextBox_Institution_Name.Text = ""
            HiddenField_Date_From.Value = Date.Today
            HiddenField_date_to.Value = Date.Today
            TextBox_Detail.Text = ""
            TextBox_Certification_No.Text = ""
            TextBox_Validity.Text = ""

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try




    End Sub
    Protected Sub GetCertifications()
        Dim objDbManager As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@EmpId", Request.QueryString("Emp_Id"))
        }

        Dim dt As DataTable = objDbManager.ExecuteDataTable("Get_Certification", "job ApplicationConnectionString", sqlParams)

        GridView1.DataSource = dt
        GridView1.DataBind()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()

        If Not Page.IsPostBack Then

            LoadCertificationType()
            GetCertifications()
        End If

        If Session("emp_ID") Is Nothing Then

            Response.Redirect("~/login.aspx")
        ElseIf Session("emp_ID").ToString = "" Then
            Response.Redirect("~/login.aspx")
        Else
            Session.Add("emp_ID", Session("emp_ID"))
            Session.Add("Enter_emp_ID", Session("Enter_emp_ID"))
        End If
    End Sub


    Protected Sub LoadCertificationType()
        Try
            Dim dt As DataTable = New DataTable()
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("select 0 as ID,'' as CertificationTypeName union select ID,CertificationTypeName from CertificationType", con)
            command.CommandType = CommandType.Text
            Dim da As SqlDataAdapter = New SqlDataAdapter(command)
            da.Fill(dt)

            ddlCertificationType.DataSource = dt
            ddlCertificationType.DataValueField = "CertificationTypeName"
            ddlCertificationType.DataTextField = "CertificationTypeName"
            ddlCertificationType.DataBind()

        Catch ex As Exception

        End Try



    End Sub
    Protected Sub attach()
        Try

            Dim val As String
            val = TextBox_Certification_No.Text
            Dim fileName As String
            HiddenField_fileName.Value = FileUpload1.FileName
            fileName = "p" + Request.QueryString("Emp_Id").ToString + val.ToString + FileUpload1.FileName
            HiddenField_file_URL.Value = fileName

            If System.IO.File.Exists(fileName) Then
                System.IO.File.Delete(fileName)
            End If

            Dim fs As FileStream = New FileStream(Server.MapPath("") + "/Documents/" + fileName, FileMode.CreateNew)

            fs.Write(FileUpload1.FileBytes, 0, FileUpload1.FileBytes.Length)
            fs.Close()
            fs.Dispose()



        Catch ex As Exception
            Dim s As String = ex.Message
        End Try

    End Sub
End Class
