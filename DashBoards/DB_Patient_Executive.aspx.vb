Imports System.Data

Partial Class DashBoards_DB_Patient_Executive
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            WebDateChooser_date_From.Value = Date.Now
            WebDateChooser_Date_To.Value = Date.Now
            LoadPatientSummaryData()
        End If
    End Sub

    Private Sub LoadPatientSummaryData()
        Dim dashTA As New DashBoardsTableAdapters.usp_DB_Patient_ExecutiveTableAdapter
        Dim ds As New DashBoards()
        Dim d1 As New DateTime
        Dim d2 As New DateTime
        d1 = WebDateChooser_date_From.Value.ToString()
        'New DateTime(DateTime.Now.Year - 1, DateTime.Now.Month, DateTime.Now.Day)
        d2 = WebDateChooser_Date_To.Value.ToString()
        'New DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day)

        dashTA.Fill(ds.usp_DB_Patient_Executive, d1, d2)

        For Each dr As DataRow In ds.Tables("usp_DB_Patient_Executive").Rows
            dr("Present") = Integer.Parse(dr("Previous_Admissions").ToString()) + Integer.Parse(dr("Today_Admissions").ToString()) - Integer.Parse(dr("Discharge").ToString())
        Next

        gvPatientExecutiveSummary.DataSource = ds.Tables("usp_DB_Patient_Executive")
        gvPatientExecutiveSummary.DataBind()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        LoadPatientSummaryData()
    End Sub

    Protected Sub gvPatientExecutiveSummary_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvPatientExecutiveSummary.PreRender
        If gvPatientExecutiveSummary.Rows.Count > 0 Then

            Dim In_Patients, out_Patients, Pre_admi, new_admi, Discharge As Label
            Dim T_In_Patient = 0, T_out_Patients = 0, T_Pre_admi = 0, T_new_admi = 0, T_Discharge As Integer = 0

            For Each row As GridViewRow In gvPatientExecutiveSummary.Rows
                In_Patients = row.FindControl("lbl_In_Pa")
                out_Patients = row.FindControl("lbl_Out_Pa")
                Pre_admi = row.FindControl("lbl_Prv_Ad")
                new_admi = row.FindControl("lbl_Today_Ad")
                Discharge = row.FindControl("lbl_Discharge")

                T_In_Patient += CInt(In_Patients.Text)
                T_out_Patients += CInt(out_Patients.Text)
                T_Pre_admi += CInt(Pre_admi.Text)
                T_new_admi += CInt(new_admi.Text)
                T_Discharge += CInt(Discharge.Text)
            Next


            Dim F_In_Patients As Label = gvPatientExecutiveSummary.FooterRow.FindControl("lbl_T_I_Pa")
            Dim F_out_Patients As Label = gvPatientExecutiveSummary.FooterRow.FindControl("lbl_T_Out_Pa")
            Dim F_Pre_admi As Label = gvPatientExecutiveSummary.FooterRow.FindControl("lbl_T_Prv_Ad")
            Dim F_new_admi As Label = gvPatientExecutiveSummary.FooterRow.FindControl("lbl_T_Today_Ad")
            Dim F_Discharge As Label = gvPatientExecutiveSummary.FooterRow.FindControl("lbl_T_Discharge")

            F_In_Patients.Text = T_In_Patient.ToString()
            F_out_Patients.Text = T_out_Patients.ToString()
            F_Pre_admi.Text = T_Pre_admi.ToString()
            F_new_admi.Text = T_new_admi.ToString()
            F_Discharge.Text = T_Discharge.ToString()


        End If
    End Sub
End Class
