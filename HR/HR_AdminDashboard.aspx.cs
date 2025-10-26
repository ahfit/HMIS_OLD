using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class HR_HR_AdminDashboard : System.Web.UI.Page
{
    string connstr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
            displayLoanEmployees();
            gvdClearance.DataBind();
        }
    }
    protected void displayLoanEmployees()
    {
        using (SqlConnection con = new SqlConnection(connstr))

        {
            //SqlCommand cmd = new SqlCommand("usp_GetAllEmployeeLoanRequestsForInitiation", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //SqlDataAdapter da = new SqlDataAdapter(cmd);
            //DataSet ds = new DataSet();
            //da.Fill(ds);

            //gvLoanEmployee.DataSource = ds;

            //gvLoanEmployee.DataBind();
        }

    }


    private void LoadData(string sortExpression = null)
    {

        DbManager manager = new DbManager();
        DataSet ds = new DataSet();
        ds = manager.ExecuteDataSet("uspAdminDashboard_HR_am", "Basic_Data_ConnectionString", new SqlParameter[] { });

        gvdCertificatons.DataSource = ds.Tables[0];
        gvdCertificatons.DataBind();


        var row = ds.Tables[0].AsEnumerable().Where(x => x["CertificationType"].Equals("PMDC"));
        if (row.Any())
        {
            spanPMDC.InnerText = (((DataTable)row.CopyToDataTable()).Rows.Count).ToString();
        }
        else
        {
            spanPMDC.InnerText = "0";
        }


        var rowPNC = ds.Tables[0].AsEnumerable().Where(x => x["CertificationType"].Equals("PNC"));
        if (rowPNC.Any())
        {
            spanPNC.InnerText = (((DataTable)rowPNC.CopyToDataTable()).Rows.Count).ToString();
        }
        else
        {
            spanPNC.InnerText = "0";
        }

        gvdCnicExpiry.DataSource = ds.Tables[1];
        gvdCnicExpiry.DataBind();

        if (ds.Tables[1].Rows.Count > 0)
        {
            spanCnic.InnerText = ds.Tables[1].Rows.Count.ToString();
        }
        else
        {
            spanPNC.InnerText = "0";
        }

        gvdProbabation.DataSource = ds.Tables[2];
        gvdProbabation.DataBind();

        if (ds.Tables[2].Rows.Count > 0)
        {
            spanProb.InnerText = ds.Tables[2].Rows.Count.ToString();

        }
        else
        {
            spanProb.InnerText = "0";
        }

        gvdProRataLeaves.DataSource = ds.Tables[3];
        gvdProRataLeaves.DataBind();

        if (ds.Tables[3].Rows.Count > 0)
        {
            spanELAgainstProRata.InnerText = ds.Tables[3].Rows.Count.ToString();
            spanAddbtnNewEmpLeavesRota.Visible = true;
        }
        else
        {
            spanELAgainstProRata.InnerText = "0";
        }

        if (ds.Tables[4].Rows.Count > 0)
        {
            spanELAgainstCalanderYear.InnerText = ds.Tables[4].Rows.Count.ToString();
            spanEmpAnnualLeaves.Visible = true;
        }
        else
        {
            spanELAgainstCalanderYear.InnerText = "0";
        }

        if (ds.Tables[5].Rows.Count > 0)
        {
            gvdProbationExtensionConfirmationStatus.DataSource = ds.Tables[5];
            gvdProbationExtensionConfirmationStatus.DataBind();

            spanProbationExtensionStatus.InnerText = ds.Tables[5].Rows.Count.ToString();
            spanProbationExtensionStatus.Visible = true;
        }
        else
        {
            spanProbationExtensionStatus.InnerText = "0";
        }
    }



    protected void lnkbtn_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(connstr);
        try
        {

            LinkButton btn = sender as LinkButton;
            SqlCommand cmd = new SqlCommand("uspInsertEmployeeLogInfo", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@empid", btn.CommandName);
            cmd.Parameters.AddWithValue("@senderDeptID", Session["SubDeptId"]);
            cmd.Parameters.AddWithValue("@senderID", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@SenderDesgid", Session["DesignationID"]);
            cmd.Parameters.AddWithValue("@EmpProbationID", btn.CommandArgument);            
            cmd.Parameters.Add("@status", SqlDbType.Int, 5);
            cmd.Parameters["@status"].Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();

            int Status = (int)cmd.Parameters["@status"].Value;
            if (Status == 1)
            {
                lblMessage.Text = "Request is Initiated . . .";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                LoadData();
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "No Approval Authority is Defined for the Department of Employee Belongs To . . . ";
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            con.Close();
        }
    }

  
    protected void lnkInitiateLoan_Click(object sender, EventArgs e)
    {
        //SqlConnection con = new SqlConnection(connstr);
        //try
        //{

        //    LinkButton btn = sender as LinkButton;
        //    SqlCommand cmd = new SqlCommand("uspInsertEmployeeLogInfoForLoan", con);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@empid", btn.CommandName);
        //    cmd.Parameters.AddWithValue("@senderDeptID", Session["SubDeptId"]);
        //    cmd.Parameters.AddWithValue("@senderID", Session["emp_id"]);
        //    cmd.Parameters.AddWithValue("@SenderDesgid", Session["DesignationID"]);
        //    cmd.Parameters.AddWithValue("@EmpLoanID", btn.CommandArgument);
        //    cmd.Parameters.Add("@status", SqlDbType.Int, 5);
        //    cmd.Parameters["@status"].Direction = ParameterDirection.Output;
        //    con.Open();
        //    cmd.ExecuteNonQuery();

        //    int Status = (int)cmd.Parameters["@status"].Value;
        //    if (Status == 1)
        //    {
        //        lblMessage.Text = "Request is Initiated . . .";
        //        lblMessage.ForeColor = System.Drawing.Color.Green;
        //        LoadData();
        //    }
        //    else
        //    {
        //        lblMessage.ForeColor = System.Drawing.Color.Red;
        //        lblMessage.Text = "No Approval Authority is Defined for the Department of Employee Belongs To . . . ";
        //    }

        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
        //}
        //catch (Exception ex)
        //{
        //    Response.Write(ex.Message);
        //}
        //finally
        //{
        //    con.Close();
        //}

        
    }

    protected void gvdProbationExtensionConfirmationStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType==DataControlRowType.DataRow)
        {
            HiddenField hfEmpProbationID = e.Row.FindControl("hfEmpProbationID") as HiddenField;
            HiddenField hfEmpID = e.Row.FindControl("hfEmpID") as HiddenField;
            HyperLink hpEmployeeProbation = e.Row.FindControl("hpEmployeeProbation") as HyperLink;
            HyperLink hpEmployeeConfirmation = e.Row.FindControl("hpEmployeeConfirmation") as HyperLink;
            LinkButton lnkEmployeeProbationStatus = e.Row.FindControl("lnkEmployeeProbationStatus") as LinkButton;
            
            DbManager manager = new DbManager();
            DataSet ds=manager.ExecuteDataSet("checkEmployeeAuthorityStatusAndLevelForProbation", "HRConnectionString"
                , new SqlParameter[] { new SqlParameter("@EmpID", hfEmpID.Value), new SqlParameter("@EmpProbationID", hfEmpProbationID.Value) });
            if (ds.Tables[0].Rows.Count > 0)
            {                
                if (int.Parse(ds.Tables[0].Rows[0]["count"].ToString()) > 0)
                {
                    if (int.Parse(ds.Tables[1].Rows[0]["count"].ToString()) > 0)
                    {
                        hpEmployeeConfirmation.Visible = true;
                        hpEmployeeConfirmation.Enabled = true;
                    }
                    else if (int.Parse(ds.Tables[2].Rows[0]["count"].ToString()) > 0)
                    {
                        hpEmployeeProbation.Visible = true;
                        hpEmployeeProbation.Enabled = true;
                    }
                }
                else
                {
                    lnkEmployeeProbationStatus.Visible = true;
                    lnkEmployeeProbationStatus.ToolTip = "Approval is In Process ";
                }
            }
        }
    }

    protected void gvdCnicExpiry_Sorting(object sender, GridViewSortEventArgs e)
    {
        DbManager manager = new DbManager();
        DataSet ds = new DataSet();
        ds = manager.ExecuteDataSet("uspAdminDashboard_HR_am", "Basic_Data_ConnectionString", new SqlParameter[] { });

        if (ds.Tables[1] != null)
        {
            DataView dataView = new DataView(ds.Tables[1]);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvdCnicExpiry.DataSource = dataView;
            gvdCnicExpiry.DataBind();
        }
    }
    
    protected void gvdCnicExpiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvdCnicExpiry.PageIndex = e.NewPageIndex;
        this.LoadData();
    }

    protected void gvdCertificatons_Sorting(object sender, GridViewSortEventArgs e)
    {
        DbManager manager = new DbManager();
        DataSet ds = new DataSet();
        ds = manager.ExecuteDataSet("uspAdminDashboard_HR_am", "Basic_Data_ConnectionString", new SqlParameter[] { });

        if (ds.Tables[0] != null)
        {
            DataView dataView = new DataView(ds.Tables[0]);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvdCertificatons.DataSource = dataView;
            gvdCertificatons.DataBind();
        }
    }

    protected void gvdCertificatons_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvdCertificatons.PageIndex = e.NewPageIndex;
        this.LoadData();
    }

    protected void gvdProbabation_Sorting(object sender, GridViewSortEventArgs e)
    {
        DbManager manager = new DbManager();
        DataSet ds = new DataSet();
        ds = manager.ExecuteDataSet("uspAdminDashboard_HR_am", "Basic_Data_ConnectionString", new SqlParameter[] { });

        if (ds.Tables[2] != null)
        {
            DataView dataView = new DataView(ds.Tables[2]);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvdProbabation.DataSource = dataView;
            gvdProbabation.DataBind();
        }
    }

    protected void gvdProbabation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvdProbabation.PageIndex = e.NewPageIndex;
        this.LoadData();
    }

    protected void gvdProbationExtensionConfirmationStatus_Sorting(object sender, GridViewSortEventArgs e)
    {
        DbManager manager = new DbManager();
        DataSet ds = new DataSet();
        ds = manager.ExecuteDataSet("uspAdminDashboard_HR_am", "Basic_Data_ConnectionString", new SqlParameter[] { });

        if (ds.Tables[5] != null)
        {
            DataView dataView = new DataView(ds.Tables[5]);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvdProbationExtensionConfirmationStatus.DataSource = dataView;
            gvdProbationExtensionConfirmationStatus.DataBind();
        }
    }

    protected void gvdProbationExtensionConfirmationStatus_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvdProbationExtensionConfirmationStatus.PageIndex = e.NewPageIndex;
        LoadData();
    }

    protected void gvdProRataLeaves_Sorting(object sender, GridViewSortEventArgs e)
    {
        DbManager manager = new DbManager();
        DataSet ds = new DataSet();
        ds = manager.ExecuteDataSet("uspAdminDashboard_HR_am", "Basic_Data_ConnectionString", new SqlParameter[] { });

        if (ds.Tables[3] != null)
        {
            DataView dataView = new DataView(ds.Tables[3]);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvdProRataLeaves.DataSource = dataView;
            gvdProRataLeaves.DataBind();
        }
    }

    protected void gvdProRataLeaves_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvdProRataLeaves.PageIndex = e.NewPageIndex;
        LoadData();
    }
    /// <summary>
    /// Genaric methods
    /// </summary>
    private string GridViewSortDirection
    {
        get { return ViewState["SortDirection"] as string ?? "DESC"; }
        set { ViewState["SortDirection"] = value; }
    }

    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        switch (GridViewSortDirection)
        {
            case "ASC":
                GridViewSortDirection = "DESC";
                break;

            case "DESC":
                GridViewSortDirection = "ASC";
                break;
        }
        return GridViewSortDirection;
    }

}