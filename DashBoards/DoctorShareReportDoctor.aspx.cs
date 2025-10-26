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

public partial class DashBoards_DoctorShareReportDoctor : System.Web.UI.Page
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
            loadCategory();
            loadServices();
            loadDepartment();
            loadConsultantDropdown();
        }
    }

    public void Openconn(string connStr)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings[connStr].ConnectionString;
            _SqlCon = new SqlConnection(constr);
            _SqlCon.Open();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    public DataTable ExecuteDataTable(string ProcedureName, string connStr, SqlParameter[] prms)
    {
        DataTable _dataTable = new DataTable();

        try
        {

            Openconn(connStr);

            _SqlCommand = new SqlCommand(ProcedureName, _SqlCon);
            _SqlCommand.CommandType = CommandType.StoredProcedure;
            _SqlCommand.CommandText = ProcedureName;
            foreach (SqlParameter sqlParam in prms)
            {
                _SqlCommand.Parameters.Add(sqlParam);
            }


            _SqlAdapter.SelectCommand = _SqlCommand;
            _SqlAdapter.Fill(_dataTable);

            _SqlCon.Close();
            _SqlCommand.Dispose();

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dataTable;
    }
    public void ExecuteNonQuery(string ProcedureName, string connStr, SqlParameter[] prms)
    {

        try
        {

            Openconn(connStr);

            _SqlCommand = new SqlCommand(ProcedureName, _SqlCon);
            _SqlCommand.CommandType = CommandType.StoredProcedure;
            _SqlCommand.CommandText = ProcedureName;
            foreach (SqlParameter sqlParam in prms)
            {
                _SqlCommand.Parameters.Add(sqlParam);
            }

            _SqlCommand.ExecuteNonQuery();

            _SqlCon.Close();
            _SqlCommand.Dispose();



        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    //=======================================================
    //Service provided by Telerik (www.telerik.com)
    //Conversion powered by NRefactory.
    //Twitter: @telerik
    //Facebook: facebook.com/telerik
    //=======================================================

    private void loadDepartment()
    {
        SqlParameter[] sqlParams = {
		
	};

        ddlDepartment.DataSource = ExecuteDataTable("GetDepartments", "Basic_Data_ConnectionString", sqlParams);
        ddlDepartment.DataTextField = "Dept_Name";
        ddlDepartment.DataValueField = "Dept_ID";
        ddlDepartment.DataBind();

    }
    private void loadCategory()
    {
        SqlParameter[] sqlParams = {
		
	};

        DropDownListCategory.DataSource = ExecuteDataTable("GetCategoryForDoctorShare", "Basic_Data_ConnectionString", sqlParams);
        DropDownListCategory.DataTextField = "Asc_Name";
        DropDownListCategory.DataValueField = "Asc_id";
        DropDownListCategory.DataBind();

    }

    public void loadConsultantDropdown()
    {
        SqlParameter[] sqlParams = { new SqlParameter("@DeptID", ddlDepartment.SelectedValue) };

        _dtConsultant = ExecuteDataTable("GetConsultantFromDutyDepartment", "Basic_Data_ConnectionString", sqlParams);

        DDL_Consultant.DataSource = _dtConsultant;
        DDL_Consultant.DataTextField = "Name";
        DDL_Consultant.DataValueField = "EmpID";
        DDL_Consultant.DataBind();
        DDL_Consultant.Items.Insert(0, new ListItem("All", "0"));
    }

    //=======================================================
    //Service provided by Telerik (www.telerik.com)
    //Conversion powered by NRefactory.
    //Twitter: @telerik
    //Facebook: facebook.com/telerik
    //=======================================================


    private void loadServices()
    {
        SqlParameter[] sqlParams = { new SqlParameter("@Cat_ID", Convert.ToString(DropDownListCategory.SelectedValue)) };

        DropDownListServices.DataSource = ExecuteDataTable("GetServicesForDoctorShare", "Basic_Data_ConnectionString", sqlParams);
        DropDownListServices.DataTextField = "S_Name";
        DropDownListServices.DataValueField = "S_ID";
        DropDownListServices.DataBind();

    }

    //=======================================================
    //Service provided by Telerik (www.telerik.com)
    //Conversion powered by NRefactory.
    //Twitter: @telerik
    //Facebook: facebook.com/telerik
    //=======================================================

    private void ShowReport()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            Decimal tax = 0;
            if (txtTax.Text.Trim() != "")
            {
                tax = Convert.ToDecimal(txtTax.Text);
            }
            else
            {
                tax = 0;
            }
            SqlParameter[] para = { new SqlParameter("Start_Date", txtSDate.Text),
                                      new SqlParameter("End_Date", txtEDate.Text),
                                      new SqlParameter("@Tax",tax),
                                   new SqlParameter("@Doc_ID", DDL_Consultant.SelectedValue),
            
            new SqlParameter("@DeptID", ddlDepartment.SelectedValue),
            new SqlParameter("@Category", DropDownListCategory.SelectedValue),
           new SqlParameter("@S_ID", DropDownListServices.SelectedValue)
                                  
                                  };
            DataTable dt = dbMgr.ExecuteDataTable("uspGetBeforDoctorShareReport", "Basic_Data_ConnectionString", para);

            DateTime startDate = Convert.ToDateTime(txtSDate.Text);
            DateTime EndDate = Convert.ToDateTime(txtEDate.Text);
            ReportParameter[] param = { new ReportParameter("SDate", startDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", EndDate.ToString("dd/MM/yyyy")) };

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("DoctorShareReportForDoctor.rdlc");
            ReportViewer1.LocalReport.SetParameters(param);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource repDs = new ReportDataSource();
            repDs.Name = "DataSet1";
            repDs.Value = dt;
            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}

            //else
            ReportViewer1.Visible = true;

        }
        catch (Exception ex)
        {

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
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadServices();
        loadConsultantDropdown();
    }
    protected void DropDownListCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadServices();
        loadConsultantDropdown();
    }
}