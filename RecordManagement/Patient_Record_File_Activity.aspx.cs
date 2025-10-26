using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;

public partial class RecordManagement_Patient_Record_File_Activity : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Sql_PatientRecordActivity.SelectParameters["Patient_File_ID"].DefaultValue = Request.QueryString["File_Id"];
        WebDateChooser_Date.Value = DateTime.Now;
    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        String Id = Request.QueryString["File_Id"];

        if (WebDateChooser_Date.Value != null && txtName.Text != "" && Id != null)
        {
            Sql_PatientRecordActivity.InsertParameters["Patient_File_ID"].DefaultValue = Id;
            Sql_PatientRecordActivity.InsertParameters["DateTime"].DefaultValue = WebDateChooser_Date.Value.ToString();
            Sql_PatientRecordActivity.InsertParameters["Name"].DefaultValue = txtName.Text;
            Sql_PatientRecordActivity.InsertParameters["Phone"].DefaultValue = txtPhone.Text;
            Sql_PatientRecordActivity.InsertParameters["Address"].DefaultValue = txtAddress.Text;
            Sql_PatientRecordActivity.InsertParameters["Relation"].DefaultValue = txtRelation.Text;
            Sql_PatientRecordActivity.InsertParameters["Remarks"].DefaultValue = txtRemarks.Text;
            Sql_PatientRecordActivity.InsertParameters["CNIC"].DefaultValue = txtCNIC1.Text + "-" + txtCNIC2.Text + "-" + txtCNIC3.Text;
            Sql_PatientRecordActivity.Insert();
            Sql_PatientRecordActivity.SelectParameters["Patient_File_ID"].DefaultValue = Id;
            GridView1.DataBind();
            txtName.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            txtRelation.Text = "";
            txtRemarks.Text = "";
            txtCNIC1.Text = "";
            txtCNIC2.Text = "";
            txtCNIC3.Text = "";

        }
        else
        {
            lbl_Msg.Text = "Please Enter Record First ";
            lbl_Msg.ForeColor = System.Drawing.Color.Red;
            lbl_Msg.Visible = true;
        }
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RecordManagement/IssuePatientRecord.aspx");
    }
}