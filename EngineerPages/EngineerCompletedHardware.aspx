<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Engineer.Master" AutoEventWireup="true" CodeBehind="EngineerCompletedHardware.aspx.cs" Inherits="AMCComplaintSystem.EngineerPages.EngineerCompletedHardware" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <asp:Label ID="lblUserName" runat="server" Text="Label"></asp:Label>
        Your Completed Hardware Jobs Report </h2>
    <asp:GridView ID="gvPendingComplaints" runat="server" AutoGenerateColumns="False" CssClass="report-table">
        <Columns>
            <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:BoundField DataField="CreatedAt" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:TemplateField HeaderText="Attachment">
                <ItemTemplate>
                    <asp:HyperLink ID="hlAttachment" runat="server" NavigateUrl='<%# Eval("FilePath") %>' Text="📎 View" Target="_blank"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
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

