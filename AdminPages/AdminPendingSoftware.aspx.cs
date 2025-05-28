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
	public partial class AdminPendingSoftware : System.Web.UI.Page
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
                    LoadComplaints(1, "Software");

                }
            }
        }

        private void LoadComplaints(int actionType, string category)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetAdminComplaintsByStatusAndCategory", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ActionType", actionType);
                    cmd.Parameters.AddWithValue("@Category", category);

                    try
                    {
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvPendingComplaints.DataSource = dt;
                        gvPendingComplaints.DataBind();

                        if (dt.Rows.Count == 0)
                        {
                            gvPendingComplaints.EmptyDataText = "No complaints found.";
                            gvPendingComplaints.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {

                        Response.Write($"<script>alert('Error: {ex.Message}');</script>");
                    }
                }
            }
        }
    }
}