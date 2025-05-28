using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMCComplaintSystem.EngineerPages
{
    public partial class EngineerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    int engineerId = Convert.ToInt32(Session["UserID"]);
                    LoadStats(engineerId);
                    LoadRecentComplaints(engineerId);
                }
            }

        }

        private void LoadRecentComplaints(int engineerId)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetEngineerRecentComplaints", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EngineerID", engineerId);
                conn.Open();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                gvRecentComplaints.DataSource = dt;
                gvRecentComplaints.DataBind();
            }
        }


        private void LoadStats(int engineerId)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetEngineerDashboardStats", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EngineerID", engineerId);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // lblTotalComplaints.Text = reader["TotalComplaints"].ToString();
                    lblPendingComplaints.Text = reader["PendingComplaints"].ToString();
                    lblNotAttend.Text = reader["NotAttendComplaints"].ToString();
                    lblCompletedJobs.Text = reader["ResolvedComplaints"].ToString();
                    lblInprogressComplaints.Text = reader["InProgressComplaints"].ToString();
                }
                reader.Close();
            }
        }
    }
}
