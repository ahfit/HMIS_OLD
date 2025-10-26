Imports System.Data
Imports System.Data.SqlClient
Partial Class Shift_Wise_Report
    Inherits System.Web.UI.Page

    Sub MAin_Function()
        Dim da As New Pt_Radiology_TestTableAdapters.DaysTableAdapter
        Dim ds As New Pt_Radiology_Test
        da.Fill(ds.Tables("Days"), Calculate_Days())

        Dim Da_Shift As New Pt_Radiology_TestTableAdapters.Test_Sift_CountTableAdapter
        Dim ds_Shift As New Pt_Radiology_Test
        Dim Da_Shift_Eve As New Pt_Radiology_TestTableAdapters.Test_Sift_CountTableAdapter
        Dim ds_Shift_Eve As New Pt_Radiology_Test
        Dim Da_Shift_Night As New Pt_Radiology_TestTableAdapters.Test_Sift_CountTableAdapter
        Dim ds_Shift_Night As New Pt_Radiology_Test

        Da_Shift.Fill(ds_Shift.Tables("Test_Sift_Count"), DropDownList_Month.SelectedValue, DropDownList_Year.SelectedValue)
        Da_Shift_Eve.FillBy_Evening(ds_Shift_Eve.Tables("Test_Sift_Count"), DropDownList_Month.SelectedValue, DropDownList_Year.SelectedValue)
        Da_Shift_Night.FillBy_Night(ds_Shift_Night.Tables("Test_Sift_Count"), DropDownList_Month.SelectedValue, DropDownList_Year.SelectedValue)

        For i As Integer = 0 To ds.Tables("Days").Rows.Count - 1
            For j As Integer = 0 To ds_Shift.Tables("Test_Sift_Count").Rows.Count - 1
                If (ds.Tables("Days").Rows(i).Item(0) = ds_Shift.Tables("Test_Sift_Count").Rows(j).Item(1)) Then
                    ds.Tables("Days").Rows(i).Item(1) = ds_Shift.Tables("Test_Sift_Count").Rows(j).Item(0)
                End If
            Next

            For j As Integer = 0 To ds_Shift_Eve.Tables("Test_Sift_Count").Rows.Count - 1
                If (ds.Tables("Days").Rows(i).Item(0) = ds_Shift_Eve.Tables("Test_Sift_Count").Rows(j).Item(1)) Then
                    ds.Tables("Days").Rows(i).Item(2) = ds_Shift_Eve.Tables("Test_Sift_Count").Rows(j).Item(0)
                End If
            Next

            For j As Integer = 0 To ds_Shift_Night.Tables("Test_Sift_Count").Rows.Count - 1
                If (ds.Tables("Days").Rows(i).Item(0) = ds_Shift_Night.Tables("Test_Sift_Count").Rows(j).Item(1)) Then
                    ds.Tables("Days").Rows(i).Item(3) = ds_Shift_Night.Tables("Test_Sift_Count").Rows(j).Item(0)
                End If
            Next
        Next
        GridView2.DataSource = ds.Tables("days")
        GridView2.Width = 500
        GridView2.DataBind()
        'Dim link As New ButtonField
        'link.Text = "sdfjh "
        ' GridView1.Rows(0).Cells
    End Sub

    Function Calculate_Days() As Integer
        Dim Days_Len As Integer = 0
        Days_Len = Date.DaysInMonth(DropDownList_Year.SelectedValue, DropDownList_Month.SelectedValue)
        Return Days_Len
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            Dim Current_Year As Integer = Date.Now.Year
            Dim Current_Month As Integer = Date.Now.Month
            For i As Integer = Current_Year - 5 To Current_Year
                DropDownList_Year.Items.Add(i)
            Next
            DropDownList_Year.SelectedValue = Current_Year
            DropDownList_Month.SelectedValue = Current_Month
            MAin_Function()
        End If
    End Sub

    Protected Sub DropDownList_Month_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Month.SelectedIndexChanged
        MAin_Function()
    End Sub

    Protected Sub DropDownList_Year_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Year.SelectedIndexChanged
        MAin_Function()
    End Sub
End Class


