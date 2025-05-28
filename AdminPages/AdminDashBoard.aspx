<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashBoard.aspx.cs" Inherits="AMCComplaintSystem.AdminPages.AdminDashBoard" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="text-align: center; color: #4CAF50; margin-bottom: 20px;">Admin Dashboard</h2>
 
    
    <div class="dashboard-stats" style="display: flex; justify-content: space-around; gap: 10px; flex-wrap: wrap; margin-bottom: 30px;">
        

      <%--  <div class="stat-box" style="background: #e80ecb; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 180px;">
            <h3>📋Total Jobs</h3>
            <asp:Label ID="lblTotalComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>--%>

        <div class="stat-box" style="background: #520b05; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 200px;">
            <h3>📍Pending Jobs</h3>
            <asp:Label ID="lblPendingComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>

        <div class="stat-box" style="background: #a87d32; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 200px;">
    <h3>🚫Not Attend Jobs</h3>
    <asp:Label ID="lblNotAttend" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
</div>

         <div class="stat-box" style="background: #2196F3; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 200px;">
     <h3>⏳In Progress Jobs</h3>
     <asp:Label ID="lblInprogressComplaints" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
 </div>

        <div class="stat-box" style="background: #215205; color: #fff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 200px;">
            <h3>✅Completed Jobs</h3>
            <asp:Label ID="lblCompletedJobs" runat="server" Text="0" style="font-size: 24px; font-weight: bold;"></asp:Label>
        </div>
    </div>

   
   
   <div style="margin-top: 40px;">
    <h3 style="text-align: center; color: #333;">Complaint Categories vs Engineer Performance</h3>
    <div style="display: flex; justify-content: space-between; gap: 10px; flex-wrap: wrap;">

       <!-- Category and Status Chart -->
<div style="flex: 1; min-width: 400px;">
    <asp:Chart ID="chartCategoryStatus" runat="server" Width="480px" Height="250px">
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
                <AxisX Title="Category - Status" Interval="1" LineColor="Gray" LabelStyle-ForeColor="DarkBlue" TitleForeColor="DarkRed" />
                <AxisY Title="Complaint Count" LineColor="Gray" LabelStyle-ForeColor="DarkBlue" TitleForeColor="DarkRed" LabelStyle-Format="0" Interval="1" />
            </asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Name="Legend1" Docking="Top" />
        </Legends>
    </asp:Chart>
</div>


        <!-- Engineer Performance Chart -->
        <div style="flex: 1; min-width: 400px;">
            <asp:Chart ID="chartEngineerPerformance" runat="server" Width="480" Height="250">
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                        <AxisX Title="Engineers" Interval="1" />
                        <AxisY Title="Number of Complaints" LabelStyle-Format="0" Interval="1" />
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Name="Legend1" Docking="Top" />
                </Legends>
            </asp:Chart>
        </div>

    </div>
</div>




    


     <div class="recent-complaints" style="margin-top: 20px;">
     <h3 style="text-align: center; color: #333;">Recent Complaints</h3>
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