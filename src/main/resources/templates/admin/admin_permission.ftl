<#compress >
    <#include "module/_macro.ftl">
    <@head>${options.blog_title} | 权限管理</@head>
    <div class="wrapper">
        <!-- 顶部栏模块 -->
        <#include "module/_header.ftl">
        <!-- 菜单栏模块 -->
        <#include "module/_sidebar.ftl">
        <div class="content-wrapper">
            <section class="content-header">
                <h1 style="display: inline-block;">权限管理</h1>
                <ol class="breadcrumb">
                    <li>
                        <a data-pjax="true" href="/admin"><i
                                    class="fa fa-dashboard"></i> 首页</a>
                    </li>
                    <li><a data-pjax="true" href="#">权限管理</a></li>
                    <li class="active">权限管理</li>
                </ol>
            </section>
            <section class="content container-fluid">
                <div class="row">
                    <div class="col-md-4 fixed">
                        <div class="box box-primary">
                            <#if updatePermission??>
                                <div class="box-header with-border">
                                    <h3 class="box-title">修改权限<#if updatePermission??>
                                        [${updatePermission.name}]</#if></h3>
                                </div>
                                <form action="/admin/permission/save" method="post" role="form" id="permissionAddForm">
                                    <input type="hidden" name="id" value="${updatePermission.id?c}">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label for="permissionName">名称</label>
                                            <input type="text" class="form-control" id="name" name="name"
                                                   value="${updatePermission.name!}">
                                        </div>
                                        <div class="form-group">
                                            <label for="url">URL</label>
                                            <input type="text" class="form-control" id="url" name="url"
                                                   value="${updatePermission.url!}">
                                            <small>接口路径</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="permissionSort">排序</label>
                                            <input type="number" class="form-control" id="sort" name="sort"
                                                   value="${updatePermission.sort!}">
                                            <small>排序字段，越小越靠前</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="permissionPid">父节点</label>
                                            <select class="form-control" id="pid" name="pid">
                                                <option value="0">无</option>
                                                <#list permissions as permission>
                                                    <#if permission.resourceType == 'menu'>
                                                        <option class="permission-level-${permission.level?default(0)}" value="${permission.id}"
                                                                <#if permission.id == updatePermission.pid>selected</#if>>${permission.name}</option>
                                                    </#if>
                                                </#list>
                                            </select>
                                            <small>用于后台菜单多级展示</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="icon">图标</label>
                                            <input type="text" class="form-control" id="icon" name="icon"
                                                   value="${updatePermission.icon!}">
                                            <small>用于后台菜单图标</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="permissionTarget">打开方式</label>
                                            <select class="form-control" id="permissionTarget" name="target">
                                                <option value="_self" ${((updatePermission.target?default("_self")=="_self")?string('selected',''))}>
                                                    当前页
                                                </option>
                                                <option value="_blank" ${((updatePermission.target?if_exists=="_blank")?string('selected',''))}>
                                                    新窗口
                                                </option>
                                            </select>
                                            <small>用于后台菜单</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="resourceType">资源类型</label>
                                            <select class="form-control" id="resourceType" name="resourceType">
                                                <option value="menu" ${((updatePermission.resourceType?default("menu")=="menu")?string('selected',''))}>
                                                    菜单
                                                </option>
                                                <option value="button" ${((updatePermission.resourceType?if_exists=="button")?string('selected',''))}>
                                                    按钮
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <button type="submit"
                                                class="btn btn-primary btn-sm ">保存</button>
                                        <a data-pjax="true" href="/admin/permission"
                                           class="btn btn-info btn-sm ">返回添加</a>
                                    </div>
                                </form>
                            <#else >
                                <div class="box-header with-border">
                                    <h3 class="box-title">添加权限</h3>
                                </div>
                                <form action="/admin/permission/save" method="post" role="form" id="permissionAddForm">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label for="name">名称</label>
                                            <input type="text" class="form-control" id="name" name="name">
                                        </div>
                                        <div class="form-group">
                                            <label for="url">URL</label>
                                            <input type="text" class="form-control" id="url" name="url">
                                            <small>接口路径</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="permissionSort">排序</label>
                                            <input type="number" class="form-control" id="sort" name="sort">
                                            <small>排序字段，越小越靠前，支持小数</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="permissionPid">父节点</label>
                                            <select class="form-control" id="pid" name="pid">
                                                <option value="0">无</option>
                                                <#list permissions as permission>
                                                    <#if permission.resourceType == 'menu'>
                                                        <option class="permission-level-${permission.level?default(1)}" value="${permission.id}">${permission.name}</option>
                                                    </#if>
                                                </#list>
                                            </select>
                                            <small>用于后台菜单多级展示</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="icon">图标</label>
                                            <input type="text" class="form-control" id="icon" name="icon">
                                            <small>用于后台菜单图标</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="target">打开方式</label>
                                            <select class="form-control" id="target" name="target">
                                                <option value="_self">当前页</option>
                                                <option value="_blank">新窗口</option>
                                            </select>
                                            <small>用于后台菜单</small>
                                        </div>
                                        <div class="form-group">
                                            <label for="resourceType">资源类型</label>
                                            <select class="form-control" id="resourceType" name="resourceType">
                                                <option value="menu">菜单</option>
                                                <option value="button">按钮</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <button type="submit"
                                                class="btn btn-primary btn-sm ">添加</button>
                                    </div>
                                </form>
                            </#if>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="nav-tabs-custom">
                            <div class="box box-primary">
                                <div class="box-body table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>名称</th>
                                            <th>URL</th>
                                            <th>类型</th>
                                            <th>名称</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <#list permissions as permission>
                                            <tr>
                                                <td class="permission-level-${permission.level?default(1)}">
                                                    <i class="${(permission.icon)!}"></i>&nbsp;${(permission.name)!}
                                                </td>
                                                <td>${(permission.url)!}</td>
                                                <td>
                                                    <#if permission.resourceType == 'menu'>
                                                        <span style="color: #ca195a;font-weight: bold;">菜单</span>
                                                    <#else>
                                                        <span>按钮</span>
                                                    </#if>
                                                </td>
                                                <td>
                                                    <#if updatePermission?? && permission.id?c==updatePermission.id?c>
                                                        <a href="#" class="btn btn-primary btn-xs "
                                                           disabled="">编辑中</a>
                                                    <#else>
                                                        <a data-pjax="true"
                                                           href="/admin/permission/edit?id=${permission.id?c}"
                                                           class="btn btn-primary btn-xs ">编辑
                                                        </a>
                                                    </#if>
                                                    <button class="btn btn-danger btn-xs "
                                                            onclick="modelShow('/admin/permission/delete?id=${permission.id?c}')">删除</button>
                                                </td>
                                            </tr>
                                        </#list>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- 删除确认弹出层 -->
            <div class="modal fade" id="removePermissionModal">
                <div class="modal-dialog">
                    <div class="modal-content message_align">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">×</span></button>
                            <h4 class="modal-title">提示</h4>
                        </div>
                        <div class="modal-body"><p>删除</p></div>
                        <div class="modal-footer">
                            <input type="hidden" id="url"/>
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">取消</button>
                            <a onclick="removeIt()" class="btn btn-danger"
                               data-dismiss="modal">确定</a>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                function modelShow(url) {
                    $('#url').val(url);
                    $('#removePermissionModal').modal();
                }

                function removeIt() {
                    var url = $.trim($("#url").val());
                    window.location.href = url;
                }
            </script>
        </div>
        <#include "module/_footer.ftl">
    </div>
    <@footer></@footer>
</#compress>
