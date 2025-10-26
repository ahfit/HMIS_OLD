Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration





Partial Class Patient_Registration_PatientFaceSheet
    Inherits System.Web.UI.Page
    Shared connection1 As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString()
    Private connection As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString()
    Private Constr_Treatment As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ToString()
    Private Stock As Int32
    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            load_hospitalData()
        End If


        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()


        lblDate.Text = DateTime.Now.ToString("dd/MMM/yyyy hh:mm:ss")

        Dim regNo As String = Session("RegistrationNo")
        Dim yearly_No As Integer = Session("YearlyNo")
        Dim obj As New PatientFaceSheet()
        'Dim tbl As DataTable = obj.GetData("281030204029036043036043050036043043036036036043")
        Dim tbl As DataTable = obj.GetData(regNo, yearly_No)

        If tbl.Rows.Count > 0 Then
            Dim row As DataRow = tbl.Rows(0)

            lblPatientName.Text = row("Prefix").ToString() + "." + ENC.Encrypt_Main(row("PFName").ToString(), False) + " " + ENC.Encrypt_Main(row("PMName").ToString(), False) + " " + ENC.Encrypt_Main(row("PLName").ToString(), False)
            lblRelationName.Text = row("Prefix").ToString() + "." + row("RFName").ToString() + " " + row("RMName").ToString() + " " + row("RLName").ToString()
            lblMedicalRecord.Text = row("Yearly_No").ToString()
            lblRoomNo.Text = row("Bed_No").ToString()
            lblSex.Text = row("Gender").ToString()
            lblCNIC.Text = row("CNIC").ToString()
            lblRelation.Text = row("Relation").ToString()
            lblDateAdmission.Text = row("RegDateTime").ToString()
            lblNoOfDays.Text = Math.Floor(Convert.ToDecimal((DateTime.Now - Convert.ToDateTime(row("RegDateTime"))).TotalDays))

            lblAge.Text = row("Age").ToString()
            lblPhone.Text = row("HomePhone").ToString() + ", " + row("MobilePhone").ToString()
            lblAddress.Text = row("House_No").ToString() + " " + row("StreetAddress").ToString() + " " + row("TehsilName").ToString() + " , " + row("ProvinceName").ToString() + " " + row("CountryName").ToString()
            lblConsultantName.Text = row("Employee").ToString()


        End If

        Load_PUMS()
    End Sub
    Private Sub Load_PUMS()

        Try
            Dim ds As New Nursing()
            Dim da As New NursingTableAdapters.DataTable_PUMS_MainTableAdapter()

            'DataList_PMUS.HeaderTemplate     
            'Label_Date1.Text = "sadfsdfsad";
            'da.Fill(ds.DataTable_PUMS);
            GridView_PMUS.DataSource = da.GetData(Session("registrationNo").ToString(), Convert.ToInt32(Session("YearlyNo")), Convert.ToDateTime(Request.QueryString("dt")))
            GridView_PMUS.DataBind()

            'SqlConnection con = new SqlConnection(Constr_Treatment);
            'String Qry = "select @sdate AS  date1 , dateadd(dd,1,@sdate) AS  date2 , dateadd(dd,2,@sdate) AS  date3, dateadd(dd,3,@sdate) AS  date4, dateadd(dd,4,@sdate) AS  date5, dateadd(dd,5,@sdate) AS date6 , dateadd(dd,6,@sdate) AS date7 where ()";

            Dim dte As DateTime = Convert.ToDateTime(Request.QueryString("dt"))

            Dim Label_HeaderDate1 As Label = DirectCast(GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate1"), Label)
            Label_HeaderDate1.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString()

            dte = dte.AddDays(1)
            Dim Label_HeaderDate2 As Label = DirectCast(GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate2"), Label)
            Label_HeaderDate2.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString()

            dte = dte.AddDays(1)
            Dim Label_HeaderDate3 As Label = DirectCast(GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate3"), Label)
            Label_HeaderDate3.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString()

            dte = dte.AddDays(1)
            Dim Label_HeaderDate4 As Label = DirectCast(GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate4"), Label)
            Label_HeaderDate4.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString()

            dte = dte.AddDays(1)
            Dim Label_HeaderDate5 As Label = DirectCast(GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate5"), Label)
            Label_HeaderDate5.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString()

            dte = dte.AddDays(1)
            Dim Label_HeaderDate6 As Label = DirectCast(GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate6"), Label)
            Label_HeaderDate6.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString()

            dte = dte.AddDays(1)
            Dim Label_HeaderDate7 As Label = DirectCast(GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate7"), Label)

            'DataTable_PUMS_Main
            Label_HeaderDate7.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString()
        Catch ex As Exception
        End Try



    End Sub



    Protected Sub DataList_Day1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

        Dim cell As DataControlFieldCell = DirectCast(TryCast(sender, Control).Parent, DataControlFieldCell)

        Dim DataList_Day1 As DataList = DirectCast(cell.FindControl("DataList_Day1"), DataList)
        Dim HF_Frequency_Sub_Id As HiddenField = DirectCast(DataList_Day1.Items(DataList_Day1.SelectedItem.ItemIndex).FindControl("HF_Frequency_Sub_Id"), HiddenField)


        Dim gvRow As GridViewRow = DirectCast(TryCast(sender, Control).Parent.Parent, GridViewRow)
        Dim index As Integer = gvRow.RowIndex
        Dim HF_Prescription_id As HiddenField = DirectCast(gvRow.FindControl("HF_Prescription_id"), HiddenField)
        Dim HF_MedCode As HiddenField = DirectCast(gvRow.FindControl("HF_MedCode"), HiddenField)
        Dim HiddenField_Date1 As HiddenField = DirectCast(gvRow.FindControl("HiddenField_Date1"), HiddenField)

        'HiddenField_DoseUseDate_1.Value = HiddenField_Date1.Value
        'HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value
        'HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value
        'HiddenField_MedCode_1.Value = HF_MedCode.Value
        'Panel_Description.Visible = True





    End Sub

    Protected Sub DataList_Day2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DataList_Day3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DataList_Day4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DataList_Day5_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DataList_Day6_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DataList_Day7_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub load_hospitalData()
        Dim conect As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        Dim con As New SqlConnection(conect)


        Dim command As New SqlCommand("usp_ReportHeaderinfo", con)

        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@Hospital_ID", Session("HospitalID"))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()

        While reader.Read()
            Try


                Label2.Text = reader("Hospital_Name").ToString()
            Catch ex As Exception
            End Try

            Try


                Label3.Text = reader("Hospital_Address").ToString()
            Catch ex As Exception
            End Try

            Try


                lbl2.Text = reader("Hospital_Phone").ToString()
            Catch ex As Exception
            End Try


            

            
           

        

          
        End While

        con.Close()
        con.Dispose()

    End Sub



End Class
