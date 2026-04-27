/**
 * Super Minds - Common JavaScript Utilities
 * Shared functions for navigation, toggles, and UI interactions
 */

// ============================================
// Constants
// ============================================

/**
 * Selector for homework progress checkboxes
 * Using specific class to avoid conflicts with other checkboxes on the page
 */
const HOMEWORK_CHECKBOX_SELECTOR = '.check-item input[type="checkbox"]';

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
if (typeof toggleTranslation !== 'function') {
    window.toggleTranslation = function(container) {
        const trans = container.querySelector('.translation');
        const icon = container.querySelector('.chevron-icon');
        const hint = container.querySelector('.translate-hint');
        
        if (trans) {
            const isShown = trans.classList.toggle('show');
            if (icon) {
                icon.style.transform = isShown ? 'rotate(180deg)' : 'rotate(0deg)';
            }
            if (hint) {
                hint.innerHTML = isShown ? '🌐 点击隐藏翻译' : '🌐 点击显示翻译';
            }
        }
    };
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
window.toggleAnswer = function(element) {
    element.classList.toggle('revealed');
    
    // Add click feedback animation
    element.style.transform = 'scale(0.98)';
    setTimeout(() => {
        element.style.transform = '';
    }, 100);
};

// ============================================
// Progress Tracking
// ============================================

/**
 * Update homework progress bar and save to localStorage
 * @param {string} storageKey - Key for localStorage (default: 'homeworkProgress')
 * @param {string} checkboxSelector - Selector for checkboxes (default: HOMEWORK_CHECKBOX_SELECTOR)
 */
if (typeof updateProgress !== 'function') {
    window.updateProgress = function(storageKey, checkboxSelector) {
        storageKey = storageKey || 'homeworkProgress';
        checkboxSelector = checkboxSelector || HOMEWORK_CHECKBOX_SELECTOR;
        const checkboxes = document.querySelectorAll(checkboxSelector);
        const checked = document.querySelectorAll(checkboxSelector + ':checked');
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
    };
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
 * @param {string} checkboxSelector - Selector for checkboxes (default: HOMEWORK_CHECKBOX_SELECTOR)
 */
function restoreProgress(storageKey = 'homeworkProgress', checkboxSelector = HOMEWORK_CHECKBOX_SELECTOR) {
    const saved = localStorage.getItem(storageKey);
    if (saved) {
        try {
            const data = JSON.parse(saved);
            const checkboxes = document.querySelectorAll(checkboxSelector);
            
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
            // Silently ignore corrupt progress data
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
        }).catch(() => {
            // Ignore clipboard errors
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
// Navigation
// ============================================

const NAV_LINKS = {
    A: {
        home: { href: '../index.html', label: '首页 Home' },
        unit7: {
            label: 'Unit 7',
            triggerHref: 'present-continuous-course.html',
            pages: [
                { key: 'unit7-course', href: 'present-continuous-course.html', label: '📖 现在进行时 Course' },
                { key: 'unit7-homework', href: 'present-continuous-homework.html', label: '✏️ 作业 Homework' }
            ]
        },
        unit8: {
            label: 'Unit 8',
            triggerHref: '../unit8/gerunds-ball-sports.html',
            pages: [
                { key: 'unit8-sports', href: '../unit8/gerunds-ball-sports.html', label: '⚾ 球类运动 Sports' },
                { key: 'unit8-vehicles', href: '../unit8/amazing-vehicles-reading.html', label: '🚌 交通工具 Vehicles' },
                { key: 'unit8-reading', href: '../unit8/fun-things-we-do-reading.html', label: '📚 补充阅读 Reading' },
                { key: 'unit8-homework', href: '../unit8/question-words-grammar-homework.html', label: '✏️ 语法作业 Homework' }
            ]
        },
        unit9: {
            label: 'Unit 9',
            triggerHref: '../unit9/holiday-plans-grammar-review.html',
            pages: [
                { key: 'unit9-grammar', href: '../unit9/holiday-plans-grammar-review.html', label: '🌴 假期计划语法 Grammar' },
                { key: 'unit9-fairytales', href: '../unit9/fairy-tales-reading.html', label: '🏰 Fairy Tales 童话' }
            ]
        }
    },
    B_unit8: {
        home: { href: '../index.html', label: '首页 Home' },
        unit7: {
            label: 'Unit 7',
            triggerHref: '../unit7/present-continuous-course.html',
            pages: [
                { key: 'unit7-course', href: '../unit7/present-continuous-course.html', label: '📖 现在进行时 Course' },
                { key: 'unit7-homework', href: '../unit7/present-continuous-homework.html', label: '✏️ 作业 Homework' }
            ]
        },
        unit8: {
            label: 'Unit 8',
            triggerHref: 'gerunds-ball-sports.html',
            pages: [
                { key: 'unit8-sports', href: 'gerunds-ball-sports.html', label: '⚾ 球类运动 Sports' },
                { key: 'unit8-vehicles', href: 'amazing-vehicles-reading.html', label: '🚌 交通工具 Vehicles' },
                { key: 'unit8-reading', href: 'fun-things-we-do-reading.html', label: '📚 补充阅读 Reading' },
                { key: 'unit8-homework', href: 'question-words-grammar-homework.html', label: '✏️ 语法作业 Homework' }
            ]
        },
        unit9: {
            label: 'Unit 9',
            triggerHref: '../unit9/holiday-plans-grammar-review.html',
            pages: [
                { key: 'unit9-grammar', href: '../unit9/holiday-plans-grammar-review.html', label: '🌴 假期计划语法 Grammar' },
                { key: 'unit9-fairytales', href: '../unit9/fairy-tales-reading.html', label: '🏰 Fairy Tales 童话' }
            ]
        }
    },
    B_unit9: {
        home: { href: '../index.html', label: '首页 Home' },
        unit7: {
            label: 'Unit 7',
            triggerHref: '../unit7/present-continuous-course.html',
            pages: [
                { key: 'unit7-course', href: '../unit7/present-continuous-course.html', label: '📖 现在进行时 Course' },
                { key: 'unit7-homework', href: '../unit7/present-continuous-homework.html', label: '✏️ 作业 Homework' }
            ]
        },
        unit8: {
            label: 'Unit 8',
            triggerHref: '../unit8/gerunds-ball-sports.html',
            pages: [
                { key: 'unit8-sports', href: '../unit8/gerunds-ball-sports.html', label: '⚾ 球类运动 Sports' },
                { key: 'unit8-vehicles', href: '../unit8/amazing-vehicles-reading.html', label: '🚌 交通工具 Vehicles' },
                { key: 'unit8-reading', href: '../unit8/fun-things-we-do-reading.html', label: '📚 补充阅读 Reading' },
                { key: 'unit8-homework', href: '../unit8/question-words-grammar-homework.html', label: '✏️ 语法作业 Homework' }
            ]
        },
        unit9: {
            label: 'Unit 9',
            triggerHref: 'holiday-plans-grammar-review.html',
            pages: [
                { key: 'unit9-grammar', href: 'holiday-plans-grammar-review.html', label: '🌴 假期计划语法 Grammar' },
                { key: 'unit9-fairytales', href: 'fairy-tales-reading.html', label: '🏰 Fairy Tales 童话' }
            ]
        }
    },
    'B_baseball-unit8': {
        home: { href: '../index.html', label: '首页 Home' },
        unit7: {
            label: 'Unit 7',
            triggerHref: '../unit7/baseball-present-continuous-course.html',
            pages: [
                { key: 'baseball-unit7-course', href: '../unit7/baseball-present-continuous-course.html', label: '⚾ 现在进行时 Course' },
                { key: 'baseball-unit7-homework', href: '../unit7/baseball-present-continuous-homework.html', label: '✏️ 作业 Homework' }
            ]
        },
        unit8: {
            label: 'Unit 8',
            triggerHref: 'baseball-gerunds-ball-sports.html',
            pages: [
                { key: 'baseball-unit8-sports', href: 'baseball-gerunds-ball-sports.html', label: '⚾ 球类运动 Sports' }
            ]
        },
        unit9: {
            label: 'Unit 9',
            triggerHref: '../../unit9/holiday-plans-grammar-review.html',
            pages: [
                { key: 'baseball-unit9-grammar', href: '../../unit9/holiday-plans-grammar-review.html', label: '🌴 假期计划语法 Grammar' },
                { key: 'baseball-unit9-fairytales', href: '../../unit9/fairy-tales-reading.html', label: '🏰 Fairy Tales 童话' }
            ]
        }
    },
    C: {
        'baseball-unit7-course': {
            home: { href: '../index.html', label: '⚾ Super Minds' },
            links: [
                { href: '../index.html', label: '🏠 首页' },
                { href: 'baseball-present-continuous-homework.html', label: '📚 课后作业' },
                { href: '../unit8/baseball-gerunds-ball-sports.html', label: '🏏 Unit 8' },
                { href: '../../unit9/holiday-plans-grammar-review.html', label: '🌴 Unit 9' },
                { href: '../../unit9/fairy-tales-reading.html', label: '🏰 Fairy Tales' }
            ],
            activeLabel: '⚾ Unit 7',
            separators: [0, 1, 2]
        },
        'baseball-unit7-homework': {
            home: { href: '../index.html', label: '⚾ Super Minds' },
            links: [
                { href: '../index.html', label: '🏠 首页' },
                { href: 'baseball-present-continuous-course.html', label: '⚾ Unit 7' },
                { href: '../unit8/baseball-gerunds-ball-sports.html', label: '🏏 Unit 8' },
                { href: '../../unit9/holiday-plans-grammar-review.html', label: '🌴 Unit 9' },
                { href: '../../unit9/fairy-tales-reading.html', label: '🏰 Fairy Tales' }
            ],
            activeLabel: '📚 课后作业',
            separators: [0, 1, 2]
        }
    }
};

function getUnitFromActive(active) {
    if (active.startsWith('baseball-unit7')) return 'baseball-unit7';
    if (active.startsWith('baseball-unit8')) return 'baseball-unit8';
    if (active.startsWith('unit7')) return 'unit7';
    if (active.startsWith('unit8')) return 'unit8';
    if (active.startsWith('unit9')) return 'unit9';
    return '';
}

function renderNav(config) {
    const container = document.getElementById('site-nav');
    if (!container) return;
    
    let html = '';
    switch (config.pattern) {
        case 'A':
            html = buildNavPatternA(config.active);
            break;
        case 'B':
            html = buildNavPatternB(config.active, config.brandIcon);
            break;
        case 'C':
            html = buildNavPatternC(config.active);
            break;

    }
    
    container.outerHTML = html;
}

function buildNavPatternA(active) {
    const links = NAV_LINKS.A;
    const isUnit7 = active.startsWith('unit7') || active.startsWith('baseball-unit7');
    const isUnit8 = active.startsWith('unit8') || active.startsWith('baseball-unit8');
    const isUnit9 = active.startsWith('unit9') || active.startsWith('baseball-unit9');
    
    const homeClass = (!isUnit7 && !isUnit8 && !isUnit9)
        ? 'px-3 py-2 text-sm font-medium text-white bg-white/20 rounded-lg border-b-2 border-yellow-400'
        : 'px-3 py-2 text-sm font-medium text-white/90 hover:text-white hover:bg-white/10 rounded-lg transition-all';
    
    function unitTriggerClass(isActive) {
        return isActive
            ? 'px-3 py-2 text-sm font-medium text-white bg-white/20 rounded-lg border-b-2 border-yellow-400 flex items-center gap-1'
            : 'px-3 py-2 text-sm font-medium text-white/90 hover:text-white hover:bg-white/10 rounded-lg transition-all flex items-center gap-1';
    }
    
    function dropdownItemClass(itemKey) {
        return active === itemKey
            ? 'block px-4 py-2 text-sm text-gray-700 bg-blue-50 font-medium'
            : 'block px-4 py-2 text-sm text-gray-700 hover:bg-blue-50';
    }
    
    function mobileItemClass(itemKey) {
        return active === itemKey
            ? 'block px-3 py-2 text-sm font-medium text-white bg-white/20 rounded-lg border-l-4 border-yellow-400'
            : 'block px-3 py-2 text-sm font-medium text-white/90 hover:text-white hover:bg-white/10 rounded-lg transition-all';
    }
    
    return `<nav id="site-nav" class="sticky top-0 z-50 bg-gradient-to-r from-blue-600 to-blue-800 border-b-4 border-yellow-400 shadow-lg mb-8 -mt-4 -mx-4 px-4 md:-mx-8 md:px-8">
        <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-14">
                <div class="flex items-center space-x-3">
                    <i data-lucide="book-open" class="text-white w-6 h-6"></i>
                    <span class="text-white text-lg font-bold">Super Minds 2</span>
                </div>
                <div class="hidden md:flex space-x-1 items-center">
                    <a href="${links.home.href}" class="${homeClass}">${links.home.label}</a>
                    <div class="relative group">
                        <a href="${links.unit7.triggerHref}" class="${unitTriggerClass(isUnit7)}">Unit 7 <i data-lucide="chevron-down" class="w-4 h-4"></i></a>
                        <div class="absolute left-0 top-full w-48 bg-white rounded-lg shadow-lg py-2 hidden group-hover:block z-50">
                            ${links.unit7.pages.map(p => `<a href="${p.href}" class="${dropdownItemClass(p.key)}">${p.label}</a>`).join('\n                            ')}
                        </div>
                    </div>
                    <div class="relative group">
                        <a href="${links.unit8.triggerHref}" class="${unitTriggerClass(isUnit8)}">Unit 8 <i data-lucide="chevron-down" class="w-4 h-4"></i></a>
                        <div class="absolute left-0 top-full w-48 bg-white rounded-lg shadow-lg py-2 hidden group-hover:block z-50">
                            ${links.unit8.pages.map(p => `<a href="${p.href}" class="${dropdownItemClass(p.key)}">${p.label}</a>`).join('\n                            ')}
                        </div>
                    </div>
                    <div class="relative group">
                        <a href="${links.unit9.triggerHref}" class="${unitTriggerClass(isUnit9)}">Unit 9 <i data-lucide="chevron-down" class="w-4 h-4"></i></a>
                        <div class="absolute left-0 top-full w-48 bg-white rounded-lg shadow-lg py-2 hidden group-hover:block z-50">
                            ${links.unit9.pages.map(p => `<a href="${p.href}" class="${dropdownItemClass(p.key)}">${p.label}</a>`).join('\n                            ')}
                        </div>
                    </div>
                </div>
                <button type="button" onclick="toggleMobileMenu()" aria-label="Toggle navigation menu" class="md:hidden text-white p-2 rounded-lg hover:bg-white/10">
                    <i data-lucide="menu" class="w-6 h-6"></i>
                </button>
            </div>
            <div id="mobileMenu" class="hidden md:hidden pb-4">
                <div class="flex flex-col space-y-2">
                    <a href="${links.home.href}" class="px-3 py-2 text-sm font-medium text-white/90 hover:text-white hover:bg-white/10 rounded-lg transition-all">${links.home.label}</a>
                    <div class="px-3 py-2">
                        <div class="text-white/70 text-xs mb-1">Unit 7</div>
                        ${links.unit7.pages.map(p => `<a href="${p.href}" class="${mobileItemClass(p.key)}">${p.label}</a>`).join('\n                        ')}
                    </div>
                    <div class="px-3 py-2">
                        <div class="text-white/70 text-xs mb-1">Unit 8</div>
                        ${links.unit8.pages.map(p => `<a href="${p.href}" class="${mobileItemClass(p.key)}">${p.label}</a>`).join('\n                        ')}
                    </div>
                    <div class="px-3 py-2">
                        <div class="text-white/70 text-xs mb-1">Unit 9</div>
                        ${links.unit9.pages.map(p => `<a href="${p.href}" class="${mobileItemClass(p.key)}">${p.label}</a>`).join('\n                        ')}
                    </div>
                </div>
            </div>
        </div>
    </nav>`;
}

function buildNavPatternB(active, brandIcon) {
    const unit = getUnitFromActive(active);
    const links = NAV_LINKS['B_' + unit];
    if (!links) return '';
    
    const icon = brandIcon || 'fa-baseball-ball';
    const isUnit7 = active.startsWith('unit7');
    const isUnit8 = active.startsWith('unit8');
    const isUnit9 = active.startsWith('unit9');
    
    const homeClass = 'nav-link px-3 py-2 text-sm font-medium';
    
    function unitTriggerClass(isActive) {
        return isActive
            ? 'nav-link px-3 py-2 text-sm font-medium border-b-2 border-red-500'
            : 'nav-link px-3 py-2 text-sm font-medium';
    }
    
    function unitTriggerLabel(unitNum) {
        if (unitNum === 7) return 'Unit 7 <i class="fas fa-chevron-down text-xs"></i>';
        if (unitNum === 8) return isUnit8 ? 'Unit 8 ⚾' : 'Unit 8 <i class="fas fa-chevron-down text-xs"></i>';
        if (unitNum === 9) return 'Unit 9 <i class="fas fa-chevron-down text-xs"></i>';
        return '';
    }
    
    function dropdownItemClass(itemKey) {
        return active === itemKey
            ? 'block px-4 py-2 text-sm text-gray-700 bg-gray-100 font-medium'
            : 'block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100';
    }
    
    function mobileItemClass(itemKey) {
        return active === itemKey
            ? 'nav-link px-3 py-2 text-sm font-medium block text-white border-l-4 border-red-500 pl-4'
            : 'nav-link px-3 py-2 text-sm font-medium block';
    }
    
    return `<nav id="site-nav" class="sticky top-0 z-50 bg-gradient-to-r from-green-900 to-green-800 border-b-4 border-red-700 shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center space-x-4">
                    <i class="fas ${icon} text-white text-2xl"></i>
                    <span class="baseball-font text-white text-xl font-bold">Super Minds 2</span>
                </div>
                <div class="hidden md:flex space-x-8">
                    <a href="${links.home.href}" class="${homeClass}">${links.home.label}</a>
                    <div class="relative group">
                        <a href="${links.unit7.triggerHref}" class="${unitTriggerClass(isUnit7)}">${unitTriggerLabel(7)}</a>
                        <div class="absolute left-0 top-full w-48 bg-white rounded-lg shadow-lg py-2 hidden group-hover:block z-50">
                            ${links.unit7.pages.map(p => `<a href="${p.href}" class="${dropdownItemClass(p.key)}">${p.label}</a>`).join('\n                            ')}
                        </div>
                    </div>
                    <div class="relative group">
                        <a href="${links.unit8.triggerHref}" class="${unitTriggerClass(isUnit8)}">${unitTriggerLabel(8)}</a>
                        <div class="absolute left-0 top-full w-48 bg-white rounded-lg shadow-lg py-2 hidden group-hover:block z-50">
                            ${links.unit8.pages.map(p => `<a href="${p.href}" class="${dropdownItemClass(p.key)}">${p.label}</a>`).join('\n                            ')}
                        </div>
                    </div>
                    <div class="relative group">
                        <a href="${links.unit9.triggerHref}" class="${unitTriggerClass(isUnit9)}">${unitTriggerLabel(9)}</a>
                        <div class="absolute left-0 top-full w-48 bg-white rounded-lg shadow-lg py-2 hidden group-hover:block z-50">
                            ${links.unit9.pages.map(p => `<a href="${p.href}" class="${dropdownItemClass(p.key)}">${p.label}</a>`).join('\n                            ')}
                        </div>
                    </div>
                </div>
                <button type="button" onclick="toggleMobileMenu()" aria-label="Toggle navigation menu" class="md:hidden text-white p-2 rounded-lg hover:bg-white/10">
                    <i class="fas fa-bars text-xl"></i>
                </button>
            </div>
            <div id="mobileMenu" class="hidden md:hidden pb-4">
                <div class="flex flex-col space-y-2">
                    <a href="${links.home.href}" class="nav-link px-3 py-2 text-sm font-medium">${links.home.label}</a>
                    <div class="px-3 py-2">
                        <div class="text-white/70 text-xs mb-1">Unit 7</div>
                        ${links.unit7.pages.map(p => `<a href="${p.href}" class="${mobileItemClass(p.key)}">${p.label}</a>`).join('\n                        ')}
                    </div>
                    <div class="px-3 py-2">
                        <div class="text-white/70 text-xs mb-1">Unit 8</div>
                        ${links.unit8.pages.map(p => `<a href="${p.href}" class="${mobileItemClass(p.key)}">${p.label}</a>`).join('\n                        ')}
                    </div>
                    <div class="px-3 py-2">
                        <div class="text-white/70 text-xs mb-1">Unit 9</div>
                        ${links.unit9.pages.map(p => `<a href="${p.href}" class="${mobileItemClass(p.key)}">${p.label}</a>`).join('\n                        ')}
                    </div>
                </div>
            </div>
        </div>
    </nav>`;
}

function buildNavPatternC(active) {
    const config = NAV_LINKS.C[active];
    if (!config) return '';
    
    const desktopLinks = config.links.map(function(link, index) {
        var sep = config.separators.indexOf(index) !== -1 ? '\n                    <span>|</span>' : '';
        return '<a href="' + link.href + '" class="hover:text-yellow-400 transition-colors">' + link.label + '</a>' + sep;
    }).join('\n                    ');
    
    const mobileLinks = config.links.map(function(link) {
        return '<a href="' + link.href + '" class="hover:text-yellow-400 transition-colors py-1">' + link.label + '</a>';
    }).join('\n                    ');
    
    return '<nav id="site-nav" class="bg-red-800 text-white py-4 sticky top-0 z-50 shadow-lg">\n' +
        '        <div class="max-w-6xl mx-auto px-4">\n' +
        '            <div class="flex justify-between items-center">\n' +
        '                <a href="' + config.home.href + '" class="text-xl font-bold baseball-font">' + config.home.label + '</a>\n' +
        '                <div class="hidden md:flex gap-4 text-sm items-center">\n' +
        '                    ' + desktopLinks + '\n' +
        '                    <span>|</span>\n' +
        '                    <span class="text-yellow-400">' + config.activeLabel + '</span>\n' +
        '                </div>\n' +
        '                <button type="button" onclick="toggleMobileMenu()" aria-label="Toggle navigation menu" class="md:hidden text-white p-2 hover:bg-white/10 rounded">\n' +
        '                    ☰\n' +
        '                </button>\n' +
        '            </div>\n' +
        '            <div id="mobileMenu" class="hidden md:hidden mt-4 pb-2 border-t border-red-700 pt-2">\n' +
        '                <div class="flex flex-col space-y-2 text-sm">\n' +
        '                    ' + mobileLinks + '\n' +
        '                    <span class="text-yellow-400 py-1 border-l-4 border-yellow-400 pl-2">' + config.activeLabel + '</span>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '        </div>\n' +
        '    </nav>';
}

// ============================================
// Reveal Answer Utilities
// ============================================

/**
 * Toggle reveal answer on a blank/fill element
 * Swaps between placeholder text and data-answer attribute
 * @param {HTMLElement} element - The element to toggle
 */
if (typeof revealAnswer !== 'function') {
    window.revealAnswer = function(element) {
        if (element.classList.contains('revealed')) {
            element.classList.remove('revealed');
            element.textContent = element.getAttribute('data-placeholder') || '_____';
        } else {
            element.classList.add('revealed');
            element.textContent = element.getAttribute('data-answer');
        }
    };
}

// ============================================
// Speech / Audio Utilities
// ============================================

/**
 * Speak text using Web Speech API with optional card animation
 * @param {string} text - The text to speak
 * @param {HTMLElement} cardElement - Optional card element to animate
 */
if (typeof speak !== 'function') {
    window.speak = function(text, cardElement) {
        if (!window.speechSynthesis) return;
        window.speechSynthesis.cancel();

        const utter = new SpeechSynthesisUtterance(text);
        utter.lang = 'en-US';
        utter.rate = 0.8;

        if (cardElement) {
            // Clear speaking state from all other cards
            document.querySelectorAll('.vocab-card.speaking, .word-card.speaking').forEach(function(c) {
                if (c !== cardElement) c.classList.remove('speaking');
            });
            cardElement.classList.add('speaking');
            utter.onend = utter.onerror = function() {
                cardElement.classList.remove('speaking');
            };
        }

        window.speechSynthesis.speak(utter);
    };
}

// ============================================
// Todo / Progress Utilities
// ============================================

/**
 * Update progress bar based on completed todo items
 * @param {string} storageKey - localStorage key for this todo list
 */
if (typeof updateTodoProgress !== 'function') {
    window.updateTodoProgress = function(storageKey) {
        const items = document.querySelectorAll('.todo-item');
        const completed = document.querySelectorAll('.todo-item.completed');
        const bar = document.getElementById('progressBar');
        if (bar && items.length > 0) {
            const pct = Math.round((completed.length / items.length) * 100);
            bar.style.width = pct + '%';
            bar.textContent = pct === 100 ? '🎉 100% 完成！' : pct + '%';
        }
        if (storageKey) {
            const states = {};
            items.forEach(function(item) {
                const id = item.getAttribute('data-todo');
                if (id) states[id] = item.classList.contains('completed');
            });
            try {
                localStorage.setItem(storageKey, JSON.stringify(states));
            } catch (e) {
                // Silently ignore storage errors
            }
        }
    };
}

/**
 * Toggle a todo item's completed state
 * @param {HTMLElement} item - The todo item element
 * @param {string} storageKey - localStorage key for this todo list
 */
if (typeof toggleTodoItem !== 'function') {
    window.toggleTodoItem = function(item, storageKey) {
        item.classList.toggle('completed');
        updateTodoProgress(storageKey);
    };
}

/**
 * Reset all todo items to incomplete
 * @param {string} storageKey - localStorage key for this todo list
 */
if (typeof resetTodoItems !== 'function') {
    window.resetTodoItems = function(storageKey) {
        if (!confirm('确定要重置所有任务吗？Are you sure you want to reset all tasks?')) return;
        document.querySelectorAll('.todo-item').forEach(function(item) {
            item.classList.remove('completed');
        });
        updateTodoProgress(storageKey);
        if (storageKey) {
            try {
                localStorage.setItem(storageKey, JSON.stringify({}));
            } catch (e) {
                // Silently ignore storage errors
            }
        }
    };
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
    // Render navigation if configured
    if (window.NAV_CONFIG && document.getElementById('site-nav')) {
        renderNav(window.NAV_CONFIG);
    }
    
    // Initialize icons (after nav injection so nav icons are also initialized)
    initIcons();
    
    // Restore progress only on homework pages (check for progress bar element)
    // Using #progress-bar as it's specific to homework pages and won't conflict
    // with other pages that might have checkboxes for different purposes
    // Only restore progress on homework pages that have both a progress bar
    // and .check-item checkboxes (Unit 8/9 todo pages use their own progress system)
    const hasProgressBar = document.getElementById('progress-bar') || document.getElementById('progressBar');
    const hasCheckboxes = document.querySelectorAll(HOMEWORK_CHECKBOX_SELECTOR).length > 0;
    if (hasProgressBar && hasCheckboxes) {
        restoreProgress();
    }
}

// Run initialization when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCommon);
} else {
    initCommon();
}
