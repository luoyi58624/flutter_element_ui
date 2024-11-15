/// 根路由模型
typedef RootRouteModelType = (String name, String path);

/// 侧边栏路由模型类型，这个模型同样适用于移动端
typedef SlideRouteModelType = (
  String title,
  List<(String name, String path, WorkStatus status)> items
);

/// Element UI 组件工作状态
enum WorkStatus {
  /// 待完成
  pending,

  /// 进行中
  processing,

  /// 测试版
  beta,

  /// 已完成
  finished,
}

class RootRoute {
  static const RootRouteModelType guide = ('指南', 'guide');
  static const RootRouteModelType component = ('组件', 'component');
  static const RootRouteModelType resource = ('资源', 'resource');

  static List<RootRouteModelType> values = [guide, component, resource];
}

class SlideRouterConfig {
  static final List<SlideRouteModelType> guideSlideRoutes = [
    (
      '基础',
      [
        ('设计', '/${RootRoute.guide.$2}/design', WorkStatus.finished),
        ('导航', '/${RootRoute.guide.$2}/nav', WorkStatus.pending),
        ('安装', '/${RootRoute.guide.$2}/install', WorkStatus.finished),
        // ('快速开始', '/${RootRoute.guide.$2}/quickstart'),
      ],
    ),
    (
      '进阶',
      [
        ('国际化', '/${RootRoute.guide.$2}/i18n', WorkStatus.pending),
        ('主题', '/${RootRoute.guide.$2}/theme', WorkStatus.pending),
        ('更新日志', '/${RootRoute.guide.$2}/changelog', WorkStatus.pending),
      ],
    ),
    (
      '开发',
      [
        (
          '开发指南',
          '/${RootRoute.guide.$2}/dev-${RootRoute.guide.$2}',
          WorkStatus.pending
        ),
        ('开发常见问题', '/${RootRoute.guide.$2}/dev-faq', WorkStatus.pending),
        ('提交示例', '/${RootRoute.guide.$2}/commit-examples', WorkStatus.pending),
        ('翻译', '/${RootRoute.guide.$2}/translation', WorkStatus.pending),
      ],
    ),
  ];

  static final List<SlideRouteModelType> componentSlideRoutes = [
    (
      'Overview 组件总览',
      [
        (
          'Element 组件总览',
          '/${RootRoute.component.$2}/element',
          WorkStatus.pending
        ),
        (
          'Material 组件总览',
          '/${RootRoute.component.$2}/material',
          WorkStatus.processing
        ),
        (
          'Cupertino 组件总览',
          '/${RootRoute.component.$2}/cupertino',
          WorkStatus.processing
        ),
      ],
    ),
    (
      'Basic 基础组件',
      [
        ('Event 交互事件', '/${RootRoute.component.$2}/event', WorkStatus.finished),
        ('Button 按钮', '/${RootRoute.component.$2}/button', WorkStatus.finished),
        (
          'ButtonGroup 按钮组',
          '/${RootRoute.component.$2}/button_group',
          WorkStatus.finished
        ),
        ('Color 色彩', '/${RootRoute.component.$2}/color', WorkStatus.finished),
        ('Icon 图标', '/${RootRoute.component.$2}/icon', WorkStatus.finished),
        ('Layout 布局', '/${RootRoute.component.$2}/layout', WorkStatus.pending),
        ('Text 文本', '/${RootRoute.component.$2}/text', WorkStatus.finished),
        (
          'Typography 排版',
          '/${RootRoute.component.$2}/typography',
          WorkStatus.pending
        ),
      ],
    ),
    (
      'Form 表单组件',
      [
        (
          'Autocomplete 自动补全输入框',
          '/${RootRoute.component.$2}/autocomplete',
          WorkStatus.pending
        ),
        (
          'Cascader 级联选择器',
          '/${RootRoute.component.$2}/cascader',
          WorkStatus.pending
        ),
        (
          'Checkbox 多选框',
          '/${RootRoute.component.$2}/checkbox',
          WorkStatus.pending
        ),
        (
          'ColorPicker 颜色选择器',
          '/${RootRoute.component.$2}/color-picker',
          WorkStatus.pending
        ),
        (
          'DatePicker 日期选择器',
          '/${RootRoute.component.$2}/date-picker',
          WorkStatus.pending
        ),
        (
          'DateTimePicker 日期时间选择器',
          '/${RootRoute.component.$2}/datetime-picker',
          WorkStatus.pending
        ),
        ('Form 表单', '/${RootRoute.component.$2}/form', WorkStatus.pending),
        (
          'Input 输入框',
          '/${RootRoute.component.$2}/input',
          WorkStatus.processing
        ),
        (
          'Input Number 数字输入框',
          '/${RootRoute.component.$2}/input-number',
          WorkStatus.pending
        ),
        ('Radio 单选框', '/${RootRoute.component.$2}/radio', WorkStatus.pending),
        ('Rate 评分', '/${RootRoute.component.$2}/rate', WorkStatus.pending),
        ('Select 选择器', '/${RootRoute.component.$2}/select', WorkStatus.pending),
        ('Slider 滑块', '/${RootRoute.component.$2}/slider', WorkStatus.beta),
        ('Switch 开关', '/${RootRoute.component.$2}/switch', WorkStatus.beta),
        (
          'TimePicker 时间选择器',
          '/${RootRoute.component.$2}/time-picker',
          WorkStatus.pending
        ),
        (
          'TimeSelect 时间选择',
          '/${RootRoute.component.$2}/time-select',
          WorkStatus.pending
        ),
        (
          'Transfer 穿梭框',
          '/${RootRoute.component.$2}/transfer',
          WorkStatus.pending
        ),
        (
          'TreeSelect 树形选择',
          '/${RootRoute.component.$2}/tree-select',
          WorkStatus.pending
        ),
        ('Upload 上传', '/${RootRoute.component.$2}/upload', WorkStatus.pending),
      ],
    ),
    (
      'Data 数据展示',
      [
        ('Avatar 头像', '/${RootRoute.component.$2}/avatar', WorkStatus.pending),
        ('Badge 徽章', '/${RootRoute.component.$2}/badge', WorkStatus.pending),
        (
          'Calendar 日历',
          '/${RootRoute.component.$2}/calendar',
          WorkStatus.pending
        ),
        ('Card 卡片', '/${RootRoute.component.$2}/card', WorkStatus.pending),
        (
          'Carousel 走马灯',
          '/${RootRoute.component.$2}/carousel',
          WorkStatus.pending
        ),
        (
          'Collapse 折叠面板',
          '/${RootRoute.component.$2}/collapse',
          WorkStatus.processing
        ),
        (
          'Descriptions 描述列表',
          '/${RootRoute.component.$2}/descriptions',
          WorkStatus.pending
        ),
        ('Empty 空状态', '/${RootRoute.component.$2}/empty', WorkStatus.pending),
        ('Image 图片', '/${RootRoute.component.$2}/image', WorkStatus.pending),
        (
          'Infinite Scroll 无限滚动',
          '/${RootRoute.component.$2}/infinite-scroll',
          WorkStatus.pending
        ),
        (
          'Pagination 分页',
          '/${RootRoute.component.$2}/Pagination',
          WorkStatus.pending
        ),
        (
          'Progress 进度条',
          '/${RootRoute.component.$2}/progress',
          WorkStatus.processing
        ),
        ('Result 结果', '/${RootRoute.component.$2}/Result', WorkStatus.pending),
        (
          'Skeleton 骨架屏',
          '/${RootRoute.component.$2}/Skeleton',
          WorkStatus.pending
        ),
        ('Table 表格', '/${RootRoute.component.$2}/Table', WorkStatus.pending),
        ('Tag 标签', '/${RootRoute.component.$2}/tag', WorkStatus.finished),
        (
          'Timeline 时间线',
          '/${RootRoute.component.$2}/Timeline',
          WorkStatus.pending
        ),
        ('Tour 漫游式引导', '/${RootRoute.component.$2}/Tour', WorkStatus.pending),
        ('Tree 树形控件', '/${RootRoute.component.$2}/Tree', WorkStatus.pending),
        (
          'Statistic 统计组件',
          '/${RootRoute.component.$2}/Statistic',
          WorkStatus.pending
        ),
        (
          'Segmented 分段控制器',
          '/${RootRoute.component.$2}/Segmented',
          WorkStatus.pending
        ),
      ],
    ),
    (
      'Navigation 导航',
      [
        ('Affix 固钉', '/${RootRoute.component.$2}/Affix', WorkStatus.pending),
        ('Anchor 锚点', '/${RootRoute.component.$2}/Anchor', WorkStatus.pending),
        (
          'Backtop 回到顶部',
          '/${RootRoute.component.$2}/Backtop',
          WorkStatus.pending
        ),
        (
          'Breadcrumb 面包屑',
          '/${RootRoute.component.$2}/Breadcrumb',
          WorkStatus.pending
        ),
        (
          'Dropdown 下拉菜单',
          '/${RootRoute.component.$2}/Dropdown',
          WorkStatus.pending
        ),
        (
          'NavMenu 导航菜单',
          '/${RootRoute.component.$2}/nav_menu',
          WorkStatus.pending
        ),
        (
          'Page Header 页头',
          '/${RootRoute.component.$2}/page-header',
          WorkStatus.pending
        ),
        ('Steps 步骤条', '/${RootRoute.component.$2}/Steps', WorkStatus.pending),
        ('Tabs 标签页', '/${RootRoute.component.$2}/tabs', WorkStatus.finished),
      ],
    ),
    (
      'Feedback 反馈组件',
      [
        ('Alert 提示', '/${RootRoute.component.$2}/Alert', WorkStatus.pending),
        ('Dialog 对话框', '/${RootRoute.component.$2}/Dialog', WorkStatus.pending),
        ('Drawer 抽屉', '/${RootRoute.component.$2}/Drawer', WorkStatus.pending),
        (
          'Loading 加载',
          '/${RootRoute.component.$2}/Loading',
          WorkStatus.pending
        ),
        (
          'Message 消息提示',
          '/${RootRoute.component.$2}/message',
          WorkStatus.finished
        ),
        (
          'MessageBox 消息弹框',
          '/${RootRoute.component.$2}/MessageBox',
          WorkStatus.pending
        ),
        (
          'Notification 通知',
          '/${RootRoute.component.$2}/Notification',
          WorkStatus.pending
        ),
        (
          'PopConfirm 气泡确认框',
          '/${RootRoute.component.$2}/PopConfirm',
          WorkStatus.pending
        ),
        (
          'Popover 气泡卡片',
          '/${RootRoute.component.$2}/Popover',
          WorkStatus.pending
        ),
        (
          'Tooltip 文字提示',
          '/${RootRoute.component.$2}/Tooltip',
          WorkStatus.pending
        ),
      ],
    ),
    (
      'Others 其他',
      [
        (
          'Divider 分割线',
          '/${RootRoute.component.$2}/Divider',
          WorkStatus.pending
        ),
        (
          'Watermark 水印',
          '/${RootRoute.component.$2}/Watermark',
          WorkStatus.pending
        ),
        (
          'AnimatedSize 动画尺寸',
          '/${RootRoute.component.$2}/animated_size',
          WorkStatus.pending
        ),
        (
          'ContextMenuPage 右键菜单',
          '/${RootRoute.component.$2}/context_menu',
          WorkStatus.pending
        ),
        ('Drag 拖拽', '/${RootRoute.component.$2}/drag', WorkStatus.pending),
      ],
    ),
  ];
}
