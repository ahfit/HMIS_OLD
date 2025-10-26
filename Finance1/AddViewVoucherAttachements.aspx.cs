using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Finance_AddViewVoucherAttachements : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            if(Request.QueryString["VTI"]!=null)
            {
                getData();
            }
        }
    }
    protected void getData()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@VTI", Request.QueryString["VTI"]) };
            gvAttachments.DataSource = dbm.ExecuteDataTable("uspGetVoucherAttachments", "Finance_ConnectionString", sp);
            gvAttachments.DataBind();
        }
        catch(Exception ex)
        {

        }
    }

    protected void btnSaveAttachment_Click(object sender, EventArgs e)
    {
        if(fuVoucher.HasFile)
        {
            lblMsg.Visible = false;
            if (fuVoucher.PostedFile.ContentType == "application/pdf" || fuVoucher.PostedFile.ContentType == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" || fuVoucher.PostedFile.ContentType == "image/jpeg")
            {
                saveRecord();
                getData();
                lblMsg.Text = "File save successfully!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMsg.Text = "File format not correct only select (pdf,jpg,excel)";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblMsg.Text = "Select file first...";
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void saveRecord()
    {
        try
        {
            string fileName = Path.GetFileName(fuVoucher.PostedFile.FileName);
            string extension = Path.GetExtension(fuVoucher.PostedFile.FileName);
            fileName = Request.QueryString["VTI"].ToString() + "_" + (gvAttachments.Rows.Count + 1).ToString()+extension;
            //Set the Image File Path.
            string filePath = "~/VoucherAttachments/" + fileName;

            //Save the Image File in Folder.
            fuVoucher.PostedFile.SaveAs(Server.MapPath(filePath));

            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@Voucher_Trans_ID", Request.QueryString["VTI"]), new SqlParameter("@FileName", fileName),
                                  new SqlParameter("@FilePath", filePath),new SqlParameter("@FileExtension", fuVoucher.PostedFile.ContentType.ToString()),
                                  new SqlParameter("@EntryBy", Session["emp_id"])
                                };
           dbm.ExecuteNonQuery("uspInsertVoucherAttachment", "Finance_ConnectionString", sp);
        }
        catch (Exception ex)
        {

        }
    }

    protected void imgDelete_Click(object sender, ImageClickEventArgs e)
    {
        lblMsg.Visible = false;
        try
        {
            ImageButton img = (ImageButton)sender;
            GridViewRow row = (GridViewRow)img.NamingContainer;
            HiddenField fname = (HiddenField)row.FindControl("hdfFileName");
            String path = Server.MapPath("~/VoucherAttachments/") + fname.Value;
            if (File.Exists(path))
            {
                File.Delete(path);
                
            }
            else
            {
                //lblMsg.Visible = true;
                //lblMsg.Text = "File not found";
                //lblMsg.ForeColor = System.Drawing.Color.Yellow;
            }
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@ID", img.CommandArgument) };
            dbm.ExecuteNonQuery("uspDeleteAttachment", "Finance_ConnectionString", sp);
            lblMsg.Visible = true;
            lblMsg.Text = "Deleted successfully!!!";
            lblMsg.ForeColor = System.Drawing.Color.YellowGreen;
            getData();
        }
        catch(Exception ex)
        {

        }
    }
}