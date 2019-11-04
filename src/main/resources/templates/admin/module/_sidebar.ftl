<aside class="main-sidebar">
    <section class="sidebar">
        <div class="user-panel">
            <div class="pull-left image">
                <img src="<@shiro.principal  property="userAvatar"/>" class="img-circle"
                     style="width: 45px;height: 45px;" alt="User Image">
            </div>
            <div class="pull-left info">
                <p><@shiro.principal  property="userDisplayName"/></p>
                <a href="/admin/user/profile"><i
                        class="fa fa-circle text-success"></i>个人信息</a>
            </div>
        </div>
        <form action="/search" method="get" target="_blank" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="keyword" class="form-control" placeholder="Search...">
                <span class="input-group-btn">
                  <button type="submit" name="keyword" id="search-btn" target="_blank"  class="btn btn-flat">
                    <i class="fa fa-search"></i>
                  </button>
                </span>
            </div>
        </form>

        <ul class="sidebar-menu" data-widget="tree">
        </ul>
    </section>
</aside>
