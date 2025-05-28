using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMCComplaintSystem
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string con = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string mobileNo = txtMobileNo.Text.Trim();
            string address = txtAddress.Text.Trim();
            string hashedPassword = HashPassword(password); 
            string role = "Customer"; 
            string specialization = "None";
            string status = "Active";

            using (SqlConnection conn = new SqlConnection(con))
            {
                string query = "INSERT INTO tblUsers (FullName, Email, PasswordHash, Role, Specialization, MobileNo, Address,Status) " +
                               "VALUES (@FullName, @Email, @PasswordHash, @Role, @Specialization, @MobileNo, @Address,@Status)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@Specialization", specialization);
                    cmd.Parameters.AddWithValue("@MobileNo", mobileNo);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@Status", status);


                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Registration successful!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        ClearFields();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Registration successful!'); window.location='LoginForm.aspx';", true);

                    }
                    else
                    {
                        lblMessage.Text = "Registration failed. Please try again.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }

        }

        private void ClearFields()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
             
            txtMobileNo.Text = "";
            txtAddress.Text = "";
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