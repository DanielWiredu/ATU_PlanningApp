<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="ATU_PlanningApp.Security.EditUser" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Edit User</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <div>
                  <div class="form-group">
                 <div class="row">
                     <div class="col-md-3">
                         <label>Username</label>
                         <asp:TextBox ID="txtUsername" runat="server" Width="100%" MaxLength="30" ReadOnly="true"></asp:TextBox>
                          <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUsername" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                     <div class="col-md-3">
                         <label>Password</label>
                         <asp:TextBox ID="txtPassword" runat="server" Width="100%" TextMode="Password"></asp:TextBox>
                         <%--<asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                     </div>
                     <div class="col-md-6">
                         <label>Fullname</label>
                         <asp:TextBox ID="txtFullname" runat="server" Width="100%"></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtFullname" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                 </div>
             </div>
                      <div class="form-group">
                 <div class="row">
                         <div class="col-md-3">
                         <label>Gender</label>
                         <telerik:RadDropDownList ID="dlGender" runat="server" Width="100%">
                             <Items>
                                 <telerik:DropDownListItem Text="Male" />
                                 <telerik:DropDownListItem Text="Female"  />
                                 <telerik:DropDownListItem Text="Unknown" />
                             </Items>
                         </telerik:RadDropDownList>
                     </div>
                   
                     <div class="col-md-3">
                         <label>Marital Status</label>
                         <telerik:RadDropDownList ID="dlMaritalStatus" runat="server" Width="100%">
                             <Items>
                                 <telerik:DropDownListItem Text="Single" />
                                 <telerik:DropDownListItem Text="Married" />
                                 <telerik:DropDownListItem Text="Separated" />
                                 <telerik:DropDownListItem Text="Divorced" />
                                 <telerik:DropDownListItem Text="Widowed"/>
                             </Items>
                         </telerik:RadDropDownList>
                     </div>
                    <div class="col-md-3">
                         <label>Mobile No.</label>
                         <asp:TextBox ID="txtMobile" runat="server" Width="100%"></asp:TextBox>
                        <asp:RegularExpressionValidator Runat="server" ControlToValidate="txtMobile" Display="Dynamic" ErrorMessage="Please enter numbers only." ForeColor="Red" SetFocusOnError="true" ValidationExpression="(^([0-9]*|\d*\d{1}?\d*)$)"></asp:RegularExpressionValidator>
                     </div>
                       <div class="col-md-3">
                         <label>Active</label>
                         <asp:CheckBox runat="server" ID="chkActive" Width="100%" />
                     </div>
                           
                 </div>
             </div>
                     <div class="form-group">
                         <div class="row">
                               <div class="col-md-6">
                         <label>Email</label>
                         <asp:TextBox ID="txtEmail" runat="server" Width="100%" TextMode="Email"></asp:TextBox>
                     </div>
                             <div class="col-md-6">
                         <label>Address</label>
                         <asp:TextBox ID="txtAddress" runat="server" Width="100%"></asp:TextBox>
                            </div>
                         </div>
                     </div>
                     <div class="form-group">
                         <div class="row">
                              <div class="col-md-6">
                         <label>Post Type</label>
                           <telerik:RadDropDownList ID="dlPost" runat="server" Width="100%" DefaultMessage="Select Post Type">
                             <Items>
                                 <telerik:DropDownListItem Text="Director" />
                                 <telerik:DropDownListItem Text="Manager" />
                                 <telerik:DropDownListItem Text="Supervisor" />
                                 <telerik:DropDownListItem Text="Officer" />
                                 <telerik:DropDownListItem Text="Data Clerk" />
                                 <telerik:DropDownListItem Text="Office Assistant" />
                             </Items>
                         </telerik:RadDropDownList>
                            </div>
                         <div class="col-md-6">
                         <label>User Role</label>
                         <telerik:RadComboBox ID="dlRoles" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" runat="server" Width="100%" DataSourceID="roleSource" DataTextField="Userrole" DataValueField="Userrole" Filter="None" MarkFirstMatch="false" Text="Select Roles"></telerik:RadComboBox>
                          <asp:SqlDataSource ID="roleSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Userrole from tblUserRoles"></asp:SqlDataSource>  
                          <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlRoles" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                     </div>
                         </div>
                     </div>

                     <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning" Text="Return" CausesValidation="false" PostBackUrl="~/Security/Users.aspx" style="margin-bottom:0px"/>              
                    <asp:Button ID="btnUpdate" CssClass="btn btn-primary" runat="server" Text="Update" OnClick="btnUpdate_Click" />         
                </div>
                            </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
