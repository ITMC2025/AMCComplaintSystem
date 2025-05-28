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
    public partial class EngineerPendingSoftware : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComplaints(1, "Software");
                LoadUserName();
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

        private void LoadComplaints(int actionType, string category)
        {

            int engineerId = Convert.ToInt32(Session["UserID"]);
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetEngineerPendingComplaintsByType", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EngineerId", engineerId);
                   // cmd.Parameters.AddWithValue("@ActionType", actionType);
                    cmd.Parameters.AddWithValue("@Cat", category);

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
