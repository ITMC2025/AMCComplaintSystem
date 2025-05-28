<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewFeedback.aspx.cs" Inherits="AMCComplaintSystem.AdminPages.AdminViewFeedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <h2>
    <asp:Label ID="lblUserName" runat="server" Text="Label"></asp:Label>
        Feedbacks on Your jobs</h2>
     <!-- Filter Dropdown -->
 <div class="filter">
     <asp:Label runat="server" Text="Filter by Job Category:" />
     <asp:DropDownList ID="ddlJobFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlJobFilter_SelectedIndexChanged">
         <asp:ListItem Value="All" Selected="True">All</asp:ListItem>
         <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
         <asp:ListItem Value="Software">Software</asp:ListItem>
     </asp:DropDownList>
 </div>
<asp:GridView ID="gvPendingComplaints" runat="server" AutoGenerateColumns="False" CssClass="report-table">
    <Columns>
         <asp:BoundField DataField="ComplaintID" HeaderText="Complaint Id" />
         <asp:BoundField DataField="CustomerName" HeaderText="Custormer Name" />
         
        <asp:BoundField DataField="Category" HeaderText="Category" />
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:BoundField DataField="EngineerName" HeaderText="Engineer Name" />
        <asp:BoundField DataField="Rating" HeaderText="Rating" />


         <asp:TemplateField HeaderText="Rating">
     <ItemTemplate>
       <%# GetEmoji(Convert.ToInt32(Eval("Rating"))) %>
     </ItemTemplate>
   </asp:TemplateField>



        <asp:BoundField DataField="Comments" HeaderText="Remarks" />
         
    </Columns>
</asp:GridView>
<style>
    /* Container to ensure full-width responsiveness */
    .table-container {
        width: 100%;
        overflow-x: auto; /* Scroll on small screens */
    }

    /* Styling the table itself */
    .report-table {
        width: 100%;
        border-collapse: collapse;
        text-align: left;
    }

    /* Header styling */
    .report-table th {
        background-color: #4CAF50;
        color: white;
        padding: 12px;
        font-size: 16px;
    }

    /* Row styling */
    .report-table td {
        padding: 10px;
        border: 1px solid #ddd;
        font-size: 14px;
    }

    /* Alternate row colors for clarity */
    .report-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    /* Hover effect */
    .report-table tr:hover {
        background-color: #ddd;
    }

    /* Make it responsive on smaller screens */
    @media (max-width: 768px) {
        .report-table th,
        .report-table td {
            padding: 8px;
            font-size: 12px;
        }
    }

    /* Center the header and the table */
    h2 {
        text-align: center;
        margin-bottom: 20px;
    }
</style>
</asp:Content>
