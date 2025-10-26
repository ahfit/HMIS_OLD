Imports System.Data

Partial Class Patient_Registration_PatientFaceSheet
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
LabelFooter.Text = obj_menu.Footer_String()


        lblDate.Text = DateTime.Now.ToString("dd/MMM/yyyy hh:mm:ss")

        Dim regNo As String = Session("RegistrationNo")
        Dim obj As New PatientFaceSheet()
        'Dim tbl As DataTable = obj.GetData("281030204029036043036043050036043043036036036043")
        Dim tbl As DataTable = obj.GetData(regNo, Convert.ToInt32(Session("YearlyNo")))

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


    End Sub
End Class
