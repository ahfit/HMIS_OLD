using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Pt_EMR_ICDRecordReport : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["ICD10ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            wdcStartDate.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd");
            wdcEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
           // ShowReport();
            bindManufactuer();
           // BindGrid();
        }
    }
    protected void bindManufactuer()
    {
        DbManager dbMgr = new DbManager();
        String query = "select Asc_id, Asc_Name from Admin_Service_Category where Asc_id in(5,6,9,10,34,42,29)";
        SqlParameter[] sqlParam = { };
        ddlCategory.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "Basic_Data_ConnectionString", sqlParam);
        ddlCategory.DataTextField = "Asc_Name";
        ddlCategory.DataValueField = "Asc_id";
        ddlCategory.Items.Insert(0, new ListItem("All", "0"));
        ddlCategory.DataBind();
    }
    private void ShowReport()
    {
        try
        {
            SqlConnection con = new SqlConnection(conString);
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_GetICDRecordReport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(wdcStartDate.Text).ToString("yyyy-MM-dd"));
            cmd.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(wdcEndDate.Text).ToString("yyyy-MM-dd"));
            cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@VisitNo", txtregoNo.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource DataSource1 = new ReportDataSource();
            DataSource1.Name = "DataSet1";
            DataSource1.Value = dt;
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            String path = Server.MapPath("~/Pt_EMR/ICDRecordReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Add(DataSource1);

            if (Request.UserAgent.Contains("Chrome"))
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
            Response.Write(ex.Message);
        }
    }

    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
       // ShowReport();
        BindGrid();
  }



    private void BindGrid()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ICD10ConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("usp_GetICDRecord", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(wdcStartDate.Text).ToString("yyyy-MM-dd"));
        cmd.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(wdcEndDate.Text).ToString("yyyy-MM-dd"));
        cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
        cmd.Parameters.AddWithValue("@MRno", txtregoNo.Text);
        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        gridview.DataSource = dt;
        gridview.DataBind();
        con.Close();
    }


    protected void lnkshowreport_Click(object sender, EventArgs e)
    {
    //    var linkbutton = (linkbutton)sender;
    //    var serial_number = linkbutton.commandargument;
    //    var pdf_path = server.mappath(string.format("~/pt_emr/icdrecordreport.rdlc.pdf", serial_number));

    //    if (system.io.file.exists(pdf_path))
    //    {
    //        httpresponse response = httpcontext.current.response;
    //        response.contenttype = "application/pdf";
    //        response.transmitfile(pdf_path);
    //    }
    }
} 
      

