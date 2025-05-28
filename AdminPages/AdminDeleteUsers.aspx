<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDeleteUsers.aspx.cs" Inherits="AMCComplaintSystem.AdminPages.AdminDeleteUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
                .gridview {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 18px;
    text-align: left;
}

.gridview th {
    background-color: #4CAF50;
    color: white;
    padding: 10px;
    border: 1px solid #ddd;
}

.gridview td {
    padding: 10px;
    border: 1px solid #ddd;
    background-color: #f9f9f9;
}

.gridview tr:nth-child(even) {
    background-color: #f2f2f2;
}

.gridview tr:hover {
    background-color: #ddd;
    cursor: pointer;

}
    </style>
      <h2>Delete/Inactive Users</h2>
     <asp:Label ID="lblStatus" runat="server" Text="Label" ForeColor="#006600" Visible="False"></asp:Label>
  
        <asp:GridView ID="gvUsers" runat="server" CssClass="gridview" AutoGenerateColumns="False" GridLines="None" OnRowCommand="gvUsers_RowCommand">
    <Columns>
        <asp:TemplateField HeaderText="Delete">
           <ItemTemplate>
        <asp:Button ID="btnDelete" runat="server" Text="Delete" 
            CommandName="DeleteUser" CommandArgument='<%# Eval("UserID") %>' 
            CssClass="btn btn-danger" />
    </ItemTemplate>
        </asp:TemplateField>
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
