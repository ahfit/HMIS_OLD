<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Approve_Qutations.aspx.cs" Inherits="Store_Approve_Qutations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%;">
 <h2><span>Approve Qutations</span></h2>
</div>
    <asp:GridView ID="GridView1" runat="server" Width="100%" 
        DataSourceID="SqlDataSource1" AutoGenerateColumns="False" 
        DataKeyNames="Qutation_Main_ID">
        <Columns>
            <asp:BoundField DataField="Qutation_Date" 
                HeaderText="Qutation_Date" SortExpression="Date" />
            <asp:BoundField DataField="Party_Name" HeaderText="Party Name" 
                SortExpression="Party_Name" />
            <asp:BoundField DataField="Item_Qty" HeaderText="Total Quantity" 
                SortExpression="Item_Qty" />
            <asp:BoundField DataField="Accumulated_Discount" HeaderText="Accumulated Discount" 
                SortExpression="Accumulated_Discount" />
            <asp:BoundField DataField="Final_Price" HeaderText="Final Price" 
                SortExpression="Final_Price" />
            <asp:BoundField DataField="Delivery_Days" HeaderText="Delivery Days" 
                SortExpression="Delivery_Days" />
            <asp:BoundField DataField="Tax" HeaderText="Tax" 
                SortExpression="Tax" />
            <asp:BoundField DataField="Terms_Conditions" HeaderText="Terms & Conditions" 
                SortExpression="Terms_Conditions" />
            <asp:BoundField DataField="Payment" HeaderText="Payment" 
                SortExpression="Payment" />
             <asp:TemplateField headerText="Approve Qutation">
                                <itemTemplate>
                                    <asp:LinkButton ID="lbApproveQutation" runat="server" 
                                        CommandArgument='<%# Bind("Demand_RQ_ID") %>' 
                                        text="Approve" onclick="lbApproveQutation_Click" ></asp:LinkButton>
                                    <asp:HiddenField ID="hfQutation_Main_ID" runat="server" 
                                        Value='<%# Eval("Qutation_Main_ID") %>' />
                                </itemtemplate>
                            </asp:TemplateField>
            
            
            
        </Columns>
        
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT
	Qutation_Main.Qutation_Main_ID,
	parties.Party_Name,
	SUM(Demand_Requisition_Sub.Item_Qty) AS Item_Qty,
	CONVERT(varchar, Qutation_Main.Qutation_Date, 103) AS Qutation_Date,
	Qutation_Main.Accumulated_Discount,
	Qutation_Main.Final_Price,
	Qutation_Main.Delivery_Days,
	Qutation_Main.Tax,
	Qutation_Main.Terms_Conditions,
	Qutation_Main.Demand_RQ_ID,
	Qutation_Main.Payment
	
FROM Qutation_Main
INNER JOIN Qutation_Sub
	ON Qutation_Main.Qutation_Main_ID = Qutation_Sub.Qutation_Main_ID
INNER JOIN Demand_Requisition_Sub
	ON Qutation_Main.Demand_RQ_ID = Demand_Requisition_Sub.Demand_RQ_ID AND
	Qutation_Sub.Item_Code = Demand_Requisition_Sub.Item_Code
LEFT OUTER JOIN parties
	ON Qutation_Main.Vendor_ID = parties.Party_Id
WHERE (Qutation_Main.Demand_RQ_ID = @Demand_RQ_ID)
GROUP BY	Qutation_Main.Qutation_Main_ID,
			parties.Party_Name,
			Qutation_Main.Qutation_Date,
			Qutation_Main.Accumulated_Discount,
			Qutation_Main.Final_Price,
			Qutation_Main.Delivery_Days,
			Qutation_Main.Tax,
			Qutation_Main.Terms_Conditions,
			Qutation_Main.Demand_RQ_ID,
			Qutation_Main.Payment
            ORDER BY parties.Party_Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

