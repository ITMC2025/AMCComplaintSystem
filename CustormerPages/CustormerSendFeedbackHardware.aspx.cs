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
    public partial class CustormerSendFeedbackHardware : System.Web.UI.Page
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
                    int CusId = Convert.ToInt32(Session["UserID"]);
                    LoadComplaints(CusId, "Hardware");
                }
            }
        }
        private void LoadComplaints(int CusId, string category)
        {
            int customerId = Convert.ToInt32(Session["UserID"]);
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetPendingFeedbackComplaints", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CustomerID", customerId);

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
                            gvPendingComplaints.EmptyDataText = "No job completed complaints found.";
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

        protected void gvPendingComplaints_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectComplaint")
            {
                string complaintId = e.CommandArgument.ToString();

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

                        pnlUserDetails.Visible = true;
                        btnSave.Visible = true;

                    }

                    conn.Close();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int complaintId = Convert.ToInt32(txtComplainId.Text);
            string comments = txtRemarks.Text.Trim();
            int rating = Convert.ToInt32(rblRating.SelectedValue);
            int customerId = Convert.ToInt32(Session["UserID"]);

            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_SaveFeedback", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ComplaintID", complaintId);
                    cmd.Parameters.AddWithValue("@CustomerID", customerId);
                    cmd.Parameters.AddWithValue("@Rating", rating);
                    cmd.Parameters.AddWithValue("@Comments", comments);

                    try
                    {
                        conn.Open();
                      cmd.ExecuteNonQuery();

                        lblStatus.Text = "✅ Feedback saved successfully!";
                        lblStatus.ForeColor = System.Drawing.Color.Green;
                        lblStatus.Visible = true;

                     
                        LoadComplaints(customerId, "Hardware");

                        
                        pnlUserDetails.Visible = false;
                        btnSave.Visible = false;

                        txtRemarks.Text = "";
                        rblRating.ClearSelection();
                        txtComplainId.Text = "";
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "❌ Error saving feedback: " + ex.Message;
                        lblStatus.ForeColor = System.Drawing.Color.Red;
                        lblStatus.Visible = true;
                    }
                }
            }
        }
    }
}