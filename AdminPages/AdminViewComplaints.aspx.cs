using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMCComplaintSystem.AdminPages
{
	public partial class ViewComplaints : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            string role = Session["Role"].ToString();
            if (role == null)
            {
                Response.Redirect("LoginForm.aspx");
            }
            else if (role != "Admin")
            {
                Response.Redirect("LoginForm.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadComplaintsByCategory("All");
                }
            }
        }

        private void LoadComplaintsByCategory(string cat)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetComplaintsByType", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cat", cat);
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                gvPendingComplaints.DataSource = dt;
                gvPendingComplaints.DataBind();
            }
        }

        protected void ddlJobFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCat = ddlJobFilter.SelectedValue;
            LoadComplaintsByCategory(selectedCat);
        }

        protected void gvPendingComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPendingComplaints.PageIndex = e.NewPageIndex;
            string selectedCat = ddlJobFilter.SelectedValue;
            LoadComplaintsByCategory(selectedCat);
        }
    }
}