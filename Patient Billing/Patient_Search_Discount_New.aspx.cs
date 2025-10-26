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
using System.IO;
public partial class Patient_Billing_Patient_Search_Discount_New : System.Web.UI.Page
{
    Encryption ENC = new Encryption();
    Coma co = new Coma();
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

        }
    }
    private int total_amount = 0;
    private string c = "";

    protected void GridView_View_Payments_PreRender(object sender, EventArgs e)
    {
        try
        {
            for (int i = 0; i < GridView_View_Payments.Rows.Count; i++)
            {
                GridView_View_Payments.Rows[i].Cells[1].Text = ENC.Encrypt_Main(GridView_View_Payments.Rows[i].Cells[1].Text, false);
                Label lbl_Date = (Label)GridView_View_Payments.Rows[i].FindControl("Label1");
            }
        }
        catch (Exception ex)
        {
            // Handle exception (logging can be added)
        }
    }

    protected void GridView_View_Payments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (string.IsNullOrEmpty(c))
                {
                    c = e.Row.Cells[3].Text;
                    e.Row.Cells[3].Text = c;
                }
                else if (c == e.Row.Cells[3].Text)
                {
                    e.Row.Cells[3].Text = "";
                }
                else
                {
                    c = e.Row.Cells[3].Text;
                    e.Row.Cells[3].Text = c;
                }

                total_amount += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "S_Amount"));
                e.Row.Cells[5].Text = co.place_Coma(e.Row.Cells[5].Text);

                DataRowView dr = (DataRowView)e.Row.DataItem;
                if (dr["Status"].ToString() != "Paid")
                {
                    LinkButton lbtn_cancel = (LinkButton)e.Row.FindControl("lbtn_cancel");
                    if (lbtn_cancel != null)
                    {
                        lbtn_cancel.Enabled = false;
                    }
                }
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[4].Text = "Total Amount:";
                e.Row.Cells[5].Text = total_amount.ToString();
            }
        }
        catch (Exception ex)
        {
            // Handle exception
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        try
        {
            Panel_Discount.Visible = false;
        }
        catch (Exception ex)
        {
            // Handle exception
        }
    }
    protected void lbtn_cancel_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in GridView_View_Payments.Rows)
            {
                HiddenField hiddenP_SID = (HiddenField)row.FindControl("HiddenField1");
                HiddenField hiddenYearlyNo = (HiddenField)row.FindControl("HiddenFieldYearlyNo");

                if (hiddenP_SID != null)
                {
                    string pSid = hiddenP_SID.Value;
                    string payid = hiddenYearlyNo.Value;

                    if (!string.IsNullOrEmpty(pSid))
                    {
                        InsertDiscountAfterPayment(pSid,payid);
                    }
                }
            }

            Response.Redirect("~/Patient%20Billing/Patient_Search_Discount_After_Bill.aspx");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
        }
    }
    private void InsertDiscountAfterPayment(string pSid, string YearlyNo)
    {
        try
        {
            string connString = ConfigurationManager.ConnectionStrings["PatientBillingConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("Pro_Discount_After_Payment", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ID", pSid);
                    cmd.Parameters.AddWithValue("@YearlyNo", YearlyNo);
                    cmd.Parameters.AddWithValue("@emp_ID", Session["emp_id"]);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Database Error: " + ex.Message);
        }
    }
    protected void AttachmentDoc()
    {
        string folderPath = Server.MapPath("~/DiscountReDoc/");

        if (!Directory.Exists(folderPath))
        {
            Directory.CreateDirectory(folderPath);
        }
        if (fileUploadReDoc.HasFile)
        {
            string fileName = Request.QueryString["payid"].ToString() + fileUploadReDoc.FileName;

            string fileNameWPath = Path.Combine(Server.MapPath("~/Patient Billing/DiscountReDoc"), fileName);

            fileUploadReDoc.SaveAs(fileNameWPath);

            lblmsg.Text = "Image Attached";
            lblmsg.ForeColor = System.Drawing.Color.ForestGreen;
            HFFileName.Value = fileName;
        }
        else
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Please Select Image to Attach . . .";
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void Button_ForwardDisReq_Click1(object sender, EventArgs e)
    {
        //AttachmentDoc();
        DbManager objDbManager = new DbManager();

        SqlParameter[] sqlParams = {
        new SqlParameter("YearlyNo", Request.QueryString["payid"])
    };

        DataTable dtDiscount = objDbManager.ExecuteDataTable("CheckDiscountRequest", "Reg_ConnectionString", sqlParams);

        if (dtDiscount.Rows.Count > 0)
        {
            lblDiscountMsg.Text = "Discount request already forwarded to " + dtDiscount.Rows[0]["Employee"].ToString();
        }
        else
        {
            using (SqlConnection ccc = new SqlConnection(conString))
            {
                string query = "SELECT SubDeptId FROM Employee WHERE (EmpID = @EmpID)";
                SqlCommand ccmd = new SqlCommand(query, ccc);
                ccmd.Parameters.AddWithValue("@EmpID", DropDownList_Consultant.SelectedValue);

                ccc.Open();
                HiddenField_SubDeptId.Value = Convert.ToString(ccmd.ExecuteScalar());
                HiddenField_BySubDeptId.Value = Session["SubDeptId"].ToString();
            }

            SqlDataSource3.Insert();
            Panel_Discount.Visible = true;
            lblDiscountMsg.Text = "";
            Response.Redirect("~/Patient Billing/PatientSearch.aspx");
        }
    }
}