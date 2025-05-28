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

namespace AMCComplaintSystem.AdminPages
{
    public partial class AdminAssignedComplaints : System.Web.UI.Page
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
                SqlCommand cmd = new SqlCommand("sp_GetPendingComplaintsByType", conn);
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

        protected void gvPendingComplaints_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectComplaint")
            {
                int complaintId = Convert.ToInt32(e.CommandArgument);

                string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand("sp_GetComplaintsById", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ComplaintId", complaintId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtComplainId.Text = reader["ComplaintID"].ToString();
                        txtType.Text = reader["Category"].ToString();
                        txtDescription.Text = reader["Description"].ToString();

                        pnlUserDetails.Visible = true;
                        LoadEngineersByType(txtType.Text);
                        pnlEngineers.Visible = true;
                    }

                    conn.Close();
                }

            }
        }

        private void LoadEngineersByType(string specilization)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetUsersBySpecilization", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Specilization", specilization);

                    DataTable dt = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);

                    gvEngineers.DataSource = dt;
                    gvEngineers.DataBind();
                }
            }
        }

        protected void ddlJobFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCat = ddlJobFilter.SelectedValue;
            LoadComplaintsByCategory(selectedCat);
        }

        protected void gvEngineers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int userId = Convert.ToInt32(e.CommandArgument);
            int loggedId = Convert.ToInt32(Session["UserID"]);
            int complaintId = Convert.ToInt32(txtComplainId.Text);

            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_UpdateAssignedComplaintsEngineer", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@ComplaintID", complaintId);
                    cmd.Parameters.AddWithValue("@LoggedID", loggedId);


                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                       
                        {
                            lblStatus.Text = "✅ Complaint successfully assigned to the engineer!";
                            lblStatus.ForeColor = System.Drawing.Color.Green;
                            lblStatus.Visible = true;
                            string selectedCat = ddlJobFilter.SelectedValue;
                            LoadComplaintsByCategory(selectedCat);
                            LoadEngineersByType(txtType.Text);
                            ClearFields();
                        }

                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = $"❌ Error: {ex.Message}";
                        lblStatus.ForeColor = System.Drawing.Color.Red;
                        lblStatus.Visible = true;
                    }
                }
            }
        }

        private void ClearFields()
        {
            txtComplainId.Text = "";
            txtDescription.Text = "";
            txtType.Text = "";
        }

        protected void gvPendingComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPendingComplaints.PageIndex = e.NewPageIndex;
            string selectedCat = ddlJobFilter.SelectedValue;
            LoadComplaintsByCategory(selectedCat);
        }
    }
}