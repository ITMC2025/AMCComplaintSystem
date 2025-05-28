<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Admin.Master" AutoEventWireup="true" CodeBehind="AdminUpdateUserRoll.aspx.cs" Inherits="AMCComplaintSystem.AdminPages.AdminUpdateUserRoll" %>
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
.form-table {
    width: 50%;
    border-collapse: collapse;
    margin-top: 10px;
}

.form-table td {
    padding: 8px;
    font-size: 16px;
    vertical-align: middle;
}

.form-table label {
    font-weight: bold;
    color: #333;
}

.textbox, .dropdown, .button {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    font-size: 16px;
}

.button {
    background-color: #4CAF50;
    color: white;
    border: none;
    cursor: pointer;
    padding: 10px 15px;
    border-radius: 5px;
}

.button:hover {
    background-color: #45a049;
}


    </style>

    <asp:GridView ID="gvUsers" runat="server" CssClass="gridview" AutoGenerateColumns="False" GridLines="None" OnRowCommand="gvUsers_RowCommand">
    <Columns>
        <asp:TemplateField HeaderText="Select">
            <ItemTemplate>
                <asp:Button ID="btnSelect" runat="server" Text="Select" CommandName="SelectUser" CommandArgument='<%# Eval("UserID") %>' />
            
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

   <asp:Panel ID="pnlUserDetails" runat="server" Visible="false">
    <h2>Update User Role</h2>
       <asp:Label ID="lblStatus" runat="server" Text="Label" ForeColor="#006600" Visible="False"></asp:Label>
    <table class="form-table">
        <tr>
            <td><label>Full Name:</label></td>
            <td><asp:TextBox ID="txtFullName" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><label>Email:</label></td>
            <td><asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><label>Mobile No:</label></td>
            <td><asp:TextBox ID="txtMobileNo" runat="server" CssClass="textbox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><label>Address:</label></td>
            <td><asp:TextBox ID="txtAddress" runat="server" CssClass="textbox"></asp:TextBox></td>
        </tr>
        <tr>
            <td><label>Role:</label></td>
            <td>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="Engineer" Value="Engineer"></asp:ListItem>
                    <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><label>Specialization:</label></td>
            <td>
                <asp:DropDownList ID="ddlSpecialization" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="Hardware" Value="Hardware"></asp:ListItem>
                    <asp:ListItem Text="Software" Value="Software"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center; padding-top: 10px;">
                <asp:HiddenField ID="hfUserID" runat="server" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update User"  CssClass="button" OnClick="btnUpdate_Click" />
            </td>
        </tr>
        
    </table>
</asp:Panel>



</asp:Content>
