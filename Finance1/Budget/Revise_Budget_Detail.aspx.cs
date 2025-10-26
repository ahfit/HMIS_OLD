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


public partial class Revise_Budget_Detail : CSharpClass
{

    string constr = ConfigurationManager.ConnectionStrings["FinanceConnectionString"].ConnectionString;
    protected void DropDownList_Sub_ESH_name_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DropDownList_Sub_EH_Name.DataBind();
       // DropDownList_Sub_ESH_name.DataBind();
        SqlDataSource_Budget_Detail.DataBind();
        GridView2.DataBind();
        load_grid();
        //GridView2.DataBound();
    }

     protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string year;
        string dat;
        dat = Request.QueryString["Date_End"];
        year = dat.Substring(dat.LastIndexOf("/"),5);
        year = year.TrimStart('/'); 
        
        HiddenField_date.Value = year;

        if (!Page.IsPostBack)
        {
            DropDownList_Sub_EH_Name.DataBind();
            DropDownList_Sub_ESH_name.DataBind();
            SqlDataSource_Budget_Detail.DataBind();
            GridView2.DataBind();
            load_grid();
        }



    }
    
    void load_grid()
    {
        string qry = "SELECT E_ID, Estimated_Amount, Revise_Amount, Actual_Amount, Description FROM  Budget_Detail WHERE (B_ID = @B_ID) order by E_ID";
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;
        command.Parameters.AddWithValue("@B_ID", Request.QueryString["B_ID"].ToString());
            con.Open();
            SqlDataReader reader = command.ExecuteReader();
            while(reader.Read())
            {

                for (int i = 0; i <= GridView2.Rows.Count - 1; i++)
                {
                    if (Convert.ToInt32(GridView2.Rows[i].Cells[0].Text) == reader.GetInt32(0))
                    
                    {
                                TextBox estimated_amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Estimated_Amount");
                                TextBox Revise_Amount =(TextBox)GridView2.Rows[i].FindControl("TextBox_Revise_Amount");
                                TextBox Actual_Amount =(TextBox)GridView2.Rows[i].FindControl("TextBox_Actual_Amount");
                                TextBox Description=(TextBox)GridView2.Rows[i].FindControl("TextBox_Description");

                        estimated_amount.Text = Convert.ToString(reader.GetSqlValue(1));
                        if (estimated_amount.Text == "Null") { estimated_amount.Text = string.Empty; }
                        Revise_Amount.Text = Convert.ToString(reader.GetSqlValue(2));
                        if (Revise_Amount.Text == "Null") { Revise_Amount.Text = string.Empty; }
                        Actual_Amount.Text = Convert.ToString(reader.GetSqlValue(3));
                        if (Actual_Amount.Text == "Null") { Actual_Amount.Text = string.Empty; }
                        Description.Text = Convert.ToString(reader.GetSqlValue(4));
                        if (Description.Text == "Null") { Description.Text = string.Empty; }
                            
                    }
                
                }


            }
        }

    protected void DropDownList_Sub_EH_Name_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DropDownList_Sub_EH_Name.DataBind();
        DropDownList_Sub_ESH_name.DataBind();
        SqlDataSource_Budget_Detail.DataBind();
        GridView2.DataBind();
        load_grid();
        
        
        //DropDownList_Sub_ESH_name.DataBind();
        //GridView2.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox Estimated_Amount;
        TextBox Revise_Amount;
        TextBox Actual_Amount;
        TextBox Description;
        HiddenField E_Code;
        HiddenField E_name;


        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            Estimated_Amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Estimated_Amount");
            Revise_Amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Revise_Amount");
            Actual_Amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Actual_Amount");
            Description = (TextBox)GridView2.Rows[i].FindControl("TextBox_Description");
            E_Code = (HiddenField)GridView2.Rows[i].FindControl("HiddenField_E_Code");
            E_name = (HiddenField)GridView2.Rows[i].FindControl("HiddenField_E_Name");

            HiddenField_Estimated_Amount.Value = Estimated_Amount.Text;
            HiddenField_Revise_Amount.Value = Revise_Amount.Text;
            HiddenField_Actual_Amount.Value = Actual_Amount.Text;
            HiddenField_Description.Value = Description.Text;
            HiddenField_E_Code.Value = GridView2.Rows[i].Cells[1].Text;
            HiddenField_E_ID.Value = E_Code.Value;
            SqlDataSource_Budget_Detail.InsertParameters["E_Name"].DefaultValue = E_name.Value;
            if(HiddenField_Estimated_Amount.Value != "" )
            {SqlDataSource_Budget_Detail.Insert();}
        }
        
    }
    protected void GridView2_PreRender(object sender, EventArgs e)
    {

        if (GridView2.Rows.Count != 0)
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                GridView2.Rows[i].Cells[0].Visible = false;


            }
            GridView2.HeaderRow.Cells[0].Visible = false;

        }
    
    
    }
  
}
