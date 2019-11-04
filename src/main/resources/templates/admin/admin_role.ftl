<#compress >
    <#include "module/_macro.ftl">
    <@head>${options.blog_title} | 角色管理</@head>
<div class="wrapper">
    <!-- 顶部栏模块 -->
    <#include "module/_header.ftl">
    <!-- 菜单栏模块 -->
    <#include "module/_sidebar.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>
                角色管理
                <small></small>
            </h1>
            <ol class="breadcrumb">
                <li>
                    <a data-pjax="true" href="/admin">
                        <i class="fa fa-dashboard"></i> 首页</a>
                </li>
                <li><a data-pjax="true" href="#">角色管理</a></li>
                <li class="active">角色列表</li>
            </ol>
        </section>
        <section class="content container-fluid">
            <div class="row">
                <div class="col-md-4">
                    <div class="box box-primary">
                        <#if updateRole??>
                            <div class="box-header with-border">
                                <h3 class="box-title">修改角色 <#if updateRole??>
                                    [${updateRole.role}]</#if>
                                </h3>
                            </div>
                            <form action="/admin/role/save" method="post" role="form" id="roleUpdateForm">
                                <input type="hidden" name="id" value="${updateRole.id?c}">
                                <div class="box-body">
                                    <div class="form-group">
                                        <label for="role">角色编码</label>
                                        <input type="text" class="form-control" id="role" name="role"
                                               value="${updateRole.role?if_exists}">
                                    </div>
                                    <div class="form-group">
                                        <label for="description">角色名称</label>
                                        <input type="text" class="form-control" id="description" name="description"
                                               value="${updateRole.description?if_exists}">
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button type="submit"
                                            class="btn btn-primary btn-sm ">保存</button>
                                    <a data-pjax="true" href="/admin/role"
                                       class="btn btn-info btn-sm ">返回添加</a>
                                </div>
                            </form>
                        <#else >
                            <div class="box-header with-border">
                                <h3 class="box-title">添加角色</h3>
                            </div>
                            <form action="/admin/role/save" method="post" role="form" id="roleAddForm">
                                <div class="box-body">
                                    <div class="form-group">
                                        <label for="role">角色编码</label>
                                        <input type="text" class="form-control" id="role" name="role">
                                    </div>
                                    <div class="form-group">
                                        <label for="description">角色名称</label>
                                        <input type="text" class="form-control" id="description" name="description">
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
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">所有角色</h3>
                        </div>
                        <div class="box-body table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>角色编码</th>
                                    <th>角色名称</th>
                                    <th>权限数</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#list roles as role>
                                    <tr>
                                        <td>${role.role?if_exists}</td>
                                        <td>${role.description?if_exists}</td>
                                        <td>
                                            <span  class="label"
                                                   style="background-color: #d6cdcd;" title="<#list role.permissions as permission>${permission.name?if_exists} &nbsp;</#list> ">${role.permissions?size}</span></td>
                                        <td>
                                            <#if updateRole?? && updateRole.id?c==role.id?c>
                                                <a href="#" class="btn btn-primary btn-xs "
                                                   disabled>编辑中</a>
                                            <#else >
                                                <a data-pjax="true"
                                                   href="/admin/role/edit?id=${role.id?c}"
                                                   class="btn btn-primary btn-xs ">编辑</a>
                                            </#if>
                                            <button class="btn btn-danger btn-xs delete-role"
                                                    onclick="removeIt(${role.id?c})">删除</button>
                                        </td>
                                    </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script>

            function removeIt(id) {
                layer.confirm('你确认要删除吗', function (index) {
                    $.ajax({
                        type: 'GET',
                        url: '/admin/role/delete?id='+id,
                        async: false,
                        success: function (data) {
                            if (data.code == 0) {
                                showMsg(data.msg, "error", 2000);
                            } else {
                                window.location.reload();
                            }

                        }
                    });
                    layer.close(index);
                });
            }

        </script>
    </div>
    <#include "module/_footer.ftl">
</div>
    <@footer></@footer>
</#compress>
