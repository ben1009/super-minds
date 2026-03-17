/**
 * Super Minds - Common JavaScript Utilities
 * Shared functions for navigation, toggles, and UI interactions
 */

// ============================================
// Mobile Navigation
// ============================================

/**
 * Toggle mobile menu visibility
 * Requires an element with id="mobileMenu"
 */
function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    if (menu) {
        menu.classList.toggle('hidden');
    }
}

// ============================================
// Toggle/Accordion Utilities
// ============================================

/**
 * Toggle an element's visibility with class toggling
 * @param {HTMLElement} element - The element to toggle
 * @param {string} showClass - The class that indicates visibility (default: 'show')
 * @param {HTMLElement} iconElement - Optional icon to rotate
 */
function toggleVisibility(element, showClass = 'show', iconElement = null) {
    element.classList.toggle(showClass);
    
    if (iconElement) {
        const isShown = element.classList.contains(showClass);
        iconElement.style.transform = isShown ? 'rotate(180deg)' : 'rotate(0deg)';
    }
}

/**
 * Generic toggle function for quiz/answer items
 * @param {HTMLElement} container - The container element that was clicked
 * @param {string} answerSelector - Selector for the answer element (default: '.quiz-answer')
 * @param {string} iconSelector - Selector for the icon element (default: '[data-lucide="chevron-down"]')
 */
function toggleQuizAnswer(container, answerSelector = '.quiz-answer', iconSelector = '[data-lucide="chevron-down"]') {
    const answer = container.querySelector(answerSelector);
    const icon = container.querySelector(iconSelector);
    
    if (answer) {
        toggleVisibility(answer, 'show', icon);
    }
    
    // Re-initialize icons if using Lucide
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
}

/**
 * Toggle translation visibility in story sections
 * @param {HTMLElement} container - The container element that was clicked
 */
function toggleTranslation(container) {
    const trans = container.querySelector('.translation');
    const icon = container.querySelector('.chevron-icon');
    
    if (trans) {
        toggleVisibility(trans, 'show', icon);
    }
}

/**
 * Toggle comprehension answer visibility
 * @param {HTMLElement} container - The container element that was clicked
 */
function toggleCompAnswer(container) {
    const answer = container.querySelector('.comp-a');
    if (answer) {
        answer.classList.toggle('show');
    }
}

/**
 * Toggle timeline detail expansion
 * @param {HTMLElement} node - The timeline node element
 */
function toggleTimeline(node) {
    const detail = node.querySelector('.timeline-detail');
    if (detail) {
        const isExpanded = detail.classList.contains('expanded');
        
        if (isExpanded) {
            detail.classList.remove('expanded');
            node.classList.remove('active');
        } else {
            detail.classList.add('expanded');
            node.classList.add('active');
        }
    }
}

/**
 * Toggle answer mask reveal
 * @param {HTMLElement} element - The answer mask element
 */
function toggleAnswer(element) {
    element.classList.toggle('revealed');
    
    // Add click feedback animation
    element.style.transform = 'scale(0.98)';
    setTimeout(() => {
        element.style.transform = '';
    }, 100);
}

// ============================================
// Progress Tracking
// ============================================

/**
 * Update homework progress bar and save to localStorage
 * @param {string} storageKey - Key for localStorage (default: 'homeworkProgress')
 */
function updateProgress(storageKey = 'homeworkProgress') {
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    const checked = document.querySelectorAll('input[type="checkbox"]:checked');
    const progress = (checked.length / checkboxes.length) * 100;
    
    const progressBar = document.getElementById('progress-bar');
    const progressText = document.getElementById('progress-text');
    
    if (progressBar) {
        progressBar.style.width = progress + '%';
    }
    if (progressText) {
        progressText.textContent = checked.length + '/' + checkboxes.length + ' 完成';
    }
    
    const progressData = {
        checked: Array.from(checkboxes).map(cb => cb.checked),
        date: new Date().toLocaleDateString()
    };
    localStorage.setItem(storageKey, JSON.stringify(progressData));
}

/**
 * Toggle checkbox completion state
 * @param {HTMLInputElement} checkbox - The checkbox element
 */
function toggleComplete(checkbox) {
    const label = checkbox.closest('label');
    if (label) {
        label.classList.toggle('completed', checkbox.checked);
    }
    updateProgress();
}

/**
 * Restore progress from localStorage
 * @param {string} storageKey - Key for localStorage (default: 'homeworkProgress')
 */
function restoreProgress(storageKey = 'homeworkProgress') {
    const saved = localStorage.getItem(storageKey);
    if (saved) {
        try {
            const data = JSON.parse(saved);
            const checkboxes = document.querySelectorAll('input[type="checkbox"]');
            
            checkboxes.forEach((cb, index) => {
                if (data.checked && data.checked[index]) {
                    cb.checked = true;
                    const label = cb.closest('label');
                    if (label) {
                        label.classList.add('completed');
                    }
                }
            });
            
            updateProgress(storageKey);
        } catch (e) {
            console.warn('Failed to restore progress:', e);
        }
    }
}

// ============================================
// Clipboard Utilities
// ============================================

/**
 * Copy text to clipboard with feedback
 * @param {string} text - The text to copy
 * @param {string} feedbackId - ID of feedback element to show
 */
function copyToClipboard(text, feedbackId = 'copy-feedback') {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(() => {
            const feedback = document.getElementById(feedbackId);
            if (feedback) {
                feedback.classList.remove('hidden');
                setTimeout(() => feedback.classList.add('hidden'), 2000);
            }
        }).catch(err => {
            console.error('Failed to copy:', err);
        });
    }
}

// ============================================
// Tab Switching
// ============================================

/**
 * Switch between tab contents
 * @param {string} tabName - The ID of the tab to show
 * @param {Object} options - Configuration options
 * @param {string} options.contentSelector - Selector for tab content (default: '.tab-content')
 * @param {string} options.btnSelector - Selector for tab buttons (default: '.tab-btn')
 * @param {string} options.activeBtnClass - Class for active button (default: 'bg-blue-900 text-white')
 * @param {string} options.inactiveBtnClass - Class for inactive button (default: 'bg-gray-200 text-gray-700')
 */
function switchTab(tabName, options = {}) {
    const defaults = {
        contentSelector: '.tab-content',
        btnSelector: '.tab-btn',
        activeBtnClass: 'bg-blue-900 text-white',
        inactiveBtnClass: 'bg-gray-200 text-gray-700',
        btnIdPrefix: 'btn-'
    };
    
    const config = { ...defaults, ...options };
    
    // Hide all tab contents
    document.querySelectorAll(config.contentSelector).forEach(content => {
        content.classList.remove('active');
    });
    
    // Show selected tab
    const selectedTab = document.getElementById(tabName);
    if (selectedTab) {
        selectedTab.classList.add('active');
    }
    
    // Update button styles
    const activeClasses = config.activeBtnClass.split(' ');
    const inactiveClasses = config.inactiveBtnClass.split(' ');
    
    document.querySelectorAll(config.btnSelector).forEach(btn => {
        btn.classList.remove(...activeClasses);
        btn.classList.add(...inactiveClasses);
    });
    
    const selectedBtn = document.getElementById(config.btnIdPrefix + tabName);
    if (selectedBtn) {
        selectedBtn.classList.remove(...inactiveClasses);
        selectedBtn.classList.add(...activeClasses);
    }
}

// ============================================
// Auto-initialization
// ============================================

/**
 * Initialize Lucide icons if available
 */
function initIcons() {
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
}

/**
 * Initialize common functionality on page load
 */
function initCommon() {
    // Initialize icons
    initIcons();
    
    // Restore progress if on homework page
    if (document.querySelector('input[type="checkbox"]')) {
        restoreProgress();
    }
}

// Run initialization when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCommon);
} else {
    initCommon();
}
