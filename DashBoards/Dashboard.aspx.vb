Imports System.Data.SqlClient
Imports System.Data

Partial Class DashBoards_Dashboard
    Inherits System.Web.UI.Page

    Dim ConBasic As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim com As New Coma
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            WebDateChooser_date_From.Value = Date.Now.AddDays(-30)
            WebDateChooser_Date_To.Value = Date.Now
            ddlHospital.DataBind()

            GetOPDPatientCount()
            GetIPDPatientCount()
            GetOPDPatientTypeWise()
            GetIPDPatientTypeWise()
            GetLabTests()
            GetLabCollections()
            GetRadiologyTests()
            GetRadiologyCollections()

        End If
    End Sub

    Private Sub GetOPDPatientCount()
        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_GetOPDPatientCount"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim adpt As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As New DataTable()
        adpt.Fill(dt)

        Chart1.DataSource = dt
        Chart1.DataBind()

    End Sub

    Private Sub GetIPDPatientCount()

        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_GetIPDPatientCount"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim adpt As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As New DataTable()
        adpt.Fill(dt)

        Chart2.DataSource = dt
        Chart2.DataBind()


    End Sub

    
    Private Sub GetOPDPatientTypeWise()
        Dim TotalOPD As Integer = 0
        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_OPDCountTypeWise"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim dr As SqlDataReader = cmd.ExecuteReader()
        Dim dt As New DataTable()
        dt.Load(dr)
        OPdTypeChart.DataSource = dt
        OPdTypeChart.Series("Series1").XValueMember = "Patient_type"
        OPdTypeChart.Series("Series1").YValueMembers = "Total_Count"

        OPdTypeChart.DataBind()
        OPdTypeChart.Series("Series1").PostBackValue = "#INDEX"


    End Sub

    Private Sub GetIPDPatientTypeWise()
        Dim TotalOPD As Integer = 0
        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_IPDCountTypeWise"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim dr As SqlDataReader = cmd.ExecuteReader()
        Dim dt As New DataTable()
        dt.Load(dr)
        IPD_PtypewiseChart.DataSource = dt
        IPD_PtypewiseChart.Series("Series1").XValueMember = "Patient_type"
        IPD_PtypewiseChart.Series("Series1").YValueMembers = "Total_Count"

        IPD_PtypewiseChart.DataBind()
        'IPD_PtypewiseChart.Series("Series1").PostBackValue = "#INDEX"


    End Sub

    Private Sub GetLabTests()

        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_GetLabTestsGroupWise"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Date_From", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@Date_To", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim adpt As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As New DataTable()
        adpt.Fill(dt)
        ChartLabTests.DataSource = dt
        ChartLabTests.DataBind()


    End Sub
    Private Sub GetLabCollections()

        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_GetLabCollectionsGroupWise"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Date_From", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@Date_To", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim adpt As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As New DataTable()
        adpt.Fill(dt)
        ChartTestGroupsAmount.DataSource = dt
        ChartTestGroupsAmount.DataBind()


    End Sub

    Private Sub GetRadiologyTests()

        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_GetRadiologyTestsGroupWise"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Date_From", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@Date_To", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim adpt As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As New DataTable()
        adpt.Fill(dt)
        ChartRadiologyTests.DataSource = dt
        ChartRadiologyTests.DataBind()


    End Sub
    Private Sub GetRadiologyCollections()

        Dim con As New SqlConnection(ConBasic)
        con.Open()
        Dim command As String = "Dashboard_GetRadiologyCollectionsGroupWise"
        Dim cmd As New SqlCommand(command, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Date_From", Convert.ToDateTime(WebDateChooser_date_From.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@Date_To", Convert.ToDateTime(WebDateChooser_Date_To.Value).ToString("yyyy-MM-dd"))
        cmd.Parameters.AddWithValue("@HospitalId", ddlHospital.SelectedValue)
        Dim adpt As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As New DataTable()
        adpt.Fill(dt)
        ChartRadiologyCollections.DataSource = dt
        ChartRadiologyCollections.DataBind()


    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        GetOPDPatientCount()
        GetIPDPatientCount()
        GetOPDPatientTypeWise()
        GetIPDPatientTypeWise()
        GetLabTests()
        GetLabCollections()
        GetRadiologyTests()
        GetRadiologyCollections()
    End Sub



   
End Class
