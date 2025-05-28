using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMCComplaintSystem.CustormerPages
{
    public partial class CustormerInprogressSoftware : System.Web.UI.Page
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
                    LoadComplaints(2, "Software");
                    LoadUserName();
                }
            }
        }
        private void LoadUserName()
        {
            // Ensure the session has UserID
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
                            // Optionally log the error
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
            int customerId = Convert.ToInt32(Session["UserID"]);
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetComplaintsByStatusAndCategory", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CustomerID", customerId);
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