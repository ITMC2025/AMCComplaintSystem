<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewAllUsers.aspx.cs" Inherits="AMCComplaintSystem.AdminPages.AdminViewAllUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background: linear-gradient(145deg, #e0e0e0, #ffffff);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
            
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .filter {
            text-align: center;
            margin-bottom: 20px;
            font-size: 18px;
        }

        .filter select {
            padding: 8px 12px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            z-index: 10;
            cursor: pointer;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border: 1px solid #ddd;
            background-color: #fff;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .gridview th {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            text-align: center;
            font-weight: bold;
            border-right: 1px solid #ddd;
        }

        .gridview td {
            padding: 10px;
            color: #555;
            /*text-align: center;*/
            border-right: 1px solid #ddd;
            vertical-align: middle;
        }

        .gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .gridview tr:hover {
            background-color: #ddd;
            transition: 0.3s ease;
        }
    </style>

    <h2>View All Users</h2>

    <div class="filter">
        <asp:Label runat="server" Text="Filter by Role:" />
        <asp:DropDownList ID="ddlRoleFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRoleFilter_SelectedIndexChanged">
            <asp:ListItem Value="All" Selected="True">All</asp:ListItem>
            <asp:ListItem Value="Customer">Customer</asp:ListItem>
            <asp:ListItem Value="Engineer">Engineer</asp:ListItem>
            <asp:ListItem Value="Admin">Admin</asp:ListItem>
        </asp:DropDownList>
    </div>

    <asp:GridView ID="gvUsers" runat="server" CssClass="gridview" AutoGenerateColumns="False" GridLines="None">
        <Columns>
            <asp:BoundField DataField="UserID" HeaderText="User ID" ReadOnly="True" />
            <asp:BoundField DataField="FullName" HeaderText="Full Name" ReadOnly="True" />
            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" />
            <asp:BoundField DataField="Role" HeaderText="Role" ReadOnly="True" />
            <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" ReadOnly="True" />
            <asp:BoundField DataField="Address" HeaderText="Address" ReadOnly="True" />
            <asp:BoundField DataField="CreatedAt" HeaderText="Created At" ReadOnly="True" DataFormatString="{0:dd/MM/yyyy}" />
        </Columns>
    </asp:GridView>
</asp:Content>
