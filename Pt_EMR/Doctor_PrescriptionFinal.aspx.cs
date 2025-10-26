using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Pt_EMR_Doctor_Prescription1 : System.Web.UI.Page
{
    Encryption enc = new Encryption();
    DbManager dbmgr = new DbManager();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadReport();
        }
    }


    private void LoadReport()
    {
        if (Request.QueryString["RegNo"] != null && Request.QueryString["YearlyNo"] != null)
        {
            try
            {
                SqlParameter[] paramEmp = { new SqlParameter("@EmpID",Session["emp_Id"])};
                DataTable dtDocName = new DataTable();
                string docName = "";
                dtDocName = dbmgr.ExecuteDataTableWithQuery("select Prefix+' '+ISNULL(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') as DocName from Employee where EmpID=@EmpID", "TreatmentConnectionString", paramEmp);
                if (dtDocName.Rows.Count>0)
                {
                    docName = dtDocName.Rows[0]["DocName"].ToString();   
                }

                SqlParameter[]  param = { new SqlParameter("@RegNo", Request.QueryString["RegNo"]), new SqlParameter("@YearlyNo", Request.QueryString["YearlyNo"]) };
                ReportViewer1.LocalReport.DataSources.Clear();
                ds = dbmgr.ExecuteDataSet("usp_doctorPrescription1", "TreatmentConnectionString", param);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ds.Tables[0].Rows[0]["RegNo"] = enc.Encrypt_Main((ds.Tables[0].Rows[0]["RegNo"].ToString()), false);
                    ds.Tables[0].Rows[0]["Patient_Name"] = ds.Tables[0].Rows[0]["Prefix"] + " " + enc.Encrypt_Main(ds.Tables[0].Rows[0]["PFName"].ToString(), false) + " " + enc.Encrypt_Main(ds.Tables[0].Rows[0]["PLName"].ToString(), false);

                }



                string reportPath = Server.MapPath("~/Pt_EMR/Doctor_Prescription_ReportFinal.rdlc");
                ReportViewer1.LocalReport.ReportPath = reportPath;

                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_PatientInformation", ds.Tables[0]));
                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports1);
                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] {new ReportParameter ("DoctorName", docName)});
                ReportViewer1.LocalReport.Refresh();



                if (Request.Browser.Browser == "Chrome")
                {
                    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(bytes);
                    Response.End();
                }

                else
                    ReportViewer1.Visible = true;

            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

        }
    }
    public void subReports1(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception)
        {
        }
    }
    private void subReports(object sender, SubreportProcessingEventArgs e)
    {
        DataView emer = ds.Tables[6].Copy().DefaultView;
        DataView disc = ds.Tables[6].Copy().DefaultView;
        if (ds.Tables[6].DefaultView.Count > 0)
        {
            emer.RowFilter = "MedicineCategory_Type like '%Emerg%'";
            disc.RowFilter = "MedicineCategory_Type like '%Disc%'";
        }
      
        if (disc.ToTable().Rows.Count == 0)
        {
            for (int i = 0; i < 5; i++)
            {
               
                DataTable dt = disc.Table;
                DataRow row =dt.NewRow();
                row[0] = "";
                row[1] =DBNull.Value;
                row[2] = DBNull.Value;
                row[3] = DBNull.Value;
                row[4] = DBNull.Value;
                row[5] = DBNull.Value;
                row[6] = DBNull.Value;
                row[7] = DBNull.Value;
                row[8] = DBNull.Value;
                row[9] = DBNull.Value;
                row[10] = DBNull.Value;
                row[11] = DBNull.Value;
                row[12] = DBNull.Value;
                row[13] = DBNull.Value;
                row[14] = DBNull.Value;
                row[15] = DBNull.Value;
                row[16] = DBNull.Value;
                row[17] = DBNull.Value;
                dt.Rows.Add(row);
            }

        }
        if (emer.ToTable().Rows.Count == 0)
        {
            for (int i = 0; i < 5; i++)
            {

                DataTable dt = emer.Table;
                DataRow row = dt.NewRow();
                row[0] = "";
                row[1] = DBNull.Value;
                row[2] = DBNull.Value;
                row[3] = DBNull.Value;
                row[4] = DBNull.Value;
                row[5] = DBNull.Value;
                row[6] = DBNull.Value;
                row[7] = DBNull.Value;
                row[8] = DBNull.Value;
                row[9] = DBNull.Value;
                row[10] = DBNull.Value;
                row[11] = DBNull.Value;
                row[12] = DBNull.Value;
                row[13] = DBNull.Value;
                row[14] = DBNull.Value;
                row[15] = DBNull.Value;
                row[16] = DBNull.Value;
                row[17] = DBNull.Value;
                dt.Rows.Add(row);
            }

        }

        DataView complaint = ds.Tables[5].Copy().DefaultView;
        DataView history = ds.Tables[5].Copy().DefaultView;
        DataView examination = ds.Tables[5].Copy().DefaultView;
        if (ds.Tables[5].DefaultView.Count > 0)
        {
            complaint.RowFilter = "category like '%presen%' ";
            history.RowFilter = "category like '%hist%' ";
            examination.RowFilter = "category like '%exam%' ";
        }


        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_Vitals", ds.Tables[1]));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_Diagnosis", ds.Tables[2]));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_PathologyTest", ds.Tables[3]));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_RadiologyTest", ds.Tables[4]));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_PresentingComplaint", complaint.ToTable()));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_History", history.ToTable()));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_Examination", examination.ToTable()));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_EmergencyMedicine", emer.ToTable()));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_DischargeMedicine", disc.ToTable()));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_PhysianNotes", ds.Tables[7]));
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet_Refer_Doc", ds.Tables[8]));
        

    }


}