using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Store_Returnable_Gate_Pass : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            WebDateChooser_date.Value = DateTime.Now;
            drReturnDate.Value = DateTime.Now;
           
            SetInitialRow();
        }
    }
    protected void SetInitialRow()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dt.Columns.Add(new DataColumn("ItemCode", typeof(string)));
        dt.Columns.Add(new DataColumn("Description", typeof(string)));
        dt.Columns.Add(new DataColumn("UOM", typeof(string)));
        dt.Columns.Add(new DataColumn("Quantity", typeof(string)));
        dt.Columns.Add(new DataColumn("Unit(s)", typeof(string)));
        dr = dt.NewRow();
        dr["RowNumber"] = 1;
        dr["ItemCode"] = string.Empty;
        dr["Description"] = string.Empty;
        dr["UOM"] = string.Empty;
        dr["Quantity"] = string.Empty;
        dr["Unit(s)"] = string.Empty;

        dt.Rows.Add(dr);
        //dr = dt.NewRow();

        //Store the DataTable in ViewState
        ViewState["CurrentTable"] = dt;

        Outward_Gate_Pass_Info.DataSource = dt;
        Outward_Gate_Pass_Info.DataBind();
    }
    protected void btnaddrow_Click(object sender, EventArgs e)
    {
        AddNewRowToGrid();
    }
    private void AddNewRowToGrid()
    {
        int rowIndex = 0;

        if (ViewState["CurrentTable"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;
            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {

                    TextBox boxIC = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[1].FindControl("tbxItemCode");
                    TextBox box1 = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[1].FindControl("tbxDescription");
                    TextBox boxUOM = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[1].FindControl("tbxUOM");
                    TextBox box2 = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[2].FindControl("tbxqty");
                    TextBox box3 = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[3].FindControl("tbxunit");

                    drCurrentRow = dtCurrentTable.NewRow();

                    drCurrentRow["RowNumber"] = i + 1;
                    dtCurrentTable.Rows[i - 1]["ItemCode"] = boxIC.Text;
                    dtCurrentTable.Rows[i - 1]["Description"] = box1.Text;
                    dtCurrentTable.Rows[i - 1]["UOM"] = boxUOM.Text;
                    dtCurrentTable.Rows[i - 1]["Quantity"] = box2.Text;
                    dtCurrentTable.Rows[i - 1]["Unit(s)"] = box3.Text;

                    rowIndex++;
                }
                dtCurrentTable.Rows.Add(drCurrentRow);
                ViewState["CurrentTable"] = dtCurrentTable;

                Outward_Gate_Pass_Info.DataSource = dtCurrentTable;
                Outward_Gate_Pass_Info.DataBind();
            }
        }
        else
        {
            Response.Write("ViewState is null");
        }

        //Set Previous Data on Postbacks
        SetPreviousData();
    }
    private void SetPreviousData()
    {
        int rowIndex = 0;
        if (ViewState["CurrentTable"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTable"];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)


                {

                    TextBox boxIC = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[1].FindControl("tbxItemCode");
                    TextBox box1 = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[1].FindControl("tbxDescription");
                    TextBox boxUOM = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[1].FindControl("tbxUOM");
                    TextBox box2 = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[2].FindControl("tbxqty");
                    TextBox box3 = (TextBox)Outward_Gate_Pass_Info.Rows[rowIndex].Cells[3].FindControl("tbxunit");


                    boxIC.Text = dt.Rows[i]["ItemCode"].ToString();
                    box1.Text = dt.Rows[i]["Description"].ToString();
                    boxUOM.Text = dt.Rows[i]["UOM"].ToString();
                    box2.Text = dt.Rows[i]["Quantity"].ToString();
                    box3.Text = dt.Rows[i]["Unit(s)"].ToString();

                    rowIndex++;
                }
            }
        }
    }
   
    protected void btnsave_Click(object sender, EventArgs e)
    {
        if (TextBox_No.Text.Trim() != "" && WebDateChooser_date.Value != null)
        {
            lblMsg.Visible = false;
            insertRecordsMain();
            insertRecordsSub();
            lblMsg.Text = "Record Saved Successfully";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Visible = true;
            ClearRecord();
            Response.Redirect("~/Store/Returnable_GatePassReport.aspx?ID=" + GatePass_Main_ID.Value + "&Type=" + ddlType.SelectedItem.Text);
        }
        else
        {
            lblMsg.Visible = true;
        }
    }
    protected void insertRecordsMain()
    {
        sdsOutGatePass_Main.InsertParameters["Gate_PassDate"].DefaultValue = WebDateChooser_date.Value.ToString();
        sdsOutGatePass_Main.InsertParameters["Return_Date"].DefaultValue = drReturnDate.Value.ToString();
       
        sdsOutGatePass_Main.Insert();
    }
    protected void insertRecordsSub()
    {
        if (Outward_Gate_Pass_Info.Rows.Count > 0)
        {
            
            for (int i = 0; i < Outward_Gate_Pass_Info.Rows.Count; i++)
            {

                TextBox txtItemCode = Outward_Gate_Pass_Info.Rows[i].FindControl("tbxItemCode") as TextBox;
                TextBox txtDescription = Outward_Gate_Pass_Info.Rows[i].FindControl("tbxDescription") as TextBox;
                TextBox txtUOM = Outward_Gate_Pass_Info.Rows[i].FindControl("tbxUOM") as TextBox;
                TextBox txtQty = Outward_Gate_Pass_Info.Rows[i].FindControl("tbxqty") as TextBox;
                TextBox txtUnits = Outward_Gate_Pass_Info.Rows[i].FindControl("tbxunit") as TextBox;

                sdsOutGatePss_Sub.InsertParameters["Sr_No"].DefaultValue = (i+1).ToString();
                sdsOutGatePss_Sub.InsertParameters["ItemCode"].DefaultValue = txtItemCode.Text;
                sdsOutGatePss_Sub.InsertParameters["Description"].DefaultValue = txtDescription.Text;
                sdsOutGatePss_Sub.InsertParameters["UOM"].DefaultValue = txtUOM.Text;
                sdsOutGatePss_Sub.InsertParameters["Unit"].DefaultValue = txtUnits.Text;
                sdsOutGatePss_Sub.InsertParameters["Qty"].DefaultValue = txtQty.Text;
                sdsOutGatePss_Sub.InsertParameters["Remarks"].DefaultValue = "";
                sdsOutGatePss_Sub.Insert();
                
            }
        }
    }
    protected void sdsOutGatePass_Main_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GatePass_Main_ID.Value = e.Command.Parameters["@GP_ID"].Value.ToString();
    }
    private void ClearRecord()
    {
        TextBox_No.Text = "";
        TextBox_Vehicle_No.Text = "";
        TextBox_Ch_For_Rs.Text = "";
        TextBox_Ch_For_Rs0.Text = "";
        TextBox_No.Text = "";
        TextBoxThrough.Text = "";
       

    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType.SelectedValue == "Returnable")
        {
            drReturnDate.Visible = true;
            
        }
        else
        {
            drReturnDate.Visible = false;
        }
    }
}