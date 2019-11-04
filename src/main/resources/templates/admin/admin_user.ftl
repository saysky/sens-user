<#compress >
    <#include "module/_macro.ftl">
    <@head>${options.blog_title} | 用户管理</@head>
    <div class="wrapper">
        <!-- 顶部栏模块 -->
        <#include "module/_header.ftl">
        <!-- 菜单栏模块 -->
        <#include "module/_sidebar.ftl">
        <div class="content-wrapper">
            <style type="text/css" rel="stylesheet">
                .role-ul {
                    list-style: none;
                    padding-left: 0
                }

                .role-ul > li {
                    list-style: none;
                    float: left;
                    margin: 0;
                    padding-bottom: 10px
                }

                #btnNewUser {
                    margin-left: 4px;
                    padding: 3px 6px;
                    position: relative;
                    top: -4px;
                    border: 1px solid #ccc;
                    border-radius: 2px;
                    background: #fff;
                    text-shadow: none;
                    font-weight: 600;
                    font-size: 12px;
                    line-height: normal;
                    color: #3c8dbc;
                    cursor: pointer;
                    transition: all .2s ease-in-out
                }

                #btnNewUser:hover {
                    background: #3c8dbc;
                    color: #fff
                }
            </style>
            <section class="content-header">
                <h1 style="display: inline-block;">用户管理</h1>
                <a data-pjax="false" id="btnNewUser" href="/admin/user/new">
                    添加用户
                </a>
                <ol class="breadcrumb">
                    <li>
                        <a data-pjax="true" href="/admin">
                            <i class="fa fa-dashboard"></i> 首页</a>
                    </li>
                    <li><a data-pjax="true" href="#">用户管理</a></li>
                    <li class="active">所有用户</li>
                </ol>
            </section>
            <section class="content container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="role-ul">
                            <#list roles as role>
                                <li class="${role.role!}">
                                    <a data-pjax="true" href="/admin/user?role=${role.role!}"
                                       <#if role.role == currentRole>style="color: #000"</#if>>
                                        ${role.description!} <span class="count">(${role.count?default(0)})</span>
                                    </a>
                                    <#if role_has_next>
                                        &nbsp;|&nbsp;
                                    </#if>
                                </li>
                            </#list>
                        </ul>
                    </div>
                    <div class="col-xs-12">
                        <div class="col-md-4 col-xs-12" style="margin-bottom: 10px;padding-left: 0;">
                            <a class="btn btn-primary" href="/admin/user/new">
                                <i class="fa fa-plus"></i> 新增
                            </a>
                            <button type="button" class="btn btn-danger" onclick="batchDelete()">
                                <i class="fa fa-remove"></i> 批量删除
                            </button>
                        </div>
                        <div class="col-md-8 col-xs-12"
                             style="margin-bottom: 10px; text-align:right;padding-left: 0; padding-right: 0;">
                            <form class="form-inline" action="/admin/user">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="keywords" name="keywords"
                                           value="${keywords!}" placeholder="请输入关键字">
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="searchType">
                                        <option value="content" disabled>搜索范围</option>
                                        <option value="userName" <#if searchType == "userName">selected</#if>>用户名
                                        </option>
                                        <option value="userDisplayName"
                                                <#if searchType == "userDisplayName">selected</#if>>显示名
                                        </option>
                                        <option value="email" <#if searchType == "email">selected</#if>>电子邮箱</option>
                                        <option value="url" <#if searchType == "url">selected</#if>>个人主页</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="role">
                                        <option value="admin" disabled>角色</option>
                                        <#list roles as role>
                                            <option value="${role.role}" <#if role.role == currentRole>selected</#if>>${role.description!}</option>
                                        </#list>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="status">
                                        <option value="-1" disabled>状态</option>
                                        <option value="-1" <#if status == -1>selected</#if>>不限</option>
                                        <option value="0" <#if status == 0>selected</#if>>正常</option>
                                        <option value="1" <#if status == 1>selected</#if>>禁止登录</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="sort">
                                        <option value="createTime" disabled>排序字段</option>
                                        <option value="createTime" <#if sort == 'createTime'>selected</#if>>注册时间
                                        </option>
                                        <option value="createTime" <#if sort == 'loginLast'>selected</#if>>最后登录时间
                                        </option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="order">
                                        <option value="desc" disabled>升序/降序</option>
                                        <option value="asc" <#if order == 'asc'>selected</#if>>升序</option>
                                        <option value="desc" <#if order == 'desc'>selected</#if>>倒序</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
                            </form>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="box box-primary">
                            <div class="box-body table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th><input type="checkbox" id="allSelect" onclick="doCheck()"></th>
                                        <th>用户名</th>
                                        <th>昵称</th>
                                        <th>电子邮箱</th>
                                        <th>状态</th>
                                        <th>注册时间</th>
                                        <th>操作</th>
                                        <th>ID</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#if users?size gt 0>
                                        <#list users as user>
                                            <tr id="user-${user.id}">
                                                <td><input type="checkbox" name="ids" value="${user.id?c}"></td>
                                                <td>
                                                    <a href="/author/${user.userName!}">${user.userName!}</a>
                                                </td>
                                                <td>${user.userDisplayName!}</td>
                                                <td>${user.userEmail!}</td>
                                                <td>
                                                    <#switch user.status>
                                                        <#case 0>
                                                            <span class="text-success">正常</span>
                                                            <#break >
                                                        <#case 1>
                                                            已禁用
                                                            <span class="text-danger">禁止登陆</span>
                                                            <#break >
                                                    </#switch>
                                                </td>
                                                <td>${(user.createTime?string("yyyy-MM-dd HH:mm"))!}</td>
                                                <td>
                                                    <a href="/admin/user/edit?id=${user.id?c}"
                                                       class="btn btn-info btn-xs ">编辑</a>
                                                    <a href="/admin/user/login?id=${user.id?c}"
                                                       class="btn btn-success btn-xs ">登录</a>
                                                    <a href="javascript:void(0)" onclick="removeIt(${user.id})"
                                                       class="btn btn-danger btn-xs ">删除</a>
                                                </td>
                                                <td>${user.id?c}</td>
                                            </tr>
                                        </#list>
                                    <#else>
                                        <tr>
                                            <th colspan="7"
                                                style="text-align: center">暂无数据</th>
                                        </tr>
                                    </#if>
                                    </tbody>
                                </table>
                            </div>
                            <div class="box-footer clearfix">
                                <#assign hasPrevious = (pageInfo.current > 1)>
                                <#assign hasNext = (pageInfo.current < pageInfo.pages)>
                                <div class="no-margin pull-left">
                                    第${pageInfo.current}
                                    /${pageInfo.pages}页
                                </div>
                                <ul class="pagination no-margin pull-right">
                                    <li><a data-pjax="true" class="btn btn-sm <#if !hasPrevious>disabled</#if>"
                                           href="/admin/user?role=${currentRole}&searchType=${searchType}&keywords=${keywords}&status=${status}&sort=${sort}&order=${order}">首页</a>
                                    </li>
                                    <li><a data-pjax="true" class="btn btn-sm <#if !hasPrevious>disabled</#if>"
                                           href="/admin/user?role=${currentRole}&page=${pageInfo.current-1}&searchType=${searchType}&keywords=${keywords}&status=${status}&sort=${sort}&order=${order}">上一页</a>
                                    </li>
                                    <li><a data-pjax="true" class="btn btn-sm <#if !hasNext>disabled</#if>"
                                           href="/admin/user?role=${currentRole}&page=${pageInfo.current+1}&searchType=${searchType}&keywords=${keywords}&status=${status}&sort=${sort}&order=${order}">下一页</a>
                                    </li>
                                    <li><a data-pjax="true" class="btn btn-sm <#if !hasNext>disabled</#if>"
                                           href="/admin/user?page=${pageInfo.pages}&role=${currentRole}&searchType=${searchType}&keywords=${keywords}&status=${status}&sort=${sort}&order=${order}">尾页</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <script>

                function removeIt(id) {
                    layer.confirm('你确认要删除吗', function (index) {
                        $.ajax({
                            type: 'POST',
                            url: '/admin/user/delete',
                            async: false,
                            data: {
                                'id': id
                            },
                            success: function (data) {
                                if (data.code == 0) {
                                    showMsg(data.msg, "error", 2000);
                                } else {
                                    showMsg(data.msg, "success", 2000);
                                    $('#user-' + id).remove();
                                }

                            }
                        });
                        layer.close(index);
                    });
                }
                function batchDelete() {
                    var arr = [];
                    $('input[name="ids"]:checked').each(function () {
                        arr.push($(this).val());
                    });
                    if (arr.length <= 0) {
                        showMsg('请选择要删除的数据', "error", 2000);
                    } else {
                        layer.confirm('你确认要删除吗', function (index) {
                            $.ajax({
                                url: "/admin/user/batchDelete?ids=" + arr,
                                type: "DELETE",
                                success: function (data) {
                                    if (data.code == 0) {
                                        showMsg(data.msg, "error", 2000);
                                    } else {
                                        showMsgAndReload(data.msg, "success", 2000);
                                    }
                                }
                            });
                            layer.close(index);
                        });
                    }
                }

            </script>
        </div>
        <#include "module/_footer.ftl">
    </div>
    <@footer></@footer>
</#compress>
