<%@ include file="layout/navbar.jsp" %>

<section class="hero-section">
  <div class="hero-title">SHAHEED PARMAR PORTAL</div>
  <p class="hero-desc">
    A dedicated government welfare platform ensuring that families of our fallen heroes receive every entitled benefit: pensions, employment, education, housing with complete transparency and dignity.
  </p>
  <div>
    <a href="${pageContext.request.contextPath}/register" class="btn btn-gold"><i class="fas fa-user-plus"></i> Register Your Family</a>
    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline"><i class="fas fa-sign-in-alt"></i> Family Login</a>
  </div>
</section>

<section class="stats-bar">
  <div class="stat-item"><span class="stat-num big-num">1,200+</span><span class="stat-label">Registered Families</span></div>
  <div class="stat-item"><span class="stat-num big-num">960+</span><span class="stat-label">Verified Applications</span></div>
  <div class="stat-item"><span class="stat-num big-num">1 Cr+</span><span class="stat-label">Benefits Disbursed</span></div>
  <div class="stat-item"><span class="stat-num big-num">8</span><span class="stat-label">Welfare Schemes</span></div>
</section>

<section class="heroes-section">
  <h2 class="section-heading">Our Immortal Heroes</h2>
  <p class="section-sub">Saluting the courage, sacrifice and undying spirit of India's brave soldiers</p>
  <div class="heroes-grid">
    <div class="hero-card">
      <img src="${pageContext.request.contextPath}/images/martyrs/capt.manoj_kumar_pandey.jpg" class="hero-real-img" alt="Manoj Pandey">
      <span class="badge badge-gold">Captain</span>
      <div class="hero-name">Manoj Kumar Pandey</div>
      <div class="hero-award">Param Vir Chakra</div>
    </div>
    <div class="hero-card">
      <img src="${pageContext.request.contextPath}/images/martyrs/vikram_batra.jpg" class="hero-real-img" alt="Vikram Batra">
      <span class="badge badge-gold">Captain</span>
      <div class="hero-name">Vikram Batra</div>
      <div class="hero-award">Param Vir Chakra</div>
    </div>
    <div class="hero-card">
      <img src="${pageContext.request.contextPath}/images/martyrs/rifl_sanjay_kumar.jpg" class="hero-real-img" alt="Sanjay Kumar">
      <span class="badge badge-gold">Rifleman</span>
      <div class="hero-name">Sanjay Kumar</div>
      <div class="hero-award">Param Vir Chakra</div>
    </div>
    <div class="hero-card">
      <img src="${pageContext.request.contextPath}/images/martyrs/abdul_hamid.jpg" class="hero-real-img" alt="Abdul Hamid">
      <span class="badge badge-gold">Havildar</span>
      <div class="hero-name">Abdul Hamid</div>
      <div class="hero-award">Param Vir Chakra</div>
    </div>
  </div>
</section>

<section class="features-section">
  <h2 class="section-heading">How This Portal Helps</h2>
  <p class="section-sub">A complete end-to-end system for martyrs' families to receive their entitled benefits</p>
  <div class="features-grid">
    <div class="feature-card">
      <span class="icon"><i class="fas fa-user-check"></i></span>
      <h3>Easy Registration</h3>
      <p class="muted">Simple family registration with Aadhaar verification, relation proof, and army documentation.</p>
    </div>
    <div class="feature-card">
      <span class="icon"><i class="fas fa-chart-line"></i></span>
      <h3>Real-Time Status</h3>
      <p class="muted">Track your application - Pending, Verified, or Rejected - from your family dashboard.</p>
    </div>
    <div class="feature-card">
      <span class="icon"><i class="fas fa-hand-holding-heart"></i></span>
      <h3>Multiple Benefits</h3>
      <p class="muted">Pension, job reservation, education scholarships, housing allotment, medical support and more.</p>
    </div>
    <div class="feature-card">
      <span class="icon"><i class="fas fa-shield-alt"></i></span>
      <h3>Transparent Process</h3>
      <p class="muted">Admin-verified applications with complete history, benefit allocation records, and remarks.</p>
    </div>
  </div>
</section>
<%@ include file="layout/footer.jsp" %>