Imports System.Data
Imports System.Data.SqlClient
'Imports CrystalDecisions.CrystalReports.Engine
'Imports CrystalDecisions.Shared
Imports System.Collections
Partial Class Admin_Holiday
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    'Dim crdoc As New ReportDocument

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindYear()
        End If


    End Sub

    Protected Sub btn_Save_WeekHolidays_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Save_WeekHolidays.Click
        Dim frmDate As Date = WDC_From.Value
        Dim ToDate As Date = WDC_TO.Value
        Dim Days_OF_Week As New System.Collections.Generic.List(Of String)
        Days_OF_Week.Clear()
        If frmDate.ToString <> "1/1/0001 12:00:00 AM" And ToDate.ToString <> "1/1/0001 12:00:00 AM" Then
            For indx As Integer = 0 To CBL_DaysOFWeek.Items.Count - 1
                If CBL_DaysOFWeek.Items(indx).Selected = True Then
                    Days_OF_Week.Add(CBL_DaysOFWeek.Items(indx).Text)
                End If
            Next
            Dim is_continue As Boolean = True
            While (is_continue)
                If Days_OF_Week.Contains(frmDate.DayOfWeek.ToString) Then
                    Insert_Holiday(frmDate, 2, False)
                End If
                If Date.Compare(ToDate, frmDate) = 0 Then
                    is_continue = False
                End If
                frmDate = frmDate.AddDays(1)
            End While
            Grd_WeekHolidays.DataBind()
            'GRD_Temp.DataSource = Days_BW_Dates
            'GRD_Temp.DataBind()
            'GRD_Temp.AutoGenerateColumns = True

        Else
            Response.Write("From To Date Not Selected")

        End If
    End Sub
    Private Sub Insert_Holiday(ByVal Dte As Date, ByVal Holiday_Type_ID As Integer, ByVal OverTimeRate As Boolean)
        Dim qry As String = "INSERT INTO Holiday (Description, Holiday_Date, Holiday_Type_ID,OverTimeRate) VALUES ('Description',@Holiday_Date,@Holiday_Type_ID,@OverTimeRate)"
        Dim con As New SqlConnection(constr)
        Dim cmd As New SqlCommand(qry, con)
        con.Open()
        cmd.Parameters.AddWithValue("@Holiday_Date", Dte)
        cmd.Parameters.AddWithValue("@Holiday_Type_ID", Holiday_Type_ID)
        If OverTimeRate = True Then
            cmd.Parameters.AddWithValue("@OverTimeRate", 2)
        Else
            cmd.Parameters.AddWithValue("@OverTimeRate", 1)
        End If

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception

        End Try
        con.Close()
    End Sub

    Protected Sub btn_Save_OtherHolidays_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Save_OtherHolidays.Click
        Insert_Holiday(WDC_Date.Value, DDL_Holiday.SelectedValue, chkBoxDoubleOverTime.Checked)
        GRD_Other_Holiday.DataBind()
    End Sub

    Protected Sub RadioButton_RBL_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButton_RBL.SelectedIndexChanged
        If RadioButton_RBL.SelectedValue = "WeekHoliday" Then
            pnl_WeekHoliday.Visible = True
            Pnl_Other_Holiday.Visible = False
        ElseIf RadioButton_RBL.SelectedValue = "OtherHoliday" Then
            pnl_WeekHoliday.Visible = False
            Pnl_Other_Holiday.Visible = True
        End If
    End Sub

    Protected Sub IMG_Btn_Close_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles IMG_Btn_Close.Click
        LB_ADD.Visible = True
        pnl_Add_HolidayType.Visible = False
        DDL_Holiday.DataBind()
    End Sub

    Protected Sub LB_ADD_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LB_ADD.Click
        LB_ADD.Visible = False
        txt_Holiday_Type.Text = ""
        pnl_Add_HolidayType.Visible = True
    End Sub

    Protected Sub btn_SaveType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_SaveType.Click
        SDS_HolidayType_ForGrid.Insert()
        txt_Holiday_Type.Text = ""
        Grd_Holiday_Type.DataBind()
    End Sub



    Protected Sub BindYear()
        For index = 10 To 0 Step -1
            ddlYear.Items.Add(DateTime.Now.Year - index)
        Next
        For index = 1 To 10
            ddlYear.Items.Add(DateTime.Now.Year + index)
        Next



        ddlYear.DataBind()
        ddlYear.SelectedValue = DateTime.Now.Year

    End Sub

End Class
