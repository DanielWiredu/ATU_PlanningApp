<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="AcademicProgramme.aspx.cs" Inherits="ATU_PlanningApp.Setups.AcademicProgramme" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Academic Programme</h5>
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
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add Programme" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="programmeGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" ShowGroupPanel="true" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" DataSourceID="programmeSource" OnItemCommand="programmeGrid_ItemCommand" OnItemDeleted="programmeGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
                                 <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="programme_list" HideStructureColumns="true"  >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Programme List" PageWidth="500"></Pdf>
                                    </ExportSettings>

                                 <MasterTableView DataKeyNames="Id" DataSourceID="programmeSource" AllowAutomaticDeletes="true" PageSize="50">
                                     <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="Group" FieldName="ProgrammeOption"></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="ProgrammeOption" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Programme" FilterControlAltText="Filter Programme column" HeaderText="Programme" SortExpression="Programme" UniqueName="Programme" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="250px">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="ProgrammeOptionId" DataType="System.Int32" FilterControlAltText="Filter ProgrammeOptionId column" HeaderText="ProgrammeOptionId" SortExpression="ProgrammeOptionId" UniqueName="ProgrammeOptionId">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Description" SortExpression="Description" UniqueName="Description" EmptyDataText="">
                                         <HeaderStyle Width="300px" />
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
                        <asp:SqlDataSource ID="programmeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwAcademicProgramme]" DeleteCommand="DELETE FROM [tblAcademicProgramme] WHERE [Id] = @Id">
                            <DeleteParameters>
                                <asp:Parameter Name="Id" Type="Int32" />
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
                    <h4 class="modal-title">New Programme</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label> Programme</label>
                                       <asp:TextBox runat="server" ID="txtProgramme" Width="100%" MaxLength="50"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtProgramme" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Programme Option</label>
                                <telerik:RadComboBox ID="dlProgrammeOption" runat="server" Width="100%" DataSourceID="programmeOptionSource" DataTextField="ProgrammeOption" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" ></telerik:RadComboBox>
                                 <asp:SqlDataSource ID="programmeOptionSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT Id,ProgrammeOption FROM tblAcademicProgrammeOption"></asp:SqlDataSource>  
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <asp:TextBox runat="server" ID="txtDescription" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
                    <h4 class="modal-title">Edit Programme</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label> Programme</label>
                                       <asp:TextBox runat="server" ID="txtProgramme1" Width="100%" MaxLength="50"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtProgramme1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Programme Option</label>
                                <telerik:RadComboBox ID="dlProgrammeOption1" runat="server" Width="100%" DataSourceID="programmeOptionSource" DataTextField="ProgrammeOption" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" ></telerik:RadComboBox>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <asp:TextBox runat="server" ID="txtDescription1" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
