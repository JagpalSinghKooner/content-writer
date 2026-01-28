// HushAway® Content Dashboard JavaScript

// Global state
let database = null;
let filteredArticles = [];
let currentEditArticle = null;
let currentCreateArticle = null;

// Initialize dashboard on load
document.addEventListener('DOMContentLoaded', () => {
    loadDatabase();
    setupEventListeners();
});

// Load content database
async function loadDatabase() {
    try {
        const response = await fetch('content-database.json');
        database = await response.json();
        filteredArticles = database.articles;
        renderDashboard();
    } catch (error) {
        console.error('Error loading database:', error);
        showError('Failed to load content database');
    }
}

// Setup event listeners
function setupEventListeners() {
    // Filters
    document.getElementById('status-filter').addEventListener('change', applyFilters);
    document.getElementById('pillar-filter').addEventListener('change', applyFilters);
    document.getElementById('priority-filter').addEventListener('change', applyFilters);

    // Search
    document.getElementById('search-input').addEventListener('input', applySearch);

    // Refresh button
    document.getElementById('refresh-btn').addEventListener('click', loadDatabase);

    // View toggles
    document.getElementById('view-cards').addEventListener('click', () => switchView('cards'));
    document.getElementById('view-table').addEventListener('click', () => switchView('table'));

    // Edit form submission
    document.getElementById('edit-form').addEventListener('submit', saveArticleChanges);
}

// Render entire dashboard
function renderDashboard() {
    updateProgressBar();
    updateStats();
    renderPillarCards();
    renderArticles();
}

// Update progress bar
function updateProgressBar() {
    const totalArticles = database.articles.length;
    const completedArticles = database.articles.filter(a => a.status === 'published').length;
    const percentage = Math.round((completedArticles / totalArticles) * 100);

    document.getElementById('progress-text').textContent =
        `${completedArticles} of ${totalArticles} articles (${percentage}%)`;
    document.getElementById('progress-fill').style.width = `${percentage}%`;
}

// Update statistics
function updateStats() {
    const stats = {
        draft: database.articles.filter(a => a.status === 'draft').length,
        review: database.articles.filter(a => a.status === 'in-review').length,
        ready: database.articles.filter(a => a.status === 'ready').length,
        published: database.articles.filter(a => a.status === 'published').length
    };

    const totalWords = database.articles.reduce((sum, a) => sum + (a.wordCount || 0), 0);

    document.getElementById('draft-count').textContent = stats.draft;
    document.getElementById('review-count').textContent = stats.review;
    document.getElementById('ready-count').textContent = stats.ready;
    document.getElementById('published-count').textContent = stats.published;
    document.getElementById('total-words').textContent = totalWords.toLocaleString();
}

// Render pillar cards
function renderPillarCards() {
    const pillarData = {};

    // Aggregate data by pillar
    database.articles.forEach(article => {
        if (!pillarData[article.pillar]) {
            pillarData[article.pillar] = {
                number: article.pillar,
                name: article.pillarName,
                articles: [],
                wordCount: 0,
                priority: 'LOW'
            };
        }
        pillarData[article.pillar].articles.push(article);
        pillarData[article.pillar].wordCount += article.wordCount || 0;

        // Set highest priority
        if (article.priority === 'HIGH') pillarData[article.pillar].priority = 'HIGH';
        else if (article.priority === 'MEDIUM' && pillarData[article.pillar].priority !== 'HIGH') {
            pillarData[article.pillar].priority = 'MEDIUM';
        }
    });

    const container = document.getElementById('pillar-cards');
    container.innerHTML = '';

    Object.values(pillarData).forEach(pillar => {
        const completedCount = pillar.articles.filter(a => a.status === 'published').length;
        const totalCount = pillar.articles.length;
        const percentage = Math.round((completedCount / totalCount) * 100);

        const card = document.createElement('div');
        card.className = 'pillar-card';
        card.onclick = () => filterByPillar(pillar.number);
        card.innerHTML = `
            <div class="pillar-card-header">
                <div>
                    <h3>Pillar ${pillar.number}: ${pillar.name}</h3>
                    <span class="pillar-priority priority-${pillar.priority}">${pillar.priority} Priority</span>
                </div>
                <div class="pillar-number">${pillar.number}</div>
            </div>
            <div class="pillar-progress">
                <div class="pillar-progress-bar">
                    <div class="pillar-progress-fill" style="width: ${percentage}%"></div>
                </div>
                <div class="pillar-stats">
                    <span>${completedCount}/${totalCount} articles</span>
                    <span>${pillar.wordCount.toLocaleString()} words</span>
                </div>
            </div>
        `;
        container.appendChild(card);
    });
}

// Render articles
function renderArticles() {
    const container = document.getElementById('articles-container');
    container.innerHTML = '';

    if (filteredArticles.length === 0) {
        container.innerHTML = `
            <div class="empty-state">
                <h3>No articles found</h3>
                <p>Try adjusting your filters or search</p>
            </div>
        `;
        return;
    }

    filteredArticles.forEach(article => {
        const card = createArticleCard(article);
        container.appendChild(card);
    });
}

// Create article card element
function createArticleCard(article) {
    const card = document.createElement('div');
    card.className = 'article-card';

    const statusClass = article.status.replace('-', '');
    const statusLabel = article.status.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ');

    // Word count display with warning if below minimum
    const wordCountClass = article.wordCount >= article.minimumWordCount ? 'success' :
                          article.wordCount > 0 ? 'warning' : '';
    const wordCountText = article.wordCount > 0 ?
        `${article.wordCount.toLocaleString()} words` : '0 words';
    const wordCountWarning = article.wordCount > 0 && article.wordCount < article.minimumWordCount ?
        ` (Need ${(article.minimumWordCount - article.wordCount).toLocaleString()}+ more)` : '';

    card.innerHTML = `
        <div class="article-header">
            <div>
                <div class="article-number">
                    Pillar ${article.pillar}.${article.articleNumber}
                </div>
                <h3 class="article-title">${article.title}</h3>
            </div>
            <span class="status-badge status-${statusClass}">${statusLabel}</span>
        </div>
        <div class="article-metadata">
            <div class="meta-row">
                <span class="word-count ${wordCountClass}">${wordCountText}${wordCountWarning}</span>
                <span class="text-muted">| Min: ${article.minimumWordCount.toLocaleString()}</span>
            </div>
            <div class="meta-row">
                <span class="keyword">${article.targetKeyword}</span>
            </div>
            <div class="meta-row">
                <span class="text-muted">Vol: ${article.searchVolume}</span>
                <span class="text-muted">| ${article.contentType}</span>
            </div>
            ${article.datePublished ? `
                <div class="meta-row">
                    <span class="text-muted">Published: ${article.datePublished}</span>
                    ${article.framerUrl ? `<a href="${article.framerUrl}" target="_blank" class="text-muted">View ↗</a>` : ''}
                </div>
            ` : ''}
        </div>
        <div class="article-actions">
            ${article.status === 'draft' ?
                `<button class="btn btn-primary btn-sm" onclick="openCreateModal('${article.id}')">Start Writing</button>` :
                `<button class="btn btn-secondary btn-sm" onclick="openArticleFile('${article.filePath}')">Open File</button>`}
            ${article.wordCount > 0 ? `<button class="btn btn-secondary btn-sm" onclick="previewArticle('${article.id}')">Preview</button>` : ''}
            <button class="btn btn-secondary btn-sm" onclick="openEditModal('${article.id}')">Edit Details</button>
            ${article.status === 'ready' && article.wordCount >= article.minimumWordCount ?
                `<button class="btn btn-secondary btn-sm" onclick="copyForFramer('${article.id}')">Copy for Framer</button>` : ''}
        </div>
    `;

    return card;
}

// Apply filters
function applyFilters() {
    const statusFilter = document.getElementById('status-filter').value;
    const pillarFilter = document.getElementById('pillar-filter').value;
    const priorityFilter = document.getElementById('priority-filter').value;

    filteredArticles = database.articles.filter(article => {
        if (statusFilter !== 'all' && article.status !== statusFilter) return false;
        if (pillarFilter !== 'all' && article.pillar.toString() !== pillarFilter) return false;
        if (priorityFilter !== 'all' && article.priority !== priorityFilter) return false;
        return true;
    });

    renderArticles();
}

// Apply search
function applySearch() {
    const searchTerm = document.getElementById('search-input').value.toLowerCase();

    if (!searchTerm) {
        applyFilters();
        return;
    }

    filteredArticles = database.articles.filter(article => {
        return article.title.toLowerCase().includes(searchTerm) ||
               article.targetKeyword.toLowerCase().includes(searchTerm) ||
               article.pillarName.toLowerCase().includes(searchTerm) ||
               article.articleNumber.toLowerCase().includes(searchTerm);
    });

    renderArticles();
}

// Filter by pillar
function filterByPillar(pillarNumber) {
    document.getElementById('pillar-filter').value = pillarNumber.toString();
    applyFilters();
}

// Switch view (cards/table)
function switchView(view) {
    document.querySelectorAll('.view-btn').forEach(btn => btn.classList.remove('active'));
    if (view === 'cards') {
        document.getElementById('view-cards').classList.add('active');
        document.getElementById('articles-container').className = 'articles-grid';
    } else {
        document.getElementById('view-table').classList.add('active');
        document.getElementById('articles-container').className = 'articles-table';
        // Table view could be implemented later
    }
}

// Open article file in VSCode (via file system)
function openArticleFile(filePath) {
    const fullPath = '../' + filePath;
    alert(`To open this file, navigate to:\n${fullPath}\n\nThe file will be opened in your editor.`);
    // Note: Browser cannot directly open files in VSCode due to security restrictions
    // User will need to manually open the file or use VSCode's file explorer
}

// Open edit modal
function openEditModal(articleId) {
    const article = database.articles.find(a => a.id === articleId);
    if (!article) return;

    currentEditArticle = article;

    document.getElementById('edit-article-id').value = article.id;
    document.getElementById('edit-status').value = article.status;
    document.getElementById('edit-word-count').value = article.wordCount || 0;
    document.getElementById('edit-framer-url').value = article.framerUrl || '';

    document.getElementById('edit-modal').classList.add('active');
}

// Close edit modal
function closeEditModal() {
    document.getElementById('edit-modal').classList.remove('active');
    currentEditArticle = null;
}

// Save article changes
function saveArticleChanges(event) {
    event.preventDefault();

    const articleId = document.getElementById('edit-article-id').value;
    const article = database.articles.find(a => a.id === articleId);
    if (!article) return;

    article.status = document.getElementById('edit-status').value;
    article.wordCount = parseInt(document.getElementById('edit-word-count').value) || 0;
    article.framerUrl = document.getElementById('edit-framer-url').value || null;
    article.dateUpdated = new Date().toISOString().split('T')[0];

    if (article.status === 'published' && !article.datePublished) {
        article.datePublished = article.dateUpdated;
    }

    // Save to database (in real implementation, this would make an API call or file write)
    saveDatabase();

    closeEditModal();
    renderDashboard();

    showSuccess('Article updated successfully');
}

// Open create article modal
function openCreateModal(articleId) {
    const article = database.articles.find(a => a.id === articleId);
    if (!article) return;

    currentCreateArticle = article;

    document.getElementById('create-article-info').textContent =
        `Create article: ${article.articleNumber} - ${article.title}`;

    document.getElementById('create-modal').classList.add('active');
}

// Close create modal
function closeCreateModal() {
    document.getElementById('create-modal').classList.remove('active');
    currentCreateArticle = null;
}

// Confirm create article
function confirmCreateArticle() {
    if (!currentCreateArticle) return;

    const instructions = `To create this article file, run this command in your terminal:

cd "/Users/jagpalkooner/Downloads/HushAway - Launch/dashboard"
node create-article.js

Or simply copy the article template from:
/Users/jagpalkooner/Downloads/HushAway - Launch/templates/article-template.md

And save it to:
${currentCreateArticle.filePath}

(Browsers cannot create files on your filesystem due to security restrictions)`;

    alert(instructions);
    closeCreateModal();
}

// Preview article
function previewArticle(articleId) {
    const article = database.articles.find(a => a.id === articleId);
    if (!article) return;

    document.getElementById('preview-title').textContent = article.title;

    // Populate metadata
    document.getElementById('preview-metadata').innerHTML = `
        <p><strong>Article:</strong> ${article.articleNumber}</p>
        <p><strong>Pillar:</strong> ${article.pillarName}</p>
        <p><strong>Word Count:</strong> ${article.wordCount.toLocaleString()} / ${article.minimumWordCount.toLocaleString()}</p>
        <p><strong>Keyword:</strong> ${article.targetKeyword}</p>
        <p><strong>Search Volume:</strong> ${article.searchVolume}</p>
        <p><strong>Status:</strong> ${article.status}</p>
    `;

    // Populate checklist
    document.getElementById('preview-checklist').innerHTML = `
        <label><input type="checkbox"> Word count met</label>
        <label><input type="checkbox"> NO emojis</label>
        <label><input type="checkbox"> NO em-dashes</label>
        <label><input type="checkbox"> UK English only</label>
        <label><input type="checkbox"> NO deficit language</label>
        <label><input type="checkbox"> Keyword in first 100-150 words</label>
        <label><input type="checkbox"> Empathy-first opening</label>
        <label><input type="checkbox"> Gentle CTA included</label>
    `;

    // Load and render article content (placeholder for now)
    document.getElementById('preview-article').innerHTML = `
        <p><em>Article preview will load here when reading from markdown file.</em></p>
        <p>To preview the article, open the file at: <code>${article.filePath}</code></p>
    `;

    document.getElementById('preview-modal').classList.add('active');
}

// Close preview modal
function closePreviewModal() {
    document.getElementById('preview-modal').classList.remove('active');
}

// Copy content for Framer
function copyForFramer(articleId) {
    const article = database.articles.find(a => a.id === articleId);
    if (!article) return;

    alert(`This feature will copy the formatted article content to clipboard for pasting into Framer.\n\nArticle: ${article.title}\n\nTo use: Open the markdown file and copy the content manually for now.`);
}

// Save database (in real implementation, would write to file)
function saveDatabase() {
    // Update stats
    database.stats.completedArticles = database.articles.filter(a => a.status === 'published').length;
    database.stats.draftArticles = database.articles.filter(a => a.status === 'draft').length;
    database.stats.inReviewArticles = database.articles.filter(a => a.status === 'in-review').length;
    database.stats.readyArticles = database.articles.filter(a => a.status === 'ready').length;
    database.stats.publishedArticles = database.articles.filter(a => a.status === 'published').length;
    database.stats.totalWordCount = database.articles.reduce((sum, a) => sum + (a.wordCount || 0), 0);

    // In a real implementation, this would save to file or API
    console.log('Database saved:', database);
    localStorage.setItem('hushaway-content-db', JSON.stringify(database));
}

// Show success message
function showSuccess(message) {
    // Simple alert for now, could be replaced with toast notification
    console.log('Success:', message);
}

// Show error message
function showError(message) {
    alert('Error: ' + message);
}

// Close modals on background click
document.addEventListener('click', (event) => {
    if (event.target.classList.contains('modal')) {
        event.target.classList.remove('active');
    }
});
