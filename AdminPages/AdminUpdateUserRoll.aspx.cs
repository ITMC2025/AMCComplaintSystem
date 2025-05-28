using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

namespace AMCComplaintSystem.AdminPages
{
    public partial class AdminUpdateUserRoll : System.Web.UI.Page
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
                    LoadUsers("Customer");
                }
            }
        }

        private void LoadUsers(string role)
        {
            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetUsersByRole", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Role", role);

                    DataTable dt = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);

                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectUser")
            {
                int userId = Convert.ToInt32(e.CommandArgument);

                string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand("sp_GetUserDetailsByID", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtFullName.Text = reader["FullName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                        txtMobileNo.Text = reader["MobileNo"].ToString();
                        txtAddress.Text = reader["Address"].ToString();
                        hfUserID.Value = userId.ToString();
                        pnlUserDetails.Visible = true;
                    }

                    conn.Close();
                }

            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(hfUserID.Value);
            string newRole = ddlRole.SelectedValue;
            string specialization = ddlSpecialization.SelectedValue;
            string mobileNo = txtMobileNo.Text.Trim();
            string address = txtAddress.Text.Trim();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AMC"].ConnectionString))
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("sp_UpdateUserRoleDetails", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@Role", newRole);
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    cmd.Parameters.AddWithValue("@MobileNo", mobileNo);
                    cmd.Parameters.AddWithValue("@Address", address);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();

                   
                        lblStatus.Text = "✅ User role updated successfully!";
                        lblStatus.ForeColor = System.Drawing.Color.Green;
                        lblStatus.Visible = true;

                        ClearFormFields();
                    
                }
                catch (Exception ex)
                {
                    lblStatus.Text = $"❌ Error: {ex.Message}";
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                    lblStatus.Visible = true;

                }
            }
            LoadUsers("Customer");
        }
        void ClearFormFields()
        {
            ddlRole.SelectedIndex = 0;
            ddlSpecialization.SelectedIndex = 0;
            txtMobileNo.Text = "";
            txtAddress.Text = "";
            txtAddress.Text = "";
            txtEmail.Text = "";
            txtFullName.Text = "";
          //  txt
        }
    }
}