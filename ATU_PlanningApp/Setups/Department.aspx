<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Department.aspx.cs" Inherits="ATU_PlanningApp.Setups.Department" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Department</h5>
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
                        <div class="row">
                                        <div class="col-sm-4 pull-right" style="width:inherit">
                                           <asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>
                                            <asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add Department" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="departmentGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" ShowGroupPanel="true" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" DataSourceID="departmentSource" OnItemCommand="departmentGrid_ItemCommand" OnItemDeleted="departmentGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
                                 <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="departmente_list" HideStructureColumns="true"  >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Department List" PageWidth="500"></Pdf>
                                    </ExportSettings>

                                 <MasterTableView DataKeyNames="ID" DataSourceID="departmentSource" AllowAutomaticDeletes="true" PageSize="50">
                                     <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="Group" FieldName="FacultyName"></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="FacultyName" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="ID" ReadOnly="True" SortExpression="ID" UniqueName="ID">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DepartmentName" FilterControlAltText="Filter DepartmentName column" HeaderText="DepartmentName" SortExpression="DepartmentName" UniqueName="DepartmentName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="250px">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="FacultyId" DataType="System.Int32" FilterControlAltText="Filter FacultyId column" HeaderText="FacultyId" SortExpression="FacultyId" UniqueName="FacultyId">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                        <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="departmentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwDepartment]" DeleteCommand="DELETE FROM [tblDepartment] WHERE [Id] = @Id">
                            <DeleteParameters>
                                <asp:Parameter Name="TradeTypeID" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                             <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                                  <asp:PostBackTrigger ControlID="btnPDFExport" />
                              </Triggers>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


       <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Department</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Department Name</label>
                                       <asp:TextBox runat="server" ID="txtDepartment" Width="100%" MaxLength="50"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDepartment" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Faculty</label>
                                <telerik:RadComboBox ID="dlFaculty" runat="server" Width="100%" DataSourceID="facultySource" DataTextField="FacultyName" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" ></telerik:RadComboBox>
                                 <asp:SqlDataSource ID="facultySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT Id,FacultyName FROM tblFaculty"></asp:SqlDataSource>  
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="new" OnClick="btnSave_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <!-- edit modal -->
    <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Department</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Department Name</label>
                                       <asp:TextBox runat="server" ID="txtDepartment1" Width="100%" MaxLength="50"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDepartment1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Trade Group</label>
                                <telerik:RadComboBox ID="dlFaculty1" runat="server" Width="100%" DataSourceID="facultySource" DataTextField="FacultyName" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" ></telerik:RadComboBox>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="edit" OnClick="btnUpdate_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <script type="text/javascript">
            function newModal() {
                $('#newmodal').modal('show');
                $('#newmodal').appendTo($("form:first"));
            }
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
            function editModal() {
                $('#editmodal').modal('show');
                $('#editmodal').appendTo($("form:first"));
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
    </script>
</asp:Content>
