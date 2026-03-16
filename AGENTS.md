# Super Minds - Agent Guide

## Project Overview

Super Minds 是一个面向儿童的互动式英语语法学习网站，目前专注于教授**现在进行时（Present Continuous Tense）**。该项目托管在 GitHub Pages 上，无需后端服务器即可运行。

- **在线访问**: https://ben1009.github.io/super-minds/
- **源码仓库**: https://github.com/ben1009/super-minds
- **目标用户**: 儿童英语学习者
- **课程来源**: Super Minds 2 教材 Unit 7

## Technology Stack

- **纯前端架构**: HTML5 + CSS3 + 原生 JavaScript（无框架）
- **CSS 框架**: [Tailwind CSS](https://tailwindcss.com/) (通过 CDN 引入)
- **图标库**: [Lucide Icons](https://lucide.dev/) (通过 CDN 引入)
- **字体**: Google Fonts (Noto Serif SC, Ma Shan Zheng, Nunito, Noto Sans SC)
- **分析工具**: Google Analytics (G-QJ6EXQH8SW)
- **托管平台**: GitHub Pages

## Project Structure

```
/home/liu/proj/super-minds/
├── index.html              # 主页 - 课程导航入口
├── unit7/
│   ├── index.html          # Unit 7 课程页面（现在进行时精讲）
│   └── homework.html       # Unit 7 作业页面
├── LICENSE                 # Apache License 2.0
├── README.md               # 项目说明文档
└── AGENTS.md               # 本文件
```

### 页面说明

| 文件 | 功能描述 |
|------|---------|
| `index.html` | 课程平台主页，展示所有可用单元卡片，导航到具体课程 |
| `unit7/index.html` | Unit 7 核心课程，包含：汉堡包结构讲解、Be动词口诀、三种句型、动词-ing规则、互动练习、故事阅读、完形填空 |
| `unit7/homework.html` | 作业页面，包含：句型转换练习、造句练习、故事复述、对话创作、作业清单与进度追踪 |

## Code Organization

### 设计模式

- **单页应用风格**: 每个 HTML 文件是独立的单页，通过锚点或 JS 切换内容
- **响应式设计**: 使用 Tailwind 的响应式类（md:, lg: 前缀）适配移动端和桌面端
- **渐进增强**: 基础内容可正常显示，JavaScript 增强交互体验

### CSS 架构

每个页面使用内嵌 `<style>` 标签定义样式，主要包含：

1. **基础样式**: body 背景、字体定义
2. **组件样式**: 卡片、按钮、徽章、时间线、对话气泡等
3. **动画样式**: fadeInUp、float 等关键帧动画
4. **交互状态**: hover、active、expanded 等状态样式

### JavaScript 架构

每个页面内嵌 `<script>` 标签实现交互功能：

| 函数/功能 | 所在页面 | 说明 |
|-----------|---------|------|
| `toggleQuizAnswer()` | unit7/index.html | 展开/收起练习题答案 |
| `toggleTranslation()` | unit7/index.html | 显示/隐藏故事翻译 |
| `toggleCompAnswer()` | unit7/index.html | 理解测验答案切换 |
| `checkCloze()` | unit7/index.html | 检查完形填空答案 |
| `switchTab()` | unit7/homework.html | 句型标签切换（肯定/否定/疑问）|
| `toggleTimeline()` | unit7/homework.html | 故事时间线展开/收起 |
| `toggleAnswer()` | unit7/homework.html | 答案遮罩显示/隐藏 |
| `toggleComplete()` | unit7/homework.html | 作业完成状态切换 |
| `updateProgress()` | unit7/homework.html | 更新进度条和 localStorage |
| `copyDialogue()` | unit7/homework.html | 复制对话文本到剪贴板 |

### 数据存储

- **localStorage 键**: `homeworkProgress`
- **存储内容**: 作业完成状态数组 + 日期
- **用途**: 跨会话保存用户的作业完成进度

## Key Features Implementation

### 1. 完形填空 (Cloze Test)

- 使用 `data-answer` 和 `data-options` 属性存储答案和选项
- 点击空白处弹出下拉选项框
- 选择后通过 `checkCloze()` 验证并显示正确/错误样式

### 2. 答案遮罩 (Answer Mask)

- 使用 `.answer-mask` 类实现可点击的答案区域
- 默认显示斜纹背景，点击后显示答案内容
- 再次点击可隐藏（切换 `revealed` 类）

### 3. 闪卡 (Flashcard)

- 使用 CSS 3D 变换实现翻转效果
- `perspective` + `rotateY(180deg)` 实现卡片翻转
- 点击切换 `.flipped` 类

### 4. 故事时间线

- 垂直时间线布局，左侧为时间轴线
- 每个节点可点击展开详情
- 使用 `max-height` 动画实现平滑展开/收起

### 5. 作业进度追踪

- 复选框状态变化时更新 localStorage
- 页面加载时从 localStorage 恢复状态
- 进度条实时显示完成百分比

## Development Guidelines

### 代码风格

1. **HTML**:
   - 使用语义化标签（section、header、main、footer）
   - 类名使用 kebab-case（如 `glass-card`, `timeline-node`）
   - 数据属性使用小写（如 `data-answer`, `data-options`）

2. **CSS**:
   - 优先使用 Tailwind 工具类
   - 自定义样式放在 `<style>` 标签中
   - 颜色使用 Tailwind 色值（如 `bg-blue-50`, `text-gray-800`）
   - 动画使用 `transition-all` 和 `ease` 缓动函数

3. **JavaScript**:
   - 使用原生 ES6+ 语法
   - 事件监听使用 `addEventListener`
   - DOM 操作优先使用 `querySelector`/`querySelectorAll`
   - 使用 `event.stopPropagation()` 防止事件冒泡

### 添加新单元的步骤

1. 创建 `unitX/` 目录
2. 复制 `unit7/index.html` 或 `unit7/homework.html` 作为模板
3. 修改页面标题和内容
4. 更新根目录 `index.html` 中的单元卡片链接
5. 测试所有交互功能

### 修改现有内容的注意事项

- **样式修改**: 检查响应式断点（md:, lg:）确保移动端正常
- **内容修改**: 保持中英文对照格式一致
- **JS 修改**: 确保不影响 localStorage 已有数据（考虑版本兼容性）

## Deployment

### GitHub Pages 部署

项目已配置 GitHub Pages，推送至 `master` 分支后自动部署：

```bash
git add .
git commit -m "描述更改"
git push origin master
```

部署后访问：https://ben1009.github.io/super-minds/

### 本地预览

由于项目使用纯静态文件，可直接用浏览器打开：

```bash
# 方法1: 直接打开文件
open index.html

# 方法2: 使用 Python 简单服务器
python3 -m http.server 8000
# 然后访问 http://localhost:8000
```

## Testing Strategy

- **手动测试**: 在 Chrome、Safari、Firefox 中测试交互功能
- **响应式测试**: 使用浏览器 DevTools 测试不同屏幕尺寸
- **功能测试**: 
  - 点击所有可交互元素检查响应
  - 验证 localStorage 数据持久化
  - 检查复制功能是否正常工作

## License

- **源代码**: Apache License 2.0
- **课程内容**: CC BY-NC-SA 4.0 (非商业用途，需署名，相同方式共享)

## Common Tasks

### 添加新的互动练习题

在 `unit7/index.html` 的 `.quiz-container` 中添加：

```html
<div class="quiz-item" onclick="toggleQuizAnswer(this)">
    <div class="flex items-center gap-4">
        <div class="w-10 h-10 bg-purple-100 rounded-full flex items-center justify-center font-bold text-purple-700 border-2 border-purple-300">X</div>
        <div class="flex-1">
            <div class="text-lg font-medium text-gray-800">题目内容</div>
        </div>
        <i data-lucide="chevron-down" class="w-6 h-6 text-gray-400"></i>
    </div>
    <div class="quiz-answer">
        <div class="font-bold text-lg mb-2">答案：xxx</div>
        <div class="text-gray-600">中文翻译</div>
    </div>
</div>
```

### 修改 Google Analytics ID

在 `unit7/index.html` 的 `<head>` 中修改：

```javascript
const GA_MEASUREMENT_ID = 'G-XXXXXXXXXX';
```

### 更新作业日期

在 `unit7/homework.html` 中搜索并替换日期字符串。
