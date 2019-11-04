<header class="main-header">
    <a href="/admin" class="logo">
        <span class="logo-mini"><b>S</b>S</span>
        <span class="logo-lg"><b>SE</b>NS</span>
    </a>
    <nav class="navbar navbar-static-top" role="navigation">
        <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
            <span class="sr-only">Toggle navigation</span>
        </a>
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <li><a href="/" title="前台" target="_blank"><i class="fa fa-location-arrow"></i></a></li>
                <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="<@shiro.principal  property="userAvatar"/>" class="user-image" alt="User Image">
                        <span class="hidden-xs"><@shiro.principal  property="userDisplayName"/></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="user-header">
                            <img src="<@shiro.principal  property="userAvatar"/>" class="img-circle" alt="User Image">
                            <p><@shiro.principal  property="userDisplayName"/></p>
                        </li>
                        <li class="user-footer">
                            <div class="pull-left"><a data-pjax="true" href="/admin/user/profile" class="btn btn-default "><i class="fa fa-user"></i>个人信息</a></div>
                            <div class="pull-right"><a href="/admin/logOut" class="btn btn-default "><i class="fa fa-sign-out"></i>登出</a></div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>
