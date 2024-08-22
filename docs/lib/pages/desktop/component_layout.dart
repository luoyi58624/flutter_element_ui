import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/slide.dart';

class ComponentLayoutPage extends StatelessWidget {
  const ComponentLayoutPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return context.sm
        ? child
        : Row(
            children: [
              const SlideWidget([
                (
                  'Overview 组件总览',
                  [
                    ('Overview 组件总览', '/component/overview'),
                  ],
                ),
                (
                  'Basic 基础组件',
                  [
                    ('Button 按钮', '/component/button'),
                    ('Color 色彩', '/component/color'),
                    ('Icon 图标', '/component/icon'),
                    ('Layout 布局', '/component/layout'),
                    ('Link 链接', '/component/link'),
                    ('Text 文本', '/component/text'),
                    ('Scrollbar 滚动条', '/component/scrollbar'),
                    ('Typography 排版', '/component/typography'),
                  ],
                ),
                (
                  'Form 表单组件',
                  [
                    ('Autocomplete 自动补全输入框', '/component/autocomplete'),
                    ('Cascader 级联选择器', '/component/cascader'),
                    ('Checkbox 多选框', '/component/checkbox'),
                    ('ColorPicker 颜色选择器', '/component/color-picker'),
                    ('DatePicker 日期选择器', '/component/date-picker'),
                    ('DateTimePicker 日期时间选择器', '/component/datetime-picker'),
                    ('Form 表单', '/component/form'),
                    ('Input 输入框', '/component/input'),
                    ('Input Number 数字输入框', '/component/input-number'),
                    ('Radio 单选框', '/component/radio'),
                    ('Rate 评分', '/component/rate'),
                    ('Select 选择器', '/component/select'),
                    ('Slider 滑块', '/component/slider'),
                    ('Switch 开关', '/component/switch'),
                    ('TimePicker 时间选择器', '/component/time-picker'),
                    ('TimeSelect 时间选择', '/component/time-select'),
                    ('Transfer 穿梭框', '/component/transfer'),
                    ('TreeSelect 树形选择', '/component/tree-select'),
                    ('Upload 上传', '/component/upload'),
                  ],
                ),
                (
                  'Data 数据展示',
                  [
                    ('Avatar 头像', '/component/avatar'),
                    ('Badge 徽章', '/component/badge'),
                    ('Calendar 日历', '/component/calendar'),
                    ('Card 卡片', '/component/card'),
                    ('Carousel 走马灯', '/component/carousel'),
                    ('Collapse 折叠面板', '/component/collapse'),
                    ('Descriptions 描述列表', '/component/descriptions'),
                    ('Empty 空状态', '/component/empty'),
                    ('Image 图片', '/component/image'),
                    ('Infinite Scroll 无限滚动', '/component/infinite-scroll'),
                    ('Pagination 分页', '/component/Pagination'),
                    ('Progress 进度条', '/component/Progress'),
                    ('Result 结果', '/component/Result'),
                    ('Skeleton 骨架屏', '/component/Skeleton'),
                    ('Table 表格', '/component/Table'),
                    ('Tag 标签', '/component/Tag'),
                    ('Timeline 时间线', '/component/Timeline'),
                    ('Tour 漫游式引导', '/component/Tour'),
                    ('Tree 树形控件', '/component/Tree'),
                    ('Statistic 统计组件', '/component/Statistic'),
                    ('Segmented 分段控制器', '/component/Segmented'),
                  ],
                ),
                (
                  'Navigation 导航',
                  [
                    ('Affix 固钉', '/component/Affix'),
                    ('Anchor 锚点', '/component/Anchor'),
                    ('Backtop 回到顶部', '/component/Backtop'),
                    ('Breadcrumb 面包屑', '/component/Breadcrumb'),
                    ('Dropdown 下拉菜单', '/component/Dropdown'),
                    ('Menu 菜单', '/component/Menu'),
                    ('Page Header 页头', '/component/page-header'),
                    ('Steps 步骤条', '/component/Steps'),
                    ('Tabs 标签页', '/component/Tabs'),
                  ],
                ),
                (
                  'Feedback 反馈组件',
                  [
                    ('Alert 提示', '/component/Alert'),
                    ('Dialog 对话框', '/component/Dialog'),
                    ('Drawer 抽屉', '/component/Drawer'),
                    ('Loading 加载', '/component/Loading'),
                    ('Message 消息提示', '/component/Message'),
                    ('MessageBox 消息弹框', '/component/MessageBox'),
                    ('Notification 通知', '/component/Notification'),
                    ('PopConfirm 气泡确认框', '/component/PopConfirm'),
                    ('Popover 气泡卡片', '/component/Popover'),
                    ('Tooltip 文字提示', '/component/Tooltip'),
                  ],
                ),
                (
                  'Others 其他',
                  [
                    ('Divider 分割线', '/component/Divider'),
                    ('Watermark 水印', '/component/Watermark'),
                  ],
                ),
              ]),
              Expanded(child: child),
            ],
          );
  }
}
