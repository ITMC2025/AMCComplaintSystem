<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Admin.Master" AutoEventWireup="true" CodeBehind="AdminViewComplaints.aspx.cs" Inherits="AMCComplaintSystem.AdminPages.ViewComplaints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
            <h3 style="text-align: center; color: #333;">All Complaints</h3>

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
    style="width: 100%; margin-top: 10px; border: 1px solid #ddd; border-collapse: collapse;">
    
    <HeaderStyle BackColor="#4CAF50" ForeColor="White" Font-Bold="True" />
    <AlternatingRowStyle BackColor="#f2f2f2" />
    <RowStyle BorderColor="#ddd" HorizontalAlign="Center" />
    <Columns>
       <%-- <asp:TemplateField HeaderText="Select">
            <ItemTemplate>
                <asp:Button ID="btnSelect" runat="server" Text="Select" CommandName="SelectComplaint" CommandArgument='<%# Eval("ComplaintID") %>' />
            </ItemTemplate>
        </asp:TemplateField>--%>
        <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
        <asp:BoundField DataField="Category" HeaderText="Category" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
    </Columns>
</asp:GridView>

</asp:Content>
