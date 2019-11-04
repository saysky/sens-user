<#compress >
    <#include "module/_macro.ftl">
    <@head>${options.blog_title} | 个人信息</@head>
    <div class="wrapper">
        <!-- 顶部栏模块 -->
        <#include "module/_header.ftl">
        <!-- 菜单栏模块 -->
        <#include "module/_sidebar.ftl">
        <div class="content-wrapper">
            <style>
                .form-horizontal .control-label {
                    text-align: left;
                }

                .third-part a {
                    margin-right: 5px;
                }

                .icon-third-sina, .icon-third-qq, .icon-third-github {
                    width: 32px;
                    height: 32px;
                }

                .icon-third-qq {
                    background-position: -112px -98px !important;
                }

                .icon-third-github {
                    background-position: -186px -98px !important;
                }

                icon-third-sina, .icon-third-qq, .icon-third-github {
                    background: url(/static/images/bg_icons.png) no-repeat;
                    display: inline-block;
                }
            </style>
            <section class="content-header">
                <h1>
                    个人信息
                    <small></small>
                </h1>
                <ol class="breadcrumb">
                    <li>
                        <a data-pjax="true" href="/admin">
                            <i class="fa fa-dashboard"></i> 首页</a>
                    </li>
                    <li><a data-pjax="true" href="#">个人信息</a></li>
                    <li class="active">个人信息</li>
                </ol>
            </section>
            <!-- tab选项卡 -->
            <section class="content container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#general"
                                       data-toggle="tab">基本信息</a>
                                </li>
                                <li>
                                    <a href="#pass"
                                       data-toggle="tab">修改密码</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="general">
                                    <form method="post" class="form-horizontal" id="profileForm">
                                        <input type="hidden" id="userPass" name="userPass"
                                               value="${user.userPass?if_exists}">
                                        <div class="box-body">
                                            <div class="form-group">
                                                <label for="userName" class="col-lg-2 col-sm-4 control-label">
                                                    当前角色:
                                                </label>
                                                <div class="col-lg-4 col-sm-8" style="padding-top: 7px;">
                                                    <#list roles as role>
                                                        <label>${role.description?if_exists}</label>
                                                    </#list>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="userName"
                                                       class="col-lg-2 col-sm-4 control-label">用户名
                                                    <span data-toggle="tooltip" data-placement="top"
                                                          title="用户登录"
                                                          style="cursor: pointer">
                                                    <i class="fa fa-question-circle" aria-hidden="true"></i>
                                                </span>
                                                </label>
                                                <div class="col-lg-4 col-sm-8">
                                                    <input type="text" class="form-control" name="userName"
                                                           value="${user.userName?if_exists}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="userDisplayName"
                                                       class="col-lg-2 col-sm-4 control-label">昵称
                                                    <span data-toggle="tooltip" data-placement="top"
                                                          title="用于显示"
                                                          style="cursor: pointer">
                                                    <i class="fa fa-question-circle" aria-hidden="true"></i>
                                                </span>
                                                </label>
                                                <div class="col-lg-4 col-sm-8">
                                                    <input type="text" class="form-control" id="userDisplayName"
                                                           name="userDisplayName"
                                                           value="${user.userDisplayName?if_exists}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="userEmail"
                                                       class="col-lg-2 col-sm-4 control-label">电子邮箱</label>
                                                <div class="col-lg-4 col-sm-8">
                                                    <input type="email" class="form-control" id="userEmail"
                                                           name="userEmail"
                                                           value="${user.userEmail?if_exists}">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="userAvatar"
                                                       class="col-lg-2 col-sm-4 control-label">头像</label>
                                                <div class="col-lg-4 col-sm-8">
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" id="userAvatar"
                                                               name="userAvatar" value="${user.userAvatar?if_exists}">
                                                        <span class="input-group-btn">
                                                        <button class="btn btn-default " type="button"
                                                                onclick="openAttach('userAvatar')">选择</button>
                                                    </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="userDesc"
                                                       class="col-lg-2 col-sm-4 control-label">个人描述
                                                </label>
                                                <div class="col-lg-4 col-sm-8">
                                                <textarea class="form-control" rows="3" id="userDesc" name="userDesc"
                                                          style="resize: none">${user.userDesc?if_exists}</textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="userEmail"
                                                       class="col-lg-2 col-sm-4 control-label">个人主页</label>
                                                <div class="col-lg-4 col-sm-8">
                                                    <input type="url" class="form-control" id="userSite" name="userSite"
                                                           value="${user.userSite?if_exists}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="box-footer">
                                            <button type="button" class="btn btn-primary btn-sm "
                                                    onclick="saveUser('profileForm')">保存</button>
                                        </div>
                                    </form>
                                </div>
                                <div class="tab-pane" id="pass">
                                    <form method="post" class="form-horizontal" id="passForm">
                                        <div class="box-body">
                                            <div class="form-group">
                                                <label for="beforePass"
                                                       class="col-sm-2 control-label">旧密码</label>
                                                <div class="col-sm-4">
                                                    <input type="password" class="form-control" id="beforePass"
                                                           name="beforePass">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="newPass"
                                                       class="col-sm-2 control-label">新密码</label>
                                                <div class="col-sm-4">
                                                    <input type="password" class="form-control" id="newPass"
                                                           name="newPass">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="reNewPass"
                                                       class="col-sm-2 control-label">确认密码</label>
                                                <div class="col-sm-4">
                                                    <input type="password" class="form-control" id="reNewPass"
                                                           name="reNewPass">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="box-footer">
                                            <button type="button" class="btn btn-primary btn-sm "
                                                    onclick="changPass()">编辑</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <@compress single_line=true>
                <script>
                    $(function () {
                        $('[data-toggle="tooltip"]').tooltip()
                    });

                    function openAttach(id) {
                        layer.open({
                            type: 2,
                            title: '所有附件',
                            shadeClose: true,
                            shade: 0.5,
                            maxmin: true,
                            area: ['90%', '90%'],
                            content: '/admin/attachment/select?id=' + id,
                            scrollbar: false
                        });
                    }

                    function saveUser(option) {
                        var param = $('#' + option).serialize();
                        $.ajax({
                            type: 'post',
                            url: '/admin/user/profile/save',
                            data: param,
                            success: function (data) {
                                if (data.code == 1) {
                                    $.toast({
                                        text: data.msg,
                                        heading: '提示',
                                        icon: 'success',
                                        showHideTransition: 'fade',
                                        allowToastClose: true,
                                        hideAfter: 1000,
                                        stack: 1,
                                        position: 'top-center',
                                        textAlign: 'left',
                                        loader: true,
                                        loaderBg: '#ffffff',
                                        afterHidden: function () {
                                            window.location.href = "/admin/logOut";
                                        }
                                    });
                                } else {
                                    showMsg(data.msg, "error", 2000);
                                }
                            }
                        });
                    }

                    function changPass() {
                        var beforePass = $('#beforePass').val();
                        var newPass = $('#newPass').val();
                        var reNewPass = $('#reNewPass').val();
                        if (beforePass == "" || newPass == "" || reNewPass == "") {
                            showMsg("请填写完整信息", "info", 2000);
                            return;
                        }
                        if (newPass != reNewPass) {
                            showMsg("两次密码不一致", "error", 2000);
                            return;
                        }
                        var param = $('#passForm').serialize();
                        $.ajax({
                            type: 'post',
                            url: '/admin/user/changePass',
                            data: param,
                            success: function (data) {
                                if (data.code == 1) {
                                    $.toast({
                                        text: data.msg,
                                        heading: '提示',
                                        icon: 'success',
                                        showHideTransition: 'fade',
                                        allowToastClose: true,
                                        hideAfter: 1000,
                                        stack: 1,
                                        position: 'top-center',
                                        textAlign: 'left',
                                        loader: true,
                                        loaderBg: '#ffffff',
                                        afterHidden: function () {
                                            window.location.reload();
                                        }
                                    });
                                } else {
                                    showMsg(data.msg, "error", 2000);
                                }
                            }
                        });
                    }

                    function removeIt(id) {
                        layer.confirm('你确认要删除吗', function (index) {
                            $.ajax({
                                type: 'POST',
                                url: '/admin/user/deleteBind',
                                async: false,
                                data: {
                                    'id': id
                                },
                                success: function (data) {
                                    console.log(data);
                                    if (data.code == 0) {
                                        showMsg(data.msg, "error", 2000);
                                    } else {
                                        $('#bind-' + id).remove();
                                        showMsg(data.msg, "success", 2000);
                                    }

                                }
                            });
                            layer.close(index);
                        });
                    }
                </script>
            </@compress>
        </div>
        <#include "module/_footer.ftl">
    </div>
    <@footer></@footer>
</#compress>
