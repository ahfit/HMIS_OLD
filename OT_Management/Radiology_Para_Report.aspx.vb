Imports System.Data
Imports System.Data.SqlClient

Partial Class Radiology_Radiology_Para_Report
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            'DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
            'Dim date1 As New DateTime()
            Try
                Label1.Text = "Date & Time :" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
                Label2.Text = "Created By : " + EmployeeName(Session("Emp_Id"))
                'Label3.Text = Request.QueryString("tittle")

            Catch ex As Exception

            End Try


            Dim ds As DataSet = Pt_Dataset_Fill()
            If ds.Tables("Patient_Prodecure_Report1").Rows.Count > 0 Then

                Label3.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("TB_Name").ToString()
                'ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("")
                Label_Patient_Name.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("PATIENTNAME").ToString()
                ' Label_RegNo.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("RegNo").ToString()
                Label_Relation.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Relation").ToString()
                Label_RELATIONNAMEe.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("RELATIONNAMEe").ToString()
                Label_RegDateTime.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("RegDateTime").ToString()
                Label_StreetAddress.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("StreetAddress").ToString()
                Label_Gender.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("PatientAge").ToString() + " " + ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Gender").ToString()

                Label_MobilePhone.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("MobilePhone").ToString()

                Label_CNIC.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("CNIC").ToString()

                Label_HomePhone.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("HomePhone").ToString()
                Label_PayID.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("PayID").ToString()
                Label_Test_Booking_Date.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Test_Booking_Date").ToString()
                Label_Sample_Collection_Date.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Sample_Collection_Date").ToLongDateString() + " " + ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Sample_Collection_Date").ToShortTimeString()
                Label_PatientType.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("PatientType").ToString()
                Label_ReferFrom.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("ReferFrom").ToString()
                Label_Patient_Type.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Patient_Type").ToString()
                Label_Patient_Type.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Patient_Type").ToString()


                ' WebHtmlEditor1.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Report").ToString
                Label_Report.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Report").ToString

                'TextBox1.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Report").ToString


                Label_Perform_Date.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Perform_Date").ToLongDateString() + " " + ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("Perform_Date").ToShortTimeString()
                Label_End_datetime.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("End_datetime").ToLongDateString() + " " + ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("End_datetime").ToShortTimeString()

                Label_RegNo.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("RegNo").ToString()
                Label_Yearly_No.Text = ds.Tables("Patient_Prodecure_Report1").Rows(0).Item("PayID").ToString()








            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        Dim dt As DataTable = Session("Rpt_Header_DT")
        Hospital_Name.Text = dt.Rows(0)("Hospital_Name").ToString().Replace("(IIMCT RGH) ", "") + "<br>"
        lbladd.Text = dt.Rows(0)("Hospital_Address").ToString().Replace("Address:", "") + dt.Rows(0)("Hospital_Phone").ToString().Replace("Phone:", " ")

        Image1.ImageUrl = "~/ShowHeaderImage.ashx?RegNO=" + dt.Rows(0)("Hospital_ID").ToString()
    End Sub
    Function Pt_Dataset_Fill() As DataSet
        Dim ds As New Pt_Radiology_Test
        Dim da As New Pt_Radiology_TestTableAdapters.Patient_Prodecure_Report1TableAdapter

        '========================= Basic Data Info =========
        Dim da_Basic_Info As New Pt_Radiology_TestTableAdapters.Patient_Prodecure_Report1TableAdapter
        da_Basic_Info.Fill_TBID(ds.Tables("Patient_Prodecure_Report1"), Request.QueryString("RegNo"), CInt(Request.QueryString("Main_Id")), CInt(Request.QueryString("TB_ID")))
        For i As Integer = 0 To ds.Tables("Patient_Prodecure_Report1").Rows.Count - 1
            ds.Tables("Patient_Prodecure_Report1").Rows(i).Item(0) = ENC.Encrypt_Main(ds.Tables("Patient_Prodecure_Report1").Rows(i).Item(0).ToString.Trim, False)
            ds.Tables("Patient_Prodecure_Report1").Rows(i).Item(1) = Convert.ToString(ENC.Encrypt_Main(ds.Tables("Patient_Prodecure_Report1").Rows(i).Item(11).ToString.Trim, False)) + " " + Convert.ToString(ENC.Encrypt_Main(ds.Tables("Patient_Prodecure_Report1").Rows(i).Item(12).ToString.Trim, False)) + " " + Convert.ToString(ENC.Encrypt_Main(ds.Tables("Patient_Prodecure_Report1").Rows(i).Item(13).ToString.Trim, False))
        Next
        Return ds
    End Function

    Function EmployeeName(ByVal Emp_id As Integer) As String
        Dim EmpName As String = ""
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("select ISNULL(prefix,'')+' '+ ISNULL(efname,'')+' '+ISNULL(emname,'')+' '+ISNULL(elname,'') as EmpName from employee where EmpID =" + Emp_id.ToString, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Dim reader As SqlDataReader = mycommand.ExecuteReader
            While reader.Read
                EmpName = reader.Item("EmpName")
            End While
            mycommand.Connection.Close()

            Return EmpName
        Catch ex As Exception

        End Try

    End Function

End Class
