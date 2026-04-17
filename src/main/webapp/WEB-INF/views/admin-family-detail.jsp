<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/admin-navbar.jsp" %>
<%
  Admin admin = (Admin) session.getAttribute("loggedAdmin");
  if(admin==null){ response.sendRedirect(request.getContextPath()+"/admin/login"); return; }
  
  FamilyUser family = (FamilyUser) request.getAttribute("family");
  Application app = (Application) request.getAttribute("app");
  Shaheed shaheed = (Shaheed) request.getAttribute("shaheed");
  Document doc = (Document) request.getAttribute("doc"); // This object has all 5 paths
  
  List<FacilityAllocation> allocs = (List<FacilityAllocation>) request.getAttribute("allocs");
  List<Facility> facs = (List<Facility>) request.getAttribute("facilities");
  
  if(family==null){ response.sendRedirect(request.getContextPath()+"/admin/applications"); return; }
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section">
        <div class="sidebar-label">Main</div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/families" class="sidebar-link"><i class="fas fa-users"></i> Registered Families</a>
    </div>
    <div class="sidebar-section">
        <div class="sidebar-label">Applications</div>
        <a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link">Pending Verification</a>
        <a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link active">All Applications</a>
    </div>
    <div class="sidebar-section">
        <div class="sidebar-label">Records</div>
        <a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link">Shaheed Records</a>
        <a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link">Benefit Allocations</a>
    </div>
    <div class="sidebar-section">
        <div class="sidebar-label">Others</div>
        <a href="${pageContext.request.contextPath}/admin/feedback" class="sidebar-link">User Feedback</a>
    </div>
    <div class="sidebar-section">
        <a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link">Logout</a>
    </div>
  </aside>

  <main class="admin-main">
    <a href="${pageContext.request.contextPath}/admin/applications" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Applications</a>
    <div class="page-header">
      <div class="page-title">Family Detail View</div>
      <div class="page-sub">Full profile for: <strong><%= family.getName() %></strong></div>
    </div>

    <div class="form-row">
      <!-- Section 1: Personal Details -->
      <div class="card">
        <div class="card-title">Personal Details</div>
        <table class="data-table" style="border:none;">
          <tr><td class="muted">Full Name</td><td class="bold"><%= family.getName() %></td></tr>
          <tr><td class="muted">Email</td><td class="bold"><%= family.getEmail() %></td></tr>
          <tr><td class="muted">Mobile</td><td class="bold"><%= family.getMobile() %></td></tr>
          <tr><td class="muted">Aadhaar No.</td><td class="bold"><%= family.getAadhaarNumber() %></td></tr>
          <tr><td class="muted">Relation</td><td class="bold"><%= family.getRelationWithShaheed() %></td></tr>
          <tr><td class="muted">City / State</td><td class="bold"><%= family.getCity() %> / <%= family.getState() %></td></tr>
          <tr><td class="muted">Account Status</td><td><span class="badge badge-<%= family.getStatus().toLowerCase() %>"><%= family.getStatus() %></span></td></tr>
        </table>
      </div>

      <!-- Section 2: Application & Shaheed Summary -->
      <div>
        <div class="card">
          <div class="card-title">Application</div>
          <% if(app!=null){ %>
          <p class="bold mb-16">#APP-<%= String.format("%05d",app.getId()) %></p>
          <span class="badge badge-<%= app.getVerificationStatus().toLowerCase() %>"><%= app.getVerificationStatus() %></span>
          <div style="margin-top:14px;display:flex;gap:8px;">
            <% if("VERIFIED".equals(app.getVerificationStatus())){ %>
                <a href="${pageContext.request.contextPath}/admin/allocate/<%= app.getId() %>" class="btn btn-gold btn-sm">Allocate Benefit</a>
            <% } else if("PENDING".equals(app.getVerificationStatus())){ %>
                <a href="${pageContext.request.contextPath}/admin/verification" class="btn btn-outline btn-sm">Review Now</a>
            <% } %>
          </div>
          <% } else { %><div class="alert alert-warning">No application submitted.</div><% } %>
        </div>

        <% if(shaheed!=null){ %>
        <div class="card">
          <div class="card-title">Shaheed Information</div>
          <p class="bold"><%= shaheed.getName() %></p>
          <p class="text-xs muted">Rank: <%= shaheed.getRank() %></p>
          <p class="text-xs muted">Service No: <%= shaheed.getServiceNumber() %></p>
          <p class="text-xs muted">Martyred: <%= shaheed.getMartyrdomDate() %></p>
        </div>
        <% } %>
      </div>
    </div>

    <!-- REQUIREMENT 3: ALL 5 DOCUMENTS COLUMN (FIXED) -->
    <div class="card">
      <div class="card-title"><i class="fas fa-file-invoice"></i> All Uploaded Documents</div>
      <% if(doc != null) { %>
        <div style="display:flex; gap:12px; flex-wrap:wrap;">
            <!-- 1. Aadhaar -->
            <div class="p-16 border rounded text-center" style="flex:1; min-width:180px;">
                <p class="text-xs muted">Aadhaar Card</p>
                <a href="<%= doc.getAadhaarPath() %>" target="_blank" class="btn btn-outline btn-xs">View Document</a>
            </div>
            <!-- 2. Army ID -->
            <div class="p-16 border rounded text-center" style="flex:1; min-width:180px;">
                <p class="text-xs muted">Army ID Card</p>
                <a href="<%= doc.getArmyIdPath() %>" target="_blank" class="btn btn-outline btn-xs">View Document</a>
            </div>
            <!-- 3. Martyrdom Certificate -->
            <div class="p-16 border rounded text-center" style="flex:1; min-width:180px;">
                <p class="text-xs muted">Martyrdom Cert.</p>
                <a href="<%= doc.getCertificatePath() %>" target="_blank" class="btn btn-outline btn-xs">View Document</a>
            </div>
            <!-- 4. Family Relationship Proof -->
            <div class="p-16 border rounded text-center" style="flex:1; min-width:180px;">
                <p class="text-xs muted">Family Proof</p>
                <a href="<%= doc.getFamilyProofPath() %>" target="_blank" class="btn btn-outline btn-xs">View Document</a>
            </div>
            <!-- 5. Shaheed Photo -->
            <div class="p-16 border rounded text-center" style="flex:1; min-width:180px;">
                <p class="text-xs muted">Shaheed Photo</p>
                <a href="<%= doc.getShaheedPhotoPath() %>" target="_blank" class="btn btn-outline btn-xs">View Photo</a>
            </div>
        </div>
      <% } else { %>
        <p class="muted p-16">No documents have been uploaded by the family yet.</p>
      <% } %>
    </div>

    <!-- Section 4: Benefits History -->
    <div class="card">
      <div class="card-title">Benefits Allocated</div>
      <% if(allocs==null||allocs.isEmpty()){ %><div class="alert alert-info">No benefits allocated yet for this family.</div>
      <% } else { %>
      <div class="table-wrap">
        <table class="data-table">
          <thead><tr><th>Benefit</th><th>Type</th><th>Status</th><th>Allocated On</th></tr></thead>
          <tbody>
            <% for(FacilityAllocation fa:allocs){ 
               String fn="N/A", ft="N/A";
               if(facs!=null) for(Facility f:facs) if(f.getId().equals(fa.getFacilityId())){ fn=f.getName(); ft=f.getFacilityType(); break; }
            %>
            <tr>
                <td><strong><%= fn %></strong></td>
                <td><span class="badge badge-gold"><%= ft %></span></td>
                <td><span class="badge badge-active"><%= fa.getStatus() %></span></td>
                <td><%= fa.getAllocatedDate() %></td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
      <% } %>
    </div>
  </main>
</div>
<%@ include file="layout/admin-footer.jsp" %>