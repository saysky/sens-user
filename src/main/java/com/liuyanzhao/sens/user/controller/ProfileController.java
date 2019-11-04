package com.liuyanzhao.sens.user.controller;

import com.liuyanzhao.sens.user.common.dto.JsonResult;
import com.liuyanzhao.sens.user.common.enums.ResultCodeEnum;
import com.liuyanzhao.sens.user.entity.Role;
import com.liuyanzhao.sens.user.entity.User;
import com.liuyanzhao.sens.user.service.RoleService;
import com.liuyanzhao.sens.user.common.utils.Md5Util;
import com.liuyanzhao.sens.user.service.UserService2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

/**
 * <pre>
 *     后台用户管理控制器
 * </pre>
 *
 * @author : saysky
 * @date : 2017/12/24
 */
@Slf4j
@Controller
@RequestMapping(value = "/admin/user")
public class ProfileController extends BaseController {

    @Autowired
    private UserService2 userService;

    @Autowired
    private RoleService roleService;

    /**
     * 获取用户信息并跳转
     *
     * @return 模板路径admin/admin_profile
     */
    @GetMapping("/profile")
    public String profile(Model model) {
        //1.用户信息
        User user = getLoginUser();
        model.addAttribute("user", user);

        //3.角色列表
        List<Role> roles = roleService.listRolesByUserId(user.getId());
        model.addAttribute("roles", roles);
        return "admin/admin_profile";
    }


    /**
     * 处理修改用户资料的请求
     *
     * @param user user
     * @return JsonResult
     */
    @PostMapping(value = "/profile/save")
    @ResponseBody
    public JsonResult saveProfile(@ModelAttribute User user) {
        User loginUser = getLoginUser();

        User saveUser = userService.get(loginUser.getId());
        saveUser.setUserPass(null);
        saveUser.setId(loginUser.getId());
        saveUser.setUserName(user.getUserName());
        saveUser.setUserDisplayName(user.getUserDisplayName());
        saveUser.setUserSite(user.getUserSite());
        saveUser.setUserAvatar(user.getUserAvatar());
        saveUser.setUserDesc(user.getUserDesc());
        saveUser.setUserEmail(user.getUserEmail());
        userService.insertOrUpdate(saveUser);
        return new JsonResult(ResultCodeEnum.SUCCESS.getCode(), "保存成功，请重新登录");
    }


    /**
     * 处理修改密码的请求
     *
     * @param beforePass 旧密码
     * @param newPass    新密码
     * @return JsonResult
     */
    @PostMapping(value = "/changePass")
    @ResponseBody
    public JsonResult changePass(@ModelAttribute("beforePass") String beforePass,
                                 @ModelAttribute("newPass") String newPass) {
        User loginUser = getLoginUser();
        User user = userService.get(loginUser.getId());
        if (user != null && Objects.equals(user.getUserPass(), Md5Util.toMd5(beforePass, "sens", 10))) {
            userService.updatePassword(user.getId(), newPass);
        } else {
            return new JsonResult(ResultCodeEnum.FAIL.getCode(), "旧密码错误");
        }
        return new JsonResult(ResultCodeEnum.SUCCESS.getCode(), "密码修改成功");
    }



}
