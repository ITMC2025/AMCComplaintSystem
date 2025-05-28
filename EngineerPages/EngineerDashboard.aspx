<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Engineer.Master" AutoEventWireup="true" CodeBehind="EngineerDashboard.aspx.cs" Inherits="AMCComplaintSystem.EngineerPages.EngineerDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="text-align: center; color: #4CAF50; margin-bottom: 20px;">Engineer Dashboard</h2>
 
    
    <div class="dashboard-stats" style="display: flex; justify-content: space-around; gap: 10px; flex-wrap: wrap; margin-bottom: 30px;">
        
        <%--<div class="stat-box" style="background: #e80ecb; color: #fff; padding: 15px; border-radius: 10px; text-align: center; flex: 0 1 160px; min-width: 160px;">--%>

       <%-- <div class="stat-box" style="background: #e80ecb; color: #fff; padding: 15px; border-radius: 10px; text-align: center; flex: 1; min-width: 170px;">
            <h3>📋Total Jobs</h3>
            <asp:Label ID="lblTotalComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>--%>

        <div class="stat-box" style="background: #520b05; color: #fff; padding: 15px; border-radius: 10px; text-align: center; flex: 1; min-width: 170px;">
            <h3>📍Pending Jobs</h3>
            <asp:Label ID="lblPendingComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>

        <div class="stat-box" style="background: #a87d32; color: #fff; padding: 15px; border-radius: 10px; text-align: center; flex: 1; min-width: 170px;">
    <h3>🚫Not Attend Jobs</h3>
    <asp:Label ID="lblNotAttend" runat="server" Text="0" style="font-size: 20px; font-weight: bold;"></asp:Label>
</div>

         <div class="stat-box" style="background: #2196F3; color: #fff; padding: 15px; border-radius: 10px; text-align: center; flex: 1; min-width: 170px;">
     <h3>⏳In Progress Jobs</h3>
     <asp:Label ID="lblInprogressComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
 </div>

        <div class="stat-box" style="background: #215205; color: #fff; padding: 15px; border-radius: 10px; text-align: center; flex: 1; min-width: 170px;">
            <h3>✅Completed Jobs</h3>
            <asp:Label ID="lblCompletedJobs" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>
    </div>

   
    <div class="recent-complaints" style="margin-top: 20px;">
        <h3 style="text-align: center; color: #333;">Recent Jobs</h3>
        <asp:GridView ID="gvRecentComplaints" runat="server" AutoGenerateColumns="False" CssClass="report-table" GridLines="None" CellPadding="8" style="width: 100%; margin-top: 10px; border: 1px solid #ddd; border-collapse: collapse; ">
            <HeaderStyle BackColor="#4CAF50" ForeColor="White" Font-Bold="True" />
            <AlternatingRowStyle BackColor="#f2f2f2" />
            <RowStyle BorderColor="#ddd" HorizontalAlign="Center" />
            <Columns>
                <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>