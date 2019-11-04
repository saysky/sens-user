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
                <form action="/admin/role/save" method="post" role="form" id="roleUpdateForm">
                    <div class="col-md-4">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">修改角色 <#if updateRole??>
                                    [${updateRole.role}]</#if>
                                </h3>
                            </div>
                            <input type="hidden" name="id" value="${updateRole.id?c}">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="role">角色编码</label>
                                    <input type="text" class="form-control disabled-input" id="role" name="role"
                                           value="${updateRole.role?if_exists}" disabled>
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
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">所有权限</h3>
                            </div>
                            <div class="box-body table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>
                                            <div class="pretty p-default">
                                                <input type="checkbox" id="allSelect" onclick="javascript:DoCheck()">
                                                <div class="state p-primary">
                                                    <label></label>
                                                </div>
                                            </div>
                                        </th>
                                        <th>权限名称</th>
                                        <th>URL</th>
                                        <th>类型</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <#list permissions as permission>
                                        <tr>
                                            <td>
                                                <div class="pretty p-default">
                                                    <input type="checkbox" name="ids" value="${permission.id?c}" <#list updateRole.permissions as current>
                                                    ${(permission.id == current.id)?string('checked','')}
                                                    </#list>>
                                                    <div class="state p-primary">
                                                        <label></label>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="permission-level-${permission.level?default(1)}">
                                                <i class="${(permission.icon)!}"></i>&nbsp;${(permission.name)!}
                                            </td>
                                            <td>${permission.url?if_exists}</td>
                                            <td>
                                                <#if permission.resourceType == 'menu'>
                                                    <span style="color: #ca195a;font-weight: bold;">菜单</span>
                                                <#else>
                                                    <span>按钮</span>
                                                </#if>
                                            </td>
                                        </tr>
                                        </#list>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <script>


        </script>
    </div>
    <#include "module/_footer.ftl">
</div>
    <@footer></@footer>
</#compress>
