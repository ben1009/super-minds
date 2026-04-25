// Unit 8 Grammar Homework - Interactive Functions

let currentUtter = null;

function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    menu.classList.toggle('hidden');
}

function toggleTrans(card) {
    const content = card.querySelector('.trans-content');
    const toggle = card.querySelector('.trans-toggle');
    const isOpen = content.classList.contains('show');
    
    if (isOpen) {
        content.classList.remove('show');
        // Restore original text from data attribute, or use default
        const originalText = toggle.getAttribute('data-original') || (toggle.textContent.includes('答案') ? '🌐 答案' : '🌐 翻译');
        toggle.textContent = originalText;
    } else {
        content.classList.add('show');
        toggle.textContent = '🔼 隐藏';
    }
}

function toggleDialog(card) {
    const content = card.querySelector('.trans-content');
    const isOpen = content.classList.contains('show');
    
    if (isOpen) {
        content.classList.remove('show');
    } else {
        content.classList.add('show');
    }
}

function speakText(btn, text) {
    if (!('speechSynthesis' in window)) {
        alert('您的浏览器不支持发音功能');
        return;
    }
    const synth = window.speechSynthesis;
    const isSpeaking = btn.classList.contains('speaking');
    
    if (currentUtter) synth.cancel();
    
    document.querySelectorAll('.audio-btn').forEach(b => {
        b.classList.remove('speaking');
        b.textContent = '🔊 点击发音';
    });
    
    if (isSpeaking) {
        currentUtter = null;
        return;
    }
    
    const utter = new SpeechSynthesisUtterance(text);
    utter.lang = 'en-US';
    utter.rate = 0.85;
    utter.pitch = 1;
    
    utter.onstart = () => {
        btn.classList.add('speaking');
        btn.textContent = '⏹ 停止发音';
    };
    utter.onend = () => {
        btn.classList.remove('speaking');
        btn.textContent = '🔊 点击发音';
        currentUtter = null;
    };
    
    currentUtter = utter;
    synth.speak(utter);
}

function toggleBlank(wrapper) {
    wrapper.classList.toggle('revealed');
}

// Todo list functionality
let todoStates = {};

try {
    const saved = localStorage.getItem('grammarTodos');
    if (saved) todoStates = JSON.parse(saved);
} catch (e) { }

function updateProgress() {
    const todos = document.querySelectorAll('.todo-item');
    const completed = document.querySelectorAll('.todo-item.completed');
    const progress = todos.length > 0 ? Math.round((completed.length / todos.length) * 100) : 0;

    const bar = document.getElementById('progressBar');
    if (bar) {
        bar.style.width = progress + '%';
        bar.textContent = progress === 100 ? '🎉 100% 完成！' : progress + '%';
    }
}

function toggleTodo(item) {
    const id = item.getAttribute('data-todo');

    if (item.classList.contains('completed')) {
        item.classList.remove('completed');
        todoStates[id] = false;
    } else {
        item.classList.add('completed');
        todoStates[id] = true;
    }

    try {
        localStorage.setItem('grammarTodos', JSON.stringify(todoStates));
    } catch (e) { }

    updateProgress();
}

function resetTodos() {
    if (confirm('确定要重置所有作业任务吗？')) {
        document.querySelectorAll('.todo-item').forEach(item => {
            item.classList.remove('completed');
        });
        todoStates = {};
        try {
            localStorage.setItem('grammarTodos', '{}');
        } catch (e) { }
        updateProgress();
    }
}

// Event Listeners - Modern approach instead of onclick attributes
document.addEventListener('DOMContentLoaded', () => {
    // Mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', toggleMobileMenu);
    }

    // Trans cards (translation toggle) - handle click on card header area
    document.querySelectorAll('.trans-card').forEach(card => {
        card.addEventListener('click', (e) => {
            // Prevent triggering if clicking interactive elements inside
            if (e.target.closest('button') || e.target.closest('a')) return;
            toggleTrans(card);
        });
    });

    // Dialog cards
    document.querySelectorAll('.dialog-card').forEach(card => {
        card.addEventListener('click', () => toggleDialog(card));
    });

    // Vocab cards - speak text on click (excluding button clicks)
    document.querySelectorAll('.vocab-card').forEach(card => {
        card.addEventListener('click', (e) => {
            // Don't trigger if clicking the button directly
            if (e.target.closest('.audio-btn')) return;
            const btn = card.querySelector('.audio-btn');
            const text = btn.getAttribute('data-text') || card.querySelector('.word').textContent;
            speakText(btn, text);
        });
    });

    // Audio buttons
    document.querySelectorAll('.audio-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.stopPropagation();
            const text = btn.getAttribute('data-text') || btn.closest('.vocab-card').querySelector('.word').textContent;
            speakText(btn, text);
        });
    });

    // Blank wrappers (cloze exercise)
    document.querySelectorAll('.blank-wrapper').forEach(wrapper => {
        wrapper.addEventListener('click', () => toggleBlank(wrapper));
    });

    // Todo items
    document.querySelectorAll('.todo-item').forEach(item => {
        item.addEventListener('click', () => toggleTodo(item));
    });

    // Restore todo states
    Object.keys(todoStates).forEach(id => {
        if (todoStates[id]) {
            const item = document.querySelector('[data-todo="' + id + '"]');
            if (item) item.classList.add('completed');
        }
    });
    updateProgress();
});
