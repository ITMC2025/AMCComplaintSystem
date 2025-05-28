using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMCComplaintSystem.CustormerPages
{
    public partial class ForwardComplain : System.Web.UI.Page
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

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SaveDetails();
        }

        private void SaveDetails()
        {
            if (ddlCategory.SelectedValue == "-1" || string.IsNullOrWhiteSpace(txtDescription.Text))
            {
                lblMessage.Text = "Please select a category and provide a description.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string category = ddlCategory.SelectedValue;
            string description = txtDescription.Text;
            int customerId = Convert.ToInt32(Session["UserID"]);

            string connString = ConfigurationManager.ConnectionStrings["AMC"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // Step 1: Insert the complaint and retrieve the ComplaintID
                    SqlCommand cmd = new SqlCommand("spInsertComplaint", conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    cmd.Parameters.AddWithValue("@CustomerID", customerId);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@Description", description);

                    SqlParameter outputIdParam = new SqlParameter("@ComplaintID", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputIdParam);

                    cmd.ExecuteNonQuery();
                    int complaintId = Convert.ToInt32(outputIdParam.Value);

                    // Step 2: Handle file upload (if any)
                    if (fileAttachment.HasFile)
                    {
                        string fileName = $"{DateTime.Now:yyyyMMddHHmmssfff}_{System.IO.Path.GetFileName(fileAttachment.PostedFile.FileName)}";
                        string attachmentPath = "~/Uploads/" + fileName;
                        fileAttachment.SaveAs(Server.MapPath(attachmentPath));

                        // Step 3: Insert into tblAttachments with correct procedure
                        SqlCommand attachCmd = new SqlCommand("spInsertAttachment", conn)
                        {
                            CommandType = CommandType.StoredProcedure
                        };
                        attachCmd.Parameters.AddWithValue("@ComplaintID", complaintId);
                        attachCmd.Parameters.AddWithValue("@FilePath", attachmentPath);
                        attachCmd.ExecuteNonQuery();
                    }

                    lblMessage.Text = $"✅ Complaint submitted successfully! Your Complaint ID is: <strong>{complaintId}</strong>";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    // Reset form fields
                    ddlCategory.SelectedIndex = 0;
                    txtDescription.Text = "";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"❌ Error: {ex.Message}";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                finally
                {
                    conn.Close();
                }
            }

        }
    }
}
