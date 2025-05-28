using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace AMCComplaintSystem.CustormerPages
{
    public partial class CustomerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string role = Session["Role"].ToString();
            if (role == null)
            {
                Response.Redirect("~/LoginForm.aspx");
            }
            else if (role != "Customer")
            {
                Response.Redirect("~/LoginForm.aspx");
            }
            else
            {

                if (!IsPostBack)
                {
                    if (Session["UserID"] != null)
                    {
                        int customerId = Convert.ToInt32(Session["UserID"]);
                        LoadStats(customerId);
                    }
                }
            }

        }

        private void LoadStats(int customerId)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetUserDashboardStats", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", customerId);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblTotalComplaints.Text = reader["TotalComplaints"].ToString();
                    lblPendingComplaints.Text = reader["PendingComplaints"].ToString();
                    lblCompletedJobs.Text = reader["ResolvedComplaints"].ToString();
                    lblInprogressComplaints.Text = reader["InProgressComplaints"].ToString();
                }
                reader.Close();
            }
        }
    }
}