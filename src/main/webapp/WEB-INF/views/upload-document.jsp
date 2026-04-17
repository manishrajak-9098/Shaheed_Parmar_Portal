<%@ page import="com.shaheed.entity.*" %>
<%@ include file="layout/navbar.jsp" %>
<%
  FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
  if(user==null){ response.sendRedirect(request.getContextPath()+"/login"); return; }
  Document existing = (Document) request.getAttribute("existingDoc");
%>
<div class="page-wrap" style="max-width:760px">
  <a href="${pageContext.request.contextPath}/dashboard" class="back-btn">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
  </a>
  <div class="page-header">
    <div class="page-title">Upload Documents</div>
    <div class="page-sub"><%= existing!=null ? "Re-upload documents (leave blank to keep existing)" : "Upload all required documents" %></div>
  </div>

  <% if(request.getAttribute("error")!=null){ %>
  <div class="alert alert-error">${error}</div>
  <% } %>
  <% if(existing!=null){ %>
  <div class="alert alert-success">Documents already uploaded. Leave any field blank to keep the existing file.</div>
  <% } %>

  <div class="card">
    <div class="alert alert-info">Accepted: PDF, JPG, JPEG, PNG | Max size: 10 MB per file</div>

    <form action="${pageContext.request.contextPath}/uploadDocuments" method="post" enctype="multipart/form-data">
      <div class="form-section-title">Required Documents</div>

      <div class="form-group">
        <label>Aadhaar Card <%= existing==null?"*":"" %></label>
        <div class="file-input-wrap">
          <input type="file" name="aadhaar" accept=".pdf,.jpg,.jpeg,.png" <%= existing==null?"required":"" %>>
          <% if(existing!=null&&existing.getAadhaarPath()!=null){ %>
          <span class="file-hint text-success mt-16">✅ Uploaded: <%= existing.getAadhaarPath() %></span>
          <% }else{ %>
          <span class="file-hint mt-16 muted">Upload Aadhaar card (front and back)</span>
          <% } %>
        </div>
      </div>

      <div class="form-group">
        <label>Army ID Card <%= existing==null?"*":"" %></label>
        <div class="file-input-wrap">
          <input type="file" name="armyId" accept=".pdf,.jpg,.jpeg,.png" <%= existing==null?"required":"" %>>
          <% if(existing!=null&&existing.getArmyIdPath()!=null){ %>
          <span class="file-hint text-success mt-16">✅ Uploaded: <%= existing.getArmyIdPath() %></span>
          <% }else{ %>
          <span class="file-hint mt-16 muted">Shaheed's Army ID / Service card</span>
          <% } %>
        </div>
      </div>

      <div class="form-group">
        <label>Martyrdom Certificate <%= existing==null?"*":"" %></label>
        <div class="file-input-wrap">
          <input type="file" name="certificate" accept=".pdf,.jpg,.jpeg,.png" <%= existing==null?"required":"" %>>
          <% if(existing!=null&&existing.getCertificatePath()!=null){ %>
          <span class="file-hint text-success mt-16">✅ Uploaded: <%= existing.getCertificatePath() %></span>
          <% }else{ %>
          <span class="file-hint mt-16 muted">Official martyrdom certificate issued by Army</span>
          <% } %>
        </div>
      </div>

      <div class="form-group">
        <label>Family Relationship Proof <%= existing==null?"*":"" %></label>
        <div class="file-input-wrap">
          <input type="file" name="familyProof" accept=".pdf,.jpg,.jpeg,.png" <%= existing==null?"required":"" %>>
          <% if(existing!=null&&existing.getFamilyProofPath()!=null){ %>
          <span class="file-hint text-success mt-16">✅ Uploaded: <%= existing.getFamilyProofPath() %></span>
          <% }else{ %>
          <span class="file-hint mt-16 muted">Marriage / Birth / Ration card</span>
          <% } %>
        </div>
      </div>

      <div class="form-group">
        <label>Shaheed's Photograph <%= existing==null?"*":"" %></label>
        <div class="file-input-wrap">
          <input type="file" name="photo" accept=".jpg,.jpeg,.png" <%= existing==null?"required":"" %>>
          <% if(existing!=null&&existing.getShaheedPhotoPath()!=null){ %>
          <span class="file-hint text-success mt-16">✅ Uploaded: <%= existing.getShaheedPhotoPath() %></span>
          <% }else{ %>
          <span class="file-hint mt-16 muted">Recent photograph in uniform (JPG/PNG)</span>
          <% } %>
        </div>
      </div>

      <div style="display:flex;gap:12px;margin-top:28px;">
        <button type="submit" class="btn btn-gold"><%= existing!=null?"Update Documents":"Upload All Documents" %></button>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline">Cancel</a>
      </div>
    </form>
  </div>
</div>
<%@ include file="layout/footer.jsp" %>