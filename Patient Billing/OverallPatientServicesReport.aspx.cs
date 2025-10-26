using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Configuration;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;



public partial class OverallPatientServicesReport: System.Web.UI.Page
{
    string conect = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    Encryption ENC = new Encryption();
   // private ReportParameter repParams[1];
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            hf_reg_no.Value = Request.QueryString["Registration"];
            hf_year_no.Value = Request.QueryString["PayId"];  
            showReport();
        }    
       
    }


    private void showReport()
    {
        loadEmployee();
        ReportViewer1.LocalReport.DataSources.Clear();
        DbManager dbMgr = new DbManager();
        SqlParameter[] para = { new SqlParameter("RegNo", hf_reg_no.Value), 

                                  new SqlParameter("PayID", hf_year_no.Value),
                                  new SqlParameter("SID", Request.QueryString["SID"])
                                  

                              };
        DataTable dt = dbMgr.ExecuteDataTable("SelectOverallPatientAdminServices", "Basic_Data_ConnectionString", para);


        ReportParameter[] repParams = new ReportParameter[1];
        repParams[0] = new ReportParameter("EmpName", HF_Employee_Name.Value);

        ReportViewer1.LocalReport.ReportPath = Server.MapPath("OverallServicesMarkReport.rdlc");
        //ReportViewer1.LocalReport.SetParameters(repParams);
        ReportDataSource repDs = new ReportDataSource();
        repDs.Name = "DataSet1";
        repDs.Value = dt;
        
        ReportViewer1.LocalReport.DataSources.Add(repDs);
        // ReportViewer1.LocalReport.SetParameters(repParams);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

        if (Request.Browser.Browser == "Chrome")
        {
            byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(bytes);
            Response.End();
        }
        else
        {
            ReportViewer1.Visible = true;
        }
      

    }
    protected void loadEmployee()
    {
        SqlConnection con = new SqlConnection(conect);
        SqlCommand command = new SqlCommand("SELECT      isnull(EFName,'')+' '+  isnull(EMName,'')+' '+ isnull(ELName,' ')FROM Employee where EmpID=@EmpID", con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@EmpID", Session["Emp_ID"].ToString());
        con.Open();
        HF_Employee_Name.Value = command.ExecuteScalar().ToString();
        con.Close();
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

}

    
   
