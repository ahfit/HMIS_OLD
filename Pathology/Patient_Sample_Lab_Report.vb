Imports System.Data
Imports System.Data.SqlClient
Partial Class Pathology_Patient_Sample_Lab_Report
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            loadReport()
          

        End If

    End Sub


    Protected Sub loadReport()

        Dim reportPath As String = Server.MapPath("~/Pathology/LabReports.rdlc")
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("BloodBank_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select isnull(Prefix,'')+' '+isnull(PFName,'')+' '+isnull(PLName,'')+' '+isnull(RFName,'') as name    from Patient where RegNo=@RegNo", con)
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo"))
            con.Open()
            Dim name As String = mycommand.ExecuteScalar()

            con.Close()
            
             

            Dim para As ReportParameter() =
            {
                New ReportParameter("LabNo", Request.QueryString("Main_ID").ToString()),
                New ReportParameter("RegNo", Request.QueryString("RegNo")),
                New ReportParameter("MainID", Request.QueryString("Main_ID")),
                New ReportParameter("Name", name),
                New ReportParameter("DateTime", DateTime.Now.ToString("dd MMM yyyy hh:mm tt"))
            }

            ReportViewer1.LocalReport.ReportPath = reportPath

            ReportViewer1.LocalReport.SetParameters(para)
            ReportViewer1.LocalReport.Refresh()
        Catch ex As Exception
            Response.Write(ex.Message)

        End Try

        If Request.Browser.Browser = "Chrome" Then

            Dim bytes As [Byte]() = ReportViewer1.LocalReport.Render("PDF")
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
            Response.ContentType = "application/pdf"
            Response.BinaryWrite(bytes)
            Response.[End]()
        Else

            ReportViewer1.Visible = True
        End If
    End Sub
   
End Class
