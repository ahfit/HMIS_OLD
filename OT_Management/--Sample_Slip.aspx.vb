Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Pathology_Sample_Slip
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)

        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim crdoc As New ReportDocument
            Dim efname As String
            Dim elname As String
            loginvalidate(Session("emp_id"), Session("dept_id"))
            Dim da As New RadiologyTableAdapters.Sample_SlaipTableAdapter
            Dim ds As New Radiology
            ''Dim path As String = 

            Dim path As String = Server.MapPath("PaymentSlip_Main.rpt")

            ''Response.Write(path)
            crdoc.FileName = path
            ''da.Fill(ds.Tables("PatientBiodataReport"), CInt(Session("YearlyNo")), CInt(Session("dept_id")))
            ''Response.Write(Session("data"))
            da.Fill(ds.Tables("Sample_Slaip"), Request.QueryString("Main_ID"))
            For i As Integer = 0 To ds.Tables("Sample_Slaip").Rows.Count - 1

                ds.Tables("Sample_Slaip").Rows(i).Item("RegNo") = ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item("RegNo").ToString, False)
                ds.Tables("Sample_Slaip").Rows(i).Item(8) = ds.Tables("Sample_Slaip").Rows(i).Item(8).ToString + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(9).ToString, False) + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(10).ToString, False) + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(11).ToString, False)

            Next
            '''''''''''''''''''''''''''''''''''''''''''''''
            ''''''''''''''''''''''''''''''''''''''''''''''

            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            command = connection.CreateCommand
            connection.Open()
            command.CommandText = " SELECT     Employee.Prefix, ISNULL(Employee.EFName, '') AS EFName, ISNULL(Employee.EMName, '') AS EMName, ISNULL(Employee.ELName, '') AS ELName, Department.Dept_Name FROM         Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID where Employee.EmpID=" + Session("emp_ID").ToString
            reader = command.ExecuteReader()
            If reader.Read Then
                efname = reader.Item(1)
                elname = reader.Item(4)
            End If

            reader.Close()
            connection.Close()
            connection.Dispose()
            '''''''''''''''''''
            ''
            ''
            crdoc.Database.Tables("Sample_Slaip").SetDataSource(ds.Tables("Sample_Slaip"))
            crdoc.Database.Tables("Hospital_Header").SetDataSource(Session("Rpt_Header_DT"))

            crdoc.SetParameterValue(0, efname)
            crdoc.SetParameterValue(1, elname)
            crdoc.SetParameterValue(2, efname)
            crdoc.SetParameterValue(3, elname)
            
            CrystalReportViewer1.ReportSource = crdoc
            CrystalReportViewer1.DataBind()
            Sample(crdoc.Subreports(0))
            Sample1(crdoc.Subreports(1))
            
        Catch ex As Exception
            '   Response.Write(ex.Message)
        End Try
    End Sub

    Sub Sample(ByRef crdoc As ReportDocument)
        Dim efname As String
        Dim elname As String

        Dim da As New PathologyTableAdapters.Sample_SlaipTableAdapter
        Dim ds As New Pathology

        da.Fill(ds.Tables("Sample_Slaip"), Request.QueryString("Main_ID"))
        For i As Integer = 0 To ds.Tables("Sample_Slaip").Rows.Count - 1

            ds.Tables("Sample_Slaip").Rows(i).Item(12) = ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(12).ToString, False)

            ds.Tables("Sample_Slaip").Rows(i).Item(8) = ds.Tables("Sample_Slaip").Rows(i).Item(8).ToString + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(9).ToString, False) + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(10).ToString, False) + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(11).ToString, False)

        Next
        ''''''''''''''''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''''''''''''''

        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        command = connection.CreateCommand
        connection.Open()
        command.CommandText = " SELECT     Employee.Prefix, ISNULL(Employee.EFName, '') AS EFName, ISNULL(Employee.EMName, '') AS EMName, ISNULL(Employee.ELName, '') AS ELName, Department.Dept_Name FROM         Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID where Employee.EmpID=" + Session("emp_ID").ToString
        reader = command.ExecuteReader()
        If reader.Read Then
            efname = reader.Item(1)
            elname = reader.Item(4)
        End If

        reader.Close()
        connection.Close()
        connection.Dispose()


        ''''''''''''''''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''''''''''

        crdoc.SetParameterValue(0, efname)
        crdoc.SetParameterValue(1, elname)

        crdoc.Database.Tables("Sample_Slaip").SetDataSource(ds.Tables("Sample_Slaip"))

        
    End Sub

    Sub Sample1(ByRef crdoc As ReportDocument)
        Dim efname As String
        Dim elname As String

        Dim da As New PathologyTableAdapters.Sample_SlaipTableAdapter
        Dim ds As New Pathology
        

        
        da.Fill(ds.Tables("Sample_Slaip"), Request.QueryString("Main_ID"))
        For i As Integer = 0 To ds.Tables("Sample_Slaip").Rows.Count - 1

            ds.Tables("Sample_Slaip").Rows(i).Item(12) = ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(12).ToString, False)

            ds.Tables("Sample_Slaip").Rows(i).Item(8) = ds.Tables("Sample_Slaip").Rows(i).Item(8).ToString + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(9).ToString, False) + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(10).ToString, False) + " " + ENC.Encrypt_Main(ds.Tables("Sample_Slaip").Rows(i).Item(11).ToString, False)

        Next
        ''''''''''''''''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''''''''''''''

        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        command = connection.CreateCommand
        connection.Open()
        command.CommandText = " SELECT     Prefix, isnull(EFName,'') as EFName, isnull(EMName,'') as EMName, isnull(ELName,'') as [ELName] FROM         Employee where EmpID=" + Session("emp_ID").ToString
        reader = command.ExecuteReader()
        If reader.Read Then
            efname = reader.Item(1)
            elname = reader.Item(3)
        End If

        reader.Close()
        connection.Close()
        connection.Dispose()


        ''''''''''''''''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''''''''''


        crdoc.Database.Tables("Sample_Slaip").SetDataSource(ds.Tables("Sample_Slaip"))
        crdoc.SetParameterValue(0, efname)
        crdoc.SetParameterValue(1, elname)

    End Sub

End Class
