<%@ include file="layout/navbar.jsp" %>
<div class="page-wrap" style="max-width:680px">
  <button class="back-btn" onclick="window.location.href='${pageContext.request.contextPath}/'">
    <i class="fas fa-arrow-left"></i> Back to Home
  </button>
  <div class="page-header">
    <div class="page-title"><i class="fas fa-comment-dots"></i> Feedback &amp; Grievance</div>
    <div class="page-sub">Share your experience, suggestions, or raise a grievance</div>
  </div>

  <% if(request.getAttribute("success")!=null){ %>
  <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
  <% } %>
  <% if(request.getAttribute("error")!=null){ %>
  <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
  <% } %>

  <div class="card">
    <form action="${pageContext.request.contextPath}/feedback" method="post">
      <div class="form-row">
        <div class="form-group">
          <label>Your Name *</label>
          <input type="text" name="name" placeholder="Full name" required>
        </div>
        <div class="form-group">
          <label>Email (for response)</label>
          <input type="email" name="email" placeholder="optional">
        </div>
      </div>
      <div class="form-group">
        <label>Subject *</label>
        <select name="subject" required>
          <option value="">Select subject</option>
          <option>Application Query</option>
          <option>Document Upload Issue</option>
          <option>Benefit Not Received</option>
          <option>Verification Delay</option>
          <option>Technical Issue</option>
          <option>Suggestion</option>
          <option>Other</option>
        </select>
      </div>
      <div class="form-group">
        <label>Message *</label>
        <textarea name="message" rows="6" placeholder="Describe your feedback or grievance in detail..." required></textarea>
      </div>
      <button type="submit" class="btn btn-gold">
        <i class="fas fa-paper-plane"></i> Submit Feedback
      </button>
    </form>
  </div>
</div>
<%@ include file="layout/footer.jsp" %>