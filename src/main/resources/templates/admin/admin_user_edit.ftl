<#compress >
    <#include "module/_macro.ftl">
    <@head>${options.blog_title} | 编辑用户</@head>
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
        </style>
        <section class="content-header">
            <h1>
                编辑用户
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
                                    <input type="hidden" name="id" value="${user.id?if_exists}">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label for="roleList" class="col-lg-2 col-sm-4 control-label">
                                                角色
                                            </label>
                                            <div class="col-lg-4 col-sm-8">
                                                <#list roles as role>
                                                    <div class="pretty p-default">
                                                        <input type="checkbox" name="roleList"
                                                               value="${role.id}"
                                                            <#list currentRoles as current>
                                                            ${(role.id == current.id)?string('checked','')}
                                                            </#list>>
                                                        <div class="state p-primary">
                                                            <label>${role.description}</label>
                                                        </div>
                                                    </div>

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
                                                <input type="text" class="form-control" id="userName" name="userName"
                                                       value="${(user.userName)!}">
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
                                                       name="userDisplayName" value="${user.userDisplayName?if_exists}">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="userEmail"
                                                   class="col-lg-2 col-sm-4 control-label">电子邮箱</label>
                                            <div class="col-lg-4 col-sm-8">
                                                <input type="email" class="form-control" id="userEmail" name="userEmail"
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
                                        <div class="form-group">
                                            <label class="col-lg-2 col-sm-4 control-label">状态</label>
                                            <div class="col-lg-4 col-sm-8 control-radio">
                                                <div class="pretty p-default p-round">
                                                    <input type="radio" name="status"
                                                           value="0" ${(user.status?if_exists == 0)?string('checked','')}>
                                                    <div class="state p-primary">
                                                        <label>启用</label>
                                                    </div>
                                                </div>
                                                <div class="pretty p-default p-round">
                                                    <input type="radio" name="status"
                                                           value="1" ${((user.status?if_exists)== 1)?string('checked','')}>
                                                    <div class="state p-primary">
                                                        <label>禁用</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="loginError"
                                                   class="col-lg-2 col-sm-4 control-label">登录错误次数</label>
                                            <div class="col-lg-4 col-sm-8">
                                                <input type="text" class="form-control" id="loginError"
                                                       value="${user.loginError?if_exists}">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-2 col-sm-4 control-label">是否允许登录</label>
                                            <div class="col-lg-4 col-sm-8 control-radio">
                                                <div class="pretty p-default p-round">
                                                    <input type="radio" name="loginEnable"
                                                           value="true" ${((user.loginEnable?default("true"))=='true')?string('checked','')}>
                                                    <div class="state p-primary">
                                                        <label>允许</label>
                                                    </div>
                                                </div>
                                                <div class="pretty p-default p-round">
                                                    <input type="radio" name="loginEnable"
                                                           value="false" ${((user.loginEnable?if_exists)=='false')?string('checked','')}>
                                                    <div class="state p-primary">
                                                        <label>禁止</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="createTime"
                                                   class="col-lg-2 col-sm-4 control-label">注册时间</label>
                                            <div class="col-lg-4 col-sm-8">
                                                <input type="text" class="form-control disabled-input" id="createTime"
                                                       disabled
                                                       value="${(user.createTime?string("yyyy-MM-dd HH:mm:ss"))!}">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="loginLast"
                                                   class="col-lg-2 col-sm-4 control-label">上次登录时间</label>
                                            <div class="col-lg-4 col-sm-8">
                                                <input type="text" class="form-control  disabled-input" id="loginLast"
                                                       disabled
                                                       value="${((user.loginLast)?string("yyyy-MM-dd HH:mm:ss"))!}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-footer">
                                        <button type="button" class="btn btn-primary btn-sm "
                                                onclick="saveUser('profileForm')">保存</button>
                                        <a href="/admin/user"
                                           class="btn btn-info btn-sm"> 返回</a>
                                    </div>
                                </form>
                            </div>
                            <div class="tab-pane" id="pass">
                                <form method="post" class="form-horizontal" id="passForm">
                                    <input type="hidden" id="id" name="id" value="${user.id?if_exists}">
                                    <div class="box-body">
                                        <div class="form-group">
                                            <label for="newPass"
                                                   class="col-sm-2 control-label">新密码</label>
                                            <div class="col-sm-4">
                                                <input type="password" class="form-control" id="newPass" name="newPass">
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
                                        <a href="/admin/user"
                                           class="btn btn-info btn-sm"> 返回</a>
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
                    var userName = $('#userName').val();
                    var userDisplayName = $('#userDisplayName').val();
                    var userEmail = $('#userEmail').val();
                    var role = $("input:checkbox[name='roleList']:checked").length;
                    if (userName == "" || userDisplayName == "" || userEmail == "" || role == 0) {
                        showMsg('请输入完整信息', "info", 2000);
                        return;
                    }

                    var param = $('#' + option).serialize();
                    $.ajax({
                        type: 'post',
                        url: '/admin/user/save',
                        data: param,
                        success: function (data) {
                            console.log(data);
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

                function changPass() {
                    var newPass = $('#newPass').val();
                    var reNewPass = $('#reNewPass').val();
                    if (newPass == "" || reNewPass == "") {
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
                        url: '/admin/user/proxy/changePass',
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
            </script>
        </@compress>
    </div>
    <#include "module/_footer.ftl">
</div>
    <@footer></@footer>
</#compress>
