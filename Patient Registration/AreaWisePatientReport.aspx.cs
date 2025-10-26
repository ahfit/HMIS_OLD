using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AreaWisePatientReport : System.Web.UI.Page
{
    SqlDataAdapter _SqlAdapter = new SqlDataAdapter();
    SqlConnection _SqlCon = default(SqlConnection);
    SqlCommand _SqlCommand = new SqlCommand();
    DataTable _dtConsultant = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtSDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtEDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            FillHospital();
            FillCity();
            FillTown();
        }
    }

    protected void FillHospital()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_hospital.DataValueField = "Hospital_ID";
            ddl_hospital.DataTextField = "Hospital_Name";
            ddl_hospital.DataSource = dt;
            ddl_hospital.DataBind();
        }
    }
    protected void FillCity()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("select CityID,CityName from Cities ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_city.DataValueField = "CityID";
            ddl_city.DataTextField = "CityName";
            ddl_city.DataSource = dt;
            ddl_city.DataBind();
        }
    }
    protected void FillTown()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("select TownID,TownName from Towns ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_town.DataValueField = "TownID";
            ddl_town.DataTextField = "TownName";
            ddl_town.DataSource = dt;
            ddl_town.DataBind();
        }
    }



    private void ShowReport()
    {
        try
        {
            DbManager dbMgr = new DbManager();

            SqlParameter[] para = {   new SqlParameter("@HospitalID", ddl_hospital.Text),
                                      new SqlParameter("@city", ddl_city.SelectedItem.Text),
                                      new SqlParameter("@town", ddl_town.SelectedItem.Text),
                                      new SqlParameter("@Start_Date", txtSDate.Text),
                                      new SqlParameter("@End_Date", txtEDate.Text),
                                  };
            DataTable dt = dbMgr.ExecuteDataTable("[Get_Patient_Area_Wise]", "Reg_ConnectionString", para);

            DateTime startDate = Convert.ToDateTime(txtSDate.Text);
            DateTime EndDate = Convert.ToDateTime(txtEDate.Text);
            ReportParameter[] param = {
                            new ReportParameter("SDate", startDate.ToString("dd/MM/yyyy")),
                            new ReportParameter("EDate", EndDate.ToString("dd/MM/yyyy")) };

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("AreaWisePatientReport.rdlc");
            ReportViewer1.LocalReport.SetParameters(param);
            ReportViewer1.LocalReport.DataSources.Clear();

            ReportDataSource repDs = new ReportDataSource("DataSet1", dt);
            repDs.Name = "DataSet1";
            repDs.Value = dt;

            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
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
        catch (Exception)
        {

        }
    }


    protected void btnReport_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
}