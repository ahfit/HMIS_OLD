using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class CustomerLogin : System.Web.UI.Page
{
    Encryption enc = new Encryption();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void LogIn_Clicked(object sender, EventArgs e)
    {
        String username = txtUsername.Text.Trim();
        String password = txtPassword.Text.Trim();

        if (username != String.Empty && username!="Username" && password != String.Empty && password!="Password")
        {
            checkLogin(username, password);
        }
        else
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Invalid Username or Password";
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void checkLogin(String name,String pass)
    {

        string constring = ConfigurationManager.ConnectionStrings["Users_ConnectionString"].ConnectionString;
        SqlConnection con = new System.Data.SqlClient.SqlConnection(constring);
        
        //Enter procedure name
        string Procedurename = "usp_Check_Customer_Login";
        System.Data.SqlClient.SqlCommand mycommand = new System.Data.SqlClient.SqlCommand(Procedurename, con);
        mycommand.CommandType = System.Data.CommandType.StoredProcedure;
        mycommand.CommandText = Procedurename;
        //Declar User Name and password as input parameter
        mycommand.Parameters.AddWithValue("@Username", name );
        mycommand.Parameters.AddWithValue("@Password", pass);
        mycommand.Parameters.Add("@Company_Id", System.Data.SqlDbType.Int);
        mycommand.Parameters["@Company_Id"].Direction = ParameterDirection.Output;
        mycommand.Parameters.Add("@MainPage", System.Data.SqlDbType.VarChar, 400);
        mycommand.Parameters["@MainPage"].Direction = ParameterDirection.Output;
        mycommand.Parameters.Add("@Is_Activated", System.Data.SqlDbType.Bit);
        mycommand.Parameters["@Is_Activated"].Direction = ParameterDirection.Output;
        mycommand.Parameters.Add("@Is_Deleted", System.Data.SqlDbType.Bit);
        mycommand.Parameters["@Is_Deleted"].Direction = ParameterDirection.Output;
        mycommand.Parameters.Add("@Is_Valid_Login", System.Data.SqlDbType.Bit);
        mycommand.Parameters["@Is_Valid_Login"].Direction = ParameterDirection.Output;
        mycommand.Parameters.Add("@Company_Name", System.Data.SqlDbType.VarChar, 200);
        mycommand.Parameters["@Company_Name"].Direction = ParameterDirection.Output;
        con.Open();
        //Execute command
        mycommand.ExecuteNonQuery();
        bool? isValid = Convert.ToBoolean(mycommand.Parameters["@Is_Valid_Login"].Value.ToString());
        if (isValid != false)
        {
            if (Convert.ToBoolean(mycommand.Parameters["@Is_Activated"].Value.ToString()) != true)
            {
                lblMsg.Text = "User is not activated";
                lblMsg.Visible = true;

            }
            else if (Convert.ToBoolean(mycommand.Parameters["@Is_Deleted"].Value.ToString()) != false)
            {
                lblMsg.Text = "User is deleted";
                lblMsg.Visible = true;
            }
            else
            {
                Session.Add("Company_Id", mycommand.Parameters["@Company_Id"].Value.ToString());
                Session.Add("Company_Name", mycommand.Parameters["@Company_Name"].Value.ToString());
                Session.Add("username", name);
                Response.Redirect("~/Pathology/SearchCorporateLabPatient.aspx");
            }
        }
        else
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Invalid Username or Password";
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }

}