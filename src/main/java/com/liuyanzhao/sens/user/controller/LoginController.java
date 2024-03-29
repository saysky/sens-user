package com.liuyanzhao.sens.user.controller;

import cn.hutool.core.lang.Validator;
import com.google.common.base.Strings;
import com.liuyanzhao.sens.user.common.constant.RedisKeys;
import com.liuyanzhao.sens.user.common.constant.SensConst;
import com.liuyanzhao.sens.user.common.dto.JsonResult;
import com.liuyanzhao.sens.user.common.enums.*;
import com.liuyanzhao.sens.user.common.utils.Md5Util;
import com.liuyanzhao.sens.user.common.utils.RedisUtil;
import com.liuyanzhao.sens.user.config.shiro.UserToken;
import com.liuyanzhao.sens.user.entity.Role;
import com.liuyanzhao.sens.user.entity.User;
import com.liuyanzhao.sens.user.entity.UserRoleRef;
import com.liuyanzhao.sens.user.service.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

/**
 * @author 言曌
 * @date 2019-10-13 17:58
 */
@Controller
@RequestMapping("/admin")
@Slf4j
public class LoginController extends BaseController {

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private UserService2 userService;

    @Autowired(required = false)
    private UserRoleRefService userRoleRefService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private MailService mailService;

    @Autowired
    private RedisUtil redisUtil;

    /**
     * 处理跳转到登录页的请求
     *
     * @return 模板路径admin/admin_login
     */
    @GetMapping(value = "/login")
    public String login() {
        Subject subject = SecurityUtils.getSubject();
        //如果已经登录，跳转到后台首页
        if (subject.isAuthenticated()) {
            return "redirect:/admin";
        }
        return "admin/admin_login";
    }

    /**
     * 验证登录信息
     *
     * @param account  登录名：邮箱／用户名
     * @param password password 密码
     * @return JsonResult JsonResult
     */
    @PostMapping(value = "/getLogin")
    @ResponseBody
    public JsonResult getLogin(String account,
                               String password) {

        Subject subject = SecurityUtils.getSubject();
        UserToken token = new UserToken(account, password, LoginTypeEnum.NORMAL.getValue());
        try {
            subject.login(token);
            if (subject.isAuthenticated()) {
                //登录成功，修改登录错误次数为0
                User user = (User) subject.getPrincipal();
                userService.updateUserLoginNormal(user);
                //清除权限列表缓存，重新加载
                redisUtil.del(RedisKeys.USER_PERMISSION_URLS + user.getId());
                Set<String> permissionUrls = permissionService.findPermissionUrlsByUserId(user.getId());
                subject.getSession().setAttribute("permissionUrls", permissionUrls);
                return new JsonResult(ResultCodeEnum.SUCCESS.getCode(), "登录成功");
            }
        } catch (UnknownAccountException e) {
            log.info("UnknownAccountException -- > 账号不存在：");
            return new JsonResult(ResultCodeEnum.FAIL.getCode(), "用户名不存在");
        } catch (IncorrectCredentialsException e) {
            //更新失败次数
            User user;
            if (Validator.isEmail(account)) {
                user = userService.findByEmail(account);
            } else {
                user = userService.findByUserName(account);
            }
            if (user != null) {
                Integer errorCount = userService.updateUserLoginError(user);
                //超过五次禁用账户
                if (errorCount > CommonParamsEnum.FIVE.getValue()) {
                    userService.updateUserLoginEnable(user, TrueFalseEnum.FALSE.getValue());
                }
                int count = (5 - errorCount) > 0 ? (5 - errorCount) : 0;
                if(count == 0) {
                    return new JsonResult(ResultCodeEnum.FAIL.getCode(), "账号被锁定，请10分钟后再试");
                }
                return new JsonResult(ResultCodeEnum.FAIL.getCode(), "密码错误，您还有" + count + "次机会");
            }
        } catch (LockedAccountException e) {
            log.info("LockedAccountException -- > 账号被锁定");
            return new JsonResult(ResultCodeEnum.FAIL.getCode(), e.getMessage());
        } catch (Exception e) {
            log.info(e.getMessage());
        }
        return new JsonResult(ResultCodeEnum.FAIL.getCode(), "查询失败");
    }

    /**
     * 处理跳转到登录页的请求
     *
     * @return 模板路径admin/admin_login
     */
    @GetMapping(value = "/register")
    public String register() {
        Subject subject = SecurityUtils.getSubject();
        //如果已经登录，跳转到后台首页
        if (subject.isAuthenticated()) {
            return "redirect:/admin";
        }
        return "admin/admin_register";
    }


    /**
     * 验证注册信息
     *
     * @param userName  用户名
     * @param userEmail 邮箱
     * @return JsonResult JsonResult
     */
    @PostMapping(value = "/getRegister")
    @ResponseBody
    public JsonResult getRegister(@ModelAttribute("userName") String userName,
                                  @ModelAttribute("userPass") String userPass,
                                  @ModelAttribute("userEmail") String userEmail) {
        if (StringUtils.equals(SensConst.OPTIONS.get(BlogPropertiesEnum.OPEN_REGISTER.getProp()), TrueFalseEnum.FALSE.getValue())) {
            return new JsonResult(ResultCodeEnum.FAIL.getCode(), "系统已经关闭注册功能");
        }
        //1.检查用户名
        User checkUser = userService.findByUserName(userName);
        if (checkUser != null) {
            return new JsonResult(ResultCodeEnum.FAIL.getCode(), "用户名已存在");
        }
        //2.检查用户名
        User checkEmail = userService.findByEmail(userEmail);
        if (checkEmail != null) {
            return new JsonResult(ResultCodeEnum.FAIL.getCode(), "邮箱已存在");
        }
        //3.创建用户
        User user = new User();
        user.setUserName(userName);
        user.setUserDisplayName(userName);
        user.setUserEmail(userEmail);
        user.setEmailEnable(TrueFalseEnum.FALSE.getValue());
        user.setLoginEnable(TrueFalseEnum.TRUE.getValue());
        user.setLoginError(0);
        user.setUserPass(userPass);
        user.setUserAvatar("/static/images/avatar/" + RandomUtils.nextInt(1, 41) + ".jpeg");
        user.setStatus(UserStatusEnum.NORMAL.getCode());
        userService.insert(user);

        //4.关联角色
        String defaultRole = SensConst.OPTIONS.get(BlogPropertiesEnum.DEFAULT_REGISTER_ROLE.getProp());
        Role role = null;
        if (!Strings.isNullOrEmpty(defaultRole)) {
            role = roleService.findByRoleName(defaultRole);
        }
        if (role == null) {
            role = roleService.findByRoleName(RoleEnum.SUBSCRIBER.getValue());
        }
        if (role != null) {
            userRoleRefService.insert(new UserRoleRef(user.getId(), role.getId()));
        }

        //4.发送激活验证码
//        if (StringUtils.equals(SensConst.OPTIONS.get(BlogPropertiesEnum.SMTP_EMAIL_ENABLE.getProp()), TrueFalseEnum.TRUE.getValue())) {
//            Map<String, Object> map = new HashMap<>(8);
//            map.put("blogTitle", SensConst.OPTIONS.get(BlogPropertiesEnum.BLOG_TITLE.getProp()));
//            map.put("blogUrl", SensConst.OPTIONS.get(BlogPropertiesEnum.BLOG_URL.getProp()));
//            map.put("activeUrl", SensConst.OPTIONS.get(BlogPropertiesEnum.BLOG_URL.getProp()));
//            mailService.sendTemplateMail(
//                    userEmail,  SensConst.OPTIONS.get(BlogPropertiesEnum.BLOG_TITLE.getProp()) + "账户 - 电子邮箱激活", map, "common/mail_template/mail_active_email.ftl");
//        } else {
//            return new JsonResult(ResultCodeEnum.FAIL.getCode(), "本站没有启动SMTP，无法发送邮件！");
//        }

        return new JsonResult(ResultCodeEnum.SUCCESS.getCode(), "注册成功");
    }

    /**
     * 处理跳转忘记密码的请求
     *
     * @return 模板路径admin/admin_login
     */
    @GetMapping(value = "/forget")
    public String forget() {
        Subject subject = SecurityUtils.getSubject();
        //如果已经登录，跳转到后台首页
        if (subject.isAuthenticated()) {
            return "redirect:/admin";
        }
        return "admin/admin_forget";
    }

    /**
     * 处理忘记密码
     *
     * @param userName  用户名
     * @param userEmail 邮箱
     * @return JsonResult
     */
    @PostMapping(value = "/getForget")
    @ResponseBody
    public JsonResult getForget(@ModelAttribute("userName") String userName,
                                @ModelAttribute("userEmail") String userEmail) {

        User user = userService.findByUserName(userName);
        if (user != null && Objects.equals(user.getUserEmail(), userEmail)) {
            //验证成功，将密码由邮件方法发送给对方
            //1.修改密码
            String password = RandomStringUtils.randomNumeric(8);
            userService.updatePassword(user.getId(), Md5Util.toMd5(password, "sens", 10));
            //2.发送邮件
            if (StringUtils.equals(SensConst.OPTIONS.get(BlogPropertiesEnum.SMTP_EMAIL_ENABLE.getProp()), TrueFalseEnum.TRUE.getValue())) {
                Map<String, Object> map = new HashMap<>(8);
                map.put("blogTitle", SensConst.OPTIONS.get(BlogPropertiesEnum.BLOG_TITLE.getProp()));
                map.put("blogUrl", SensConst.OPTIONS.get(BlogPropertiesEnum.BLOG_URL.getProp()));
                map.put("password", password);
                mailService.sendTemplateMail(
                        userEmail, SensConst.OPTIONS.get(BlogPropertiesEnum.BLOG_TITLE.getProp()) + "账户 - 找回密码", map, "common/mail_template/mail_forget.ftl");
            } else {
                return new JsonResult(ResultCodeEnum.FAIL.getCode(), "SMTP未配置");
            }
        } else {
            return new JsonResult(ResultCodeEnum.FAIL.getCode(), "用户名和邮箱不匹配");
        }
        return new JsonResult(ResultCodeEnum.SUCCESS.getCode(), "新密码已经发生到您的邮箱");
    }

    /**
     * 退出登录
     *
     * @return 重定向到/admin/login
     */
    @GetMapping(value = "/logOut")
    public String logOut() {
        User loginUser = getLoginUser();

        Subject subject = SecurityUtils.getSubject();
        subject.logout();

        log.info("用户[{}]退出登录", loginUser.getUserName());
        return "redirect:/admin/login";
    }
}
