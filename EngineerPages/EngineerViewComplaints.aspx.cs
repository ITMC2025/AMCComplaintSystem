using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AMCComplaintSystem.SiteMaster;

namespace AMCComplaintSystem.EngineerPages
{
	public partial class EngineerViewComplaints : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    int engineerId = Convert.ToInt32(Session["UserID"]);

                    LoadComplaintsByCategory(engineerId, "All");
                }
            }

        }

        private void LoadComplaintsByCategory(int engineerId, string cat)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetEngineerComplaintsByType", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EngineerId", engineerId);
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
            int engineerId = Convert.ToInt32(Session["UserID"]);
            LoadComplaintsByCategory(engineerId,selectedCat);
        }

        protected void gvPendingComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPendingComplaints.PageIndex = e.NewPageIndex;
            string selectedCat = ddlJobFilter.SelectedValue;
            int engineerId = Convert.ToInt32(Session["UserID"]);
            LoadComplaintsByCategory(engineerId, selectedCat);
        }
    }
}