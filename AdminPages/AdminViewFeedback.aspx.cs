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
    public partial class AdminViewFeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string role = Session["Role"].ToString();
            if (role == null)
            {
                Response.Redirect("~/LoginForm.aspx");
            }
            else if (role != "Admin")
            {
                Response.Redirect("~/LoginForm.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadFeedbacks("All");
                    LoadUserName();
                }
            }
        }
        private void LoadUserName()
        {
            if (Session["UserID"] != null)
            {
                int customerId = Convert.ToInt32(Session["UserID"]);
                string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_GetLoggedUserName", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserID", customerId);

                        try
                        {
                            conn.Open();
                            object result = cmd.ExecuteScalar();

                            if (result != null)
                            {
                                lblUserName.Text = $"Welcome, {result.ToString()}!";
                            }
                            else
                            {
                                lblUserName.Text = "Welcome, Guest!";
                            }
                        }
                        catch (Exception ex)
                        {
                            lblUserName.Text = "Error loading user name";

                            System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
                        }
                    }
                }
            }
            else
            {
                lblUserName.Text = "Welcome, Guest!";
            }
        }

        private void LoadFeedbacks(string cat)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetFeedbackForAdmin", conn);
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

            LoadFeedbacks(selectedCat);
        }
        protected string GetEmoji(int rating)
        {
            switch (rating)
            {
                case 5:
                    return "😄 Excellent";
                case 4:
                    return "🙂 Good";
                case 3:
                    return "😐 Average";
                case 2:
                    return "😕 Poor";
                case 1:
                    return "😡 Bad";
                default:
                    return "Unknown";
            }
        }
    }
}