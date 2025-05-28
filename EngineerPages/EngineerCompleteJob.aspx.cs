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
	public partial class EngineerCompleteJob : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                int engineerId = Convert.ToInt32(Session["UserID"]);
                LoadComplaintsByCategory(engineerId, "All");
            }
        }

        private void LoadComplaintsByCategory(int engineerId, string cat)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("sp_GetEngineerInprogressComplaintsByType", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EngineerID", engineerId);
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
            LoadComplaintsByCategory(engineerId, selectedCat);
        }

        protected void gvPendingComplaints_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void gvPendingComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPendingComplaints.PageIndex = e.NewPageIndex;
            string selectedCat = ddlJobFilter.SelectedValue;
            int engineerId = Convert.ToInt32(Session["UserID"]);
            LoadComplaintsByCategory(engineerId, selectedCat);
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
                        txtCreatedDate.Text = reader["CreatedDate"].ToString();
                        txtAssignedDate.Text = reader["AssignedAt"].ToString();
                        txtInprogress.Text = reader["InprogressAt"].ToString();
                        pnlUserDetails.Visible = true;
                        btnSave.Visible = true;

                    }

                    conn.Close();
                }

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int loggedId = Convert.ToInt32(Session["UserID"]);
            int complaintId = Convert.ToInt32(txtComplainId.Text);

            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_UpdateComplaintsStatusEngineer", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
                    cmd.Parameters.AddWithValue("@ComplaintID", complaintId);
                    cmd.Parameters.AddWithValue("@LoggedID", loggedId);


                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        {
                            lblStatus.Text = "✅ Complaint status updated successfully !";
                            lblStatus.ForeColor = System.Drawing.Color.Green;
                            lblStatus.Visible = true;
                            string selectedCat = ddlJobFilter.SelectedValue;

                            int engineerId = Convert.ToInt32(Session["UserID"]);
                            LoadComplaintsByCategory(engineerId, selectedCat);
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
            txtRemarks.Text = "";
            txtType.Text = "";
            txtDescription.Text = "";
            txtCreatedDate.Text = "";
            txtComplainId.Text = "";
            txtAssignedDate.Text = "";
        }
    }
}