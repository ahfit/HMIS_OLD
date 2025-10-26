using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class Radiology_Pt_View_Xray : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Xray_Image();
        Label1.Text = Request.RawUrl;
    }

    protected void Xray_Image()
    {
        try
        {
            if (Request.QueryString["TB_ID"] != null && Request.QueryString["RegNo"] != null && Request.QueryString["YearlyNo"] != null)
            {
                SqlDataAdapter da = new SqlDataAdapter();
                DataSet ds = new DataSet();
                string constring = ConfigurationManager.ConnectionStrings["RadiologyConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(constring);
                SqlCommand mycommand = new SqlCommand("SELECT path_ID, YearlyNo, TB_ID, Image, RegNo FROM Pt_Path_Images WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND TB_ID = @TB_ID", con);
                mycommand.CommandType = CommandType.Text;
                SqlParameter param;
                param = mycommand.Parameters.AddWithValue("@TB_ID", Request.QueryString["TB_ID"]);
                param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString["RegNo"]);
                param = mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString["YearlyNo"]);
                con.Open();

                da.SelectCommand = mycommand;
                da.Fill(ds);
                con.Close();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        Table_Label("<Table class ='Grid_1' border = '1' align='center' style = 'padding:10px'><tr><td>", pnlXrayImages);
                    }
                    else if (i % 7 == 0)
                    {
                        Table_Label("</tr><tr><td>", pnlXrayImages);
                    }
                    else
                    {
                        Table_Label("<td>", pnlXrayImages);
                    }
                    Table_Label("<a href ='" + ds.Tables[0].Rows[i]["Image"].ToString() + "' target='_self'", pnlXrayImages);
                    Image control = new Image();
                    control.ImageUrl = ds.Tables[0].Rows[i]["Image"].ToString();
                    control.Width = 120;
                    control.Height = 120;
                    pnlXrayImages.Controls.Add(control);
                    Table_Label("</a>", pnlXrayImages);
                    if (i == ds.Tables[0].Rows.Count - 1)
                    {
                        Table_Label("</td></tr></table>", pnlXrayImages);
                    }
                    else
                    {
                        Table_Label("</td>", pnlXrayImages);
                    }
                }
            }
        }
        catch
        {

        }
    }

    protected void Table_Label(string Lbl, Panel pnl)
    {
        Label lbl_tbl = new Label();
        lbl_tbl.Text = Lbl;
        pnl.Controls.Add(lbl_tbl);
    }

}
