using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMCComplaintSystem
{
    public partial class LoginForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtEmail.Focus();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT UserID, FullName, Role, Specialization, PasswordHash FROM tblUsers WHERE Email = @Email AND Status ='Active'";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        string storedPassword = reader["PasswordHash"].ToString();
                        if (VerifyPassword(txtPassword.Text.Trim(), storedPassword))
                        {

                            Session["UserID"] = reader["UserID"].ToString();
                            Session["FullName"] = reader["FullName"].ToString();
                            Session["Role"] = reader["Role"].ToString();
                            Session["Specialization"] = reader["Specialization"].ToString();


                            string role = reader["Role"].ToString();
                            switch (role)
                            {
                                case "Admin":
                                    Response.Redirect("~/AdminPages/AdminDashBoard.aspx");
                                    break;
                                case "Engineer":
                                    Response.Redirect("~/EngineerPages/EngineerDashBoard.aspx");
                                    break;
                                default:
                                    Response.Redirect("~/CustormerPages/CustomerDashboard.aspx");

                                    break;
                            }
                        }
                        else
                        {
                            lblMessage.Text = "❌ Invalid email or password.";
                            lblMessage.CssClass = "alert alert-danger";
                            lblMessage.Visible = true;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "❌ Invalid email or password.";
                        lblMessage.CssClass = "alert alert-danger";
                        lblMessage.Visible = true;
                    }
                }
            }
        }
        private bool VerifyPassword(string enteredPassword, string storedHash)
        {
            string enteredHash = HashPassword(enteredPassword); // Hash entered password
            return enteredHash.Equals(storedHash, StringComparison.OrdinalIgnoreCase);
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}