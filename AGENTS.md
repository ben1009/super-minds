# Super Minds - Agent Guide

## Project Overview

Super Minds 是一个面向儿童的互动式英语语法学习网站，涵盖**现在进行时（Present Continuous Tense）**、**动名词作主语（Gerunds as Subjects）**等多个语法主题。该项目托管在 GitHub Pages 上，无需后端服务器即可运行。

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
<project-root>/
├── index.html              # 主页 - 课程导航入口
├── ga.js                   # 共享的 Google Analytics 跟踪脚本 (根目录)
├── css/
│   └── common.css          # 共享 CSS 样式（变量、动画、工具类）
├── js/
│   └── common.js           # 共享 JavaScript 工具函数
├── unit7/
│   ├── index.html          # Unit 7 课程页面（现在进行时精讲）
│   └── homework.html       # Unit 7 作业页面
├── unit8/
│   ├── index.html          # Unit 8 课程页面 - 球类运动（动名词作主语）
│   ├── amazing-vehicles.html  # Unit 8 课程页面 - 神奇的交通工具（阅读与词汇）
│   ├── reading.html        # Unit 8 课程页面 - Fun Things We Do（阅读与爱好）
│   ├── grammar.html        # Unit 8 语法作业页面（疑问词练习与完形填空）
│   ├── grammar.css         # Unit 8 语法页面专用样式
│   └── grammar.js          # Unit 8 语法页面交互脚本
├── unit9/
│   └── index.html          # Unit 9 语法复习页面（假期计划语法总结）
├── super-minds-baseball/   # 棒球英语学习板块
│   ├── index.html          # 棒球版主页
│   ├── unit7/
│   │   ├── index.html      # 棒球版 Unit 7 课程
│   │   └── homework.html   # 棒球版 Unit 7 作业
│   └── unit8/
│       └── index.html      # 棒球版 Unit 8 课程
├── LICENSE                 # Apache License 2.0
├── README.md               # 项目说明文档
└── AGENTS.md               # 本文件
```

### 页面说明

| 文件 | 功能描述 |
|------|---------|
| `index.html` | 课程平台主页，展示所有可用单元卡片，导航到具体课程；页脚含有彩蛋链接到棒球板块 |
| `unit7/index.html` | Unit 7 核心课程，包含：汉堡包结构讲解、Be动词口诀、三种句型、动词-ing规则、互动练习、故事阅读、完形填空 |
| `unit7/homework.html` | 作业页面，包含：句型转换练习、造句练习、故事复述、对话创作、作业清单与进度追踪 |
| `unit8/index.html` | Unit 8 核心课程 - 球类运动，包含：10个球类运动词汇、动名词作主语语法结构、歌曲填空、两篇阅读材料、汉译英练习、理解测验 |
| `unit8/amazing-vehicles.html` | Unit 8 课程 - 神奇的交通工具，包含：9个核心词汇、Measure与There be语法、两篇阅读理解（10题）、完形填空、作业待办清单 |
| `unit8/reading.html` | Unit 8 课程 - Fun Things We Do，包含：人物卡片、阅读课文、5道理解题、9个词汇卡片（带发音）、语法重点、作业清单 |
| `unit8/grammar.html` | Unit 8 语法作业页面，包含：5个疑问词用法、新对话、9个动词短语、造句练习、邮件完形填空、作业清单 |
| `unit8/grammar.css` | Unit 8 语法页面专用样式（棒球主题风格） |
| `unit8/grammar.js` | Unit 8 语法页面交互脚本（翻译切换、发音、填空交互） |
| `unit9/index.html` | Unit 9 语法复习页面，包含：Page 108歌曲语法重点、Page 109语法总结、两组对话填空（35+空）、5个动词短语发音、作业清单 |
| `super-minds-baseball/unit8/index.html` | 棒球版 Unit 8 课程内容 |
| `super-minds-baseball/index.html` | 棒球主题的英语学习板块主页 |
| `css/common.css` | 共享 CSS 样式模块（变量、动画、工具类） |
| `js/common.js` | 共享 JavaScript 工具函数（导航、切换、进度追踪） |
| `super-minds-baseball/unit7/index.html` | 棒球版 Unit 7 课程内容 |
| `super-minds-baseball/unit7/homework.html` | 棒球版 Unit 7 作业内容 |

## Code Organization

### 设计模式

- **单页应用风格**: 每个 HTML 文件是独立的单页，通过锚点或 JS 切换内容
- **响应式设计**: 使用 Tailwind 的响应式类（md:, lg: 前缀）适配移动端和桌面端
- **渐进增强**: 基础内容可正常显示，JavaScript 增强交互体验

### CSS 架构

项目使用分层 CSS 架构：

1. **共享样式** (`css/common.css`):
   - CSS 变量（品牌色、字体、背景渐变）
   - 通用关键帧动画（fadeInUp, float）
   - 工具类（.sm-body, .animate-fade-in, .glass-card, .card-hover, .ink-gradient）

2. **页面特定样式** (内嵌 `<style>`):
   - 组件特有样式（时间线、对话气泡、闪卡等）
   - 页面特定的动画和交互状态

**使用方式**: 
```html
<link rel="stylesheet" href="css/common.css">  <!-- 根目录页面 -->
<link rel="stylesheet" href="../css/common.css">  <!-- 子目录页面 -->
<body class="sm-body">  <!-- 启用共享 body 样式 -->
```

### JavaScript 架构

项目使用分层 JavaScript 架构：

#### 共享模块 (`js/common.js`)

| 函数 | 说明 |
|------|------|
| `toggleMobileMenu()` | 切换移动端菜单显示/隐藏 |
| `toggleQuizAnswer(container)` | 展开/收起练习题答案 |
| `toggleTranslation(container)` | 显示/隐藏故事翻译 |
| `toggleCompAnswer(container)` | 切换理解测验答案 |
| `toggleTimeline(node)` | 展开/收起时间线节点 |
| `toggleAnswer(element)` | 切换答案遮罩显示/隐藏 |
| `switchTab(tabName)` | 切换标签页 |
| `toggleComplete(checkbox)` | 切换作业完成状态 |
| `updateProgress()` | 更新进度条并保存到 localStorage |
| `restoreProgress()` | 从 localStorage 恢复进度 |
| `copyToClipboard(text)` | 复制文本到剪贴板 |

**使用方式**:
```html
<script src="js/common.js"></script>  <!-- 根目录页面 -->
<script src="../js/common.js"></script>  <!-- 子目录页面 -->
```

#### 页面特定脚本

页面内嵌 `<script>` 包含仅该页面需要的逻辑，如：
- `checkCloze()` - 完形填空检查（unit7/index.html）
- `copyDialogue()` - 对话复制（unit7/homework.html）
- 事件监听器和初始化代码

所有页面自动调用 `initCommon()` 进行初始化（图标初始化、进度恢复等）。

### 数据存储

- **localStorage 键**: `homeworkProgress`
- **存储内容**: 作业完成状态数组 + 日期
- **用途**: 跨会话保存用户的作业完成进度

## Unit 8 Specific Features

### 1. 词汇卡片 (Vocabulary Cards)
- 10个球类运动词汇，带emoji图标
- 点击卡片可朗读单词（使用 Web Speech API）
- 棒球主题高亮显示

### 2. 语法公式展示 (Grammar Formula)
- 动名词作主语核心结构：Playing + 球类 + is + 形容词
- 彩色代码区分各部分
- 多个例句展示不同形容词搭配

### 3. 歌曲填空 (Song Activity)
- 四段歌词，每段有一个动名词填空
- 点击空白处切换显示/隐藏答案
- 使用 data-answer 属性存储正确答案

### 4. 阅读理解 (Reading Comprehension)
- 两篇阅读材料，共23个段落
- 点击段落显示中文翻译
- 大量动名词作主语的例句

### 5. 汉译英练习 (Translation Exercise)
- 9道中文句子翻译练习
- 点击显示英文答案
- 强化动名词作主语的句型结构

## Unit 8 Amazing Vehicles Specific Features

### 1. 词汇卡片 (Vocabulary Cards)
- 9个交通工具相关词汇（amazing, because, inside, difficult, front, back, party, drive, pool）
- 每个词汇包含英文单词、中文释义、英文定义和例句
- 点击朗读按钮使用 Web Speech API 发音

### 2. 语法重点 (Grammar Focus)
- Measure vs Measuring 对比展示
- There be 句式与长度单位（1cm=10mm, 1m=100cm）
- 可视化换算图表

### 3. 阅读理解 (Reading Comprehension)
- 两篇阅读文章：双层巴士和豪华轿车
- 10道选择题，点击显示答案和解析
- 高亮显示正确答案选项

### 4. 完形填空 (Cloze Exercise)
- 6个填空，点击空白处显示/隐藏答案
- 词库（Word Bank）可点击朗读
- 答案填充动画效果

### 5. 作业待办清单 (Homework Todo List)
- 4项作业任务，带进度条
- LocalStorage 持久化保存完成状态
- 家长提示区域

## Unit 8 Grammar Homework (grammar.html) Specific Features

### 1. 语法重点卡片 (Grammar Focus Cards)
- 5个疑问词用法卡片：Where, When, Which, Who, How often
- 点击卡片展开例句和用法说明
- Pattern 卡片展示核心句式结构

### 2. 新对话 (New Dialogue)
- 8段对话，讲述组建足球队的故事场景
- 点击对话卡片显示中文翻译
- 场景标签标注关键情境（进球、比赛等）

### 3. 重点词汇 (Key Vocabulary)
- 9个Unit 9动词短语（来自教材page 4-5）
- 点击 🔊 按钮使用 Web Speech API 发音
- 每个词汇配例句展示实际用法

### 4. 造句练习 (Sentence Practice)
- 4道造句练习题
- 使用 Where/When/Which + do you like doing 句式
- 点击卡片显示参考答案

### 5. 邮件完形填空 (Email Cloze)
- Harry的法国游学邮件场景
- 10个动词填空（live, work, get up, leave, have, walk, catch, finish, meet, go out）
- 词库（Word Bank）提示，点击下划线显示/隐藏答案

### 6. 今日任务 (Today's Todo)
- 4项作业任务，点击标记完成（划掉效果）
- 任务包括：背单词、复习句型、完成造句、完成填空

---

## Unit 8 Reading (Fun Things We Do) Specific Features

### 1. 人物卡片 (Character Cards)
- 5个人物卡片（Amy, Ben, Cindy, David, Writer）
- 每个人物展示爱好和性格特点
- 彩色边框区分不同人物

### 2. 阅读课文 (Reading Text)
- 完整阅读文章，分人物展示
- 点击段落显示/隐藏中文翻译
- 周末活动单独区块展示

### 3. 阅读理解题 (Reading Questions)
- 5道选择题，点击显示答案
- 正确答案选项自动高亮
- 答案解析展示原文依据

### 4. 词汇卡片 (Vocabulary Cards)
- 9个重点词汇，带emoji图标
- 点击卡片朗读单词（Web Speech API）
- 发音动画反馈

### 5. 语法重点 (Grammar Focus)
- Like/Enjoy/Love + V-ing 结构
- Be interested in + V-ing 结构
- Help sb. (to) do sth. 结构

### 6. 作业待办清单 (Homework Todo List)
- 4项作业任务，点击切换完成状态
- 家长提示区域

## Unit 9 Grammar Review (unit9/index.html) Specific Features

### 1. Page 108 语法重点卡片 (Grammar Focus Cards)
- 3个核心语法卡片：It's time for...、Can I...、be going to...
- 每个卡片包含结构说明、例句和注意事项
- Can I 卡片展示7个人称的完整列表表格
- be going to 卡片展示各人称变化及常见错误提醒

### 2. 动词短语发音卡片 (Verb Phrase Vocabulary)
- 5个动词短语（build a tree house, join me, go camping, go swimming, take riding lessons）
- 点击卡片使用 Web Speech API 发音
- 发音动画反馈（.speaking 类 + pulse 动画）

### 3. Page 109 语法总结 (Grammar Summary)
- 4大语法点分类：一般现在时（系动词/实义动词）、can 句型、have got 句型、there be 句型
- 12道问句类型总结表（编号、问句、语法点、疑问词/结构）
- 各语法点配有问句结构说明和注意事项

### 4. 对话填空练习 (Dialogue Fill-in-the-Blanks)
- Tom & Anna 对话：18个填空
- Amy & Ben 对话：17个填空
- 涵盖7个特殊疑问词 + 助动词/be动词/情态动词
- 点击空白处显示/隐藏答案（revealAnswer 函数）
- 答案解析表格可展开/收起（toggleAnswerTable 函数）

### 5. 今日任务 (Today's Todo)
- 4项作业任务，点击标记完成（圆形复选框 + 划线效果）
- 皮革质感卡片容器（.leather-card）

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

### 6. 共享 Google Analytics 脚本

所有 HTML 页面使用共享的 GA 脚本以遵循 DRY 原则：

**根目录 (`/`)：**
- **`ga.js`** - 根目录的 GA 脚本
- 引用方式：`<script src="ga.js"></script>` (根目录文件)
- 引用方式：`<script src="../ga.js"></script>` (子目录文件如 unit7/, unit8/)

**棒球板块 (`super-minds-baseball/`)：**
- **`ga.js`** - 棒球版的 GA 脚本（可与根目录相同内容）
- 引用方式：`<script src="ga.js"></script>` (棒球版根目录)
- 引用方式：`<script src="../ga.js"></script>` (子目录如 unit7/, unit8/)

**特点：**
- 单一信息源：只需在 `ga.js` 中修改一次，所有页面自动更新
- 使用动态加载方式确保 `GA_MEASUREMENT_ID` 一致性
- 所有 8 个 HTML 文件都使用共享脚本，无内联 GA 代码

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

### Unit 8 添加示例

Unit 8 是一个独立风格的单元（棒球主题），不同于延续 Unit 7 的风格：

1. 创建了 `unit8/index.html` - 动名词作主语课程
2. 复制到 `super-minds-baseball/unit8/index.html` - 棒球主题版本
3. 更新了 `index.html` - 添加 Unit 8 卡片和快速链接
4. 更新了 `super-minds-baseball/index.html` - 添加 Unit 8 导航卡片
5. 更新了 `README.md` - 添加 Unit 8 课程描述
6. 更新了 `AGENTS.md` - 更新项目结构和功能说明

### Unit 8 Amazing Vehicles 添加示例

1. 创建了 `unit8/amazing-vehicles.html` - 交通工具主题课程
2. 更新了 `index.html` - 添加新卡片到课程单元列表
3. 更新了 `unit8/index.html` - 添加 Unit 8 下拉导航菜单
4. 更新了 `unit7/index.html` - 添加 Unit 8 下拉导航菜单
5. 更新了 `unit7/homework.html` - 添加 Unit 8 下拉导航菜单
6. 更新了 `README.md` - 添加课程描述
7. 更新了 `AGENTS.md` - 更新项目结构

### Unit 8 Reading (Fun Things We Do) 添加示例

1. 创建了 `unit8/reading.html` - 阅读主题课程
2. 更新了 `index.html` - 添加课程卡片和快速链接
3. 更新了 `unit8/index.html` - 添加导航下拉菜单链接
4. 更新了 `unit8/amazing-vehicles.html` - 添加导航下拉菜单链接
5. 更新了 `unit7/index.html` - 添加 Unit 8 下拉导航菜单链接
6. 更新了 `unit7/homework.html` - 添加 Unit 8 下拉导航菜单链接
7. 更新了 `README.md` - 添加课程描述
8. 更新了 `AGENTS.md` - 更新项目结构和功能说明
9. 添加了测试 - 导航链接验证测试

### Unit 9 添加示例

Unit 9 是一个语法复习页面，采用棒球主题风格（与 unit8/reading.html 一致）：

1. 创建了 `unit9/index.html` - 假期计划语法复习页面
2. 更新了 `index.html` - 添加 Unit 9 卡片和快速链接
3. 更新了 `unit7/index.html` - 添加 Unit 9 导航下拉菜单
4. 更新了 `unit7/homework.html` - 添加 Unit 9 导航下拉菜单
5. 更新了 `unit8/index.html` - 添加 Unit 9 导航下拉菜单
6. 更新了 `unit8/amazing-vehicles.html` - 添加 Unit 9 导航下拉菜单
7. 更新了 `unit8/reading.html` - 添加 Unit 9 导航下拉菜单
8. 更新了 `unit8/grammar.html` - 添加 Unit 9 导航下拉菜单
9. 更新了 `README.md` - 添加 Unit 9 课程描述
10. 更新了 `AGENTS.md` - 更新项目结构和功能说明
11. 更新了 `TESTING.md` - 添加 Unit 9 测试清单
12. 添加了测试工作流 `.github/workflows/unit9-test.yml`
13. 更新了 `test.sh` - 添加 Unit 9 验证、grammar.html 检查、棒球版 unit9 导航检查
14. 更新了 `.github/workflows/quick-test.yml` - 添加 Unit 9 检查、grammar.html 验证、棒球版 unit9 导航检查
15. 更新了 `.github/workflows/ci.yml` - 添加 Unit 9 及 unit8 子页面 HTML 验证
16. 更新了 `super-minds-baseball/index.html` - 添加 Unit 9 导航卡片
17. 更新了 `super-minds-baseball/unit7/index.html` - 添加 Unit 9 导航链接
18. 更新了 `super-minds-baseball/unit7/homework.html` - 添加 Unit 9 导航链接
19. 更新了 `super-minds-baseball/unit8/index.html` - 添加 Unit 9 导航链接

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

### Automated Testing (CI/CD)

项目使用 GitHub Actions 进行自动化测试：

**Workflows:**

| Workflow | Trigger | Description |
|----------|---------|-------------|
| `quick-test.yml` | Push/PR to master | 文件结构、引用检查、HTML基础验证、棒球版Unit 9导航链接检查 |
| `ci.yml` | Manual/Scheduled | HTML/CSS/JS验证、链接检查、功能测试 |
| `browser-tests.yml` | Push/PR to master | 无头浏览器E2E测试、Lighthouse、视觉回归、跨页面导航测试 |
| `unit8-reading-test.yml` | Push/PR to master (when unit8/reading.html changes) | Unit 8 Reading页面专项测试 |

**Headless Browser Testing:**
- 使用 Puppeteer 和 Playwright 进行浏览器自动化
- 在 CI 环境中以 headless 模式运行
- 测试覆盖率包括：页面加载、交互功能、响应式设计、跨页面导航（含棒球版→Unit 9）

**本地运行测试:**
```bash
# 快速验证
./test.sh

# 无头浏览器测试
npm install puppeteer
node smoke-test.js

# 本地服务器测试
python3 -m http.server 8000
# 访问 http://localhost:8000
```

### Manual Testing

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
