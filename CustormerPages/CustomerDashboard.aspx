<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Custormer.Master" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="AMCComplaintSystem.CustormerPages.CustomerDashboard" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%--<h2 style="text-align: center; color: #4CAF50; margin-bottom: 20px;">Admin Dashboard</h2>--%>
 
   <div class="dashboard-stats" style="display: flex; justify-content: flex-start; gap: 10px; flex-wrap: wrap; margin-bottom: 30px; width: 80%; max-width: 1200px; margin: 0 auto;">

    <div class="stat-box" style="background: #e80ecb; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 160px; box-sizing: border-box;">
            <h3>📋Total Jobs</h3>
            <asp:Label ID="lblTotalComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>

        <div class="stat-box" style="background: #520b05; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 160px; box-sizing: border-box;">
            <h3>📍Pending Jobs</h3>
            <asp:Label ID="lblPendingComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>

        <div class="stat-box" style="background: #2196F3; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 160px; box-sizing: border-box;">
            <h3>⏳In Progress Jobs</h3>
            <asp:Label ID="lblInprogressComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>

        <div class="stat-box" style="background: #215205; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 160px; box-sizing: border-box;">
            <h3>✅Completed Jobs</h3>
            <asp:Label ID="lblCompletedJobs" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>
    </div>

    <style>
        /* Ensure the body doesn't overflow horizontally */
        body {
            overflow-x: hidden;
        }

        /* Additional styles for responsiveness */
        @media (max-width: 768px) {
            .dashboard-stats {
                flex-direction: column;
                align-items: flex-start;
            }
            .stat-box {
                min-width: 90%;  /* Reduced width of cards on smaller screens */
                margin-bottom: 15px;
            }
        }

        @media (max-width: 480px) {
            .stat-box {
                min-width: 90%;
                font-size: 18px;
            }
        }
    </style>
</asp:Content>


