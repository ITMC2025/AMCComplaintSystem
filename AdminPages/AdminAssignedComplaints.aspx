<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAssignedComplaints.aspx.cs" Inherits="AMCComplaintSystem.AdminPages.AdminAssignedComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .panel-box {
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #fafafa;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }

        .form-table td {
            padding: 6px 10px;
            vertical-align: middle;
        }

        .form-table label {
            font-weight: bold;
        }

        .report-table th, .report-table td {
            text-align: center !important;
        }
    </style>

    <div class="recent-complaints" style="margin-top: 20px;">
        <h3 style="text-align: center; color: #333;">Assigned Complaints</h3>

        <div class="filter">
            <asp:Label runat="server" Text="Filter by Job Category:" />
            <asp:DropDownList ID="ddlJobFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlJobFilter_SelectedIndexChanged">
                <asp:ListItem Value="All" Selected="True">All</asp:ListItem>
                <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                <asp:ListItem Value="Software">Software</asp:ListItem>
            </asp:DropDownList>
        </div>

        <asp:GridView ID="gvPendingComplaints" runat="server" 
    AutoGenerateColumns="False" 
    CssClass="report-table" 
    GridLines="None" 
    CellPadding="8"
    AllowPaging="true" 
    PageSize="10"
    OnPageIndexChanging="gvPendingComplaints_PageIndexChanging"
    OnRowCommand="gvPendingComplaints_RowCommand"
    style="width: 100%; margin-top: 10px; border: 1px solid #ddd; border-collapse: collapse;">
    
    <HeaderStyle BackColor="#4CAF50" ForeColor="White" Font-Bold="True" />
    <AlternatingRowStyle BackColor="#f2f2f2" />
    <RowStyle BorderColor="#ddd" HorizontalAlign="Center" />
    <Columns>
        <asp:TemplateField HeaderText="Select">
            <ItemTemplate>
                <asp:Button ID="btnSelect" runat="server" Text="Select" CommandName="SelectComplaint" CommandArgument='<%# Eval("ComplaintID") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
        <asp:BoundField DataField="Category" HeaderText="Category" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
    </Columns>
</asp:GridView>


        <!-- Flex container for side-by-side panels -->
        <div class="panel-container" style="display: flex; gap: 20px; margin-top: 20px; align-items: flex-start;">

            <!-- Left Panel -->
            <asp:Panel ID="pnlUserDetails" runat="server" Visible="false" CssClass="panel-box" style="flex: 0.6;">
                <h4>Assign Complaints to the Engineers</h4>
                <table class="form-table">
                    <tr>
                        <td><label>Complain Id:</label></td>
                        <td><asp:TextBox ID="txtComplainId" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><label>Type:</label></td>
                        <td><asp:TextBox ID="txtType" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><label>Description:</label></td>
                        <td><asp:TextBox ID="txtDescription" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center; padding-top: 10px;">
                            <asp:HiddenField ID="hfUserID" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <!-- Right Panel -->
           <asp:Panel ID="pnlEngineers" runat="server" Visible="false" CssClass="panel-box" style="flex: 1;">
    <h4>Available Engineers<asp:Label ID="lblStatus" runat="server" ForeColor="#006600" Text="Label" Visible="False"></asp:Label>
               </h4>
    <asp:GridView ID="gvEngineers" runat="server" AutoGenerateColumns="False" CssClass="report-table" GridLines="None"
        CellPadding="8" OnRowCommand="gvEngineers_RowCommand">
        <HeaderStyle BackColor="#4CAF50" ForeColor="White" Font-Bold="True" />
        <RowStyle HorizontalAlign="Center" />
        <Columns>
            <asp:BoundField DataField="UserID" HeaderText="ID" />
            <asp:BoundField DataField="FullName" HeaderText="Engineer Name" />
            <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" />
            <asp:BoundField DataField="PendingCount" HeaderText="Pending Jobs" />
            <asp:BoundField DataField="InProgressCount" HeaderText="Jobs In Progress" />
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnAssign" runat="server" Text="Assign" CommandName="AssignEngineer"
                        CommandArgument='<%# Eval("UserID") %>' CssClass="button" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Panel>


        </div>
    </div>
</asp:Content>

