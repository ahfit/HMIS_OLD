using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Gatepass_SearchAddPOtoGP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
          
            wdcFromDate.Value = DateTime.Now.AddDays(-6);
            wdcToDate.Value = DateTime.Now;
            
        }
    }
    protected void bindGrid()
    {
        try
        {
            DbManager db = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@GPNo", txtGPNo.Text), new SqlParameter("@FromDate", wdcFromDate.Value.ToString()),
                                  new SqlParameter("@ToDate", wdcToDate.Value.ToString()),new SqlParameter("@Type", ddlGPType.SelectedValue)};
            gvGPValues.DataSource = db.ExecuteDataTable("uspGetGPForAddPO", "STOREConnectionString", sp);
            gvGPValues.DataBind();
            
        }
        catch(Exception ex)
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindGrid();
    }
   protected void bindPoList()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("Select PO_ID from Purchase_Order_Main", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlPo.DataSource = dt;
        ddlPo.DataBind();
        con.Close();
    }
    protected void lnkAddPO_Click(object sender, EventArgs e)
    {
        bindPoList();
        ddlPo_SelectedIndexChanged(sender, e);
        LinkButton btn = sender as LinkButton;
        HiddenField hfdgpsubid = (HiddenField) btn.FindControl("hfdgpsubid");
        hfdGPsubid.Value = hfdgpsubid.Value;
        panel.Visible = true;
    }

    protected void ddlPo_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("Select PM.PO_ID,I.Item_Name,I.Item_Code,PS.Rate,PS.Qty from Purchase_Order_Main PM join Purchase_Order_Sub PS on PM.PO_ID=PS.PO_ID join Store_Items I on I.Item_Code = PS.Item_Code where PM.PO_ID = @poid", con);
        cmd.Parameters.AddWithValue("@poid", ddlPo.SelectedValue);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        gvdPoItems.DataSource = dt;
        gvdPoItems.DataBind();
        con.Close();
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {

     
        foreach (GridViewRow row in gvdPoItems.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox ckbx = (CheckBox)row.FindControl("ckcheck");
                if (ckbx.Checked)
                {
                    HiddenField hfdPoid = (HiddenField)row.FindControl("hfdpoid");
                    HiddenField hfdItemCode = (HiddenField)row.FindControl("hfdItemCode");
                        HiddenField hfdQty = (HiddenField)row.FindControl("hfdQty");
                        

                    SqlCommand cmd;
                    string conString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
                    SqlConnection con = new SqlConnection(conString);
                    cmd = new SqlCommand("if not exists (Select id from  GPTrack where po_Id=@poid and GPSubID=@GPSubid and ItemCode=@ItemCode) Begin INSERT INTO [dbo].[GPTrack] ([po_Id]  ,[ItemCode]  ,[GDate],GPSubID,ItemQty)   VALUES (@poid ,@ItemCode  ,GetDate(),@GPSubid,@qty) END", con);
                    cmd.Parameters.AddWithValue("@poid", hfdPoid.Value);
                    cmd.Parameters.AddWithValue("@ItemCode", hfdItemCode.Value);
                    cmd.Parameters.AddWithValue("@GPSubid", hfdGPsubid.Value);
                        cmd.Parameters.AddWithValue("@qty", hfdQty.Value);
                        cmd.CommandType = CommandType.Text;
                    con.Open();
                    cmd.ExecuteNonQuery();

                    con.Close();
                }
            }
        }
        }
        catch (Exception ex)
        {


        }
    }

    protected void Unnamed_Click(object sender, ImageClickEventArgs e)
    {
        panel.Visible = false;
    }
}