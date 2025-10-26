using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class PayRoll_AddEmployeeAdvancerpt : System.Web.UI.Page
{
    string constring = ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            //GetHead();
            getDDLYears();
            DropDownList_year.SelectedValue = DateTime.Now.Year.ToString();
            DropDownList_year.Enabled = true;            
            SubDepartment();
            semployee();
            //ShowGridData();
            LoadReport();
            WebDateChooser_Date.Value = DateTime.Now;
        }


    }
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
    protected void GetHead()
    {
        DbManager objDbManager = new DbManager();
        SqlParameter[] sqlParams = { new SqlParameter("@Type", rdoType.SelectedValue) };

        DataTable dt = new DataTable();
        dt = objDbManager.ExecuteDataTable("GetSalaryAllowanceDeductionHead", "PayRoll_ConnectionString", sqlParams);
        ddlMainHead.DataSource = dt;
        ddlMainHead.DataBind();

        ddlSalaryHead.DataSource = dt;
        ddlSalaryHead.DataBind();
    }
    private void LoadReport()
    {  
        try
        {


         
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            



            

            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = getgrid_Data();
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("AddEmployeeAdvance.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            //ReportParameter rp = new ReportParameter("Parameter1", ddlMonth.SelectedItem.Text);
            //ReportParameter rp2 = new ReportParameter("Parameter2", ddlYear.SelectedItem.Text);
            //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
            ReportViewer1.LocalReport.Refresh();

        }
        catch (Exception ex)
        {

        }
        finally
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
    protected void SaveAdvance()
    {
        lblMsg.Text = "";
        try
        {
            int mainHead = 0;
            if (rdoType.SelectedValue == "Advance")
            {
                mainHead = 1498;
            }
            else
            {
                mainHead = 10371;
            }
            DbManager objDbManager = new DbManager();
            SqlParameter[] sqlParams = { 
                                       new SqlParameter("@EmpId", ddlEmployee.SelectedValue) ,
                                       new SqlParameter("@MainHeadId", mainHead) ,
                                       new SqlParameter("@SalaryHeadId", mainHead) ,
                                       new SqlParameter("@Amount", txtAmount.Text.Trim()) ,
                                       new SqlParameter("@year",DropDownList_year.SelectedValue) ,
                                       new SqlParameter("@months",DropDownList_Month.SelectedValue),
                                       new SqlParameter("@ApprovalDate", Convert.ToDateTime(WebDateChooser_Date.Value).ToString("yyyy-MM-dd")) ,
                                       new SqlParameter("@Installment", txtInstallment.Text) ,
                                       new SqlParameter("@InstallmentType", ddlInstallmentType.SelectedValue) ,
                                       new SqlParameter("@Type", rdoType.SelectedValue),
                                       new SqlParameter("@EntryBy", Session["emp_id"]),

                                   };
            objDbManager.ExecuteNonQuery("Add_EmployeeAdvances_Main", "PayRoll_ConnectionString", sqlParams);
            lblMsg.Text = "Information saved successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            ClearForm();
        }
        catch
        {
            lblMsg.Text = "Some error occurred!";
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveAdvance();
        //ShowGridData();
        LoadReport();
    }
    protected void ClearForm()
    {
       
        txtInstallment.Text = "0";      
        txtStart.Value = DateTime.Now;
        txtAmount.Text = "0";
    }


    private void getDDLYears() {

        for (int i = DateTime.Now.AddYears(-6).Year ; i < 2025; i++)
        {
            DropDownList_year.Items.Add(new ListItem() { Text=i.ToString() });
            DropDownList_year.DataBind();
        }
    
    }
    protected void rdoType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetHead();
    }
   
        private void SubDepartment()
    {
        DbManager manager = new DbManager();
        DataTable dt = manager.ExecuteDataTableWithQuery(@"SELECT SubDept_Name, SubDept_Id FROM SubDepartment order by SubDept_Name", "Basic_Data_ConnectionString", new SqlParameter[] { });
  

        ddlsdept.DataSource = dt;
        ddlsdept.DataValueField = "SubDept_Id";
        ddlsdept.DataTextField = "SubDept_Name";
        
        ddlsdept.DataBind();
        ddlsdept.Items.Insert(0, new ListItem("--ALL--", "0"));
    }

    protected void ddlsdept_SelectedIndexChanged(object sender, EventArgs e)
    {
        semployee();
        //ShowGridData();
        LoadReport();
    }
    private void semployee()
    {

        DbManager manager = new DbManager();
        DataTable dt = manager.ExecuteDataTableWithQuery(@"Select 0 as Empid , '--ALL--' as Name Union select  EmpID,ISNULL(Employee.EFName,'')+' '+ISNULL(Employee.EmName,'')+' '+ISNULL(Employee.ELName,'')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')'  as Name from Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID
           where (@SubDeptId=0 or Employee.SubDeptId=@SubDeptId )and (Employee.ActiveStatus = 1) order by Name", "Basic_Data_ConnectionString", new SqlParameter[] { new SqlParameter("@SubDeptId", ddlsdept.SelectedValue) });

        ddlEmployee.DataSource = dt;
        ddlEmployee.DataValueField = "EmpID";
        ddlEmployee.DataTextField = "Name";
        ddlEmployee.DataBind();
    }

    protected DataTable getgrid_Data()
    {
        DataTable dt = new DataTable();
        DbManager objDbManager = new DbManager();

        SqlParameter[] sqlParams = new SqlParameter[] { 
            new SqlParameter("@EmpId", ddlEmployee.SelectedValue) ,
             new SqlParameter("@Type", rdoType.SelectedValue),
             new SqlParameter("@SubDeptId", ddlsdept.SelectedValue)
        };

        dt = objDbManager.ExecuteDataTable("GetEmployeeLoansrpt", "PayRoll_ConnectionString", sqlParams);
      
        return dt;
    }
    private void ShowGridData()
    {
       
        DataTable dt = new DataTable();
        dt= getgrid_Data();
        grdViewEmployeeAdvanceLoanDetails.DataSource = dt;
        grdViewEmployeeAdvanceLoanDetails.DataBind();

    }
    protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        //ShowGridData();
        LoadReport();
    }
    protected void lnkReport_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        

        Response.Redirect("~/payroll/EmployeeLoanAdvanceReport.aspx?MainId=" + lbtn.CommandArgument);
    }
    protected void rdoType_SelectedIndexChanged1(object sender, EventArgs e)
    {
        //ShowGridData();
        LoadReport();
    }

    protected void grdViewEmployeeAdvanceLoanDetails_Sorting(object sender, GridViewSortEventArgs e)
    {
        getgrid_Data();
        DataTable dt = new DataTable();

        if (dt.Rows.Count>0)
        {
            DataView dataView = new DataView(dt);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            grdViewEmployeeAdvanceLoanDetails.DataSource = dataView;
            grdViewEmployeeAdvanceLoanDetails.DataBind();
        }
    }

    protected void grdViewEmployeeAdvanceLoanDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdViewEmployeeAdvanceLoanDetails.PageIndex = e.NewPageIndex;
        this.ShowGridData();
    }

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        
        LinkButton LNK = (LinkButton)sender;

        hdnPlanId.Value = LNK.CommandArgument;
        lblAmount.Text = LNK.ToolTip;
        GetEmployeeLoanPlan(int.Parse(LNK.CommandArgument));

        panelLoanPlan.Visible = true;

    }
    protected void GetEmployeeLoanPlan(int AdvanceId_Main)
    {
        DbManager objDbManager = new DbManager();

        SqlParameter[] sqlParams = new SqlParameter[] { 
            new SqlParameter("@AdvanceId_Main", AdvanceId_Main) 
        };

        grdLoanPlan.DataSource = objDbManager.ExecuteDataTable("GetEmployeeLoanPlan", "PayRoll_ConnectionString", sqlParams);
        grdLoanPlan.DataBind();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        panelLoanPlan.Visible = false;
    }
   
    protected void lnkCancel_Click(object sender, EventArgs e)
    {
        DbManager objDbManager = new DbManager();
        LinkButton LNK = (LinkButton)sender;

        GridViewRow row = (GridViewRow)LNK.NamingContainer;

        HiddenField hdnAdvanceId_Sub = (HiddenField)row.FindControl("hdnAdvanceId_Sub");
        HiddenField hdnMainHeadId = (HiddenField)row.FindControl("hdnMainHeadId");
        HiddenField hdnEmpId = (HiddenField)row.FindControl("hdnEmpId");

        SqlParameter[] sqlParams = new SqlParameter[] { 
           
                                       new SqlParameter("@AdvanceId_Sub", hdnAdvanceId_Sub.Value) ,
                                       new SqlParameter("@AdvanceId_Main", hdnPlanId.Value) ,                                                              
                                       new SqlParameter("@EmpId", hdnEmpId.Value),
                                       new SqlParameter("@MainHeadId", hdnMainHeadId.Value),
                                       new SqlParameter("@EntryBy", Session["emp_id"]),
        };

        objDbManager.ExecuteNonQuery("EmployeeAdvances_Sub_OnHold", "PayRoll_ConnectionString", sqlParams);

        GetEmployeeLoanPlan(int.Parse(hdnPlanId.Value));
    }
    protected void grdLoanPlan_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnApprovedId = (HiddenField)e.Row.FindControl("hdnApprovedId");
            HiddenField hdnStatus = (HiddenField)e.Row.FindControl("hdnStatus");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            LinkButton lnkCancel = (LinkButton)e.Row.FindControl("lnkCancel");

            if(hdnStatus.Value=="On Hold")
            {
                txtAmount.Text = "0";
                lnkCancel.Text = "On Hold";
                lnkCancel.Enabled = false;
                lnkCancel.ForeColor = System.Drawing.Color.Red;
                txtAmount.Enabled = false;
            }
            if (hdnApprovedId.Value != "0")
            {
               
                lnkCancel.Enabled = false;
                lnkCancel.Text = "Paid";
                lnkCancel.ForeColor = System.Drawing.Color.Green;
                txtAmount.Enabled = false;
            }
        }  
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            DbManager objDbManager = new DbManager();
            for (int b = 0; b < grdLoanPlan.Rows.Count; b++)
            {

                HiddenField hdnAdvanceId_Sub = (HiddenField)grdLoanPlan.Rows[b].FindControl("hdnAdvanceId_Sub");
                HiddenField hdnStatus = (HiddenField)grdLoanPlan.Rows[b].FindControl("hdnStatus");
                TextBox txtAmount = (TextBox)grdLoanPlan.Rows[b].FindControl("txtAmount");
                if (hdnStatus.Value != "On Hold")
                {
                    SqlParameter[] sqlParams = new SqlParameter[] { 
           
                                       new SqlParameter("@AdvanceId_Sub", hdnAdvanceId_Sub.Value) ,
                                       new SqlParameter("@Amount", txtAmount.Text.Trim()) ,                                                                                                   
                                       new SqlParameter("@EntryBy", Session["emp_id"]),
                     };

                    objDbManager.ExecuteNonQuery("EmployeeAdvances_Sub_Update", "PayRoll_ConnectionString", sqlParams);
                }
            }
        }
        catch (Exception)
        {

            ;
        }
        panelLoanPlan.Visible = false;
       
    }
}
