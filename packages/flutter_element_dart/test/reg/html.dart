import 'package:flutter_element_dart/flutter_element_dart.dart';
import 'package:test/test.dart';

String _html = """
<ul id="nav_right" class="navbar-list navbar-right">
  <li>
      <form id="zzk_search" class="navbar-search dropdown" action="https://zzk.cnblogs.com/s" method="get" role="search">
          <input name="w" id="zzk_search_input" placeholder="代码改变世界" type="search" tabindex="3" autocomplete="off" />
          <button id="zzk_search_button" onclick="window.navbarSearchManager.triggerActiveOption()">
              <img id="search_icon" class="focus-hidden" src="//assets.cnblogs.com/icons/search.svg" alt="搜索" />
              <img class="hidden focus-visible" src="//assets.cnblogs.com/icons/enter.svg" alt="搜索" />
          </button>
          <ul id="navbar_search_options" class="dropdown-menu quick-search-menu">
              <li tabindex="0" class="active" onclick="zzkSearch(event, document.getElementById('zzk_search_input').value)">
                  <div class="keyword-wrapper">
                      <img src="//assets.cnblogs.com/icons/search.svg" alt="搜索" />
                      <div class="keyword"></div>
                  </div>
                  <span class="search-area">所有博客</span>
              </li>
                      <li tabindex="1" onclick="zzkBlogSearch(event, 'troyt', document.getElementById('zzk_search_input').value)">
                          <div class="keyword-wrapper">
                              <img src="//assets.cnblogs.com/icons/search.svg" alt="搜索" />
                              <div class="keyword"></div>
                          </div>
                          <span class="search-area">当前博客</span>
                      </li>
          </ul>
      </form>
  </li>
  <li id="navbar_login_status" class="navbar-list">
      <a class="navbar-user-info navbar-blog" href="https://i.cnblogs.com/EditPosts.aspx?opt=1" alt="写随笔" title="写随笔">
          <img id="new_post_icon" class="navbar-icon" src="//assets.cnblogs.com/icons/newpost.svg" alt="写随笔" />
      </a>
      <a id="navblog-myblog-icon" class="navbar-user-info navbar-blog" href="https://passport.cnblogs.com/GetBlogApplyStatus.aspx" alt="我的博客" title="我的博客">
          <img id="myblog_icon" class="navbar-icon" src="//assets.cnblogs.com/icons/myblog.svg" alt="我的博客" />
      </a>
      <a class="navbar-user-info navbar-message navbar-icon-wrapper" href="https://msg.cnblogs.com/" alt="短消息" title="短消息">
          <img id="msg_icon" class="navbar-icon" src="//assets.cnblogs.com/icons/message.svg" alt="短消息" />
          <span id="msg_count" style="display: none"></span>
      </a>
      <a id="navbar_lite_mode_indicator" data-current-page="blog" style="display: none" href="javascript:void(0)" alt="简洁模式" title="简洁模式启用，您在访问他人博客时会使用简洁款皮肤展示">
          <img class="navbar-icon" src="//assets.cnblogs.com/icons/lite-mode-on.svg" alt="简洁模式" />
      </a>
      <div id="user_info" class="navbar-user-info dropdown">
          <a class="dropdown-button" href="https://home.cnblogs.com/">
              <img id="user_icon" class="navbar-avatar" src="//assets.cnblogs.com/icons/avatar-default.svg" alt="用户头像" />
          </a>
          <div class="dropdown-menu">
              <a id="navblog-myblog-text" href="https://passport.cnblogs.com/GetBlogApplyStatus.aspx">我的博客</a>
              <a href="https://home.cnblogs.com/">我的园子</a>
              <a href="https://account.cnblogs.com/settings/account">账号设置</a>
              <a href="javascript:void(0)" id="navbar_lite_mode_toggle" title="简洁模式会使用简洁款皮肤显示所有博客">
简洁模式 <img id="navbar_lite_mode_on" src="/images/lite-mode-check.svg" class="hide" /><span id="navbar_lite_mode_spinner" class="hide">...</span>
</a>
              <a href="javascript:void(0)" onclick="account.logout();">退出登录</a>
          </div>
      </div>
      <a class="navbar-anonymous" href="https://account.cnblogs.com/signup">注册</a>
      <a class="navbar-anonymous" href="javascript:void(0);" onclick="account.login()">登录</a>
  </li>
</ul>
""";

String _target = """
所有博客
当前博客
我的博客
我的园子
账号设置
简洁模式...
退出登录
注册
登录""";

void htmlRegTest() {
  final result = _html
      .replaceAll(RegUtil.htmlTag, '')
      .replaceAll(RegExp(r' +'), '')
      .replaceAll(RegExp(r'\n+'), '\n')
      .clearFrontBackBlank;
  expect(result, _target);
}
