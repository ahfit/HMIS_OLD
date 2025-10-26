using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PayRoll_EmployeeAllowancesDeductionsSetup : System.Web.UI.Page
{
    SqlDataAdapter _SqlAdapter = new SqlDataAdapter();
    SqlConnection _SqlCon = default(SqlConnection);
    SqlCommand _SqlCommand = new SqlCommand();
    DataTable _dataTable = new DataTable();
    DataSet _dataSet = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetAllowances();
            GetDeduction();
            GetGrossSal();
            GetIncomeTaxExcemption();
            GetEmp_SalRaiseLog();
        }
    }
    public void GetIncomeTaxExcemption()
    {
        DbManager objDbManager = new DbManager();


        SqlParameter[] sqlParams =
        {            
            new SqlParameter("@EmpId", Request.QueryString["EmpId"])
        };

        DataTable dt = objDbManager.ExecuteDataTable("GetIncomeTaxExcemption", "Basic_Data_ConnectionString", sqlParams);
        if (dt.Rows.Count > 0)
            txtEmpExcemption.Text = dt.Rows[0]["TaxExemption"].ToString();
    }
    public void GetGrossSal()
    {
        DbManager objDbManager = new DbManager();
        
        SqlParameter[] sqlParams =
        {            
            new SqlParameter("@EmpId", Request.QueryString["EmpId"])
        };

       DataTable dt= objDbManager.ExecuteDataTable("GetEmp_LatestGrossSalary", "PayRoll_ConnectionString", sqlParams);
        if (dt.Rows.Count>0)
        {
            txtGrossSal.Text = dt.Rows[0]["GrossSal"].ToString();
            hfGrossSal.Value = dt.Rows[0]["GrossSal"].ToString();
            hfType.Value = "Updated";
            txtGrossSal.Enabled = false;
            hfIsRevised.Value = "false";
        }
        
    }
  
    public void GetAllowances()
    {
        DbManager objDbManager = new DbManager();


        SqlParameter[] sqlParams =
        {
            new SqlParameter("@ScaleId", Request.QueryString["ScaleID"]),
            new SqlParameter("@EmpId", Request.QueryString["EmpId"]),
             new SqlParameter("@Month", 1),
        new SqlParameter("@Year", 2020)
        };

        GVD_Allowance.DataSource = objDbManager.ExecuteDataTable("GetAllowancesHead", "PayRoll_ConnectionString", sqlParams);
        GVD_Allowance.DataBind();
    }
    public void GetDeduction()
    {
        DbManager objDbManager = new DbManager();


        SqlParameter[] sqlParams = { new SqlParameter("@EmpId", Request.QueryString["EmpId"]),
                                    new SqlParameter("@Month", 1),
        new SqlParameter("@Year", 2020)};

        GVD_Deduction.DataSource = objDbManager.ExecuteDataTable("GetDeductionHead", "PayRoll_ConnectionString", sqlParams);
        GVD_Deduction.DataBind();
    }
    protected void chkExclude_CheckedChanged(object sender, System.EventArgs e)
    {
        CheckBox chk = (CheckBox)sender;
        GridViewRow gvRow = chk.NamingContainer as GridViewRow;
        TextBox txtAmount = (TextBox)gvRow.FindControl("txtAllowanceAmount");
        if (chk.Checked)
        {
            txtAmount.Enabled = true;
        }
        
    }
    public void Openconn(string connStr)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString;
            _SqlCon = new SqlConnection(constr);
            _SqlCon.Open();
        }
        catch (Exception ex)
        {
          
        }

    }   

    public DataTable ExecuteDataTable_Query(string query, string connStr, SqlParameter[] prms)
    {

        try
        {

            Openconn(connStr);

            _SqlCommand = new SqlCommand(query, _SqlCon);
            //_SqlCommand.CommandType = CommandType.StoredProcedure
            //_SqlCommand.CommandText = ProcedureName
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
            
        }
    }
    public void ExecuteNonQuery_Query(string query, string connStr)
    {

        try
        {

            Openconn(connStr);

            _SqlCommand = new SqlCommand(query, _SqlCon);
            _SqlCommand.CommandType = CommandType.Text;
            //_SqlCommand.CommandText = query            
            _SqlCommand.ExecuteNonQuery();
            _SqlCon.Close();
            _SqlCommand.Dispose();
        }
        catch (Exception ex)
        {
          
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

        try
        {
            //if (txtEmpExcemption.Text != "" && Convert.ToInt32(txtEmpExcemption.Text) >= 0 && Convert.ToInt32(txtEmpExcemption.Text) <= 100)
            //{
            
            DbManager dbMgr = new DbManager();
            string AllData = "<All>", DUDData="<Dud>";

            string EmpAllowance = GetAllowancesData(AllData);
            string Deduction = GetDeductionData(DUDData);

            if (Insert_Allow_Deduction(EmpAllowance, Deduction))
           {
                GetEmp_SalRaiseLog();
               lblMsg.Text = "Information saved successfully";
               lblMsg.ForeColor = Color.Green;
           }
           else
           {

               lblMsg.Text = "An Error Occur while Saving  ";
               lblMsg.ForeColor = Color.Red;
           }


            GetGrossSal();
            GetAllowances();
        }
        catch (Exception exception)
        {
            lblMsg.Text = "Some error occurred";
            lblMsg.ForeColor = Color.Red;
        }
    }

    private bool Insert_Allow_Deduction(string AllData, string DUDData)
    {
        bool flag = false;
        try

         { 
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParams =
            {
                new SqlParameter("@EmpId", Request.QueryString["EmpId"]),
                new SqlParameter("@ByEmp", Session["emp_id"] ),
                new SqlParameter("@Allowance", AllData),                
                new SqlParameter("@Deduction", DUDData),
                new SqlParameter("@IsRevised",Convert.ToBoolean(hfIsRevised.Value)),
                new SqlParameter("@ReviseType", hfType.Value),
                new SqlParameter("@EffectiveDate", hfEffectiveDate.Value)
            };

            ExecuteNonQuery("AddEmployeeAllowance_Deduction", "PayRoll_ConnectionString", sqlParams);
            flag = true;

         }
        catch
        {

        }

        return flag;
    }

    private string GetDeductionData(string DUDData)
    {
        if (GVD_Deduction.Rows.Count > 0)
        {
            CheckBox chkSelectDeduction = new CheckBox();
            string Dcode = String.Empty, txtDeductionAmount = String.Empty, txtDeductionNo = String.Empty, txtOpening = String.Empty;

            foreach (GridViewRow item in GVD_Deduction.Rows)
            {
                chkSelectDeduction = (CheckBox)item.FindControl("chkSelectDeduction");
                Dcode = ((HiddenField)item.FindControl("hfHeadId")).Value.Trim();
                txtDeductionAmount = ((TextBox)item.FindControl("txtDeductionAmount")).Text.Trim();
                txtDeductionNo = ((TextBox)item.FindControl("txtDeductionNo")).Text.Trim();
                txtOpening = ((TextBox)item.FindControl("txtOpening")).Text.Trim();

                txtDeductionAmount = txtDeductionAmount == "" ? "0" : txtDeductionAmount;

                //if (Convert.ToDouble(txtDeductionAmount) > 0)
                //{
                    DUDData = DUDData + "<row>" +
                     "<empID>" + Request.QueryString["EmpId"] + "</empID>" +
                     "<D_Code>" + Dcode + "</D_Code>" +
                     "<Amount>" + txtDeductionAmount + "</Amount>" +
                     "<DeductionNo>" + txtDeductionNo + "</DeductionNo>" +
                     "<Opening>" + txtOpening + "</Opening>" +
                     "</row>"
                     ;
                //}

           
                //dbMgr = new DbManager();
                //SqlParameter[] sqlParams =
                //{
                //    new SqlParameter("@EmpId", Request.QueryString["EmpId"]),
                //    new SqlParameter("@D_Code", EID),
                //    new SqlParameter("@Amount", txtDeductionAmount),
                //    new SqlParameter("@DeductionNo", txtDeductionNo)
                //};

                //ExecuteNonQuery("AddEmployeeDeduction", "PayRoll_ConnectionString", sqlParams);

                //lblMsg.Text = "Information saved successfully";
                //lblMsg.ForeColor = Color.Green;
            }
            

        }
        DUDData = DUDData + "</Dud>";
        return DUDData;
    }

    private string GetAllowancesData(string AllData)
    {
        if (GVD_Allowance.Rows.Count > 0)
        {
            CheckBox chkExclude = new CheckBox();
            string EID = String.Empty, txtAllowanceAmount = String.Empty, txtTaxExempted = String.Empty;

            foreach (GridViewRow item in GVD_Allowance.Rows)
            {
                chkExclude = (CheckBox)item.FindControl("chkExclude");
                EID = ((HiddenField)item.FindControl("hfHeadId")).Value.Trim();
                TextBox allowanceAmount = ((TextBox)item.FindControl("txtAllowanceAmount"));
                HiddenField hfAmount = ((HiddenField)item.FindControl("hfAmount"));
                Boolean GrossSalHead=false;

                if (allowanceAmount.Enabled)
                {
                    txtAllowanceAmount = allowanceAmount.Text.Trim();
                    
                }
                else
                {
                    txtAllowanceAmount = hfAmount.Value;
                    GrossSalHead = true;
                }
                //string txtTaxExempted = ((TextBox)item.FindControl("txtTaxExempted")).Text.Trim();

                txtTaxExempted = chkExclude.Checked ? "100" : "0";
                txtAllowanceAmount = txtAllowanceAmount == "" ? "0" : txtAllowanceAmount;

               
                

                //if (Convert.ToDouble(txtAllowanceAmount) > 0)
                //{
                    AllData = AllData + "<row>" +
                     "<empID>" + Request.QueryString["EmpId"] + "</empID>" +
                     "<E_id>" + EID + "</E_id>" +
                     "<Amount>" + txtAllowanceAmount + "</Amount>" +
                     "<IsFix>" + chkExclude.Checked + "</IsFix>" +
                     "<TaxExempted>" + txtTaxExempted + "</TaxExempted>"+
                     "<GrossSalHead>" + GrossSalHead + "</GrossSalHead>" +
                     "</row>"
                     ;
                //}


                //SqlParameter[] sqlParams1 =
                //    {
                //        new SqlParameter("@EmpId", Request.QueryString["EmpId"]),
                //        new SqlParameter("@EId", EID),
                //        new SqlParameter("@Amount", txtAllowanceAmount),
                //        new SqlParameter("@IsFix",chkExclude.Checked),
                //        new SqlParameter("@TaxExempted",txtTaxExempted)
                //    };
                //ExecuteNonQuery("AddEmployeeAllowance", "PayRoll_ConnectionString", sqlParams1);

            }
        }

        AllData = AllData + "</All>";

        return AllData;
    }

    decimal totalSalary = 0;
    protected void GVD_Allowance_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            CheckBox chkSelectAllowances = (CheckBox)e.Row.FindControl("chkSelectAllowances");
            TextBox txtAllowanceAmount = (TextBox)e.Row.FindControl("txtAllowanceAmount");
            CheckBox chkExclude = (CheckBox)e.Row.FindControl("chkExclude");
            
            DataRowView dr = (DataRowView)e.Row.DataItem;
            string allowanceType = dr["AllowanceType"].ToString();
            string IsExcluded = dr["IsExcluded"].ToString();
            // string allowanceType = DataBinder.Eval(e.Row.DataItem, "AllowanceType").ToString();
            if (IsExcluded == "1")
            {
                //chkExclude.Checked = true;
            }
            if (allowanceType == "1")
            {
                //e.Row.BackColor = Color.FromName("#E56E94");
                e.Row.Attributes["style"] = "background-color: #28b779";
                txtAllowanceAmount.Enabled = false;
                //chkSelectAllowances.Checked = true;
                chkSelectAllowances.Enabled = false;
            }
            totalSalary += Convert.ToDecimal(txtAllowanceAmount.Text.Trim());

        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label txtAllowanceAmount = (Label)e.Row.FindControl("lblTotalAllowance");
            txtAllowanceAmount.Text = totalSalary.ToString();
            totalSalary = 0;
        }
    }

    public void GetEmp_SalRaiseLog()
    {
        DbManager objDbManager = new DbManager();
        SqlParameter[] sqlParams =
        {
            new SqlParameter("@EmpId", Request.QueryString["EmpId"])
        };

        grdSalRaiseLog.DataSource = objDbManager.ExecuteDataTable("GetEmp_SalRaiseLog", "PayRoll_ConnectionString", sqlParams);
        grdSalRaiseLog.DataBind();
    }

    protected void lnkDetails_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;

        DbManager objDbManager = new DbManager();
        SqlParameter[] sqlParams =
        {
            new SqlParameter("@EmpSalId", lnk.CommandArgument)
        };

        grdSalRaiseBreakUp.DataSource = objDbManager.ExecuteDataTable("GetEmp_SalRaise_Breakup", "PayRoll_ConnectionString", sqlParams);
        grdSalRaiseBreakUp.DataBind();
        pnlSalRaiseBreakeup.Visible = true;
    }

    protected void btnCloseRaisSal_Click(object sender, EventArgs e)
    {
        pnlSalRaiseBreakeup.Visible = false;
    }

    decimal totalDeduction = 0;
    protected void GVD_Deduction_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtDeductionAmount = (TextBox)e.Row.FindControl("txtDeductionAmount");
            totalDeduction += Convert.ToDecimal(txtDeductionAmount.Text.Trim());
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotalDeduction = (Label)e.Row.FindControl("lblTotalDeduction");
            lblTotalDeduction.Text = totalDeduction.ToString();
            totalDeduction = 0;
        }
    }
}