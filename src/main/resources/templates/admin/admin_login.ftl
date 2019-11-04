<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>${options.blog_title!} &lsaquo; 登录</title>
    <link rel='stylesheet' id='dashicons-css' href='/static/css/dashicons.min.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='buttons-css' href='/static/css/buttons.min.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='login-css' href='/static/css/login.min.css' type='text/css' media='all'/>
    <meta name='robots' content='noindex,follow'/>
    <meta name="viewport" content="width=device-width"/>
    <link rel="stylesheet" href="${options.blog_static_url?if_exists}/static/plugins/animate/animate.min.css?version=1.5.0">
    <link rel="stylesheet" href="${options.blog_static_url?if_exists}/static/plugins/toast/css/jquery.toast.min.css?version=1.5.0">

</head>
<body class="login login-action-login wp-core-ui  locale-zh-cn">
<div id="login" class="login-body animated">
    <h1><a href="${options.blog_url!}" title="欢迎您光临本站！" tabindex="-1">${options.blog_title!}</a></h1>
    <p class="message register">${options.blog_title!}，欢迎登录！</p>

    <form name="loginform" id="loginform" action="/admin/login" method="post">
        <p>
            <label for="account">用户名或电子邮件地址<br/>
                <input type="text" name="account" id="login-name" class="input" size="20" required/>
            </label>
        </p>
        <p>
            <label for="password">密码<br/>
                <input type="password" name="password" id="login-pwd" class="input" size="20" required/>
            </label>
        </p>
        <div style="clear: both;"></div>
        <p class="forgetmenot">
            <label for="rememberme">
                <input name="rememberMe" type="checkbox" id="rememberMe"
                       checked="checked"> 记住我的登录信息
            </label>
        </p>
        <p class="submit">
            <button type="button" id="btn-login" data-loading-text="登录中..."
                    class="btn button button-primary button-large btn-block login-button fadeInUp" onclick="btn_login()"
                    style="animation-delay: 0.4s;outline: none;">
                登录
            </button>
        </p>
        <br>
    </form>

    <p id="nav">
        <a href="/admin/register">注册</a> |
        <a href="/admin/forget">忘记密码？</a>
    </p>

    <div class="threeLogin">
        <span>快速登录</span>
    <#if options.bind_qq_open?default('true') == 'true' >
        <a class="qq"
           href="https://graph.qq.com/oauth2.0/authorize?response_type=code&amp;client_id=${options.bind_qq_app_id?if_exists}&amp;redirect_uri=${options.bind_qq_callback?if_exists}&amp;scope=get_user_info"
           target="_blank"></a>
    </#if>
    <#if options.bind_github_open?default('true') == 'true' >
        <a class="github"
           href="https://github.com/login/oauth/authorize?client_id=${options.bind_github_app_id?if_exists}&amp;redirect_uri=${options.bind_github_callback?if_exists}&amp;state=abc"
           target="_blank"></a>
    </#if>
    </div>
    <p id="backtoblog"><a href="/">&larr; 返回到${options.blog_title!}</a></p>

</div>

<script>
    var heading = "提示";
</script>
<script src="${options.blog_static_url?if_exists}/static/plugins/jquery/jquery.min.js?version=1.5.0"></script>
<script src="${options.blog_static_url?if_exists}/static/plugins/toast/js/jquery.toast.min.js?version=1.5.0"></script>
<script src="${options.blog_static_url?if_exists}/static/plugins/bootstrap/js/bootstrap.min.js?version=1.5.0"></script>
<script src="${options.blog_static_url?if_exists}/static/js/login.js?version=1.5.0"></script>
</body>
</html>