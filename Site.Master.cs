using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMCComplaintSystem
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetMenuVisibility();
                lblYear.Text = DateTime.Now.Year.ToString(); // Set footer year dynamically

            }
        }

        private void SetMenuVisibility()
        {
            string userRole = Session["Role"] as string;

            if (string.IsNullOrEmpty(userRole))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Hide all menus initially
            hlComplaints.Visible = false;
            hlEngineers.Visible = false;
            reportsMenu.Visible = false;
            panelPending.Visible = false;
            panelInProgress.Visible = false;
            panelCompleted.Visible = false;

            hlPendingSoftware.Visible = false;
            hlPendingHardware.Visible = false;
            hlInProgressSoftware.Visible = false;
            hlInProgressHardware.Visible = false;
            hlCompletedSoftware.Visible = false;
            hlCompletedHardware.Visible = false;

            // Show menus based on role
            switch (userRole)
            {
                case "Customer":
                    hlComplaints.Visible = true;
                    reportsMenu.Visible = true;
                    panelPending.Visible = true;
                    panelInProgress.Visible = true;
                    panelCompleted.Visible = true;

                    // Explicitly make submenu items visible
                    hlPendingSoftware.Visible = true;
                    hlPendingHardware.Visible = true;
                    hlInProgressSoftware.Visible = true;
                    hlInProgressHardware.Visible = true;
                    hlCompletedSoftware.Visible = true;
                    hlCompletedHardware.Visible = true;
                    break;

                case "Engineer":
                    hlComplaints.Visible = true;
                    reportsMenu.Visible = true;
                    panelPending.Visible = true;
                    panelInProgress.Visible = true;
                    panelCompleted.Visible = true;

                    hlPendingSoftware.Visible = true;
                    hlPendingHardware.Visible = true;
                    hlInProgressSoftware.Visible = true;
                    hlInProgressHardware.Visible = true;
                    hlCompletedSoftware.Visible = true;
                    hlCompletedHardware.Visible = true;
                    break;

                case "Admin":
                    hlComplaints.Visible = true;
                    hlEngineers.Visible = true;
                    reportsMenu.Visible = true;
                    panelPending.Visible = true;
                    panelInProgress.Visible = true;
                    panelCompleted.Visible = true;

                    hlPendingSoftware.Visible = true;
                    hlPendingHardware.Visible = true;
                    hlInProgressSoftware.Visible = true;
                    hlInProgressHardware.Visible = true;
                    hlCompletedSoftware.Visible = true;
                    hlCompletedHardware.Visible = true;
                    break;
            }
        }

    }
}